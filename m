Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA08EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11382085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11382085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbeKFSDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:03:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:33046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729021AbeKFSDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:03:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5FFCAAFDE;
        Tue,  6 Nov 2018 08:38:57 +0000 (UTC)
Date:   Tue, 6 Nov 2018 09:38:56 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181106083856.lhmibz6vrgtkqsj7@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181102133629.GN3178@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102133629.GN3178@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-11-02 14:36:29, Peter Zijlstra wrote:
> On Fri, Nov 02, 2018 at 10:31:57PM +0900, Tetsuo Handa wrote:
> > syzbot is sometimes getting mixed output like below due to concurrent
> > printk(). Mitigate such output by using line-buffered printk() API.
> > 
> >   RCU used illegally from idle CPU!
> >   rcu_scheduler_active = 2, debug_locks = 1
> >   RSP: 0018:ffffffff88007bb8 EFLAGS: 00000286
> >   RCU used illegally from extended quiescent state!
> >    ORIG_RAX: ffffffffffffff13
> >   1 lock held by swapper/1/0:
> >   RAX: dffffc0000000000 RBX: 1ffffffff1000f7b RCX: 0000000000000000
> >    #0: 
> >   RDX: 1ffffffff10237b8 RSI: 0000000000000001 RDI: ffffffff8811bdc0
> >   000000004b34587c
> >   RBP: ffffffff88007bb8 R08: ffffffff88075e00 R09: 0000000000000000
> >    (
> >   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> >   rcu_read_lock
> >   R13: ffffffff88007c78 R14: 0000000000000000 R15: 0000000000000000
> >   ){....}
> >    arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
> >    default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
> >   , at: trace_call_bpf+0xf8/0x640 kernel/trace/bpf_trace.c:46
> 
> WTH is that buffered aPI, and no, that breaks my earlyprintk stuff.

The API is supposed to replace the existing unreliable and tricky code,
see struct cont and KERN_CONT flag in kernel/printk/printk.c.

The solution has been discussed many times. The preferred solution
is to use explicit buffers instead of having many
per-cpu/per-context ones and auto magically switching between them.

The original idea was to use buffers on stack. But the stack is
limited and people would need to guess the length.

This current approach uses small pool of buffers and simple logic
to get/put one. If any buffer is not available, it falls back
to direct printk(), see
https://lkml.kernel.org/r/1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp

If you would want to avoid buffering, you could set the number
of buffers to zero. Then it would always fallback to
the direct printk().

Best Regards,
Petr
