Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66860C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115AE20881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jb8n/G6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115AE20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeGIL66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:58:58 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39403 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbeGIL64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:58:56 -0400
Received: by mail-it0-f68.google.com with SMTP id p185-v6so25986157itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J7UbJV1PPYZ3e4BNvFjHFi4711aP5Zp1nbfzzQfebo8=;
        b=Jb8n/G6ttp8z35/gC3nhnqV00WoApuH4oljvqr9C3yv5SbTX16M2BIc1MJreGXAucy
         Gccjay1VKsWb7NUQunmSVN3omV213eqP8lS0cAFxSd6o/kmUVilgIl+0Rlx80NjRJzZz
         78N8MOFAnKkCw194peYGjwjjPj8Zh0HVP6ubM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J7UbJV1PPYZ3e4BNvFjHFi4711aP5Zp1nbfzzQfebo8=;
        b=NeQ4tyv9mDf+VTiGSMOXZtg4H4x55+0Nsd+rHEtCujHvaRgN3tOpRttsb7sITtQm8g
         j1J5NNsLrspGtAcyCyMPGLZn7zqTsZpDl11kFWwkVGYpyNG9rSMFBzT2br1lyxHn9xJ9
         2ftdMLacPvDjstEAULoNMrL0GNKNKpNn6SSUzv9tkf7w7yAE3a6R7VPLIV+NXDSSHBPs
         7tRLT/gUKBG6D+Rykw5qSOoqemZEQhlhYwcOWr/TNMkSe4bEOeNexw92fcr1651dkslj
         weV9hT1/62Fs9gQDhr1RjptXAg0jr7myND+JEFa+c6XgnacX1GSQcenzUviOQMKJLaC+
         hpGQ==
X-Gm-Message-State: AOUpUlF5PHFAsooDJUIdOdYgmsuNfkt3KzMDgC9Hd9bs6OUE6wtdqBRa
        uWgSARevF58itYpQxkKdL4BZezGw7RNzWmzyslg0xA==
X-Google-Smtp-Source: AAOMgpcSCqbGJwxMDicotuND72V7k9C8Gg0SB5W27ViZsJzdgsgFZ1QBKMZG33RJXTD1Tj6+NG0kWrwplENZU4TDiX4=
X-Received: by 2002:a24:2c49:: with SMTP id i70-v6mr396280iti.135.1531137536121;
 Mon, 09 Jul 2018 04:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180627114904.10890-1-paul@crapouillou.net> <20180627114904.10890-4-paul@crapouillou.net>
In-Reply-To: <20180627114904.10890-4-paul@crapouillou.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jul 2018 13:58:44 +0200
Message-ID: <CACRpkdZMCzry4gKPi7wtayCRBrhAkS5hkBjBTwZwbkuLiESzfw@mail.gmail.com>
Subject: Re: [PATCH 3/5] pinctrl: ingenic: Fix inverted direction for < JZ4770
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 1:49 PM Paul Cercueil <paul@crapouillou.net> wrote:

> The .gpio_set_direction() callback was setting inverted direction
> for SoCs older than the JZ4770, this restores the correct behaviour.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

As you pointed out that this was an important fix I picked it
out and applied for fixes (v4.18) before looking at the rest of
the patches.

Yours,
Linus Walleij
