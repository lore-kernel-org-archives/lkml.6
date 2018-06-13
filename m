Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 581E1C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1179B208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1179B208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935148AbeFMKJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:09:19 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47426 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934978AbeFMKJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:09:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 5918824672;
        Wed, 13 Jun 2018 06:09:16 -0400 (EDT)
Date:   Wed, 13 Jun 2018 20:09:51 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: xen-scsifront: add error handling for
 xenbus_printf
In-Reply-To: <1528774962-39173-1-git-send-email-jiazhouyang09@gmail.com>
Message-ID: <alpine.LNX.2.21.1806132002180.45@nippy.intranet>
References: <1528774962-39173-1-git-send-email-jiazhouyang09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jun 2018, Zhouyang Jia wrote:

> When xenbus_printf fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling xenbus_printf.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  drivers/scsi/xen-scsifront.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
> index 36f59a1..3d858ac 100644
> --- a/drivers/scsi/xen-scsifront.c
> +++ b/drivers/scsi/xen-scsifront.c
> @@ -654,10 +654,17 @@ static int scsifront_dev_reset_handler(struct scsi_cmnd *sc)
>  static int scsifront_sdev_configure(struct scsi_device *sdev)
>  {
>  	struct vscsifrnt_info *info = shost_priv(sdev->host);
> +	struct xenbus_device *dev = info->dev;
> +	int err;
>  
> -	if (info && current == info->curr)
> -		xenbus_printf(XBT_NIL, info->dev->nodename,
> +	if (info && current == info->curr) {
> +		err = xenbus_printf(XBT_NIL, info->dev->nodename,
>  			      info->dev_state_path, "%d", XenbusStateConnected);

The existing code checks whether 'info' is NULL before dereferencing it. 
But your patch checks for NULL after dereferencing.

> +		if (err) {
> +			dev_err(&dev->dev, "writing dev_state_path\n");
> +			return err;
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -665,10 +672,15 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
>  static void scsifront_sdev_destroy(struct scsi_device *sdev)
>  {
>  	struct vscsifrnt_info *info = shost_priv(sdev->host);
> +	struct xenbus_device *dev = info->dev;
> +	int err;
>  
> -	if (info && current == info->curr)
> -		xenbus_printf(XBT_NIL, info->dev->nodename,
> +	if (info && current == info->curr) {
> +		err = xenbus_printf(XBT_NIL, info->dev->nodename,
>  			      info->dev_state_path, "%d", XenbusStateClosed);

Same here.

> +		if (err)
> +			dev_err(&dev->dev, "writing dev_state_path\n");
> +	}
>  }
>  
>  static struct scsi_host_template scsifront_sht = {

-- 
