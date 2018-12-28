Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C18C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7066720874
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbeL1QAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 11:00:38 -0500
Received: from netrider.rowland.org ([192.131.102.5]:52645 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726462AbeL1QAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 11:00:38 -0500
Received: (qmail 8157 invoked by uid 500); 28 Dec 2018 11:00:37 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Dec 2018 11:00:37 -0500
Date:   Fri, 28 Dec 2018 11:00:36 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Icenowy Zheng <icenowy@aosc.io>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] USB: storage: don't insert sane sense for SPC3+ when
 bad sense specified
In-Reply-To: <20181227143437.17151-2-icenowy@aosc.io>
Message-ID: <Pine.LNX.4.44L0.1812281059370.7523-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2018, Icenowy Zheng wrote:

> Currently the code will set US_FL_SANE_SENSE flag unconditionally if
> device claims SPC3+, however we should allow US_FL_BAD_SENSE flag to
> prevent this behavior, because SMI SM3350 UFS-USB bridge controller,
> which claims SPC4, will show strange behavior with 96-byte sense
> (put the chip into a wrong state that cannot read/write anything).
> 
> Check the presence of US_FL_BAD_SENSE when assuming US_FL_SANE_SENSE on
> SPC4+ devices.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/usb/storage/scsiglue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index fde2e71a6ade..699fe9557127 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -236,7 +236,8 @@ static int slave_configure(struct scsi_device *sdev)
>  			sdev->try_rc_10_first = 1;
>  
>  		/* assume SPC3 or latter devices support sense size > 18 */
> -		if (sdev->scsi_level > SCSI_SPC_2)
> +		if (sdev->scsi_level > SCSI_SPC_2 &&
> +		    !(us->fflags & US_FL_BAD_SENSE))
>  			us->fflags |= US_FL_SANE_SENSE;

Please update the comment so that it matches the new code.

Alan Stern

