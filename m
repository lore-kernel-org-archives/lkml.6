Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0614CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0D421741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 14:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeL0OiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 09:38:13 -0500
Received: from hermes.aosc.io ([199.195.250.187]:59230 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbeL0OiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 09:38:12 -0500
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 2DE8A15E503;
        Thu, 27 Dec 2018 14:38:08 +0000 (UTC)
Message-ID: <4f331bc4bdfdeeec98a9a59b097ee8c36d597cfe.camel@aosc.io>
Subject: Re: [PATCH 1/2] USB: storage: don't insert sane sense for SPC3+
 when bad sense specified
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
Date:   Thu, 27 Dec 2018 22:38:05 +0800
In-Reply-To: <20181227143437.17151-2-icenowy@aosc.io>
References: <20181227143437.17151-1-icenowy@aosc.io>
         <20181227143437.17151-2-icenowy@aosc.io>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018-12-27四的 22:34 +0800，Icenowy Zheng写道：
> Currently the code will set US_FL_SANE_SENSE flag unconditionally if
> device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
> prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
> which claims SPC4, will show strange behavior with 96-byte sense
> (put the chip into a wrong state that cannot read/write anything).
> 
> Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE
> on
> SPC4+ devices.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

I forgot to:

Cc: stable@vger.kernel.org

>  drivers/usb/storage/scsiglue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c
> b/drivers/usb/storage/scsiglue.c
> index fde2e71a6ade..699fe9557127 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -236,7 +236,8 @@ static int slave_configure(struct scsi_device
> *sdev)
>  			sdev->try_rc_10_first = 1;
>  
>  		/* assume SPC3 or latter devices support sense size >
> 18 */
> -		if (sdev->scsi_level > SCSI_SPC_2)
> +		if (sdev->scsi_level > SCSI_SPC_2 &&
> +		    !(us->fflags & US_FL_BAD_SENSE))
>  			us->fflags |= US_FL_SANE_SENSE;
>  
>  		/*

