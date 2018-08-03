Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E44C43142
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5999021531
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 02:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5999021531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeHCERj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 00:17:39 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:57348 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeHCERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 00:17:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5728C27D51;
        Thu,  2 Aug 2018 22:23:38 -0400 (EDT)
Date:   Fri, 3 Aug 2018 12:24:07 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     zhong jiang <zhongjiang@huawei.com>
cc:     schmitzmic@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, andy.shevchenko@gmail.com,
        john.garry@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in
 NCR5380_select
In-Reply-To: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <alpine.LNX.2.21.1808031156350.16@nippy.intranet>
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Aug 2018, zhong jiang wrote:

> The same check condition is redundant, so remove one of them.
> 

If you are trying to find redundant code, your coccinelle script is 
dangerously flawed.

You need to realize that NCR5380_read(CURRENT_SCSI_DATA_REG) is not simply 
a value in a CPU register or a device register, but it is the actual state 
of the scsi bus data lines, which are subject to change any time, at the 
whim of the firmwares in all of the SCSI bus devices participating in 
arbitration at the time, or of a user who might kick a plug etc.

From the datasheet:

    The SCSI data lines are not actually registered, but gated directly 
    onto the CPU bus whenever Address 000 is read by the CPU...

Hence, NAK.

-- 

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/NCR5380.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
> index 90ea0f5..2ecaf3f 100644
> --- a/drivers/scsi/NCR5380.c
> +++ b/drivers/scsi/NCR5380.c
> @@ -999,8 +999,7 @@ static struct scsi_cmnd *NCR5380_select(struct Scsi_Host *instance,
>  
>  	/* Check for lost arbitration */
>  	if ((NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_LOST) ||
> -	    (NCR5380_read(CURRENT_SCSI_DATA_REG) & hostdata->id_higher_mask) ||
> -	    (NCR5380_read(INITIATOR_COMMAND_REG) & ICR_ARBITRATION_LOST)) {
> +	    (NCR5380_read(CURRENT_SCSI_DATA_REG) & hostdata->id_higher_mask)) {
>  		NCR5380_write(MODE_REG, MR_BASE);
>  		dsprintk(NDEBUG_ARBITRATION, instance, "lost arbitration, deasserting MR_ARBITRATE\n");
>  		spin_lock_irq(&hostdata->lock);
> 
