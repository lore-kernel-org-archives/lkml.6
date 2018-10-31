Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89F6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A475220685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 09:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwnBwpEy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A475220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbeJaSnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 14:43:20 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41849 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbeJaSnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 14:43:20 -0400
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so8131883ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yh+xcyDuNaQcm5dvReosPndqR3uzujxkGzE/xt6GmTo=;
        b=cwnBwpEyR8enSkYsnDkn5PtKd9TFvUFKXT5EncA/iX/XpT/nSfbsnbgIOjWWhQ7MR8
         ypZ7o1eiBzSxAo9gG8VMHLjE36hx7La9knp0T/SvaGkCW7jZgJyeyhsqdiRnK1vskiFb
         iwHUrnfRen462UpxwhDKZclQdxVP/9IZJNl0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yh+xcyDuNaQcm5dvReosPndqR3uzujxkGzE/xt6GmTo=;
        b=Oc6HU6l4FxN20WVVOm3nGiQhJXgE5vdZ1wyD2Q96+4L9u1TnbVB0A0yIRJ9PdDM1WE
         m6ImfEDAWybCTDvsJTjxwYgZP7Pb8H/D0q1RMjCDlp76dbcBNG/XB7hD5HX4ELdQbdwZ
         DPAc3vJKrBINEorHipm0qNqQ9/nLt7luE9UHXzxIrLhhRCiVhZSVpzOO4b4C9unbmrwx
         0AXqQOOBNiSzFcTWmJIP72t3XDdai4TcYvG5OXGRazsfUul4xQmhMRsQZHSRt57a0o1h
         5puDSXOCzMhDvWXltsS2ROK6wg4hD7Al+oedRMU0SL/a5j/f/wGdmic6yeIzpm2NDyq9
         bNMg==
X-Gm-Message-State: AGRZ1gJFLvkOz3+w1Wa67RubBonub6GNjK2A3SwEcG2n8h7R3RFkR8Mz
        JSamzVWWz3ARjH6mVeiCCTTDzfiSSc0MdDGqiNr6fQ==
X-Google-Smtp-Source: AJdET5cwslk2PyxnSQ0X1nDX6Ia/1G70GN0FXouJAJO+7xk5wIEH8MP6XWWY2X3gmryrbH9MwhrFgjKTvmlP0Q38W0Y=
X-Received: by 2002:a2e:9849:: with SMTP id e9-v6mr1539108ljj.9.1540979155807;
 Wed, 31 Oct 2018 02:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181023160319.27003-1-jbrunet@baylibre.com>
In-Reply-To: <20181023160319.27003-1-jbrunet@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 10:45:44 +0100
Message-ID: <CACRpkdbXP2s7gEUUaJ8cUgS1V_8SejWUVTkjPdZDZ7W9Vw7tqQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: meson: fix pinconf bias disable
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 6:03 PM Jerome Brunet <jbrunet@baylibre.com> wrote:

> If a bias is enabled on a pin of an Amlogic SoC, calling .pin_config_set()
> with PIN_CONFIG_BIAS_DISABLE will not disable the bias. Instead it will
> force a pull-down bias on the pin.
>
> Instead of the pull type register bank, the driver should access the pull
> enable register bank.
>
> Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Patch applied for fixes with Neil's ACK.

Yours,
Linus Walleij
