Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104F1ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABA9214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dd8bh/Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABA9214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbeIRAop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:44:45 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46323 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbeIRAop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:44:45 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so8219361ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 12:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e0y/zkalFCasYLTyI4ojbO1sEmeLgsjSH2FsUdC9z+Q=;
        b=dd8bh/Zm6CGlSoD3tAcfy6kscIcqGhka90nX1K2I1tmMDeHFwJH8yxpsOo7D6HkKGU
         xCF2E0kHLwQUEipQYJVa1Y1tiRvhXQowjKr0sitTZjDGPk4YKm+ZUGAEjAYqdAuJYYnJ
         XbgJaLEQifQHYGp35zo/MQghiaSrHMaqTQN5HTidiXNKSoESM/TntiK+0j4zbkgyK1pu
         NJeOoWxNjl9ypP96HYmZgTDdukFbX9HIQriF3O+toeCQxT1KPvWaPKoiuD8QNld4wsFv
         Sg3BUEFnyxD010Uxt7O1SgpMBoKzCx/Ynl/qLmpNdixbW40Vsp8V74Dq0wf7OQr2UwwR
         Qz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e0y/zkalFCasYLTyI4ojbO1sEmeLgsjSH2FsUdC9z+Q=;
        b=ZQEmel9FxhjuMdbtyUEqMEZ0GR3fmzcDvhQ1HNr+COrtIyWNivHXQPYgXVWf0dSCU+
         +JNVqwZv4PP9f/US9qhE0OqS/Rvv8QYVDnHfyEexM3siT/lSmk9TvlMZbjOcCOinwwFF
         ykBh2GygLT0Hj3DNkXElTJ3uhILmj1ytDZn9orJFeDa7Ozb+OdBngw1ka90xJiwKanDI
         O3PMduHDq8peLOycsrBHbnm1VCG5SnbJSIMoH/iHyM6i8wEvnU+QGIoNup9cKlTlCLci
         Pr5Qtuct5hsbEWZKI7mwVnDtcMSgC1igI3x/xGxPBJDHR+9lF7OOwj20cla1jRohrbu1
         ttxw==
X-Gm-Message-State: APzg51DYr6s0CJ6Gt7q8uvEYj2TXJfs0wRLL7FLaiLnQk4If1nw8PCAK
        zv/C44ZGoG4LMh9CkZmY/HQ1jw==
X-Google-Smtp-Source: ANB0VdYzuByViPQ8vMvly5nIPniT01Lko+rcZf0KSNWWdQ933RQoxHuwyQOadD5pCiddw7vUktJ+sw==
X-Received: by 2002:a25:8605:: with SMTP id y5-v6mr130573ybk.297.1537211763382;
        Mon, 17 Sep 2018 12:16:03 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id g131-v6sm7662230ywh.70.2018.09.17.12.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:16:02 -0700 (PDT)
Date:   Mon, 17 Sep 2018 15:16:02 -0400
From:   Sean Paul <sean@poorly.run>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Robert Chiras <robert.chiras@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        dri-devel@lists.freedesktop.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Message-ID: <20180917191602.GP188300@art_vandelay>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 04:42:10PM +0300, Leonard Crestez wrote:
> Adding lcdif nodes to a power domain currently doesn't work, it results
> in black/corrupted screens or hangs. While the driver does enable
> runtime pm it does not deal correctly with the block being unpowered.
> 
> ---
> 
> All patches in this series have review tags from a while ago and I
> tested them again on top of next-20180913. No changes since last
> version: https://lkml.org/lkml/2018/8/27/299
> 
> This series stalled so I reached out to Marek on IRC and he was
> surprised to be listed as maintainer 

Hopefully not too surprised since Marek added themself to MAINTAINERS when
adding the driver :-)

I suppose we should probably move this to drm-misc since it qualifies as a
"small driver" and needs a home. Looking through git history shows the last
mxsfb-specific change was back in 02/17. Everything else has been drm-wide
refactors. Thoughts?

Marek/Leonard: Care to sign up to be listed as a reviewers?

Sean

> and asked me to resend and add
> Daniel Vetter.
> 
> Perhaps it would help to clarify that the pengutronix people should feel
> free to push patches in this area?
> 
> Right now drm/imx is mostly for IPUv3 but there are other display output
> paths on imx, such as the LCDIF supported by this driver. This LCDIF
> block is included on imx8 so still quite relevant.
> 
> Leonard Crestez (5):
>   drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
>   drm/mxsfb: Fix initial corrupt frame when activating display
>   drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
>   drm/mxsfb: Add PM_SLEEP support
>   drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm
> 
>  drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 19 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
