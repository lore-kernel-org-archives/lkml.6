Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C535EC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C6224E9A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IPiM0e9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C6224E9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754305AbeGCGJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:09:11 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35906 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753789AbeGCGJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:09:08 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so476795pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=XKLfdTjdTJdqR/RlDJExMkWqZawRLopdtj9Ctw22bCM=;
        b=IPiM0e9cT5awZeDrxub3ii3mmOJCgnYXTMSIrcxX5G72Br9WuyW7ouYvDFUdmdJ8yy
         JqxbWBN8nR1CKHQ/1MNHZty9Ipa+Plf8L6ExXGKrb1y/vdj+oKCYI4AMMFcONvnvafWd
         WSlgfME7wHiOHAYuytHqZtKbMY63qfoRsqpZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=XKLfdTjdTJdqR/RlDJExMkWqZawRLopdtj9Ctw22bCM=;
        b=P511G8kfOLYQ6DXkPgV5H3nruh3noZKmf/8/1VaYt8dQlu/duOPUbqUYyQlLlVGYyl
         +SJb2YLn1bYi2X/usrFr1ZpJ15yShyIQqgEpRRjuchm2VhmyZ7qEX+kh0ogIcGNqhlwF
         O/2iEOVfw0aXnIa0tnA9sdgJaqwZtLXXt+z3yPKMvngOPLBsIq0UNgyuL4c//v5Xvy7g
         A9XcG8wQhI1YpnLrolaX1iNZP93iKUkIyoHg30D/XJ6YrpzLMpAejlQFtvCgDiXTbHgw
         RtLeORE7WsFfdMyt58mvqL82K7wW68s8q8PDQv1pJfO1064UhCdrQUAAq3VOg0ELry7s
         SSIg==
X-Gm-Message-State: APt69E3E9V+ndQ8ydBeS+x9ZzjrSbBHM8DDlt8aGFFIDSW6UjXU/Snzz
        diYwbQVAArEREmEUa710J4+6Yw==
X-Google-Smtp-Source: ADUXVKItMLcV++NVUMQrZx0AaqzJXacw2Nk/ttlF7vp7zMfwdn0Ihh3bq9MUZa2N7FUPT8qbTrqsmw==
X-Received: by 2002:a65:4a92:: with SMTP id b18-v6mr23958428pgu.107.1530598148472;
        Mon, 02 Jul 2018 23:09:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:1511:d30e:62c6:f82c:ff40])
        by smtp.gmail.com with ESMTPSA id w5-v6sm712380pfn.44.2018.07.02.23.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:09:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180702225939.109169-3-dianders@chromium.org>
Cc:     iivanov@mm-sol.com, Douglas Anderson <dianders@chromium.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20180702225939.109169-1-dianders@chromium.org>
 <20180702225939.109169-3-dianders@chromium.org>
Message-ID: <153059814703.143105.275831530209187562@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 3/3] pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be
 compliant
Date:   Mon, 02 Jul 2018 23:09:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-07-02 15:59:39)
> If you do this on an sdm845 board:
>   grep "" /sys/kernel/debug/pinctrl/*spmi:pmic*/pinconf-groups
> =

> ...it looks like nonsense.  For every pin you see listed:
>   input bias disabled, input bias high impedance, input bias pull down, i=
nput bias pull up, ...
> =

> That's because pmic_gpio_config_get() isn't complying with the rules
> that pinconf_generic_dump_one() expects.  Specifically for boolean
> parameters (anything with a "struct pin_config_item" where has_arg is
> false) the function expects that the function should return its value
> not through the "config" parameter but should return "0" if the value
> is set and "-EINVAL" if the value isn't set.
> =

> Let's fix this.
> =

> From a quick sample of other pinctrl drivers, it appears to be
> tradition to also return 1 through the config parameter for these
> boolean parameters when they exist.  I'm not one to knock tradition,
> so I'll follow tradition and return 1 in these cases.  While I'm at
> it, I'll also continue searching for four leaf clovers, kocking on

Small typo here.

> wood three times, and trying not to break mirrors.
> =

> NOTE: This also fixes an apparent typo for reading
> PIN_CONFIG_BIAS_DISABLE where the old driver was accidentally
> using "=3D" instead of "=3D=3D" and thus was setting some internal
> state when you tried to query PIN_CONFIG_BIAS_DISABLE.  Oops.

Awesome!

> =

> Fixes: eadff3024472 ("pinctrl: Qualcomm SPMI PMIC GPIO pin controller dri=
ver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

We should fix the ssbi-gpio/mpp and spmi-mpp drivers too. All those
drivers are designed on the same buggy original driver.

