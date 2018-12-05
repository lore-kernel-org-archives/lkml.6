Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87527C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4942920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivvyPCoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4942920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLEJfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:35:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:36170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbeLEJfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:35:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827382084C;
        Wed,  5 Dec 2018 09:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002510;
        bh=z4fNNDin4XZasXuNnO209IwEyQvSjt/9m3fUTAiOgok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivvyPCoZeWX65e403JBsAJzhu2ie3LGf1c/s3t2fdO9oHXfQWp/J8hU6PjCvFVFYZ
         KUKEYe7eeiMWbPxajzZHfPcwovF6L7FIieCEzRXNTvg8SR/T0FZsBXGzVjfqB419+V
         TlCihhoKZofRjJ3nrY7xLnf4eSQOnLaHG9p9trtE=
Date:   Wed, 5 Dec 2018 10:35:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kyle Williams <kdgwill@chromium.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Rajat Jain <rajatja@chromium.org>,
        Harry Pan <harry.pan@intel.com>,
        Julius Werner <jwerner@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Maxence =?iso-8859-1?Q?Dupr=E8s?= <xpros64@hotmail.fr>,
        Dmitry Fleytman Dmitry Fleytman <dmitry.fleytman@gmail.com>,
        Danilo Krummrich <danilokrummrich@dk-develop.de>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: quirks: add NO_LPM quirk for Logitech Rally Camera
Message-ID: <20181205093507.GC1817@kroah.com>
References: <CAAd214VGLYUSE10AEfk+ujjnXRDr9-HxhtucoLKLVR35vzH3Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd214VGLYUSE10AEfk+ujjnXRDr9-HxhtucoLKLVR35vzH3Rw@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 07:59:09AM -0500, Kyle Williams wrote:
> Description: Some USB device / host controller combinations seem to have
> problems with Link Power management. In particular it is described that
> the combination of a Logitech Rally and Atrus device causes
> 'not enough bandwidth for new device state'error
> 
> This patch creates quirk entries for the Logitech Rally Camera
> indicating LPM should remain disabled for the device.
> 
> Signed-off-by: Kyle Williams <kdgwill@chromium.org>
> Reviewed-on: https://chromium-review.googlesource.com/1297535
> Commit-Ready: Kyle Williams <kdgwill@chromium.org>
> Tested-by: Kyle Williams <kdgwill@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> ---
>  drivers/usb/core/quirks.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
> index 2deac3a55957..49c44d89a394 100644
> --- a/drivers/usb/core/quirks.c
> +++ b/drivers/usb/core/quirks.c
> @@ -224,6 +224,11 @@ static const struct usb_device_id usb_quirk_list[] = {
>   /* Logitech Logitech Screen Share */
>   { USB_DEVICE(0x046d, 0x086c), .driver_info = USB_QUIRK_NO_LPM },
> 
> + /* Logitech Rally Camera */
> + { USB_DEVICE(0x046d, 0x0881), .driver_info = USB_QUIRK_NO_LPM },
> + { USB_DEVICE(0x046d, 0x0888), .driver_info = USB_QUIRK_NO_LPM },
> + { USB_DEVICE(0x046d, 0x0889), .driver_info = USB_QUIRK_NO_LPM },
> +
>   /* Logitech Quickcam Fusion */
>   { USB_DEVICE(0x046d, 0x08c1), .driver_info = USB_QUIRK_RESET_RESUME },
> 

This patch had all tabs stripped out of it, and was sent in html :(

