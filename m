Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9456DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747F20652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XZBG4Sca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5747F20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeJAOuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 10:50:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45889 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJAOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 10:50:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so11849828eds.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 01:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kjg56rlYPcSEzooE9WDVUxPUzYK52nWkqoiMxLx2x98=;
        b=XZBG4ScaQbYS17m/AGxKgYa2mHNJ9TaWqk1Zi2aRr6sgcNJrVwU6E6iJFM2RbsHmQY
         fPFtfVPjfFrZ/2OvV6siYpJmBpSbrT0Us4gKsMGLUpolQna/cG75zLiJ0RemAlxX8Vkc
         fBfl/CWX8K6d41qyQv0V9JIMTGXFO5HfLs0h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Kjg56rlYPcSEzooE9WDVUxPUzYK52nWkqoiMxLx2x98=;
        b=JKKFwyej+Fo0VqQcd/ABF/BdwcDlqN0e4I80T+2XLRrw36vSUrFh/ergDEBll9lrbW
         8DcfwkSW3lWvc4L/dQDes4Yh7Zpt1mH33/CftwiTnf71LtDowLyooQw2V7EKwXjvwJm2
         F1fGUMNz0RZP0F7ftQ5LZ8F1uoastrdxrnDAapzYDqcfE2O6/UARkJQxgdkrYSNDT/to
         0ydjOBnAxFXg4b/6Rdsaagon8jIziqrunSUzH4dgVU5UhU4Da1e/LR+dgQuI6r2N66+G
         svSm41Tbve8AGFVUwZqrF1ySmW4vLue3HKtK9aEwfcW9WGFwSXkXjzwRevEZCkGz+Gxb
         OiOw==
X-Gm-Message-State: ABuFfogZ3VPd+wmMoe1Lp6b7yi4iSwhHPPh2WXTkWPlquJ5ltW3+iYSR
        8DEUAXDHz42Xqh3rq/+Lbfe7qw==
X-Google-Smtp-Source: ACcGV61VHfat3xjMF1AfulqyQlXcTGW/Z+crhwHfUhzsyY7y393CLaYR21zw699uMGtxqou7A9MxWg==
X-Received: by 2002:a50:d09e:: with SMTP id v30-v6mr16542846edd.61.1538381651811;
        Mon, 01 Oct 2018 01:14:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id gw15-v6sm1956643ejb.57.2018.10.01.01.14.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 01:14:10 -0700 (PDT)
Date:   Mon, 1 Oct 2018 10:14:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] DRM: UDL: get rid of useless vblank initialization
Message-ID: <20181001081408.GV11082@phenom.ffwll.local>
Mail-Followup-To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
        linux-snps-arc@lists.infradead.org, Sean Paul <sean@poorly.run>
References: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928144126.21598-1-Eugeniy.Paltsev@synopsys.com>
X-Operating-System: Linux phenom 4.14.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 05:41:26PM +0300, Eugeniy Paltsev wrote:
> UDL doesn't support vblank functionality so we don't need to
> initialize vblank here (we are able to send page flip
> completion events even without vblank initialization)
> 
> Moreover current drm_vblank_init call with num_crtcs > 0 causes
> sending DRM_EVENT_FLIP_COMPLETE event with zero timestamp every
> time. This breaks userspace apps (for example weston) which
> relies on timestamp value.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/udl/udl_main.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
> index f455f095a146..1b014d92855b 100644
> --- a/drivers/gpu/drm/udl/udl_main.c
> +++ b/drivers/gpu/drm/udl/udl_main.c
> @@ -350,15 +350,10 @@ int udl_driver_load(struct drm_device *dev, unsigned long flags)
>  	if (ret)
>  		goto err;
>  
> -	ret = drm_vblank_init(dev, 1);
> -	if (ret)
> -		goto err_fb;
> -
>  	drm_kms_helper_poll_init(dev);
>  
>  	return 0;
> -err_fb:
> -	udl_fbdev_cleanup(dev);
> +
>  err:
>  	if (udl->urbs.count)
>  		udl_free_urb_list(dev);
> -- 
> 2.14.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
