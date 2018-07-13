Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7D7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204C62124D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaDvOlu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204C62124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbeGMHiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:38:25 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51501 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeGMHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:38:24 -0400
Received: by mail-it0-f68.google.com with SMTP id h2-v6so8481132itj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RckRxjLWcSUAoOdaSiTimk+esXC6JwYcZvyVlEDY9yU=;
        b=BaDvOlu1zqaq4eeYcX+KHqkWpoVZPjJqMfvKmgodsVPVZx5wvUYIyY3e+6JTMvu6Hg
         e6RqQwRbGKbwC4OkCLj04NeKJHC1rzcDGEJmjZc250f/LcFBnj5QTS3ZxTC75CLMCMbw
         fyhAz5zwU1BCcshMOa+BY5oVRgmuVJJUcA49U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RckRxjLWcSUAoOdaSiTimk+esXC6JwYcZvyVlEDY9yU=;
        b=h25eGNrqfnvlsg58yRkjlgYWxiZqCut/w9ObdEfCIJIPeDxOfaLn1yrM51wZ9h6HpD
         ri/Qhe7KFHgDbqJ4RaCZcRGQ8gqNksBWQrGotQ6Pa804CkAqH9YmA8SmW5zwEu9fk/C3
         ZmjWpiJijxVZn4S68xJsi2MSR/24uiAxnQam1rE6nbfeB8cl6MO+HsnNhq6DM3FTWHM8
         PmRCxXZZn66uVMVdQWyZuq8e771T1QQ6TBDH61K3BicM9LHjchVhq6gA4WntleeFe6rB
         lvn+/H5lBmfWAPL5AE6skIopEMFIX84OJMPlSDgr2RWaxRrX7ZvYkkigCmwqw4bMkizI
         7yLQ==
X-Gm-Message-State: AOUpUlEt/eQyPu3zD8SVhWI+uGCVXud9L4+7Gy4BT5kDMn1TJCG49TnQ
        pes8eEpIJCHbWf9blQGKm8gbCES6xB4GCPSIjEPbQXYjUqM=
X-Google-Smtp-Source: AAOMgpf1/SPR220mv1Qgjv8Bgnf2x3ATU4snIfbnInI0IXGO9nh/2deaI44Wq8tCZI1A0OyGuR6IU847l/D7uVIgz+A=
X-Received: by 2002:a24:ad01:: with SMTP id c1-v6mr3834114itf.70.1531466703679;
 Fri, 13 Jul 2018 00:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180710144737.1136856-1-arnd@arndb.de>
In-Reply-To: <20180710144737.1136856-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Jul 2018 09:24:52 +0200
Message-ID: <CACRpkdY5oMG0WknSEnG1khTTm_UKwWwdAbAthA54geGhqgyXpQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] Documentation: document ktime_get_*() APIs
To:     Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>, david@fromorbit.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, willy@infradead.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:48 PM Arnd Bergmann <arnd@arndb.de> wrote:

> As Dave Chinner points out, we don't have a proper documentation for the
> ktime_get() family of interfaces, making it rather unclear which of the
> over 30 (!) interfaces one should actually use in a driver or elsewhere
> in the kernel.
>
> I wrote up an explanation from how I personally see the interfaces,
> documenting what each of the functions do and hopefully making it a bit
> clearer which should be used where.
>
> This is the first time I tried writing .rst format documentation, so
> in addition to any mistakes in the content, I probably also introduce
> nonstandard formatting ;-)
>
> I first tried to add an extra section to
> Documentation/timers/timekeeping.txt, but this is currently not included
> in the generated API, and it seems useful to have the API docs as part
> of what gets generated in
> https://www.kernel.org/doc/html/latest/core-api/index.html#core-utilities
> instead, so I started a new file there.
>
> I also considered adding the documentation inline in the
> include/linux/timekeeping.h header, but couldn't figure out how to do
> that in a way that would result both in helpful inline comments as
> well as readable html output, so I settled for the latter, with
> a small note pointing to it from the header.
>
> Cc: Dave Chinner <david@fromorbit.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: minor changes suggested by Randy

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

This brings into question commit bc2b7dab629a5
"iio:core: timestamping clock selection support"
that has bothered me for some time. Now that is ABI, but
we might be able to do some recommendations based on the
time base and have a sensible default moving forward.

As I want to make that clock base parsing similar for GPIO
I first thought it was a good idea to support the same clocks,
but now it seems like a bad idea.

IIRC you told me to simply hammer down the clock that
makes the most sense.

At the same time userspace libraries (such as GNU radio) will
be confused if they can't match the timestamping clocks,
as correlating GPIO and IIO events is something they will
want to do. And I guess these clocks are there for a reason.

So asking Lars-Peter and Gregor: from a userspace point
of view, what makes most sense for the usecases you
have seen? Having one consistent time base or all of these
as we currently have? Different clocks under different
circumstances?

Yours,
Linus Walleij
