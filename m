Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEAFC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84BEC206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2PRwxs0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84BEC206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeI2F6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:58:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeI2F6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:58:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so1487964wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG59PWsjc1/L1DPpI8msTki+CENLSaFu5iNEATjte3A=;
        b=R2PRwxs0uYO+FqVTzO2VujduMC0iSD2ol+9f3i/FBC1rULSC69KI60rzhCMkOXBszt
         uYN/zY0C1jZMPnhvQBvMaJR4+ZSxXaRXbFiW9OepGKsBYbSesf8D8zfBd8B+n7wPk9QB
         sTcGf7iwljimnHybCKsj4PWaoCYYgXSuisSjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG59PWsjc1/L1DPpI8msTki+CENLSaFu5iNEATjte3A=;
        b=Ih512KjhYk9IDlF+W4HtlUh0dGWxpz63Q1o11LwFf1RlOW6QrK5//dqom7Chgqn3gz
         laOaVBn5jLYkkuhqO/k2iok0Er+XVBqe693bXShcBt3osAMS8vc3sTS1TrfBKn/PYTOM
         4daE27aIeuSgFUwQdfAaqc8J85eo5foJAIiBxgXHwFvpBq6kdRPpyVomK9B5W7JE38q1
         ITuF1KnvHndUmXn6caiABmAfJUbh8dycGpdG25LOsFWIrQ4gsuSuepq+6A6UxS5Cg+ND
         oh4NKH7G1PHS2SRYcpJbd7Hk4LTUQ0gaDgwvAx0pcZlj1TopZNmkERPddp5EClxu/wk/
         h+nA==
X-Gm-Message-State: ABuFfohLcOs8mu1UBbYJpsZu/DBtn8UBQznZVer5zqwAlXTy7DIC3HLV
        TPv5QTYNNAutMJidvOGqfPxp/lcefF1sTHtLHoQ=
X-Google-Smtp-Source: ACcGV60L3U1FFzHpJ/of5U6aNBVLRCSmj1aNR3agFwAebH8gVHuWZumyWwLwbDMIkRnuyN8epoyGe0oXHsqK60LAw/w=
X-Received: by 2002:adf:f88d:: with SMTP id u13-v6mr439031wrp.311.1538177565883;
 Fri, 28 Sep 2018 16:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180906122436.25610-1-linus.walleij@linaro.org>
In-Reply-To: <20180906122436.25610-1-linus.walleij@linaro.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 28 Sep 2018 16:32:33 -0700
Message-ID: <CANcMJZBAerypZGFV+Bc_+J34+8zt7t6+6vnJof7x7PC9bFGq8w@mail.gmail.com>
Subject: Re: [PATCH v7] regulator: fixed: Convert to use GPIO descriptor only
To:     linus.walleij@linaro.org, Anders Roxell <anders.roxell@linaro.org>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jmkrzyszt@gmail.com, shc_work@mail.ru, haojian.zhuang@gmail.com,
        aaro.koskinen@iki.fi, rppt@linux.vnet.ibm.com,
        robert.jarzmik@free.fr, philipp.zabel@gmail.com, zonque@gmail.com,
        marc.zyngier@arm.com, jacopo@jmondi.org, geert+renesas@glider.be,
        rmk+kernel@armlinux.org.uk, Tom Gall <tom.gall@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 6:01 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> As we augmented the regulator core to accept a GPIO descriptor instead
> of a GPIO number, we can augment the fixed GPIO regulator to look up
> and pass that descriptor directly from device tree or board GPIO
> descriptor look up tables.
>
> Some boards just auto-enumerate their fixed regulator platform devices
> and I have assumed they get names like "fixed-regulator.0" but it's
> pretty hard to guess this. I need some testing from board maintainers to
> be sure. Other boards are straight forward, using just plain
> "fixed-regulator" (ID -1) or "fixed-regulator.1" hammering down the
> device ID.

Hey Linus,
  Anders recently noted a regression in -next when running HiKey,
where USB fails to function.  I took a look and could reproduce this
as well, and after some unsuccessful muddling about in the usb
changes, I bisected it down to your commit here (specifically
efdfeb079cc3 in -next).

I'm not sure exactly why this would cause trouble, but I suspect it
has something to do w/ the cable-detect OTG to host-hub switch on the
HiKey.

Anyway, I just wanted to raise this with you so it can get sorted out
before that patch hits mainline.

thanks
-john
