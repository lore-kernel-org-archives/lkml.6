Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B51EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3B121386
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OV2D6+Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3B121386
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934215AbeGCQ7U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:59:20 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:45479 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933860AbeGCQ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:59:18 -0400
Received: by mail-yb0-f196.google.com with SMTP id h127-v6so991286ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vsxPlBMAxMUYN6TdoBmTjoXy54aM/jxdijRQBb7aO/M=;
        b=OV2D6+Wcnq5/+SFjnY5VM0uBW3LhHy1KaVKHnDi/qetPJ2wn0RyLucPoFziZ6KJuB+
         Q377KQZl0MtPAkO0xn/n5K68SpdKxiLg1lUakKM3yU0BVEYz2jgY2D3IeRxG6xx8BG/5
         BvvLSByBYzlrAW2ALZO0O1N63WIcBTSWj55fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vsxPlBMAxMUYN6TdoBmTjoXy54aM/jxdijRQBb7aO/M=;
        b=gYYbsXAkNpFeiKTQ7ZDZTsLidY33QihNnZTPCtZFpiWoIjFK7khxKxXAHpgGa/aWU+
         zgPrg+ctnNmwoig7zjx1rR40PXT+VzuVrykk7dd0IfVQMwwpL7R1X9FqYxjGRjNgSCmf
         pa0k/fH6hJ9xAw/rkduhhV3xXDrYmCIntrFq/6n9hqHhapfDdCC0j+EpyiFQskAZrxMu
         aM8w5sf2RDEC6ai42dPGW2fl57mFVxfzo9QtqEMLCAfDqq2o9CGchdai+gVRLSSLVGAy
         M2f1Qz12IqQJ2+jR6m34QBdTriGnMJ9al8MjGsXigQVatzFNEp0qJmDr7vDtBaZd5KFC
         auKA==
X-Gm-Message-State: APt69E3p44uHrDtGP4cFsMMmDW8om9JvIeu6O10MqDe1T5BP9lYudiXO
        TWuFwlCKNJg7+kNLwFjb+UmkaP3TcXw=
X-Google-Smtp-Source: AAOMgpd1kwVFomHubqzY8Am80bZj1JCUHOQtsGmk9wCnNIWV3oaGmOxVuGm6aPd92o4eD0umyIL9gw==
X-Received: by 2002:a25:b441:: with SMTP id c1-v6mr845099ybg.424.1530637158389;
        Tue, 03 Jul 2018 09:59:18 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id a68-v6sm616821ywh.12.2018.07.03.09.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 09:59:17 -0700 (PDT)
Date:   Tue, 3 Jul 2018 12:59:17 -0400
From:   Sean Paul <seanpaul@chromium.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/mdp5: fix missing CTL flush
Message-ID: <20180703165917.GA20359@art_vandelay>
References: <20180703164403.23877-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703164403.23877-1-robdclark@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 03, 2018 at 12:43:50PM -0400, Rob Clark wrote:
> f9cb8d8d836e fixed various race conditions with CTL flush, in particular
> flushing and sending the START signal before encoder state was updated.
> But it did this a little too well in some cases that don't trigger
> encoder->enable(), and CTL[n].FLUSH would never be set.  When page flips
> happen it would paper over the bug, since the first plag flip would
> flush out the state to the hardware.
> 
> The issue could be reproduced with, for example, modetest (without the
> '-v' argument).
> 
> Fixes: f9cb8d8d836e drm/msm/mdp5: rework CTL START signal handling
> Signed-off-by: Rob Clark <robdclark@gmail.com>

Reviewed-by: Sean Paul <seanpaul@chromium.org>

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> index 9af94e35f678..fcd44d1d1068 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c
> @@ -319,7 +319,17 @@ static int mdp5_encoder_atomic_check(struct drm_encoder *encoder,
>  
>  	mdp5_cstate->ctl = ctl;
>  	mdp5_cstate->pipeline.intf = intf;
> -	mdp5_cstate->defer_start = true;
> +
> +	/*
> +	 * This is a bit awkward, but we want to flush the CTL and hit the
> +	 * START bit at most once for an atomic update.  In the non-full-
> +	 * modeset case, this is done from crtc->atomic_flush(), but that
> +	 * is too early in the case of full modeset, in which case we
> +	 * defer to encoder->enable().  But we need to *know* whether
> +	 * encoder->enable() will be called to do this:
> +	 */
> +	if (drm_atomic_crtc_needs_modeset(crtc_state))
> +		mdp5_cstate->defer_start = true;
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
