Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871C3C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9C423F0A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 08:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fCfsrTDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9C423F0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFVIe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 04:34:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43819 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751198AbeFVIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 04:34:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id d16-v6so766561edp.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xaDWqX895g71QcxGX/1yFpjjxxuVEn5blDe7CIiOWvg=;
        b=fCfsrTDv5Bk9VCU4DUBeM4ZlaQPt+KnwnTwuXeipwjtRuM6zhAQOXasDgsT6OmNId7
         HuMT0SGxCs0tfCPhe3BvvPZ96ghhiSpsnB63K7VCyxei5/ALAHa1DlsGWEloT20/ueeU
         GM/qzhfcBvjTFK0cHNNMB6buMnHOfQxT84mEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=xaDWqX895g71QcxGX/1yFpjjxxuVEn5blDe7CIiOWvg=;
        b=CJs9TicoLcnqum9S7/AKJP0QpfvdZiBvYjb0LvNUUKFZdYMwq+2AdMzxrayuAG7btO
         0m/d/rDOP/653chkTuD1h+Qf+tiZvOUGfBLMC8LIvlBOPOTCirXU924bcfPY9el0uGVg
         BBMDP2fjROreClPP5zBxPS5qkqqc5T1TzjVkanWnSpnqshLr29vAKEYz+EV3j2hVOxY7
         jlx/KTE87G0NhAEKCKFKHAx43smmldUj5LQk85FB+ywlLUNWQjNTvK7el4sQfxwimZMe
         3DnSeFofM8B3XNx6FYrO8AbYklJI5DXlO5W8YCksbtD5TxT6gLLii29pC5idBmjDtOgY
         GGtQ==
X-Gm-Message-State: APt69E0jxWQlvAPlA8qCm8Ek7ZGJkNnII3cdCpyogltg5BJf20siH5Ou
        FF6gi4KvNk9B6NOJ3e9JqCxUiDvY
X-Google-Smtp-Source: ADUXVKKnbqPprTIYkXv3Ia8uLKA7PeQBrhlfDPTGN2m75rdctCOT8hN/NZoJenCOT5b7TAozFMOrPA==
X-Received: by 2002:a50:b942:: with SMTP id m60-v6mr1029250ede.20.1529656491638;
        Fri, 22 Jun 2018 01:34:51 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:5628:0:496f:7dc5:66d7:a057])
        by smtp.gmail.com with ESMTPSA id c46-v6sm3658374edc.34.2018.06.22.01.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 01:34:50 -0700 (PDT)
Date:   Fri, 22 Jun 2018 10:34:48 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [RFC][PATCH] drm: kirin: Remove useless "Scale not support"
 error message
Message-ID: <20180622083448.GH2958@phenom.ffwll.local>
Mail-Followup-To: John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Peter Griffin <peter.griffin@linaro.org>,
        dri-devel@lists.freedesktop.org
References: <1529622076-20386-1-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529622076-20386-1-git-send-email-john.stultz@linaro.org>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 04:01:16PM -0700, John Stultz wrote:
> The driver doesn't support scaling, but when an atomic test is done
> it repeatedly spits out this warning which isn't particularly useful.
> 
> So just remove the error message.
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Makes sense, applied to drm-misc-next. This code should probably use
drm_atomic_helper_check_plane_state() anyway, which also comes with a
useful set of opt-in debug output to replace this.
-Daniel

> ---
>  drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> index 2269be9..bb77420 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
> @@ -859,7 +859,6 @@ static int ade_plane_atomic_check(struct drm_plane *plane,
>  		return PTR_ERR(crtc_state);
>  
>  	if (src_w != crtc_w || src_h != crtc_h) {
> -		DRM_ERROR("Scale not support!!!\n");
>  		return -EINVAL;
>  	}
>  
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
