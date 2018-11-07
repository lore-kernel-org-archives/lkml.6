Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F358DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BF82081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BF82081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbeKGTvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 14:51:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:57400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbeKGTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 14:51:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4080DB6F4;
        Wed,  7 Nov 2018 10:21:56 +0000 (UTC)
Date:   Wed, 7 Nov 2018 11:21:54 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
Message-ID: <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106143502.GA32748@tigerII.localdomain>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-11-06 23:35:02, Sergey Senozhatsky wrote:
> On (11/02/18 22:31), Tetsuo Handa wrote:
> >   (1) Call get_printk_buffer() and acquire "struct printk_buffer *".
> > 
> >   (2) Rewrite printk() calls in the following way. The "ptr" is
> >       "struct printk_buffer *" obtained in step (1).
> > 
> >       printk(fmt, ...)     => printk_buffered(ptr, fmt, ...)
> >       vprintk(fmt, args)   => vprintk_buffered(ptr, fmt, args)
> >       pr_emerg(fmt, ...)   => bpr_emerg(ptr, fmt, ...)
> >       pr_alert(fmt, ...)   => bpr_alert(ptr, fmt, ...)
> >       pr_crit(fmt, ...)    => bpr_crit(ptr, fmt, ...)
> >       pr_err(fmt, ...)     => bpr_err(ptr, fmt, ...)
> >       pr_warning(fmt, ...) => bpr_warning(ptr, fmt, ...)
> >       pr_warn(fmt, ...)    => bpr_warn(ptr, fmt, ...)
> >       pr_notice(fmt, ...)  => bpr_notice(ptr, fmt, ...)
> >       pr_info(fmt, ...)    => bpr_info(ptr, fmt, ...)
> >       pr_cont(fmt, ...)    => bpr_cont(ptr, fmt, ...)
> > 
> >   (3) Release "struct printk_buffer" by calling put_printk_buffer().
> 
> [..]
> 
> > Since we want to remove "struct cont" eventually, we will try to remove
> > both "implicit printk() users who are expecting KERN_CONT behavior" and
> > "explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
> > this API is recommended.
> 
> - The printk-fallback sounds like a hint that the existing 'cont' handling
>   better stay in the kernel. I don't see how the existing 'cont' is
>   significantly worse than
> 		bpr_warn(NULL, ...)->printk() // no 'cont' support
>   I don't see why would we want to do it, sorry. I don't see "it takes 16
>   printk-buffers to make a thing go right" as a sure thing.

I see it the following way:

   + mixed cont lines are very rare but they happen

   + 16 buffers are more than 1 so it could only be better [*]

   + the printk_buffer() code is self-contained and does not
     complicate the logic of the classic printk() code [**]


[*] A missing put_printk_buffer() might cause that we would get
    out of buffers. But the same problem is with locks,
    disabled preemption, disabled interrupts, seq_buffer,
    alloc/free. Such problems happen but they are rare.

    Also I do not expect that the same buffer would be shared
    between many functions. Therefore it should be easy
    to use it correctly.


[**] I admit that cont buffer implementation is much easier
     after removing the early flush to consoles but still...


Anyway, I do not think that both implementations are worth it.
We could keep both for some transition period but we should
remove the old one later.


> A question.
> 
> How bad would it actually be to:
> 
> - Allocate seq_buf 512-bytes buffer (GFP_ATOMIC) just-in-time, when we
>   need it.
>     // How often systems cannot allocate a 512-byte buffer? //
> 
> - OK, assuming that systems around the world are so badly OOM like all the
>   time and even kmalloc(512) is absolutely impossible, then have a fallback
>   to the existing 'cont' handling; it just looks to me better than a plain
>   printk()-fallback with removed 'cont' support.

This would prevent removing the fallback to struct cont. OOM is
one important scenario where continuous lines are used.


> - Do not allocate seq_buf if we are in printk-safe or in printk-nmi mode.
>   To avoid "buffering for the sake of buffering". IOW, when in printk-safe
>   use printk-safe.

Sure, my plan is to add a helper function is_buffered_printk_context() or so
that would check printk_context. Then we could do the following in
vprintk_buffered()

	if (is_buffered_printk_context())
		vprintk_func(....);

It might be added on top of the current patchset. I opened this
problem once and it got lost. So I did not want to complicate
it at this moment.

Best Regards,
Petr
