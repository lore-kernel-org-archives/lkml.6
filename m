Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265AC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D282C214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 00:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YjyNLa9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfA2AFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 19:05:37 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34033 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfA2AFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 19:05:37 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so8514154plz.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ELdkaiedanPeQEeDOYORc6tkeZC/vYu+kvBFX8INGuA=;
        b=YjyNLa9GRoV3pFAXFRFcuQ/zjN6QbHBIC56vAy2/C4d9/T99KgcQabygV4moZ1aCpe
         /tZq4f5pmOakntj5zukr7A7Fmypo4P6JO27VnPuTut9G7MTd8wPDFuA+gAiTP5cKZd+G
         f74dC/Nrh+ti7wgqdJe6FOaaaemNM++8XevL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ELdkaiedanPeQEeDOYORc6tkeZC/vYu+kvBFX8INGuA=;
        b=HtgjZ/3FClssiUty5NT0QC8hJhphnfSVdLHLLOxvjcK633jF6SRQCpovWvXsYOlkq/
         P8GhJqscgNYKkuPtnfZZ0IRyaF2XnmmTS+RwIpE7MulURU4jPlTtnfaMwn+Sl5FwETT2
         A2y8KaJhxBomyxiTtyDE/vPs4sQE9LkUARRsVmH+w+oTiOdSLE7VRs2VR7TV14iGAS00
         3o1nvMYcpnHwnssckCEKYO5ZoxgvTi232r0PU9HgTZBdd7Cvsm2NElWA1+Rh6oJCzO4l
         RO7nswWFYmHfHzQug4VnOraXH0ChOUlA2qkTSmm25fBDg4AdpuyWW7tLILCN44oxRMbK
         BaRQ==
X-Gm-Message-State: AJcUukeJaEClCtCtxNVt22SldHpiTXF5jCnpGLHfhLufeod2HV8H4s6L
        K2mwuT+D6dA5NOozyvyukZQakw==
X-Google-Smtp-Source: ALg8bN4XgCtoCOxj/Z99erdgtXr+juFko7ptB4V+aBHFabNEco7+HeRFQ+7T3VtTT8ZwIgTqrpwEJg==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr23972630plt.134.1548720336507;
        Mon, 28 Jan 2019 16:05:36 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id b7sm53930160pga.39.2019.01.28.16.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 16:05:35 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:05:34 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Archit Taneja <architt@codeaurora.org>,
        Sean Paul <seanpaul@chromium.org>,
        Rajesh Yadav <ryadav@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>
Subject: Re: [PATCH v5 0/8] drm/msm/dsi: Get PHY ref clocks from the DT
Message-ID: <20190129000534.GJ81583@google.com>
References: <20181219235528.114830-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181219235528.114830-1-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series has gone through multiple rounds of review and there are
no outstanding comments. It seems it should be ready to land, or is
there anything left that needs to be addressed?

Thanks

Matthias

On Wed, Dec 19, 2018 at 03:55:20PM -0800, Matthias Kaehlcke wrote:
> The MSM DSI PHY drivers currently hardcode the name and the rate of
> the PHY ref clock. Get the ref clock from the device tree instead.
> 
> Note: testing of this series was limited to SDM845 and the 10nm PHY
> 
> Major changes in v5:
> - none (see per-patch change log for minor changes)
> 
> Major changes in v4:
> - always use parent rate for 28nm and 28nm 8960 PHYs
> 
> Major changes in v3:
> - keep supporting DTs without ref clock for the 28nm and the 28nm
>   8960 PHYs
> - added patch to add ref clock to qcom-apq8064.dtsi
> 
> Major changes in v2:
> - apply to all MSM DSI PHY drivers, not only 10nm
> 
> Matthias Kaehlcke (8):
>   dt-bindings: msm/dsi: Add ref clock for PHYs
>   drm/msm/dsi: 28nm 8960 PHY: Get ref clock from the DT
>   drm/msm/dsi: 28nm PHY: Get ref clock from the DT
>   drm/msm/dsi: 14nm PHY: Get ref clock from the DT
>   drm/msm/dsi: 10nm PHY: Get ref clock from the DT
>   arm64: dts: qcom: msm8916: Set 'xo_board' as ref clock of the DSI PHY
>   arm64: dts: sdm845: Set 'bi_tcxo' as ref clock of the DSI PHYs
>   ARM: dts: qcom-apq8064: Set 'xo_board' as ref clock of the DSI PHY
> 
>  .../devicetree/bindings/display/msm/dsi.txt   |  1 +
>  arch/arm/boot/dts/qcom-apq8064.dtsi           |  5 +--
>  arch/arm64/boot/dts/qcom/msm8916.dtsi         |  5 +--
>  arch/arm64/boot/dts/qcom/sdm845.dtsi          | 10 +++---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c    | 20 +++++++++--
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c    | 23 +++++++++---
>  drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c    | 36 +++++++++++++------
>  .../gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c   | 24 ++++++++++---
>  8 files changed, 92 insertions(+), 32 deletions(-)
> 
