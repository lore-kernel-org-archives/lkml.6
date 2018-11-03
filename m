Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885C6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8582082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 08:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8582082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKCR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 13:57:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:42098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbeKCR52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 13:57:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8384BAE14;
        Sat,  3 Nov 2018 08:46:51 +0000 (UTC)
Subject: Re: [PATCH] scsi: myrb: fix sprintf buffer overflow warning
To:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181102153458.1567593-1-arnd@arndb.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <6a012c05-67a5-e899-f636-db01b79dfbf2@suse.de>
Date:   Sat, 3 Nov 2018 09:46:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102153458.1567593-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 4:34 PM, Arnd Bergmann wrote:
> gcc warns that the 12 byte fw_version field might not be long enough to
> contain the generated firmware name string:
> 
> drivers/scsi/myrb.c: In function 'myrb_get_hba_config':
> drivers/scsi/myrb.c:1052:38: error: '%02d' directive writing between 2 and 3 bytes into a region of size between 2 and 5 [-Werror=format-overflow=]
>    sprintf(cb->fw_version, "%d.%02d-%c-%02d",
>                                        ^~~~
> drivers/scsi/myrb.c:1052:26: note: directive argument in the range [0, 255]
>    sprintf(cb->fw_version, "%d.%02d-%c-%02d",
>                            ^~~~~~~~~~~~~~~~~
> drivers/scsi/myrb.c:1052:2: note: 'sprintf' output between 10 and 14 bytes into a destination of size 12
>    sprintf(cb->fw_version, "%d.%02d-%c-%02d",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     enquiry2->fw.major_version,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     enquiry2->fw.minor_version,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     enquiry2->fw.firmware_type,
>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     enquiry2->fw.turn_id);
>     ~~~~~~~~~~~~~~~~~~~~~
> 
> I have not checked whether there are appropriate range checks before the
> sprintf, but there is a range check after it that will bail out in case
> of out of range version numbers. This means we can simply use snprintf()
> instead of sprintf() to limit the output buffer size, and it will work
> correctly.
> 
> Fixes: 081ff398c56c ("scsi: myrb: Add Mylex RAID controller (block interface)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/myrb.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
> index aeb282f617c5..0642f2d0a3bb 100644
> --- a/drivers/scsi/myrb.c
> +++ b/drivers/scsi/myrb.c
> @@ -1049,7 +1049,8 @@ static int myrb_get_hba_config(struct myrb_hba *cb)
>   		enquiry2->fw.firmware_type = '0';
>   		enquiry2->fw.turn_id = 0;
>   	}
> -	sprintf(cb->fw_version, "%d.%02d-%c-%02d",
> +	snprintf(cb->fw_version, sizeof(cb->fw_version),
> +		"%d.%02d-%c-%02d",
>   		enquiry2->fw.major_version,
>   		enquiry2->fw.minor_version,
>   		enquiry2->fw.firmware_type,
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
