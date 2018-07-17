Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A01ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43656206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C/jVXA4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43656206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbeGQQ7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:59:39 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52985 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbeGQQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:59:38 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so2632994itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OZwIuFTa9wPx3qAvpYw8n+7WONDTpHKRmU7UyWF4vk=;
        b=C/jVXA4nmzKwDnaj/u/xCdma0Ga5abgdwyku8LGxGN7JZZ0f8n64q3Csd7/eXPTGY9
         S/lg09p7BkmrJ1u91xUWGgPWlTzGlNp4FyF/sTLaKTG/bVdySw9CMh35qJokO5DvDopV
         cUJd0ivHNqRJLcB91LNvG7IJfhlIIhCXK60XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OZwIuFTa9wPx3qAvpYw8n+7WONDTpHKRmU7UyWF4vk=;
        b=Tj2N2rtUT7baIw3G/biL12zjHiD9OWJ9u1h4p/z02+99MVdErCScpkYNRsMbtxmF2D
         Nm8ZB51Aw0JzaqqfxGUti7LmTiDhCvfadK3q1IMqLBJxdar8fnlyBYUcV2PLPB/rXjRu
         rPdrr9T7MTbOhJ7PgnRLdyl8d67KjDe4bpVilv9kCMdPTeTUfnhasT934IAVmvzgvCXM
         BbCKJ6gYpwcOKTf4K6UcSu9jrLSkdKJg3AlVb/LtEZReRY7OG+1fP/tVJEmWT679DR38
         Lf2D4NbitRRWeJBCR8SqkROTLKuV9hAN6L4eecKdKd5zHJco0+QzMXJCK6FS6EXP4o2w
         hZAg==
X-Gm-Message-State: AOUpUlEq6N6REuRsN45MpccfxUiminKmdXyRyYHy1wVH9wjnjoBmWGdX
        jel7nMmO/+p56op1r9n5om7HeeMAYFaCmat/4bo=
X-Google-Smtp-Source: AAOMgpe+UYILCLpxIDcCpVbuXIuC/mMIPPvAaOw6SCr9ONg1GbwEAjxtg45ZkfFri5ScA3dSuIdbboaBOquL7F0KmEY=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr2127719jas.72.1531844772175;
 Tue, 17 Jul 2018 09:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180717135307.3713325-1-arnd@arndb.de>
In-Reply-To: <20180717135307.3713325-1-arnd@arndb.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Jul 2018 09:26:00 -0700
Message-ID: <CA+55aFxjx+naf3vQ++kqxBNS=dvevPebcKOzA=OYWfMJZ2CrzA@mail.gmail.com>
Subject: Re: [PATCH] random: fix rdrand mix-in
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, tcharding <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 6:54 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The newly added arch_get_random_int() call was done incorrectly,
> using the output only if rdrand hardware was /not/ available. The
> compiler points out that the data is uninitialized in this case:

Ack.

Except:

>                 for (b = bytes ; b > 0 ; b -= sizeof(__u32), i++) {
> -                       if (arch_get_random_int(&t))
> +                       if (!arch_get_random_int(&t))
>                                 continue;
>                         buf[i] ^= t;
>                 }

Why not just make that "continue" be a "break"? If you fail once, you
will fail the next time too (whether the arch just doesn't support it
at all, or whether the HW entropy is just temporarily exhausted).

So no point in "continue". Just give up. Maybe it will work much
later, but not _immediately_.

(I don't actually see the commit in question - it's not in my pile of
emails only in linux-next, maybe there's some reason further down
prefers "continue" and the whole loop be finished).

             Linus
