Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A50EC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B148C20843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 17:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EySpaRFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B148C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbeIBV4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 17:56:49 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42947 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeIBV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 17:56:49 -0400
Received: by mail-yw1-f65.google.com with SMTP id n207-v6so6684076ywn.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 10:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pWrgDShMuB0wPQd+OYpZaKnApdkulZ6D6GHKGScb7GQ=;
        b=EySpaRFxfwuvm33VbGS/k1YMRN4i6sGidxwIYdYJYjs/GZQ7qXEgKL6SFaLevnlXXM
         yiAZrjGtSnUY9f50Pi+luAH69Tu65sirxcG/BKnE0rk57b3eBO98HDC/rLFceC914KIt
         he3eAhc1EqP14C/x0zJI/ul6WxRStaCflqIiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pWrgDShMuB0wPQd+OYpZaKnApdkulZ6D6GHKGScb7GQ=;
        b=Edl4A0cA0+i1EF7ZNh1VvSOsVR87gcuhthhqFUG+xLeZqp+5Ckrf22NGuHCZKe1Akg
         2PCryrGcFGqFLuaB2wmwOkysM5VjcY7VNMNKjlS9O28aXuOiV44KNmWZwYY9bxysLj3+
         /+U1In37cQDTsqIDhsz49pEqMfNd5GcgXP1ftE7jSb1hwb++ys1Dh20dUDHIiO0gITSJ
         I1xWG2AO4jlWagAQx9pWRC0ZRcphF8bxJzf4h7jCd6pBOVUm73LtGIPWxx9vcIDGF00z
         yfRK9txeNhEaBUKhTcxN17vMMDK1O20BlInJYPMgWxV6jsbbOriY+p/6prdSOKLnwK6L
         g7ag==
X-Gm-Message-State: APzg51D7OEzGCuJBB1oo/6in4uXX8fyIgBSuYrgRS8UMlnJpQjwmp6aU
        skgecm/ModabieCf4BrQUVELrLA3DBQ=
X-Google-Smtp-Source: ANB0VdZ0FdQAls3oG0F0qm1YZF/7o4wCS//1JGx1+xzTJKlasYjfJuMlDfSVdjODZLNuEbR33gyGLg==
X-Received: by 2002:a81:7505:: with SMTP id q5-v6mr13379283ywc.85.1535910016840;
        Sun, 02 Sep 2018 10:40:16 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id j70-v6sm6040933ywb.69.2018.09.02.10.40.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 10:40:15 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id h22-v6so2154271ybg.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 10:40:15 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr14272418ybd.141.1535910014668;
 Sun, 02 Sep 2018 10:40:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Sun, 2 Sep 2018 10:40:13 -0700 (PDT)
In-Reply-To: <1535875700.17858.3.camel@med.uni-goettingen.de>
References: <1535875700.17858.3.camel@med.uni-goettingen.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 2 Sep 2018 10:40:13 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
Message-ID: <CAGXu5jJ7kGm-DGUB8uwwhd-Hv7i4WEcSKumTf2MBsj_-yzWcqg@mail.gmail.com>
Subject: Re: VLAs and security
To:     "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 1:08 AM, Uecker, Martin
<Martin.Uecker@med.uni-goettingen.de> wrote:
> I do not agree that VLAs are generally bad for security.
> I think the opposite is true. A VLA with the right size
> allows the compiler to automatically perform or insert
> meaningful bounds checks, while a fixed upper bound does not.

While I see what you mean, the trouble is that the compiler has no
idea what the upper bounds of the _available_ stack is. This means
that a large VLA might allow code to read/write beyond the stack
allocation, which also bypasses the "standard" stack buffer overflow
checks. Additionally, VLAs bypass the existing stack-size checks we've
added to the kernel.

> For example:
>
> char buf[N];
> buf[n] = 1;
>
> Here, a compiler / analysis tool can for  n < N  using
> static analysis or insert a run-time check.
>
> Replacing this with
>
> char buf[MAX_SIZE]
>
> hides the information about the true upper bound
> from automatic tools.

While this may be true for some tools, I don't agree VLAs are better
in general. For example, the compiler actually knows the upper bound
at build time now, and things like the printf format size checks and
CONFIG_FORTIFY_SOURCE are now able to produce compile-time warnings
(since "sizeof(buf)" isn't a runtime value). With a VLA, this is
hidden from those tools, and detection depends on runtime analysis.

It should be noted that VLAs are also slow[1], so removing them not
only improves robustness but also improves performance.

> Limiting the stack usage can also be achieved in
> the following way:
>
> assert(N <= MAX_SIZE)
> char buf[N];

If you look through the various VLA removals that have been landing,
there is a common pattern of performing these checks where it might be
possible for an "n" to be larger than the fixed size. (Many removals
can be compile-time checked as callers are usually just in a specific
range -- it's not really a "runtime" size that was changing, since all
callers used different but hard-coded sizes.)

char buf[N];
...
if (WARN_ON(n > N))
    return -EINVAL;
...

> Of course, having predictable stack usage might be more
> important in the kernel and might be a good argument
> to still prefer the constant bound.

Between improved compile-time checking, faster runtime performance,
and improved robustness against stack exhaustion, I strongly believe
the kernel to be better off with VLAs entirely removed. And we are
close: only 6 remain (out of the 115 I counted in v4.15).

> But loosing the tighter bounds is clearly a disadvantage
> with respect to security that one should keep it mind.

Yes: without VLAs, stack array usage is reduced to "standard" stack
buffer overflow concerns. Removing the VLA doesn't introduce a new
risk: we already had to worry about fixed-size arrays. Removing VLAs
means we don't have to worry about the VLA-specific risks anymore.

-Kees

[1] https://git.kernel.org/linus/02361bc77888

-- 
Kees Cook
Pixel Security
