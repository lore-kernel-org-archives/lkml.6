Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3293CC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098982082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfBKRMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:12:07 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45834 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBKRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:12:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id e5so12954543qtr.12;
        Mon, 11 Feb 2019 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nj5+4EqD3IH7EqzU3cYCkHLND8mMcw71VzW0DiV0fZc=;
        b=p/+hSZXTNW9GPM1Xgx4JYWDfrTjh4AFaXGNjyCvtuMHIIgIdvn8S5TPRGroJlQ1QVg
         1Ab4nhZ6gzAmFckH4dTb1DqiIBpBl+9WfoqvgcMoejqLynaQl3JilJM3sZlOixggTzIf
         liBLWsRj1FM8HkYixRGScmHdEA+4FR1rKMkIwYyCTYGpaN6OmDEK0yS6HzRUarSFnebn
         gqFwurm5GANVUch6QAjhN3CeXjdDM/GB6PRjfVOMjnN2D3Chorww0TVddbwmoPXpaWWD
         TAUjs31BbNhMS2AiMnszsYmpGB3AStL586rqaV+VdF+F+FHuelEcHBocc9l8xZ5D0A98
         DaUQ==
X-Gm-Message-State: AHQUAuYbvLCir8SL62TqKz2OjAhvl+kUrgeAhTzjlvknIsc7GnWuZxfW
        KxA343RBUwjJERx/5NCATsZJvESl0qbDUZvmXAk=
X-Google-Smtp-Source: AHgI3IZuYGgBoAnPlukcT2A0MRj8GE9sx9J4PaMsbdpMhLBGDa0PsZCE1PJAjQWNymyYbQz089SUV5UI/yVpY1MtmYY=
X-Received: by 2002:a0c:e98f:: with SMTP id z15mr8420739qvn.115.1549905125915;
 Mon, 11 Feb 2019 09:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20190109210706.GA27268@linux.ibm.com> <20190109210748.29074-5-paulmck@linux.ibm.com>
 <20190211153043.GC32385@fuggles.cambridge.arm.com>
In-Reply-To: <20190211153043.GC32385@fuggles.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 Feb 2019 18:11:48 +0100
Message-ID: <CAK8P3a3bkQoVfkV-+pNniirLN5Z_Wv3eG2TXW35kdJixCOH9_Q@mail.gmail.com>
Subject: Re: [PATCH RFC LKMM 5/7] docs/memory-barriers.txt: Enforce heavy
 ordering for port I/O accesses
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, Matthew Wilcox <willy@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Laight <David.Laight@aculab.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 4:30 PM Will Deacon <will.deacon@arm.com> wrote:

> Given the lack of Intel response here, I went away to do some digging.
> As evidenced by the commit message, there is certainly an understanding
> amongst some developers that inX/outX() are strongly ordered on x86 and
> this was re-enforced by Linus in March last year:
>
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg131212.html
>
> It was this information on which I based my patch. The Intel SDM is not
> quite as assertive in its claims.
>
> However, it has also occurred to me that this patch is actually missing
> the point. memory-barriers.txt should be documenting the *Linux* memory
> model, not the x86 one, and so the port accessors should be defined to
> have the same ordering semantics as the MMIO accessors. If this wasn't
> the case, then macros such as ioreadX() and iowriteX() would be unusable
> in portable driver code.

My interpretation of the ioreadX() and iowriteX() semantics is that they
only guarantee readl()/writel() barrier semantics, even though they
may in fact provide stronger barriers for PIO on architectures that use
CONFIG_GENERIC_IOMAP (which falls back to inX()/outX()).

> The inX/outX implementation in asm-generic would
> also be bogus, despite being widely used.

They likely are. The asm-generic files tend to provide a generic
abstraction as much as that is possible, but without having access
to the architecture specific semantics, they raditionally don't know
what should be done here. We now have __io_pbw()/__io_paw()/
__io_pbr()/__io_par() to let architectures get it right, but that is
a fairly recent addition, so nothing other than riscv defines them
today.
To make things worse, a lot of machines are unable to provide
__io_paw(), e.g. when all bus writes are posted.

      Arnd
