Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76441C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EA120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EA120841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbeHAIOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 04:14:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387419AbeHAIOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 04:14:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 02FE4AEB9;
        Wed,  1 Aug 2018 06:30:34 +0000 (UTC)
Subject: Re: [PATCH 2/3] scsi: fcoe: drop frames in ELS LOGO error path
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        ard <ard@kwaak.net>
References: <20180731134603.20089-1-jthumshirn@suse.de>
 <20180731134603.20089-3-jthumshirn@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <bf4d9fbb-4801-044b-680e-b44894592b11@suse.de>
Date:   Wed, 1 Aug 2018 08:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731134603.20089-3-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 03:46 PM, Johannes Thumshirn wrote:
> Drop the frames in the ELS LOGO error path instead of just returning
> an error.
> 
> This fixes the following kmemleak report:
> unreferenced object 0xffff880064cb1000 (size 424):
>   comm "kworker/0:2", pid 24, jiffies 4294904293 (age 68.504s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<(____ptrval____)>] _fc_frame_alloc+0x2c/0x180 [libfc]
>     [<(____ptrval____)>] fc_lport_enter_logo+0x106/0x360 [libfc]
>     [<(____ptrval____)>] fc_fabric_logoff+0x8c/0xc0 [libfc]
>     [<(____ptrval____)>] fcoe_if_destroy+0x79/0x3b0 [fcoe]
>     [<(____ptrval____)>] fcoe_destroy_work+0xd2/0x170 [fcoe]
>     [<(____ptrval____)>] process_one_work+0x7ff/0x1420
>     [<(____ptrval____)>] worker_thread+0x87/0xef0
>     [<(____ptrval____)>] kthread+0x2db/0x390
>     [<(____ptrval____)>] ret_from_fork+0x35/0x40
>     [<(____ptrval____)>] 0xffffffffffffffff
> 
> which can be triggered by issuing
> echo eth0 > /sys/bus/fcoe/ctlr_destroy
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/scsi/fcoe/fcoe_ctlr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
> index ceb35ebbeb8f..ffec695e0bfb 100644
> --- a/drivers/scsi/fcoe/fcoe_ctlr.c
> +++ b/drivers/scsi/fcoe/fcoe_ctlr.c
> @@ -754,9 +754,9 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
>  	case ELS_LOGO:
>  		if (fip->mode == FIP_MODE_VN2VN) {
>  			if (fip->state != FIP_ST_VNMP_UP)
> -				return -EINVAL;
> +				goto drop;
>  			if (ntoh24(fh->fh_d_id) == FC_FID_FLOGI)
> -				return -EINVAL;
> +				goto drop;
>  		} else {
>  			if (fip->state != FIP_ST_ENABLED)
>  				return 0;
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
