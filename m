Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C107C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4AF72082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AF72082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeKCR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:58:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:42214 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeKCR6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:58:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 97523AE80;
        Sat,  3 Nov 2018 08:47:35 +0000 (UTC)
Subject: Re: [PATCH] scsi: myrs: avoid stack overflow warning
To:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102154426.1951776-1-arnd@arndb.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <c4e5b45e-85a5-d279-0265-a4974f41fa85@suse.de>
Date:   Sat, 3 Nov 2018 09:47:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102154426.1951776-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 4:44 PM, Arnd Bergmann wrote:
> Putting a 1024 byte data structure on the stack is generally a bad idea.
> On 32-bit systems, it also triggers a compile-time warning when building
> with -Og:
> 
> drivers/scsi/myrs.c: In function 'myrs_get_ctlr_info':
> drivers/scsi/myrs.c:212:1: error: the frame size of 1028 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> We only really need three members of the structure, so just read them
> manually here instead of copying the entire structure.
> 
> Fixes: 77266186397c ("scsi: myrs: Add Mylex RAID controller (SCSI interface)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/myrs.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> index 0264a2e2bc19..b8d54ef8cf6d 100644
> --- a/drivers/scsi/myrs.c
> +++ b/drivers/scsi/myrs.c
> @@ -163,9 +163,12 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
>   	dma_addr_t ctlr_info_addr;
>   	union myrs_sgl *sgl;
>   	unsigned char status;
> -	struct myrs_ctlr_info old;
> +	unsigned short ldev_present, ldev_critical, ldev_offline;
> +
> +	ldev_present = cs->ctlr_info->ldev_present;
> +	ldev_critical = cs->ctlr_info->ldev_critical;
> +	ldev_offline = cs->ctlr_info->ldev_offline;
>   
> -	memcpy(&old, cs->ctlr_info, sizeof(struct myrs_ctlr_info));
>   	ctlr_info_addr = dma_map_single(&cs->pdev->dev, cs->ctlr_info,
>   					sizeof(struct myrs_ctlr_info),
>   					DMA_FROM_DEVICE);
> @@ -198,9 +201,9 @@ static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
>   		    cs->ctlr_info->rbld_active +
>   		    cs->ctlr_info->exp_active != 0)
>   			cs->needs_update = true;
> -		if (cs->ctlr_info->ldev_present != old.ldev_present ||
> -		    cs->ctlr_info->ldev_critical != old.ldev_critical ||
> -		    cs->ctlr_info->ldev_offline != old.ldev_offline)
> +		if (cs->ctlr_info->ldev_present != ldev_present ||
> +		    cs->ctlr_info->ldev_critical != ldev_critical ||
> +		    cs->ctlr_info->ldev_offline != ldev_offline)
>   			shost_printk(KERN_INFO, cs->host,
>   				     "Logical drive count changes (%d/%d/%d)\n",
>   				     cs->ctlr_info->ldev_critical,
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
