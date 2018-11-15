Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7563C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B232133D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNXxMh/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B232133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbeKPI7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:59:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35662 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeKPI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:59:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so18687983ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0KvRkJRDAECrC64Kt2e9OGW666XAF51Tt7gv3CXMxA=;
        b=TNXxMh/5eVA9s299UR/Q1cWqx+Yo1vfYRWDhkMC1zOMD28ePln2o09e7VmJ/3pqvjB
         Dw8ymxNH7Z41v8xWd06iBJpEGtaTVykKL6MWhlYMDCs3AIUP5Sv1rOJMzFR33nPqOuZo
         Bss+2kxeGhEZ417QEHhqREMg1UcvnMYNiI7xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b0KvRkJRDAECrC64Kt2e9OGW666XAF51Tt7gv3CXMxA=;
        b=erUPw0KPTRyhSr9/i0JrSrroiDBkgcwJD4ujxgqa1MpGtY/J/DLqhMa6AOJsD0HJQa
         M4Y5Et2GGTDK7kOl5Nbn1gNAgxFG7npnX5sWNNOy+3z3OOkgpWroFdtnDU72o5Mgr9++
         S0saA29WIIGj8M/IVO9kNSUhwAsMrVyQyI1ZnmV+Go4WEp7fOrvAY1R7jlAlLAUj7JMb
         kjni0UIkzmHKanI+tnRUAlFoyul7PUJ7yLCTBnqu+Ai04aq4DzIkhljeyYijrX8TAB16
         M3Ea6ofklxFDWu0X6mbKQ79NtFkkv897JgBcJpGGkISGqNKVAdpIL7r6wIqLkhjK8RMN
         ZjGg==
X-Gm-Message-State: AA+aEWYXJTHtYnOd8/kD0X5XwkwuqhTr1QxysBh9hNtOHxT6OtsYCuXA
        cg9ThvreuMqSraE47ni9uRjoCtzk906iVQYQ+z/3XfO6wsY=
X-Google-Smtp-Source: AFSGD/WYpociEs9LRnsxPsfFKgsLl9gzY50PlfuMqlyY5Yg3Fy90Jni3igM1vGn5rZNwAWWMaqRjelBAw3KwjB+vOkk=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr158883ljk.4.1542322159666;
 Thu, 15 Nov 2018 14:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20181115171638.5704-1-robert.jarzmik@free.fr>
In-Reply-To: <20181115171638.5704-1-robert.jarzmik@free.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Nov 2018 23:49:07 +0100
Message-ID: <CACRpkdbJ6AoF=Y0XzrMrfg_oFX_DhdhQ_hafbtacD8N=g1uXRA@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: fix legacy non pinctrl aware builds again
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 6:16 PM Robert Jarzmik <robert.jarzmik@free.fr> wrote:

> As pointed out by Gregor, spitz keyboard matrix is broken, with or
> without CONFIG_PINCTRL set, quoting :
> "The gpio matrix keypard on the Zaurus C3x00 (see spitz.c) does not work
> properly. Noticeable are that rshift+c does nothing where as lshift+c
> creates C.  Opposite it is for rshift+a vs lshift+a, here only rshift
> works. This affects a few other combinations using the rshift or lshift
> buttons."
>
> As a matter of fact, as for platform_data based builds CONFIG_PINCTRL=n
> is required for now (as opposed for devicetree builds where it should be
> set), this means gpio driver should change the direction, which is what
> was attempted by commit c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl
> aware builds").
>
> Unfortunately, the input case was inverted, and the direction change was
> never done. This wasn't seen up until now because the initial platform
> setup (MFP) was setting this direction. Yet in Gregory's case, the
> matrix-keypad driver changes back and forth the direction dynamically,
> and this is why he's the first to report it.
>
> Fixes: c4e5ffb6f224 ("gpio: pxa: fix legacy non pinctrl aware builds")
> Tested-by: Greg <greguu@null.net>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Patch applied for fixes.

Yours,
Linus Walleij
