Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE5CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YNgklWwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeLKRWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:22:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34260 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbeLKRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:22:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so13706489ljd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1I4UW49vZ+99rSVWGMa84Lbor7J/QWM5eRq757XxbM=;
        b=YNgklWwOh5qRmK3nQzvxAvnpIfr4/yFRe1W+pgkPAdsfZvaMn+c+iuTTcB8RAgOwDV
         YSsvO3WqBEfNc3Dwq4t3sEypvMjS2YHWhA7fwrevBbyqnKYFzFvg276x3RokBF/a7uMr
         hl1v7XkLDrvs1esKLKzW23CMvHI2k6RWrSMZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1I4UW49vZ+99rSVWGMa84Lbor7J/QWM5eRq757XxbM=;
        b=VMz6rNCNN2GRt13sZhXxXBnL1meoC3JjRK13WQnVRHYfkRv6/3zeosigiwyABKvWI7
         mwdSfDVNpBrLPDyaOk9ewt06DUkDbFyw2L/Z8gcnget6go7pO+2feEeUZDt7+O4scOFX
         Jk09gieYrhjD24R9uj2ZJUQFRatil/Hl+WzP9PV5SwePlu388EoT4X3cropOdw3g35s7
         Az37k0gx2/htRbdcegH1Fqvn/XGA74JDkwRZCkl8EG1YiRLxOXJYP+yKM0vEZH3qxS9Q
         Xb+a12Ma0aIIucvet/1mi7nbxJk7KS9EvH+HmMFmBnlmt3zW2nnfkffeUJQQsl0johT4
         2igA==
X-Gm-Message-State: AA+aEWbPHSPZA9pNJMPNvx4vNzbbtrktimaXYc3ID3ZfVBUmmsVifyh4
        NW3C0uKq5EMtLVWIMRIfLGokTQfbt9o=
X-Google-Smtp-Source: AFSGD/WlROO0b7WqbzlXm7YMDyxPGBDabbr9ay/PCvxdnP26QdPcczhOM1T891REj6ms8xN6mg3v2g==
X-Received: by 2002:a2e:8596:: with SMTP id b22-v6mr10660536lji.122.1544548959918;
        Tue, 11 Dec 2018 09:22:39 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id g3-v6sm2849935lje.50.2018.12.11.09.22.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 09:22:39 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v15-v6so13653190ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:22:38 -0800 (PST)
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr9155229ljj.120.1544548958376;
 Tue, 11 Dec 2018 09:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20181211152113.8523-1-thomas.preston@codethink.co.uk> <20181211152113.8523-3-thomas.preston@codethink.co.uk>
In-Reply-To: <20181211152113.8523-3-thomas.preston@codethink.co.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Dec 2018 09:22:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
Message-ID: <CAHk-=wi2kvoDh3z_X3ZCBcyAX1MU4OedPkQjA-4=bR=6q7AT3w@mail.gmail.com>
Subject: Re: [PATCH 2/2] vsprintf: Stop using obsolete simple_strtoul()
To:     thomas.preston@codethink.co.uk
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>, geert+renesas@glider.be,
        Jonathan Corbet <corbet@lwn.net>, tcharding <me@tobin.cc>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        ben.dooks@codethink.co.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 7:21 AM Thomas Preston
<thomas.preston@codethink.co.uk> wrote:
>
> Stop using the obsolete functions simple_strtoul() and
> simple_strtoull(). Instead, we should use the improved kstrtol() and
> kstrtoll() functions. To do this, we must copy the current field into a
> null-terminated tmpstr and advance the variable `next` manually.

I see what you're trying to do, but this fix is much much worse than
the bug was.

> +               if (field_width > 0) {
> +                       char tmpstr[INT_BUF_LEN];
> +                       int ret;
> +
> +                       strscpy(tmpstr, str, field_width+1);

If field_width is larger than INT_BUF_LEN, you are now corrupting kernel stack.

And no, you can't fix it by limiting field_width, since a large
field_width is quite possible and might even be valid - and still fit
in an int. Maybe the number is

    000000000000000000000001

or something?

A fix might be to skip leading zeroes.

Honestly, just do it by hand. Don't use kstrol and friends at all.
Just do something like

    unsigned long long val = 0;
    p = str;
    for (;;) {
        int c;
        if (field_width > 0 && p - str >= field_width)
            break;
        c = hexval(*p++);
        if (c < 0 || c > base)
            break;
        val = val * base + c;
        // check for overflow
    }
    /* Now do "sign" and range checking on val */
    /* Ta-daa, all done */

or similar.  Treat the above as pseudo-code, I didn't fill in all the details.

            Linus
