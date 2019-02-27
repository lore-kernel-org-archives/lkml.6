Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD90C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C936B20C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551288994;
	bh=rh2OsDbMJ72P/cASM8S4orCxuJX/wOoj/lHCnEzZ2Tg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OaV4m6GlhFsfMlKnoDdoz4CT3rK2HGjMeVbc+ggbTWw50wE68Mhg9s09YXwxg9etU
	 I0H5hktpXoAZ8ZZHfgz9T9x2BM9hXi+3Gt2QRy7UMbIXgrG+Cabj4cN2rJVvV5h6hp
	 Di5QiyRIWWgJpZrab9WGcK+HydKvtCQ1Ni26giWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfB0Rgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 12:36:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35124 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0Rgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 12:36:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id t13so10324256lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wckjCNIig3Ybnw5K6f0tO9TPLGk4mAXuMQSBbkIvtDk=;
        b=gdz4NsslrAT789rwqtaAok2GIZB+PuCePUF8GG+iifMd2mBufsiLowlFXsaw5a03E3
         bk4Dp8JtCpinC1F6S4k2+vy3GuNX2JQ8PPBREmZj4rON9VacYfmaUBfER4IU4zLO1BAP
         0t6e5wnuiphF8X7W1KPgOLv7+GHsh1L3a+GbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wckjCNIig3Ybnw5K6f0tO9TPLGk4mAXuMQSBbkIvtDk=;
        b=G0zg1Ma6ts+ph8ktgNZJ0FD9LCieBGIo7q1GzaVBtK5HRBrhf8YYBtZk+DGKDbG1Y5
         ruiEzdtCkRYr8yelqMTHRI33Bzv7sMM9WcHvYip7/BHiHcA8IOtTSCYaMGlqUfq7qdrq
         xoxkDubsscbkJh1ztjC2RyXtm1ogX7n1MzRugONtTZ3hd1SUUlIWnAdqxcVHAXChOH/C
         XN8O0ZNopSZ5YiBu7w/gzt/x84L1TKmWoTf/+cIMYPNaUMdGxC+bJMK5JpYXE3Yibcho
         s2WdPSxz/vN2YHvAiPPuDGVezoo/7EBWvyFUOYTA0E9hLZBUxcOoxjAx0qwBQPJNerLe
         /3fA==
X-Gm-Message-State: APjAAAXqsYuQcgZbO3rLxpvY1TgZrMLzW+MvS15NzZZy4173YfGDjvk+
        iB3FA5/DHEpSN6mF6vteMc3qoO+KkT0=
X-Google-Smtp-Source: APXvYqwczwM9hMWxi4OlzTalXZrAqgUqqljCwX5AwvWOz28noUmHafxUgRgx9Qnl2MMoXS1M0J+l0w==
X-Received: by 2002:a2e:9001:: with SMTP id h1mr2177972ljg.5.1551288989851;
        Wed, 27 Feb 2019 09:36:29 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 5sm3606817ljf.86.2019.02.27.09.36.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 09:36:28 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id d24so14419891ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 09:36:28 -0800 (PST)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr1959575lji.79.1551288987853;
 Wed, 27 Feb 2019 09:36:27 -0800 (PST)
MIME-Version: 1.0
References: <20190225124330.613028745@infradead.org> <20190225125232.191698923@infradead.org>
 <20190227140830.GP32494@hirez.programming.kicks-ass.net> <CAHk-=wg6P=hDhq+kPs0TCCvN7_q3usW5WNWzfdCBcLX_syoVxg@mail.gmail.com>
 <20190227173046.GU32494@hirez.programming.kicks-ass.net>
In-Reply-To: <20190227173046.GU32494@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Feb 2019 09:36:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2tocacYp2vDJZy9NWatdk_YCjoFYkcSGAbKon8anTLA@mail.gmail.com>
Message-ID: <CAHk-=wj2tocacYp2vDJZy9NWatdk_YCjoFYkcSGAbKon8anTLA@mail.gmail.com>
Subject: Re: [PATCH 5/6] objtool: Add UACCESS validation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Peter Anvin <hpa@zytor.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>, valentin.schneider@arm.com,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 9:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Right, but I was hoping to avoid having to do that; and I think we can
> do that if we push all of kasan_report into an exception, like that
> 'patch' I just posted.
>
> If I'm not mistaken the regular kasan house-keeping crud just prods at
> the shadow memory with simple code and should be perfectly safe.

Fair enough. I do agree it would be nice to not have the save/restore
simply because "it cannot matter" and we have the static tool to prove
that.

             Linus
