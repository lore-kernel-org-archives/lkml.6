Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4824FC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00FB920870
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 18:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EX68Nn/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00FB920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbeKUEsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:48:15 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39321 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeKUEsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:48:14 -0500
Received: by mail-vk1-f194.google.com with SMTP id q80so627138vka.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5zG7uhlPNA3Rk5LEVAV0qrqRXw+pesW7moq5lDhgvo=;
        b=EX68Nn/QtyYJGP90I6E9ZerPNl+GyisJGU6graJTOMq3QlbQtcChWgsT1Eaq7xT11E
         9nKBKQP1rtM7zGpJGFt/7xtOupnbM8RFqegSHIjJTLE1wyUEkXJSGM+O4v6R1Xts3o2+
         7WA6TVAuL/CKtLf4LA3CrBEFLC+ucHidC43bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5zG7uhlPNA3Rk5LEVAV0qrqRXw+pesW7moq5lDhgvo=;
        b=YuQyYxhvmz5JEQ89TQ0xljAix4ae7OFadzMzt/4ydFHXB0oq5VPws5jH4tJto0BP7y
         kmqQPFx6QlBu4L1Pk8C8qESv/2xpDOGddwuneshQtPE8MgZ3FPw+ewMpBzMh45uQGgs7
         Yj7UlHZ7E9pFwCZuUek/0ylzxsrOZJFPPZTmA0COKUJCOqJ5pd6km9qWCq5mwWqkvRgl
         24Xh84FGBF951FA6J1vz7vA9eQpcVKpuv6kxZ8HvaAFJb3ByUxyeuwiVLw4r+Zif4M8M
         zk7H/5f0GmmWIAaK2LapnVAi8WXHE7GQhjUtuCbT0BavM3XkPCLwxtZldZeN8QuKqUlc
         fv/A==
X-Gm-Message-State: AA+aEWa1x39ZPZiwxmxrDUZzrWYMKhLj3tizeSDHek4O7n/azCd2wKaB
        x/LJ9tps3XtrkjXSjz0X7B+3Ka4To2w=
X-Google-Smtp-Source: AFSGD/X3FVxwoifZh/+yYYU9ByfcokDlkvifIlJkek2YNDJmY9P+aLHnP8g1GlJRWKKC2A58ikrQ0g==
X-Received: by 2002:a1f:9042:: with SMTP id s63mr1268394vkd.17.1542737865987;
        Tue, 20 Nov 2018 10:17:45 -0800 (PST)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id s195sm11345924vks.28.2018.11.20.10.17.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 10:17:44 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id h128so618703vkg.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 10:17:44 -0800 (PST)
X-Received: by 2002:a1f:ab17:: with SMTP id u23mr1271986vke.73.1542737863658;
 Tue, 20 Nov 2018 10:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20181120002654.1891-1-dianders@chromium.org> <20181120002654.1891-2-dianders@chromium.org>
 <20181120160010.GH3894@sirena.org.uk>
In-Reply-To: <20181120160010.GH3894@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 20 Nov 2018 10:17:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XM0S+0RzkDH2Ln6dJ9m12LH7A8tgfe_f=czV8fHP_Ghw@mail.gmail.com>
Message-ID: <CAD=FV=XM0S+0RzkDH2Ln6dJ9m12LH7A8tgfe_f=czV8fHP_Ghw@mail.gmail.com>
Subject: Re: [PATCH 2/7] regulator: core: Don't assume always_on when
 is_enabled returns err
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Osipenko <digetx@gmail.com>, ryandcase@chromium.org,
        David Collins <collinsd@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 20, 2018 at 8:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 19, 2018 at 04:26:49PM -0800, Douglas Anderson wrote:
>
> > At boot sometimes regulators (like qcom-rpmh-regulator) will return
> > -EINVAL if we don't know the enable state of the regulator.  We
> > shouldn't take this to mean that the regulator is an always-on
> > regulator, but that was what was happening since "-EINVAL" is non-zero
> > and a few places in the code were not properly checking for errors.
>
> This still results in breakage - if the regulator fails to read when
> we're initializing then we won't flag the regualtor as always_on, the
> regulator would need to tell the framework when it becomes readable.

Hrm.  Are you sure it's broken?  I'll admit that I'm a little fuzzy
about why a regulator that happens to be enabled when its supplies get
resolved should be considered always-on.  Can you give me a hint about
why it works that way?

My best guess was that the code was assuming that when we were
resolving supplies it was super early and the only way the regulator
could be enabled at that point is if either:
A) the regulator ops have no is_enabled()
B) we called _regulator_do_enable() in set_machine_constraints()

If that's true then my patch definitely helps things.  Case A) isn't
an issue for qcom-rpmh-regulator.  For case B) once we see the first
call to set the enable state of the regulator then we'll definitely
return 1 from is_enabled.  That means we'll be able to tell the
difference between a regulator that should be considered always-on and
one that can't.

Did that make sense, or am I spouting nonsense again?


> This hardware really is fragile :(

No kidding.

-Doug
