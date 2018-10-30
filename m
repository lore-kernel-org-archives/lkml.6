Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF09C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6FD62064C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9hxMrRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6FD62064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeJ3WKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:10:24 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44063 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbeJ3WKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:10:24 -0400
Received: by mail-lf1-f68.google.com with SMTP id m18-v6so8813003lfl.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=j9hxMrRl3LeJ8BDIr8gsbuCYC5x1jis1un28w+/ifkjYGgLBY9kK5obuIXypaoZZQ2
         tp/Jfe2gQufGxHNM/kdj0dJKyWJ8daKMR+pAZu8Sv4Mz6cnkdqrjdhzRRR93/lVTqqqo
         2EWKRRE0znv7y1pUln7Ff3+jvNn4bPs7O2RDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HspSmfBDzptBzR2Kjg+MRKQqBhB8F2WJHal4+FQ9+OI=;
        b=lw/WhiA+8ELSckCbYD0bVIP7zTvmUjS6wTOgbag8b1xtvZf70z9jSXEvjbHv8gOzG1
         SF2wrcxi3ISbe+Pd4zzC0gao8UfjKASBpeHw7yTpfY+x7ObIDYVsZceEZuZoJZzQeaoC
         s6K7Pn4I1pY7n+ey01SC2qXA77Xm76AbyA7D50qVNzr25ImAWbuQllZR8eIayDbtBkmL
         a5jGEd74Prp+AojYxtmUOhtfGF7FGOsfQuan+0syjKsi7ss3+PYLOv2ciF6aOW1E51RP
         4/tVjiojUun82e3ZiGoTrX3H8yNPWZT78mYxA5IgFuqXK6hxjvZ0KpgD2YtLukFxyZcy
         G6Pg==
X-Gm-Message-State: AGRZ1gKyPQtw4hdNj352WQukvq5Yc3PBJOUPGK+4wyFEt3IgmY8PGlAj
        rRCSWkSLih9LSG1E9pd5h+AQmSRQ6PBRbJNHkr2q9g==
X-Google-Smtp-Source: AJdET5epC9Q4o9TKHtb8zedDFZfAp7pCA/5HS52EId1Ki8DnBpDAi6HVK3XJORwfz5ZlPESq4HKH7R64gZ7TcBiUvOA=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr1768841lfd.149.1540905417956;
 Tue, 30 Oct 2018 06:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com> <20181021200032.1833-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20181021200032.1833-5-wsa+renesas@sang-engineering.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:16:46 +0100
Message-ID: <CACRpkdbOM5N+OBbZnT0SQATpsRdXZLEE1YgODW9ZGewytGVdYQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: pinctrl-amd: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied.

Yours,
Linus Walleij
