Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA81A206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1twqnU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbeLNPGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:06:32 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35796 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730050AbeLNPGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:06:31 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so5192627ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2PIUH3HdKGl6pVSuMINWEihukBZSvv6yZJMsxGKz5I=;
        b=W1twqnU6uy5l5Z3qPBg7Azm/5upwxRmTe/ef3WYOH275Rr1vLl/wCEKf0Hc/uAljS8
         8pAmS5xzuceASVh28cSF9JEpsi1FK0Tq6dX8ONI80S+vsJFe/q5mdXgtMji0GmHIWVRV
         7lKcn8kxF9yDvz5w1mEMEKPfL79KjTvUdto4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2PIUH3HdKGl6pVSuMINWEihukBZSvv6yZJMsxGKz5I=;
        b=jKDP2gsBnc7mbm+DIuynax89pqfOabnMaw5vB7s6GZy5vk2UWgbdcYuXXGVzyic0oH
         0tt4qTXH7gwnEYKidU3QIk2iXWplxZv4EfTbhSyXSrArXuqUSNLLWDH0/4aCCWZx8akC
         T8j8sL1+Fv0SiAhflM+r2uGY+R+H9HEIFJAG6WjU+hG6uSND+ZwHUQoJsF+qcHwpv4Oo
         CWCA9DB7NriIdG4yvk70YpllkRoX0MPvBYwhlrfnA9pGoPsUGjOaUMB9ZzX/IuX0rYcg
         Pqc29i6rXfJEZMCRPlyimrr3mvdfD6Yquj7FgUG8ImbnoeY+NtM6luubwQw8mbCMvCaF
         rQtA==
X-Gm-Message-State: AA+aEWahPPquWcdZhfsoxDWuMIYbxcmas556sZe0athDTOQ+sLPYPPnP
        BXIFI7oarPouWS0ykrOHsJK4EWRczIB44JLX8DzKYg==
X-Google-Smtp-Source: AFSGD/Whs4MojTPjr9kJfSdu2q/lMlCZapWapjYV+Ed2U5R1+hdCq8BQbH+p0EMesp92fmH6geook1/T7YKhOeUWFYY=
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr1845971ljj.120.1544799990061;
 Fri, 14 Dec 2018 07:06:30 -0800 (PST)
MIME-Version: 1.0
References: <1544089549-23629-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1544089549-23629-1-git-send-email-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 16:06:17 +0100
Message-ID: <CACRpkdZf2pqS04H0DVvQAig2WGFcD9i-kwK=LExT_Nar4Lyu_Q@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 10:45 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> If CONFIG_GPOILIB is not set, the stub of gpio_to_desc() should return
> the same type of error as regular version: NULL.  All the callers
> compare the return value of gpio_to_desc() against NULL, so returned
> ERR_PTR would be treated as non-error case leading to dereferencing of
> error value.
>
> Fixes: 79a9becda894 ("gpiolib: export descriptor-based GPIO interface")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Patch applied. I kept the Fixes but removed stable, I do not know
of any regression it is fixing.

Yours,
Linus Walleij
