Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54835C6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1435A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 15:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mE2MI1Yf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1435A2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeLJPvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 10:51:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33870 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728286AbeLJPvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 10:51:21 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so5447058plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 07:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:message-id:to
         :subject:from:user-agent:references:cc:date;
        bh=SWfL4mPcRIcopNB53EPC5zMJ8VujMRxXkrbFAB/Gagc=;
        b=mE2MI1Yf+8BYi7uDzbXn2jP1bw+3abbQSy49LYfn26pLTqN3DWTixVWavD533Pp0xp
         AOzRXBwqx9/RHKF9C2b5VEXcL8Db42cYGiWxhnwFUA+tgDLF9CEIwUjpcTH8NK4uSgrB
         ptEzLwXQJy2xmABjXEOjctJC0WG/fvxTceCw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:message-id:to:subject:from:user-agent:references:cc
         :date;
        bh=SWfL4mPcRIcopNB53EPC5zMJ8VujMRxXkrbFAB/Gagc=;
        b=bdUOEGN95obWzoIdr4lLNf8wbfA1M3+LVS3b9yX7TBgKp2PRMaa3KBLnlF+6Zuk7BE
         WYCKNUMmhJvtXUe8cWV5RoiZhRs9YOmrNDEXIxmXRtEdB8J402QxqzyMlzYmhWOGhcox
         UliDV8aXi2uKH8lC5ZSGBsAOE/3vLVf32POFW81hULesfhnoZ14IqurZZowWy9ibwBeK
         JbjdJoDhh+9rUXgMsVNx/ZGY2e2T1CYgn1trXYCdK/iihzHcID6r0D++fBUZc1ZJZ8Oc
         lTfjAYlVmsuy2D2lzPzL5r8tKdddKiNfzBmcvQTCHt1V7iyWEzyzQGgBmlmyQPoSO4Uw
         GaNw==
X-Gm-Message-State: AA+aEWbPtggjmq6qyLfIfhHc8atKm1yg8UmYQ+nYh4QnV/bv5x1KlgRx
        pGyJm0N6Ug+6BKnUp/2YzUKiFQ==
X-Google-Smtp-Source: AFSGD/WWGxIJiRGtee62rzcr2ey0vIsUXYFUZvEQY49MhbcBNOxmKjbyD90drsicd73TGkF6+7U9Cw==
X-Received: by 2002:a17:902:3124:: with SMTP id w33mr12636333plb.241.1544457080992;
        Mon, 10 Dec 2018 07:51:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 12sm11830311pgd.35.2018.12.10.07.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 07:51:20 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181204224234.62619-5-mka@chromium.org>
Message-ID: <154445707953.17204.10100324387384439759@swboyd.mtv.corp.google.com>
To:     Andy Gross <andy.gross@linaro.org>,
        David Airlie <airlied@linux.ie>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 4/8] drm/msm/dsi: 14nm PHY: Get ref clock from the DT
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.7
References: <20181204224234.62619-1-mka@chromium.org> <20181204224234.62619-5-mka@chromium.org>
Cc:     Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Date:   Mon, 10 Dec 2018 07:51:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2018-12-04 14:42:30)
> diff --git a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c b/drivers/gpu/drm=
/msm/dsi/pll/dsi_pll_14nm.c
> index 71fe60e5f01f1..032bf3e8614bd 100644
> --- a/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> +++ b/drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
> @@ -40,7 +40,6 @@
> =20
>  #define NUM_PROVIDED_CLKS              2
> =20
> -#define VCO_REF_CLK_RATE               19200000
>  #define VCO_MIN_RATE                   1300000000UL
>  #define VCO_MAX_RATE                   2600000000UL
> =20
> @@ -139,6 +138,7 @@ struct dsi_pll_14nm {
>         /* protects REG_DSI_14nm_PHY_CMN_CLK_CFG0 register */
>         spinlock_t postdiv_lock;
> =20
> +       struct clk *vco_ref_clk;

Is there any need to keep it in the struct? Or just get the clk, find
the rate, and then put the clk and call pll_14nm_postdiv_register()?

>         u64 vco_current_rate;
>         u64 vco_ref_clk_rate;
> =20
