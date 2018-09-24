Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081BBC43382
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6A20676
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 23:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="A08oMoaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D6A20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbeIYFZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 01:25:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35360 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeIYFZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 01:25:00 -0400
Received: by mail-qt1-f196.google.com with SMTP id z14-v6so6442409qtn.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFV4dnlatzbguNcNR/N13waU+Yimxo+sUEj115HJZJA=;
        b=A08oMoawSGdS/ISuOn8gkzopwRW4qrK+cXoWiBa5VTKbq3zBNAVqR9bAJfhunAwehA
         UlKkHN0/nLwS15g6Lo0uGVL9NRp8p1vkuWX0ZQ8HWONifYRB1tVgbPUvQuY87DMGm7eh
         7oiqbLKvOEPW3Wfl/w1mIEsrilboPQQGigGl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFV4dnlatzbguNcNR/N13waU+Yimxo+sUEj115HJZJA=;
        b=qT6FU+I/5dqr04lkzPRTIfCbynqkOQNrXsEouza+2VHtGtOERN1yxUGElzc78jnwSm
         VWRBKA6UPZYnRUBPEVTUTmXwILLxzJf77tkUqkN3cItdYH9P6HXfDIIqFukNzkNWVHyD
         j7CBrLDx66/80fhJJ8b8dj3d8ZO7QKAAkyinFUsHKebxhhzWx76Xg0OzNouJtgsORS9t
         W/aG2CfVaJJgdbhuDh3faMRoaUdEKUGqrG5qcP1LZACnPpq/R9u8pdgaTsWD5LDEratZ
         tiRG8nStxk7YRU49KajuUO9ywd0Vhv2rB+yi27BZPQi4oxGYOOkn5Vqwa5mKCCKQVMz3
         1PdA==
X-Gm-Message-State: ABuFfogCMVjN1zGY2pOcBLlZBbwcMC4r4rgJqbrlWg2DyJdLA/8x1Jnt
        jJNKUkJQOKCXPYXFvRDTYY35fe2bWXgCjBo22UJ68g==
X-Google-Smtp-Source: ACcGV6293BhLYBqd+Jcq7bV3cjqa+bqry9aCHoUa3t5UlTxwehMeUNeOLBpJYGy84K8VLnA4GrvEYkhbtkxKdi2k/0I=
X-Received: by 2002:aed:3667:: with SMTP id e94-v6mr869282qtb.285.1537831224427;
 Mon, 24 Sep 2018 16:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180919221331.2511558-1-taoren@fb.com> <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com> <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
 <E3FA56EF-0B3C-4DBE-9A63-428EB342887D@fb.com>
In-Reply-To: <E3FA56EF-0B3C-4DBE-9A63-428EB342887D@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 Sep 2018 08:50:11 +0930
Message-ID: <CACPK8Xd03w51FM8iJsFNhWkpRFMhy97XZpxOhbRwbD3ytQcRbg@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     Tao Ren <taoren@fb.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, cov@fb.com,
        Tian Fang <tfang@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Sep 2018 at 03:41, Tao Ren <taoren@fb.com> wrote:
>
> On 9/20/18, 8:33 PM, "Joel Stanley" <joel@jms.id.au> wrote:
>
> > I gave this a spin on the ast2400. It looked okay, but I was wondering
> > if you could share you test case so I can run the same test?
>
> Thank you Joel for the testing.
> Sure I can share the test (a small c program which measures delay introduced by nanosleep()), but what would be the preferred way to share it? Like a format-patch? Or maybe I should refine the test and send to openbmc for review?

Whatever method is easiest for you. A patch file or a tarball is fine.
I will then add it to the set of tests I run when testing aspeed
kernels.

Cheers,

Joel
