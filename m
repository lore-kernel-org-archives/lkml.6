Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F31C64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3BC20863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cce4i7fM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3BC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeK3RsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:48:18 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36075 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbeK3RsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:48:18 -0500
Received: by mail-ot1-f65.google.com with SMTP id k98so4208351otk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6E7sYIIw6KUKiajDLRzPhFKObV1kJ0njAZ4ZSyLIKs=;
        b=Cce4i7fM4EBio73/Jy0QiWVscHBYUpFVR0EBx83kHtuctrVsXtxw4r1UHsVeiZgEEb
         awEITIFSTI4b8YFJtiNCSFUCECIDYVOh44hS7oRDoYJ7rojc6EktBiBre5ITIM391b+G
         GifSEhxcbmGHVgROjSCrDKqBf8FXkCS1O7bLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6E7sYIIw6KUKiajDLRzPhFKObV1kJ0njAZ4ZSyLIKs=;
        b=I5pMM3koEjTcWEoONmguKeaRD/YZs4X7hMcGG+VkKD5MgLBAoiot+EN0OxaeKqXoco
         s9F6GkrZnYMxdqfwESX77j1J+heiRZoywR97Vn4YkA9afIxAeY0ts63WBbcNuLL3+v3R
         o9jqfdZrEwY+WmTrJ7FWUxLhVtV/DryRNVpFL1ku9/94Tk80I0eEnPRDiU0+4SY16DMD
         VXkpIxzqFzcruROhhvrw16IHnaNswusM6bDa5OMmlwvSegEtPmx9nHuDedvDjUviJxCH
         t9S3gFJOsujFyRnriEuBxzitFFbKr762uMZLVH5BbfytGx4ItPz/w4UvJeXDkDX2/5sR
         ip7A==
X-Gm-Message-State: AA+aEWYSE+6nI0YJiHtrAJuQIdN4Ceom/yV4HnRjg+JUkke2GqLxbE4K
        xMC8Sthc9A50/RpfYEJBnHxAhSQi2gDxCg==
X-Google-Smtp-Source: AFSGD/UKb+MGXRVhy7bD1wKOgcdO9Xe0bkBM1dWBrUcawbz7hXKQvZaYvKN7v4T2tGD3ZxvgV+TVIw==
X-Received: by 2002:a9d:58f:: with SMTP id 15mr2669433otd.218.1543560002639;
        Thu, 29 Nov 2018 22:40:02 -0800 (PST)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id y2sm1398771oto.49.2018.11.29.22.40.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 22:40:01 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id j21so3863820oii.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:40:01 -0800 (PST)
X-Received: by 2002:aca:bc42:: with SMTP id m63mr2530683oif.323.1543560001236;
 Thu, 29 Nov 2018 22:40:01 -0800 (PST)
MIME-Version: 1.0
References: <1543410642-6475-1-git-send-email-mgottam@codeaurora.org>
In-Reply-To: <1543410642-6475-1-git-send-email-mgottam@codeaurora.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 30 Nov 2018 15:39:48 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU6b01OEfJ=dHF7Y2E1MeNNR3TTVJDo_SyaNURJVoU2ww@mail.gmail.com>
Message-ID: <CAPBb6MU6b01OEfJ=dHF7Y2E1MeNNR3TTVJDo_SyaNURJVoU2ww@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: sdm845: add video nodes
To:     mgottam@codeaurora.org
Cc:     Andy Gross <andy.gross@linaro.org>, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 10:12 PM Malathi Gottam <mgottam@codeaurora.org> wrote:
>
> This adds video nodes to sdm845 based on the examples
> in the bindings.
>
> Signed-off-by: Malathi Gottam <mgottam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0c9a2aa..4c9d6a4 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -84,6 +84,11 @@
>                         reg = <0 0x86200000 0 0x2d00000>;
>                         no-map;
>                 };
> +
> +               venus_region: memory@95800000 {
> +                       reg = <0x0 0x95800000 0x0 0x500000>;

This patch depends on the firmware loader being fixed to not expect a
6MB area size. I think you can do it as follows:

1) Record the reserved area size in the venus_core structure during
venus_load_fw(),
2) Use that area size in place of VENUS_FW_MEM_SIZE everywhere else in the code.

That way we don't put any artificial limitation on the expected
firmware size, or on the reserved area in the DT matching a hardcoded
size.

Once you have this, the driver should work no matter what the size of
the reserved area is, provided the firmware first into it.

> +                       no-map;
> +               };
>         };
>
>         cpus {
> @@ -1103,5 +1108,35 @@
>                                 status = "disabled";
>                         };
>                 };
> +
> +               video-codec@aa00000 {
> +                       compatible = "qcom,sdm845-venus";
> +                       reg = <0x0aa00000 0xff000>;
> +                       interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +                       power-domains = <&videocc VENUS_GDSC>;
> +                       clocks = <&videocc VIDEO_CC_VENUS_CTL_CORE_CLK>,
> +                                <&videocc VIDEO_CC_VENUS_AHB_CLK>,
> +                                <&videocc VIDEO_CC_VENUS_CTL_AXI_CLK>;
> +                       clock-names = "core", "iface", "bus";
> +                       iommus = <&apps_smmu 0x10a0 0x8>,
> +                                <&apps_smmu 0x10b0 0x0>;
> +                       memory-region = <&venus_region>;
> +
> +                       video-core0 {
> +                               compatible = "venus-decoder";
> +                               clocks = <&videocc VIDEO_CC_VCODEC0_CORE_CLK>,
> +                                        <&videocc VIDEO_CC_VCODEC0_AXI_CLK>;
> +                               clock-names = "core", "bus";
> +                               power-domains = <&videocc VCODEC0_GDSC>;
> +                       };
> +
> +                       video-core1 {
> +                               compatible = "venus-encoder";
> +                               clocks = <&videocc VIDEO_CC_VCODEC1_CORE_CLK>,
> +                                        <&videocc VIDEO_CC_VCODEC1_AXI_CLK>;
> +                               clock-names = "core", "bus";
> +                               power-domains = <&videocc VCODEC1_GDSC>;
> +                       };

We should probably have status = "disabled" here and enable this node
on a per-board basis?

Also, shouldn't we define the firmware subnode here too?

Cheers,
Alex.
> --
> 1.9.1
>
