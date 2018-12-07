Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEDFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE7420868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DaWSV3qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE7420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbeLGAIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:08:52 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36013 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGAIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:08:51 -0500
Received: by mail-vk1-f193.google.com with SMTP id t132so566065vkc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuU53HriEhD2Bqcy0v1QBJCSmFzGD7kDr1XJWVgl0pg=;
        b=DaWSV3qc13uDuWcKghrBzT6hAC/scOfVXedgMkL87g2S4F7y28e8Z3+vFoMllOrFXB
         9UBQsHm4g9XNeu9DNqjIpAJZmIc6HxR1KqEp9sk/+SEsDNadRqRrzzvBPu/PFCNa1SwL
         n3sRyq6Wp3HDJa2grdHtGIE9OTd9TaBXv3LSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuU53HriEhD2Bqcy0v1QBJCSmFzGD7kDr1XJWVgl0pg=;
        b=gAQHRwAIAxjvn9RX4iNn72SBVpLFxfVUHaYg3UL/D2titrrta7tgdBixRDc0KNL3qm
         gU6i71h2ah81Er+u3ZsJTW/s4zJ1PUoOAW7n2yxYj+WG43qvnZQZP0du3od77oxwCecI
         P2wvZsXyBgk2dgj+T3Gyn6juWc4ECb6Ft/CwvWtrWL8Yko+80BEsys5b+2gsMIJZbN0z
         as/zY8CnZAWoailAOeBqCGsBqi32s8D/wNlvBjOw8K4+RU+Z1FqjlnmP2ZSMZ1Irb0/P
         MEFKIslKLNo68vnDWboWN90KsscWKa4h6oBLFyWB0Kvn/7JWVDga3aU6QdzKPShgSdbu
         fINw==
X-Gm-Message-State: AA+aEWbVlmd5ojeuXCgNsGRdk6lNkb5cnL5iSPNvxFHEB5ySdwHmB8i2
        XaIIRNk3qsYPpKJYknmzh7zvqd9YgdQ=
X-Google-Smtp-Source: AFSGD/UHNyEiZwvbp91ngPGQHEM5zC2V2OtPsdPQbo8T5Wz2SWaEplxphK6Z8CncIk2goixLOCwWLw==
X-Received: by 2002:a1f:a28a:: with SMTP id l132mr3928vke.37.1544141329788;
        Thu, 06 Dec 2018 16:08:49 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 188sm657084vkr.25.2018.12.06.16.08.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 16:08:48 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id v205so1459522vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 16:08:48 -0800 (PST)
X-Received: by 2002:a67:f955:: with SMTP id u21mr360vsq.149.1544141328353;
 Thu, 06 Dec 2018 16:08:48 -0800 (PST)
MIME-Version: 1.0
References: <1543996836-16717-1-git-send-email-tdas@codeaurora.org>
In-Reply-To: <1543996836-16717-1-git-send-email-tdas@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Dec 2018 16:08:36 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UA3zyjr_VqUcyekWhSOo7rtjEbbcU-E=SZ1e9HNhOyrQ@mail.gmail.com>
Message-ID: <CAD=FV=UA3zyjr_VqUcyekWhSOo7rtjEbbcU-E=SZ1e9HNhOyrQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add lpasscc node
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 5, 2018 at 12:00 AM Taniya Das <tdas@codeaurora.org> wrote:
>
> This adds the low pass audio clock controller node to sdm845 based on
> the example in the bindings.
>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 4 +++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index b3def03..cf73f3c 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -346,7 +346,9 @@
>  &gcc {
>         protected-clocks = <GCC_QSPI_CORE_CLK>,
>                            <GCC_QSPI_CORE_CLK_SRC>,
> -                          <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
> +                          <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +                          <GCC_LPASS_Q6_AXI_CLK>,
> +                          <GCC_LPASS_SWAY_CLK>;
>  };
>
>  &i2c10 {
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 1419b00..a3db089 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -7,6 +7,7 @@
>
>  #include <dt-bindings/clock/qcom,dispcc-sdm845.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <dt-bindings/clock/qcom,lpass-sdm845.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/phy/phy-qcom-qusb2.h>
> @@ -1264,6 +1265,13 @@
>                         #power-domain-cells = <1>;
>                 };
>
> +               lpasscc: clock-controller@17014000 {
> +                       compatible = "qcom,sdm845-lpasscc";
> +                       reg = <0x17014000 0x1f004>, <0x17300000 0x200>;
> +                       reg-names = "cc", "qdsp6ss";
> +                       #clock-cells = <1>;
> +               };
> +
>                 tsens0: thermal-sensor@c263000 {

Please keep nodes with a unit address sorted numerically by unit
address.  0x17014000 should not come before 0xc263000

Presumably this is the kind of thing that Andy can fix himself when he
lands stuff (often dts stuff ends up conflicting a bunch anyway), so I
wouldn't personally post another patch unless I hear from him that he
wants you to repost.  ...but please keep it in mind for the future.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
