Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5253420870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4rWHesd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbfAKMTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:19:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38164 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbfAKMTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:19:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so12763030lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 04:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hUB4Mxdg1jcc6Yo92cFrzmRtIYd0yWqCYV4RNq4YQ9w=;
        b=Z4rWHesdrWP+xM0zCb1CABaWacveXs1qO0jh136QEuBMJjxXJV6ACW5/AHfr1/6/ji
         vD+z8FNpmD/Z+vtVHV7885NHgChvxEWVGS6u9tukCQXHigt1Vi+fq6kFblVqxSgGVvt9
         iW/j4qc16/D7ExmNC0NsC+HrbpPGIeCovrOFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hUB4Mxdg1jcc6Yo92cFrzmRtIYd0yWqCYV4RNq4YQ9w=;
        b=keG20P/+0TH6MxRhyt5bTaSz6oA/txwgM1CtRH2rFi/EdAtjJJLHKueWFbXHfctRFs
         Qo6Tfn5MqBTSQT2B6Xg7B90D0q3oCKMbebtJOoDFspPpVzjnF8o/u1k9vlHOGhLWGsTL
         EYvqYR9lwx+FuybsM0wihuJC/O5hRiYZJjSWG8RnjRuEsotw1lNe3BiYbV/9QYSxuMAt
         7SxLPeR1BpTWkjBIC4z/HiHgYFjXMM2gRX8+3gBjc0LCeHm3gvmbeQ4ajC10vd1aHAQJ
         qKZt1WJYQdForAJbwgVxNLc9c9AFIf8HNGlm/fbIsmlS0GVMsYDNALNqG/j1xF3VBljF
         s1Xw==
X-Gm-Message-State: AJcUukdXRBpihusAoJKyIdhIW/xvy51o3A5UHTyUvpv6usddz7zM3UeU
        iMJJAfqz8SzxSB0QsT2oomgV71F2i2UpBn/j8ByiYQ==
X-Google-Smtp-Source: ALg8bN6SBszocyiKBcd2VbtIahmf8C2sB2zOYd848Onj2qBs+x9P/+IeYdM8reJuzlztmXr1htBFa6RO/rXHjoq0ZAo=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr8362889ljc.66.1547209177648;
 Fri, 11 Jan 2019 04:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20190104103226.2878-1-brgl@bgdev.pl>
In-Reply-To: <20190104103226.2878-1-brgl@bgdev.pl>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Jan 2019 13:19:26 +0100
Message-ID: <CACRpkdacXeBEh2UMmigSo+zYQCj3yMyNRfxHjqhu_kiZ2JMXbg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix line event timestamps for nested irqs
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 11:32 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Nested interrupts run inside the calling thread's context and the top
> half handler is never called which means that we never read the
> timestamp.
>
> This issue came up when trying to read line events from a gpiochip
> using regmap_irq_chip for interrupts.
>
> Fix it by reading the timestamp from the irq thread function if it's
> still 0 by the time the second handler is called.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Oh that's right. Should this not have Fixes: and Cc: stable?

> +       /*
> +        * We may be running from a nested threaded interrupt in which case
> +        * we didn't get the timestamp from lineevent_irq_handler().
> +        */
> +       if (!le->timestamp)
> +               le->timestamp = ktime_get_real_ns();
> +
>         ge.timestamp = le->timestamp;

I would merge these:

if (!le->timestamp)
    ge.timestamp = ktime_get_real_ns();
else
    ge.timestamp = le->timestamp;

Yours,
Linus Walleij
