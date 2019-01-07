Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C61AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BAA2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmTmMM6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfAGKxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:53:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38028 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:53:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so4739035lfk.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jeKwDB/2Is/6iPunhOhtgtREZ1O1mP4ZOy4Ty1PsUuw=;
        b=kmTmMM6DSkx+0ZLYlthplTRU9UZDR5l+m4F3aL2jNURRQsJ187Gthu2pVKuNkHQ/If
         XpqIVsG7W6inLWd8PR4GFkc5kvEuZofwFlFP0q0MOYMUFESIbeICY0GmUhdmTPGFREJ9
         nIh78hIjTZ1KcKHTK4tBQC4y6TwRUVHuIgpLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jeKwDB/2Is/6iPunhOhtgtREZ1O1mP4ZOy4Ty1PsUuw=;
        b=ehJQnM81+/PYLB2aLNRdcRLtgYTwTCbML3rzJ1luyGuZhvv7QapgrcKGlAQHaFyWwd
         Vmtoprzet5LDe1kXhtZGIIZIR6yu5LMl5jpJrF2/gcwvp23HrnkX7zF7wjimPeN57M0e
         kjtBhQiJV+gNSc49jo9/0f6b2wKdD9BIMn2CJUalrpucriwTVQ5NY7fAWEIwA9nW+4L7
         EUwrhg5BPOt1xvnXF4xZwUGNkWjbnYMsPTrUKBciPUaOzVMvdZ0RqQ+GbAKsH1lxT1Ak
         H//t70HQKkH83v5hdB/dVAbyWq/Lh3o39Lawf0thsjLJdv0KvP7pzllLHh1qIKq7GYmY
         s1AA==
X-Gm-Message-State: AA+aEWYsM9z2KAYi1zulIzfyxsnQbwe6OOwAovx7gGqN1u6XZaF+s+xe
        TzzjMmaXQJPWLU1ss33mHRuvb2vG0zIbJFalk8697g==
X-Google-Smtp-Source: AFSGD/VgSQ7Ind3lHmhtCyOf9RuBCBo/o8k36Z7ONi1j46ibe7EPj4A+U4U7Im/b2oLxCc2WFaZb/WJhFuoDiLItj2U=
X-Received: by 2002:a19:5154:: with SMTP id f81mr31980355lfb.96.1546858398294;
 Mon, 07 Jan 2019 02:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20190107021145.6370-1-masneyb@onstation.org> <20190107021145.6370-3-masneyb@onstation.org>
In-Reply-To: <20190107021145.6370-3-masneyb@onstation.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 7 Jan 2019 11:53:07 +0100
Message-ID: <CACRpkdbLU_2JC1wT=M7EPsx6gPxL=poj2Ci8zTa++51K2qGZ4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mfd: qcom-spmi-pmic: use devm_mfd_add_devices
 instead of devm_of_platform_populate
To:     Brian Masney <masneyb@onstation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 3:11 AM Brian Masney <masneyb@onstation.org> wrote:

> pmic_spmi_probe calls devm_of_platform_populate, which traverses all
> of the children in device tree from the parent down to the children,
> grandchildren, etc. of_irq_count is called on most of the nodes (via
> of_device_alloc) and this initializes all of the IRQs. Further along in
> the boot process, spmi-gpio is initialized as a hierarchical IRQ chip
> in a later patch (with spmi-arb as the parent IRQ domain), and the same
> hwirq is now associated with two Linux virqs and IRQs will not work as
> expected. Correct this issue by using devm_mfd_add_devices to initialize
> just the children so that IRQs are initialized on an as-needed basis.
>
> This patch also selects CONFIG_MFD_CORE since this is required by
> devm_mfd_add_devices.
>
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Good catch! Now I see why this was acting so weird for you.
Also the MFD semantics are standardized and make much more
sense after this.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose Lee can merge this in orthogonal in the MFD tree,
the end result will be functional after the v5.1 merge window.

I think I should also fix qcom-pm8xxx after this, as well as
the similar SSBI code for elder platforms.

Yours,
Linus Walleij
