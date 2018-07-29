Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569DAC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CE120873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dSbPIpQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CE120873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeG2Vn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:43:27 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34221 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbeG2Vn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:43:27 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so8222534ioj.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roo/6Cp6yTKX9s+Y4673cFk8K0Vc6ECqrmlt19RkSLw=;
        b=dSbPIpQsK8mmMYkhO9msxIT/cEjp6AbzC3DTZRpTbt583cPIDpPcYpQEPSGCyB0+kP
         LtEPxzS4qxAWplZsHn2PKLtGYYblnbQBbeQHrKQSshe+SJstPZJ/JlElMNYCGDqcjb5z
         QUX5rlzYQVAl2WosHsGRlk7BEA4KJQxQMCck4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roo/6Cp6yTKX9s+Y4673cFk8K0Vc6ECqrmlt19RkSLw=;
        b=B496QigjRo4ybY7PN9Ck18UX8jOq5xySMgSO/ndQbQNF1p8EfdrpcyO9UT9EeZnaNx
         FDgy54iGKN9aQqWbjzjkcuuIgNG7g/IIV2k41iifLUkKJ2tAbMBUYb5VyOuxEzlvvzqU
         l96+anlkHxIXo3PeSQWvOVmroancQ3PT7DnizqfB0Bs2XG0I5Nj5IJq7d/VHyKmTtFDJ
         7wrQOBG+W2FqAFxegziketEcgtUulRStBvkx8nAHWGtkBB75SgLYtrzdVmC0IcugQ+Vf
         hX1Frg/8GvyFYDbxz4r15fL5Y+E0jWoji6CehE9lyT8ld+9qZtFi3BNc6bpKC/OTexM9
         TC7Q==
X-Gm-Message-State: AOUpUlG6+pbAglYUys+1/46lP2vgFhUNvrcEcENAKQS6Dm+Egb5+JAa8
        x6pDYCytvlaxZtSNqmUw2Crq2HnHSyO8c+ZSFb9KDw==
X-Google-Smtp-Source: AAOMgpf24Ry47nK/+CnfTm0AZuSm7rIpdBgBJUyU5n+vr8z5HuIazNuOAkRHAScMHHEMgTEADQ3j8oEafHAHbE+QIZM=
X-Received: by 2002:a6b:4006:: with SMTP id k6-v6mr10753970ioa.277.1532895107450;
 Sun, 29 Jul 2018 13:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <1531745857-5561-1-git-send-email-alexandre.torgue@st.com> <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
In-Reply-To: <1531745857-5561-3-git-send-email-alexandre.torgue@st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:11:36 +0200
Message-ID: <CACRpkdaDy5MGPMxh3GYFHL9VqTv44=t6J=xu_0sdXc4OHFo84g@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: stm32: check node status before new gpio
 bank registering
To:     Alexandre TORGUE <alexandre.torgue@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 2:57 PM Alexandre Torgue
<alexandre.torgue@st.com> wrote:

> Register a new GPIO bank only if GPIO bank node is enabled. This patch also
> adds checks on ranges which are defined only if a bank is registered.
>
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>

Patch applied.

Alexandre can you check the discussion we've had about using
GPIOLIB_IRQCHIP for multi-bank GPIOs with several IRQ
lines as per drivers/gpio/gpio-tegra186.c?

Is this approach applicable for STM32 so we can pull
more stuff in under GPIOLIB_IRQCHIP?

Yours,
Linus Walleij
