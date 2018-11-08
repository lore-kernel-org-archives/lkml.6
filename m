Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0AAC46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0D720892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 11:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0D720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKHV2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 16:28:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:48962 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726304AbeKHV2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 16:28:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ADC73B06B;
        Thu,  8 Nov 2018 11:53:11 +0000 (UTC)
Date:   Thu, 8 Nov 2018 12:53:10 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181108115310.rf7htdyyocaowbdk@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181108044510.GC2343@jagdpanzerIV>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-08 13:45:10, Sergey Senozhatsky wrote:
> On (11/07/18 16:19), Petr Mladek wrote:
> > I really hope that the maze of pr_cont() calls in lockdep.c is the most
> > complicated one that we would meet.
> 
> Hmm... Yes, buffered/seq_buf printk looks like a hard-to-use API,
> when it comes to real world cases like this.
>
> So... here is a random and wild idea.
> 
> We actually already have an easy-to-use buffered printk. And it's per-CPU.
> And it makes all printk-s on this CPU to behave like as if they were called
> on UP system. And it cures pr_cont(). And it doesn't require anyone to learn
> any new printk API names. And it doesn't require any additional maintenance
> work. And it doesn't require any printk->buffered_printk conversions. And
> it's already in the kernel. And we gave it a name. And it's printk_safe.
> 
> a) lockdep reporting path should be atomic. And it's not a hot path,
>    so local_irq_save/local_irq_restore will not cause a lot of trouble
>    there probably.
> 
> b) We already have some lockdep reports coming via printk_safe.
>    All those
> 	printk->console_driver->scheduler->lockdep
> 	printk->console_driver->timekeeping->lockdep
> 	etc.
> 
>    came via printk_safe path. So it's not a complete novelty.
> 
> c) printk_safe sections can nest.
> 
> d) No premature flushes. Everything looks the way it was supposed to
>    look.
> 
> e) There are no out-of-line printk-s. We keep the actual order of events.
> 
> f) We flush it on panic.
> 
> g) Low maintenance costs.
> 
> So, can we just do the following? /* a sketch */
> 
> lockdep.c
> 	printk_safe_enter_irqsave(flags);
> 	lockdep_report();
> 	printk_safe_exit_irqrestore(flags);

All this looks nice. Let's look it also from the other side.
The following comes to my mind:

a) lockdep is not the only place when continuous lines get mixed.
   This patch mentions also RCU stalls. The other patch mentions
   OOM. I am sure that there will be more.

b) It is not obvious where printk_safe() would be necessary.
   While buffered printk is clearly connected with continuous
   lines.

c) I am not sure that disabling preemption would always be
   acceptable.

d) We might need to increase the size of the per-CPU buffers if
   they are used more widely.

e) People would need to learn a new (printk_safe) API when it is
   use outside printk sources.

f) Losing the entire log is more painful than loosing one line
   when the buffer never gets flushed.


Sigh, no solution is perfect. If only we could agree that one
way was better than the other.

Best Regards,
Petr
