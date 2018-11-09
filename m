Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C85C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC6820855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHAa+UI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC6820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeKIRnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:43:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeKIRnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:43:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id b13so841248wrx.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 00:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=whY3cdlLymYbAemwAFA7cNzdmUGnDBNaeGZFtOPUr0A=;
        b=oHAa+UI4kykma9/3SOV4qWLXl/MkBZMZv+t8OxJUQLMb19XB6BVVae8jsQIeuODb2B
         OWC2e2jaZTvLoe7bcKRN3KWqZDRYyOql9fcEtIbXUpHXQkY3kIWtKXdIoDk0mqTtd5/X
         2ywiHUUuhjk0tgBat4Q5r0B2rzIYwuiDtC9KAg/hmZ99I8Dw9/sKIPBqpGd7JjEzJJvf
         IbHZa/njh2DV8s9fITsidqE9n4pseNG2Aczxxvwue9UDYeEfDr30ScJLvyIaXZT5N8ga
         2jVJ4J4ITCdbl1/VP4E1We07D3skv8AMclrfVrY+Ic2thjIAx1YAMjMX4C4A1KKlVpsO
         nvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=whY3cdlLymYbAemwAFA7cNzdmUGnDBNaeGZFtOPUr0A=;
        b=W0w+htKQNtLQm4+6qzXfAdL92HaE+FPD9RM6LfPDHF/pGskIzs/GToY75fwggwk/L7
         5HAH/YnNlWQVg89JqCBlrUDhfzRYsIVdFIiNwPXjlsse1YQTt+4XZM+HI15J0TDf4PcD
         k+izpTudaAzbT5HlHJkOzEGbuuaclHiULxmK25KNQLvdup0J1qD0bUEPlpTAz+4Nj6cS
         cWdBdKoU8HJ29Shqn/sKGxvvX1PI2hu//s1JrizM2xepMuYDopQBFByB9YibPaqvR6v4
         7pItgQ19+wbst9oKAF950G5NVZ33NH6FyG8DLgfDFe4Qlj13kKVsln0xSqBPHXomJENV
         ad9g==
X-Gm-Message-State: AGRZ1gKcTHTP9Zq1GbNmY7Reyimn3UyJA+uPFpzsK+KZ6XFu0Nmlx4VE
        G1Se0+oG/T2bsE8y/nE1igY=
X-Google-Smtp-Source: AJdET5d7EfVlfyXqyLNdjCJu5mvgkCTgnW6NkAILg8K+sExX26PYk7PujQP6zrWvNAfamRVPRLMFAw==
X-Received: by 2002:adf:9022:: with SMTP id h31-v6mr7355477wrh.297.1541750655114;
        Fri, 09 Nov 2018 00:04:15 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 82-v6sm708891wms.17.2018.11.09.00.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 00:04:14 -0800 (PST)
Date:   Fri, 9 Nov 2018 09:04:12 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/12] locking/lockdep: Add a new class of terminal
 locks
Message-ID: <20181109080412.GC86700@gmail.com>
References: <1541709268-3766-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541709268-3766-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Waiman Long <longman@redhat.com> wrote:

> The purpose of this patchset is to add a new class of locks called
> terminal locks and converts some of the low level raw or regular
> spinlocks to terminal locks. A terminal lock does not have forward
> dependency and it won't allow a lock or unlock operation on another
> lock. Two level nesting of terminal locks is allowed, though.
> 
> Only spinlocks that are acquired with the _irq/_irqsave variants or
> acquired in an IRQ disabled context should be classified as terminal
> locks.
> 
> Because of the restrictions on terminal locks, we can do simple checks on
> them without using the lockdep lock validation machinery. The advantages
> of making these changes are as follows:
> 
>  1) The lockdep check will be faster for terminal locks without using
>     the lock validation code.
>  2) It saves table entries used by the validation code and hence make
>     it harder to overflow those tables.
> 
> In fact, it is possible to overflow some of the tables by running
> a variety of different workloads on a debug kernel. I have seen bug
> reports about exhausting MAX_LOCKDEP_KEYS, MAX_LOCKDEP_ENTRIES and
> MAX_STACK_TRACE_ENTRIES. This patch will help to reduce the chance
> of overflowing some of the tables.
> 
> Performance wise, there was no statistically significant difference in
> performanace when doing a parallel kernel build on a debug kernel.

Could you please measure a locking intense workload instead, such as:

   $ perf stat --null --sync --repeat 10 perf bench sched messaging

and profile which locks used there could be marked terminal, and measure 
the before/after performance impact?

> Below were selected output lines from the lockdep_stats files of the
> patched and unpatched kernels after bootup and running parallel kernel
> builds.
> 
>   Item                     Unpatched kernel  Patched kernel  % Change
>   ----                     ----------------  --------------  --------
>   direct dependencies           9732             8994          -7.6%
>   dependency chains            18776            17033          -9.3%
>   dependency chain hlocks      76044            68419         -10.0%
>   stack-trace entries         110403           104341          -5.5%

That's pretty impressive!

> There were some reductions in the size of the lockdep tables. They were
> not significant, but it is still a good start to rein in the number of
> entries in those tables to make it harder to overflow them.

Agreed.

BTW., if you are interested in more radical approaches to optimize 
lockdep, we could also add a static checker via objtool driven call graph 
analysis, and mark those locks terminal that we can prove are terminal.

This would require the unified call graph of the kernel image and of all 
modules to be examined in a final pass, but that's within the principal 
scope of objtool. (This 'final pass' could also be done during bootup, at 
least in initial versions.)

Note that beyond marking it 'terminal' such a static analysis pass would 
also allow the detection of obvious locking bugs at the build (or boot) 
stage already - plus it would allow the disabling of lockdep for 
self-contained locks that don't interact with anything else.

I.e. the static analysis pass would 'augment' lockdep and leave only 
those locks active for runtime lockdep tracking whose dependencies it 
cannot prove to be correct yet.

Thanks,

	Ingo
