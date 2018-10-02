Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A489C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C1420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EWzSSDHu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48C1420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJBO42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:56:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43785 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbeJBO42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:56:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a4-v6so1224914eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 01:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgegIQ/byNt8xV1I27XfF+twtuqfNZLc6USJrQVa6Ew=;
        b=EWzSSDHuTh2Pof4KiSgg28UnElBctb7qwgVE5xH0nopa59GJf3quuEcn0gI/51FVpw
         l+Alv48GzRGqyuHIeVPBTEQrAByhja41Wa3JrjvkxI2rwK//0U0VOsOmOKTXWisMV4tN
         +e81AkYl8ZAf8AtQ1YUMh+PZvAtd7F7T1ojeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RgegIQ/byNt8xV1I27XfF+twtuqfNZLc6USJrQVa6Ew=;
        b=J5C7Rj9d7S1NKycPf9hGnaSlMkWVrMp8KyDtZxjd6+LFt6gOl8SQb2wk9cG5wr941s
         3PL5g67xuFmBXCoYhXrUFznPvt8EMIQDDX+/tyFsajswkJzvvw2MeQGQiLvAI5SNuWVV
         4Nb2WBb35/mSiAxKDPsgsrkIIYRR5iN4K2M4lLZsaWcRB0C2HnuMqoMApVgWdlcudsm0
         9ba8Kb4M/jl13STYnRy+Q5AagOYJzoXxtVBWlUQNfwR5db8h/Jier33jsGZ4hSeHdeEw
         4GM2/zBV8BlLSORrG7KQcm1408RCx+LNM9L1/Qbg2D/rIKJpTVLsL4hfiixGg57xCpgG
         Pa1A==
X-Gm-Message-State: ABuFfoiLyu2SXRxhxvhR+f/jXUocm84vc4ZSSISUgqOYzNOtfmCr/1fX
        ZCMVlyIjcC/SnlOFPKY2KpSJAw==
X-Google-Smtp-Source: ACcGV61H61KXkhN4pPLb9CO719G5v2pQjSlU8x8xyUuswS0pT1n8GIfMLWueqawu/kaTFsUDKgEfJQ==
X-Received: by 2002:aa7:c883:: with SMTP id p3-v6mr6979191eds.295.1538468065115;
        Tue, 02 Oct 2018 01:14:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id i38-v6sm3246145ede.83.2018.10.02.01.14.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:14:24 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:14:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peter Wu <peter@lekensteyn.nl>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] qxl: fix null-pointer crash during suspend
Message-ID: <20181002081422.GH11082@phenom.ffwll.local>
Mail-Followup-To: Peter Wu <peter@lekensteyn.nl>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
References: <20180904202747.14968-1-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904202747.14968-1-peter@lekensteyn.nl>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:27:47PM +0200, Peter Wu wrote:
> "crtc->helper_private" is not initialized by the QXL driver and thus the

This is still initialized, it's the ->disable that goes boom. At least the
call to drm_crtc_helper_add is still there. The ->disable was removed in:

commit 64581714b58bc3e16ede8dc37a025c3aa0e0eef1
Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:   Fri Jun 30 12:36:45 2017 +0300

    drm: Convert atomic drivers from CRTC .disable() to .atomic_disable()

Fixes: 64581714b58b ("drm: Convert atomic drivers from CRTC .disable() to .atomic_disable()")
Cc: <stable@vger.kernel.org> # v4.14+
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

I'll let Gerd pick this one up, after some testing. Also adding Laurent.
-Daniel

> "crtc_funcs->disable" call would crash (resulting in suspend failure).
> Fix this by converting the suspend/resume functions to use the
> drm_mode_config_helper_* helpers.
> 
> Tested system sleep with QEMU 3.0 using "echo mem > /sys/power/state".
> During suspend the following message is visible from QEMU:
> 
>     spice/server/display-channel.c:2425:display_channel_validate_surface: canvas address is 0x7fd05da68308 for 0 (and is NULL)
>     spice/server/display-channel.c:2426:display_channel_validate_surface: failed on 0
> 
> This seems to be triggered by QXL_IO_NOTIFY_CMD after
> QXL_IO_DESTROY_PRIMARY_ASYNC, but aside from the warning things still
> seem to work (tested with both the GTK and -spice options).
> 
> Signed-off-by: Peter Wu <peter@lekensteyn.nl>
> ---
> Hi,
> 
> I found this issue while trying to suspend a VM that uses QXL. In order to see
> the stack trace over serial, boot with no_console_suspend. Searching for
> "qxl_drm_freeze" showed one recent report from Alan:
> https://lkml.kernel.org/r/891e334c-cf19-032c-b996-59ac166fcde1@gmail.com
> 
> Kind regards,
> Peter
> ---
>  drivers/gpu/drm/qxl/qxl_drv.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> index 2445e75cf7ea..d00f45eed03c 100644
> --- a/drivers/gpu/drm/qxl/qxl_drv.c
> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> @@ -136,20 +136,11 @@ static int qxl_drm_freeze(struct drm_device *dev)
>  {
>  	struct pci_dev *pdev = dev->pdev;
>  	struct qxl_device *qdev = dev->dev_private;
> -	struct drm_crtc *crtc;
> -
> -	drm_kms_helper_poll_disable(dev);
> -
> -	console_lock();
> -	qxl_fbdev_set_suspend(qdev, 1);
> -	console_unlock();
> +	int ret;
>  
> -	/* unpin the front buffers */
> -	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
> -		const struct drm_crtc_helper_funcs *crtc_funcs = crtc->helper_private;
> -		if (crtc->enabled)
> -			(*crtc_funcs->disable)(crtc);
> -	}
> +	ret = drm_mode_config_helper_suspend(dev);
> +	if (ret)
> +		return ret;
>  
>  	qxl_destroy_monitors_object(qdev);
>  	qxl_surf_evict(qdev);
> @@ -175,14 +166,7 @@ static int qxl_drm_resume(struct drm_device *dev, bool thaw)
>  	}
>  
>  	qxl_create_monitors_object(qdev);
> -	drm_helper_resume_force_mode(dev);
> -
> -	console_lock();
> -	qxl_fbdev_set_suspend(qdev, 0);
> -	console_unlock();
> -
> -	drm_kms_helper_poll_enable(dev);
> -	return 0;
> +	return drm_mode_config_helper_resume(dev);
>  }
>  
>  static int qxl_pm_suspend(struct device *dev)
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
