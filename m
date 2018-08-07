Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BC7C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9FA21731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FeDWwR1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9FA21731
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeHGWNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:13:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33770 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeHGWNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:13:22 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so14435646ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1MaYiyBPwgBCUv42mgzrebMsZanNn2U8SWwUN+XtjY=;
        b=FeDWwR1d9SwrqldQlGTmJfwRRVmjUfLS7uqByunw4AWd1eqsHfxfxJOY7VmsjQ3wtL
         rPzF42ESu21JbWXBE6L98/Pt35RH2lU4LkBFxrsYooyhq0dm6Hi5T2KI3IJ5r8gNnY3D
         cIimiRdt+drayklZe0xffediZSyhsjdvtPlZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1MaYiyBPwgBCUv42mgzrebMsZanNn2U8SWwUN+XtjY=;
        b=sgTAUCSI2XLvP/ihcY7Yg0RiM0SsxOYkwb6wdLtVxjWc+wFQt9MdIe5zBZwjXU6o8B
         4olOo0q0x7xYuTDyWNMGj1RuU+zmFKB3bXN2sXOXvfqIJ2Emfr0yICFy/jY/3NAVm5Zs
         9fmEOsHzYoQCfCtPQclU00U/3kjwL/OZu3nKDtRX/dhQWQm+pNZP9IXz21OevKBPVVS/
         5gDreCCSP7jp0rh4eHRvCrE48uYT+iH4gNVDnrYYLcVNU5oHbUEycjw1fg5FBwpcgA4o
         EH8ChYPr7QOUiN7Vv1woToIFooUD2dUEhcpEKnz8M9Mw5DKR4X+Ft1T8stZKbbv/2XYx
         xBGQ==
X-Gm-Message-State: AOUpUlHt9HqrXTf14iLEBcNFAdOZ95m/6vWHfq+p91T4aQwpSd3n0Bip
        fnD4Myad/BOGrExqTOdD7pRS6UOcPac=
X-Google-Smtp-Source: AAOMgpd7RxV1CL9JJUoRIiWDKUCC5sIMUEJAEEkLF+rbIZB2zQaktf04KRJgWYO+a7JVrzf0Os4xUQ==
X-Received: by 2002:a2e:8346:: with SMTP id l6-v6mr17585633ljh.72.1533671842132;
        Tue, 07 Aug 2018 12:57:22 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id a15-v6sm378512ljf.92.2018.08.07.12.57.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 12:57:20 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id u202-v6so12506966lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:57:20 -0700 (PDT)
X-Received: by 2002:a19:d484:: with SMTP id l126-v6mr14455132lfg.28.1533671840372;
 Tue, 07 Aug 2018 12:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180731224421.29062-1-ilina@codeaurora.org> <20180731224421.29062-5-ilina@codeaurora.org>
In-Reply-To: <20180731224421.29062-5-ilina@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 7 Aug 2018 12:56:43 -0700
X-Gmail-Original-Message-ID: <CAE=gft5SRSnXN4Cs8JdTNgFKAFk1YH4bxL91=jvhRZe7Zznxdg@mail.gmail.com>
Message-ID: <CAE=gft5SRSnXN4Cs8JdTNgFKAFk1YH4bxL91=jvhRZe7Zznxdg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] arm64: dts: qcom: add wake up interrupts for GPIOs
To:     Lina Iyer <ilina@codeaurora.org>
Cc:     marc.zyngier@arm.com, Stephen Boyd <sboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        rplsssn@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, swboyd@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 3:44 PM Lina Iyer <ilina@codeaurora.org> wrote:
>
> GPIOs that are wakeup capable have interrupt lines that are routed to
> the always-on interrupt controller (PDC) in parallel to the pinctrl. The
> interrupts listed here are the wake up lines corresponding to GPIOs.
>
> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 69 ++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 8ccce42885c1..96ef18ced85b 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -720,6 +720,75 @@
>                         #gpio-cells = <2>;
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
> +                       interrupts-extended = <&pdc 30 IRQ_TYPE_LEVEL_HIGH>,

In order to get any GPIO interrupts on my board, I needed to add the
summary IRQ first in this list. My reading of platform_get_irq is that
"interrupts-extended" is queried before "interrupts", so we
accidentally wire the summary IRQ to PDC 30. Given this, you can
probably remove the regular "interrupts" property.

-Evan

> +                                             <&pdc 31 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 32 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 33 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 34 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 35 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 36 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 37 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 38 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 39 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 41 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 42 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 43 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 44 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 45 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 46 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 47 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 49 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 50 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 52 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 54 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 55 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 56 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 57 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 58 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 59 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 60 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 61 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 62 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 63 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 64 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 65 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 66 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 67 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 68 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 69 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 70 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 71 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 72 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 73 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 74 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 75 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 76 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 77 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 79 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 80 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 81 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 82 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 83 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 84 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 85 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 86 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 90 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 91 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 92 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 95 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 96 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 97 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 98 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 99 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 100 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 102 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 103 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 104 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 105 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 106 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 107 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 108 IRQ_TYPE_LEVEL_HIGH>;
>
>                         qup_i2c0_default: qup-i2c0-default {
>                                 pinmux {
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
