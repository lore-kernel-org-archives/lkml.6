Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC60C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F3A2089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 15:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F3A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbeKJBYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:24:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:36824 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728059AbeKJBYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:24:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DD6FAE24;
        Fri,  9 Nov 2018 15:43:29 +0000 (UTC)
Date:   Fri, 9 Nov 2018 16:43:26 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-09 18:55:26, Tetsuo Handa wrote:
> On 2018/11/09 15:12, Sergey Senozhatsky wrote:
> > On (11/08/18 20:37), Tetsuo Handa wrote:
> > > On 2018/11/08 13:45, Sergey Senozhatsky wrote:
> How early_printk requirement affects line buffered printk() API?
> 
> I don't think it is impossible to convert from
> 
>      printk("Testing feature XYZ..");
>      this_may_blow_up_because_of_hw_bugs();
>      printk(KERN_CONT " ... ok\n");
> 
> to
> 
>      printk("Testing feature XYZ:\n");
>      this_may_blow_up_because_of_hw_bugs();
>      printk("Testing feature XYZ.. ... ok\n");
> 
> in https://lore.kernel.org/lkml/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com/ .

I just wonder how this pattern is common. I have tried but I failed
to find any instance.

This problem looks like a big argument against explicit buffers.
But I wonder if it is real.

> > 
> > So in my email I was not advertising printk_safe as a "buffered printk for
> > everyone", I was just talking about lockdep. It's a bit doubtful that Peter
> > will ACK lockdep transition to buffered printk.
> 
> What Linus is suggesting is "helper functions with no printk()", which is
> more difficult than my "helper functions with printk()" because we need to
> calculate enough buffer size (which may traverse many functions) because
> we can't printk() from helper functions when buffer size is too small.
> 
> I'm wondering if Linus still insists scattering "a data structure which
> Linus suggested" around. Rather, I'd like to propose below one. This is not
> perfect but modification is much smaller.
> 
> + * Line buffered printk() tries to assign a buffer when printk() from a new
> + * context identifier comes in. And it automatically releases that buffer when
> + * one of three conditions listed below became true.
> + *
> + *   (1) printk() from that context identifier emitted '\n' as the last
> + *       character of output.
> + *   (2) printk() from that context identifier tried to print a too long line
> + *       which cannot be stored into a buffer.
> + *   (3) printk() from a new context identifier noticed that some context
> + *       identifier is reserving a buffer for more than 10 seconds without
> + *       emitting '\n'.
> + *
> + * Since (3) is based on a heuristic that somebody forgot to emit '\n' as the
> + * last character of output(), pr_cont()/KERN_CONT users are expected to emit
> + * '\n' within 10 seconds even if they reserved a buffer.

This is my main concern about this approach. It is so easy to omit
the final '\n'.

They are currently delayed until another printk(). Even this is bad.
Unfortunately we could not setup timer from printk() because it
would add more locks into the game.

This patch will make it worse. They might get delayed by 10s or even
more. Many other lines might appear in between. Also the code is
more tricky[*].


Sign, I am really unhappy how the buffered_printk() conversion
looks in lockdep.c. But I still think that the approach is more
reliable. I am going to investigate much more pr_cont() users.
I wonder how many would be that complicated. I do not want
to give up just because one use-case that was complicated
even before.


[*] The buffer can get written and flushed by different processes.
    It is not trivial to do it correctly a lockless way.

    The proposed locking looks right on the first glance. But
    the code is a bit scary ;-)
