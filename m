Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E1C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15272087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dvgq1jhj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15272087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932956AbeGILRQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:17:16 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56107 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932738AbeGILRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:17:13 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so24805280itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnsdBlsT80zg4c2HgfsiV3RFJAf+vcuf3k+OkcP7c4c=;
        b=Dvgq1jhjLvi8dNgPeocGUZdeq7rT5W3LR6OTlryBaUaoW3WsvIXillyRKLswLtkjUD
         +He4HWs2JpyRXaZoNoHvpfKd290To2HEGY0r2bzFN7PMIel/SUhuaWTV3esDhYZjzlKI
         Mx7HCQRLah2YvrlgDkPvGlyF4e9DR8X42i03s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnsdBlsT80zg4c2HgfsiV3RFJAf+vcuf3k+OkcP7c4c=;
        b=ZOc6Rt2X9UBMtjmfElCkGwu66M1c+696xom5ZL6H2489d8UxU+UzFJhhkk73ddeyZi
         d6VeQLW4fMQ01dv1pDQE3vs9RY1UhyRG5mRjrltaxaiyFjedPt4GMH1XHIhw5g8/ms9n
         LWcCc9Cy8XND3pLZ0oaxZhiqM7YhY3pY3VTn3TydTXILuVYyzh76ZNMc1mjcedCcVrr1
         xh+9WEwU5XlMbQqLbcYqOvipT8PyqAQNv2OkwY0nPQulO5x80vNbWfSJ8MmFQkmx+Yoz
         zBFaXlOKOJCEEAQMoSMxuzNAMifmN56+zylqg+r9j1QOdaFo2VMHqbEKSFyzuEFgGP2B
         XblQ==
X-Gm-Message-State: AOUpUlGTz0SFjGMCcaxfKzmGrTZhjg2pYokBxUwLeZQ/l/sIuLLkL76i
        bA51ZsodRY+fguClwCVTE2GDjRncdP8DAOmiqZD5Ag==
X-Google-Smtp-Source: AAOMgpeEoahT7JQiMpGNM2MabgpT5m8sLigaJGlyi9WtCwkVPFiMIllpdyupJfrGdaCr2F5+Ab6gL2rHJUhogvHbNco=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr300601iti.135.1531135032987;
 Mon, 09 Jul 2018 04:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180702225939.109169-1-dianders@chromium.org> <20180702225939.109169-3-dianders@chromium.org>
In-Reply-To: <20180702225939.109169-3-dianders@chromium.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 13:17:01 +0200
Message-ID: <CACRpkdbGejz1a1doN_LuBNgYeHo9Hdz54vRYU=inQZfyiJEmaA@mail.gmail.com>
Subject: Re: [PATCH 3/3] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get()
 to be compliant
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Ivan T. Ivanov" <iivanov@mm-sol.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 1:00 AM Douglas Anderson <dianders@chromium.org> wrote:

> If you do this on an sdm845 board:
>   grep "" /sys/kernel/debug/pinctrl/*spmi:pmic*/pinconf-groups
>
> ...it looks like nonsense.  For every pin you see listed:
>   input bias disabled, input bias high impedance, input bias pull down, input bias pull up, ...
>
> That's because pmic_gpio_config_get() isn't complying with the rules
> that pinconf_generic_dump_one() expects.  Specifically for boolean
> parameters (anything with a "struct pin_config_item" where has_arg is
> false) the function expects that the function should return its value
> not through the "config" parameter but should return "0" if the value
> is set and "-EINVAL" if the value isn't set.
>
> Let's fix this.
>
> From a quick sample of other pinctrl drivers, it appears to be
> tradition to also return 1 through the config parameter for these
> boolean parameters when they exist.  I'm not one to knock tradition,
> so I'll follow tradition and return 1 in these cases.  While I'm at
> it, I'll also continue searching for four leaf clovers, kocking on
> wood three times, and trying not to break mirrors.
>
> NOTE: This also fixes an apparent typo for reading
> PIN_CONFIG_BIAS_DISABLE where the old driver was accidentally
> using "=" instead of "==" and thus was setting some internal
> state when you tried to query PIN_CONFIG_BIAS_DISABLE.  Oops.
>
> Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Patch applied, same thing. Stays in unless Bjorn has some
objections.

Yours,
Linus Walleij
