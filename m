Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938CC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0FF20892
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdotbmFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE0FF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731029AbeG2WVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:21:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:40670 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbeG2WVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:21:10 -0400
Received: by mail-io0-f195.google.com with SMTP id l14-v6so8227565iob.7
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 13:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s9yWI7a2Lz+xSLMUcszkskGuHNc2DxeKG518CzgWQ24=;
        b=NdotbmFiFCsWmQivjG/9gcHrTiE0I0xn4UdMWHUeMMoanfjrJkpJ6mQg815FAEYEV9
         fIFoGIG0YX239iMJN0Xzn7ZoI8dXyaTB2R6xCZshUsaa0VyXuc7vrH4Cd+nXmx1+oxvT
         HnKtX8Fhr/Bfmrtn1W+KgRZqF9mC0sciJTzGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s9yWI7a2Lz+xSLMUcszkskGuHNc2DxeKG518CzgWQ24=;
        b=W5/wxx9x/CpHvzCVBOmp4234gmHRt4pXqefjC4otJKGxPRDKS+tUn8jDuIY4tWKXd1
         5NIc/z87DmDussRyAAOV0qLwA70N1VoGz4SCXxE2pq8M9bbfB3NPb8A5AbRCLwPCg6Pj
         x2pJXltz1wK5LXEYbr2+46YI4MLeP6v+X7txknDLfihhGG1ckVBgyqtY9ShAfS/ZcA80
         kvlz2idC0K+Kkuj5ncVaUCDQfG+S4/YmhyyyUSGfpbR67ogfrz+HB9UNSUUT5FmRuPsi
         oOvoaVDbxcLm8HZt/cYA7azhjhB0GrLqmbMKBcJ7KrxLKdvupwSISRpDJcrt7XU+tDm2
         aG8w==
X-Gm-Message-State: AOUpUlHN5Vv9iQECMC70we3JKuDEn5A4uodZFq8Od8gNyV8H6QWhFE15
        oB4WTtUTX2a7EEv0RuevOWQC9+SSsa+m09gkwp4pfaTC
X-Google-Smtp-Source: AAOMgpeC+Q8NlIg6PrWBTHZr2oyRNmvcZnBPxSozusdOayiN0gAUKhJflM3gayRzmpImUMsI8nEBk1axUaq88F6ffp8=
X-Received: by 2002:a6b:6306:: with SMTP id p6-v6mr11551574iog.175.1532897363564;
 Sun, 29 Jul 2018 13:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180720075449.26711-1-marcel@ziswiler.com>
In-Reply-To: <20180720075449.26711-1-marcel@ziswiler.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Jul 2018 22:49:12 +0200
Message-ID: <CACRpkdZSb--nGAR2DVfBgqmQTv=S_sBjLTfJiKHzG2GyfJ6jEw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: probe deferral error reporting
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 9:54 AM Marcel Ziswiler <marcel@ziswiler.com> wrote:

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>
> Actually report the error code from devm_regulator_get() which may as
> well just be a probe deferral.
>
> This is e.g. what one gets upon booting a Colibri T20:
>
> gpiochip_add_data_with_key: GPIOs 0..223 (tegra-gpio) failed to register
>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Makes perfect sense.
Patch applied.

Yours,
Linus Walleij
