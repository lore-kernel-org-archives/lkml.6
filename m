Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5F2C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1974E20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="A4sN8ZE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1974E20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=poorly.run
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIZOZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:25:14 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38020 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZOZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:25:14 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so10959913ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NdnN4SfQ44YwgQ8rObNfKien4uGhVxz3nQuD8q4giV4=;
        b=A4sN8ZE8ARHs1vMzGSE2wwHokZRnL2gmBiCZK6veT2rO5zZO3fg1gWmbCa4aeYrapz
         d12NQgU8G1xcHH/ZKbDTST8+acy/7uyAGaO4XgEGuQar/sRabPoyIC64emJh+22TWLWT
         Z5ICTkjVTCLEZD/N019GzyUKR7U7qbahj5Nyd805nPC4RUurScFsgZ43ntPO+7OXybzG
         Npw/CWMfII4YruXmgLtQJlR3n9mPr9nuOSYs8HzEeCz81piJFaR8Yy+Kzw4MeoP7hzHX
         Hj91YhxZefXxt4J8So4lqBk6zITB1Qx/QyMjhBf9rCaQ7EqDF+93hp0kPFJ7QyACmcWY
         uhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NdnN4SfQ44YwgQ8rObNfKien4uGhVxz3nQuD8q4giV4=;
        b=iFcEAo4AjZ4GPv/B7HoD5qtV47Hotv0Z4ZPq06Bhq4Y6z7P4RKVZVFHF1O/PDR/HMo
         FaGSOdiupLgYGNw/JiseoM1o7C3R3394RuzsT8my2ihoDEZi/S2VeIvd/INgMl9hsd4Z
         cpe7w/1t/CGY+QhpP6g6pPhWMsvMfHs1WjWx2ptgoxRiTUY7Ivd44q1p2OV8gnsVp8CI
         mTTuT3xa4OrhtO7kiL9416vbr0FIACBp2nx6GdoHMFE2/JI/r5xz7r1Ec3eK73bVKraU
         RHWrLBzqClPrFDRzHarE0F9iNCAQ66SwY9BYuvYeMqtL16IQ1jkLlbDeCSBeXPg3qyGT
         36LA==
X-Gm-Message-State: ABuFfohOxfc4zg37sT1ibEuZ9+i3ZdORXwBSUJI64pMzW6GWFfUTH2tu
        +CevtYhUkYmM8dpZe+xzKN/3iA==
X-Google-Smtp-Source: ACcGV60YRaUDm8T195G6MRQLihT+uZeSlwhTLrw+WT6yGkL9+23x1nY+umRVD3hPhyJBRFVV3RuZhQ==
X-Received: by 2002:a25:9b43:: with SMTP id u3-v6mr2456360ybo.86.1537949610618;
        Wed, 26 Sep 2018 01:13:30 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:ad55:b1db:adfe:3b9f])
        by smtp.gmail.com with ESMTPSA id z125-v6sm1773609ywe.72.2018.09.26.01.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 01:13:30 -0700 (PDT)
Date:   Wed, 26 Sep 2018 04:13:29 -0400
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
Message-ID: <20180926081329.GO72545@art_vandelay>
References: <cover.1537191359.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1537191359.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> surprised to be listed as maintainer and asked me to resend and add
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

The whole set is

Reviewed-by: Sean Paul <seanpaul@chromium.org>


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
