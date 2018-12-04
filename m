Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8105C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E232082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9E232082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbeLDLM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:12:26 -0500
Received: from foss.arm.com ([217.140.101.70]:57534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727977AbeLDLMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:12:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FF1AA78;
        Tue,  4 Dec 2018 03:12:23 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D31DD3F59C;
        Tue,  4 Dec 2018 03:12:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 288E31AE10A5; Tue,  4 Dec 2018 11:12:43 +0000 (GMT)
Date:   Tue, 4 Dec 2018 11:12:43 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204111242.GA32596@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
 <20181203192228.GC29028@arm.com>
 <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
 <20181204005012.11f73df9@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204005012.11f73df9@vmware.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve, Arnd,

On Tue, Dec 04, 2018 at 12:50:12AM -0500, Steven Rostedt wrote:
> On Mon, 3 Dec 2018 22:51:52 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Dec 3, 2018 at 8:22 PM Will Deacon <will.deacon@arm.com> wrote:
> > > On Fri, Nov 30, 2018 at 04:09:56PM +0100, Anders Roxell wrote:  
> > > > Both of those functions end up calling ftrace_modify_code(), which is
> > > > expensive because it changes the page tables and flush caches.
> > > > Microseconds add up because this is called in a loop for each dyn_ftrace
> > > > record, and this triggers the softlockup watchdog unless we let it sleep
> > > > occasionally.
> > > > Rework so that we call cond_resched() before going into the
> > > > ftrace_modify_code() function.
> > > >
> > > > Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > > ---
> > > >  arch/arm64/kernel/ftrace.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)  
> > >
> > > It sounds like you're running into issues with the existing code, but I'd
> > > like to understand a bit more about exactly what you're seeing. Which part
> > > of the ftrace patching is proving to be expensive?
> > >
> > > The page table manipulation only happens once per module when using PLTs,
> > > and the cache maintenance is just a single line per patch site without an
> > > IPI.
> > >
> > > Is it the loop in ftrace_replace_code() that is causing the hassle?  
> > 
> > Yes: with an allmodconfig kernel, the ftrace selftest calls ftrace_replace_code
> > to look >40000 through ftrace_make_call/ftrace_make_nop, and these
> > end up calling

Ok, 40000 invocations would do it!

> > static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
> > {
> >         void *waddr = addr;
> >         unsigned long flags = 0;
> >         int ret;
> > 
> >         raw_spin_lock_irqsave(&patch_lock, flags);
> >         waddr = patch_map(addr, FIX_TEXT_POKE0);
> > 
> >         ret = probe_kernel_write(waddr, &insn, AARCH64_INSN_SIZE);
> > 
> >         patch_unmap(FIX_TEXT_POKE0);
> >         raw_spin_unlock_irqrestore(&patch_lock, flags);
> > 
> >         return ret;
> > }
> > int __kprobes aarch64_insn_patch_text_nosync(void *addr, u32 insn)
> > {
> >         u32 *tp = addr;
> >         int ret;
> > 
> >         /* A64 instructions must be word aligned */
> >         if ((uintptr_t)tp & 0x3)
> >                 return -EINVAL;
> > 
> >         ret = aarch64_insn_write(tp, insn);
> >         if (ret == 0)
> >                 __flush_icache_range((uintptr_t)tp,
> >                                      (uintptr_t)tp + AARCH64_INSN_SIZE);
> > 
> >         return ret;
> > }
> > 
> > which seems to be where the main cost is. This is with inside of
> > qemu, and with lots of debugging options (in particular
> > kcov and ubsan) enabled, that make each function call
> > more expensive.
> 
> I was thinking more about this. Would something like this work?
> 
> -- Steve
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 8ef9fc226037..42e89397778b 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
>  {
>  	struct dyn_ftrace *rec;
>  	struct ftrace_page *pg;
> +	bool schedulable;
>  	int failed;
>  
>  	if (unlikely(ftrace_disabled))
>  		return;
>  
> +	schedulable = !irqs_disabled() & !preempt_count();

Looks suspiciously like a bitwise preemptible() to me!

> +
>  	do_for_each_ftrace_rec(pg, rec) {
>  
>  		if (rec->flags & FTRACE_FL_DISABLED)
> @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
>  			/* Stop processing */
>  			return;
>  		}
> +		if (schedulable)
> +			cond_resched();
>  	} while_for_each_ftrace_rec();
>  }

If this solves the problem in core code, them I'm all for it. Otherwise, I
was thinking of rolling our own ftrace_replace_code() for arm64, but that's
going to involve a fair amount of duplication.

Will
