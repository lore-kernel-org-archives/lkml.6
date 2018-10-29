Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0708BC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27AE2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C27AE2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeJ3AcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbeJ3AcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:32:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8DF73091DAB;
        Mon, 29 Oct 2018 15:43:06 +0000 (UTC)
Received: from treble (ovpn-124-183.rdu2.redhat.com [10.10.124.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76BC85D970;
        Mon, 29 Oct 2018 15:43:02 +0000 (UTC)
Date:   Mon, 29 Oct 2018 10:42:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Torsten Duwe <duwe@lst.de>, Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v4 3/3] arm64: reliable stacktraces
Message-ID: <20181029154259.b7v5ou3r4sxkmxvq@treble>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142157.B8FAA68C97@newverein.lst.de>
 <20181026153704.7g34j3gtlklepyvb@treble>
 <20181029092812.j7q5gfwxc3qq4vye@salmiak>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029092812.j7q5gfwxc3qq4vye@salmiak>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 29 Oct 2018 15:43:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:28:12AM +0000, Mark Rutland wrote:
> Hi Josh,
> 
> I also have a few concerns here, as it is not clear to me precisely what is
> required from arch code. Is there any documentation I should look at?

The short answer is that we need:

1) Reliable frame pointers --  on x86 we do that with objtool:

   tools/objtool/Documentation/stack-validation.txt

2) Reliable unwinder -- on x86 we had to rewrite the unwinder.  There's
   no documentation but the code is simple enough.  See
   unwind_next_frame() in arch/x86/kernel/unwind_frame.c  and
   __save_stack_trace_reliable() in arch/x86/kernel/stacktrace.c.

> On Fri, Oct 26, 2018 at 10:37:04AM -0500, Josh Poimboeuf wrote:
> > On Fri, Oct 26, 2018 at 04:21:57PM +0200, Torsten Duwe wrote:
> > > Enhance the stack unwinder so that it reports whether it had to stop
> > > normally or due to an error condition; unwind_frame() will report
> > > continue/error/normal ending and walk_stackframe() will pass that
> > > info. __save_stack_trace() is used to check the validity of a stack;
> > > save_stack_trace_tsk_reliable() can now trivially be implemented.
> > > Modify arch/arm64/kernel/time.c as the only external caller so far
> > > to recognise the new semantics.
> 
> There are a number of error conditions not currently handled by the unwinder
> (mostly in the face of stack corruption), for which there have been prior
> discussions on list.
> 
> Do we care about those cases, or do we consider things best-effort in the face
> of stack corruption?

The unwinder needs to be able to detect all stack corruption and return
an error.

[ But note that we don't need to worry about unwinding a task's stack
  while the task is running, which can be a common source of
  "corruption".  For livepatch we make sure every task is blocked
  (except when checking the current task). ]

It also needs to:

- detect preemption / page fault frames and return an error

- only return success if it reaches the end of the task stack; for user
  tasks, that means the syscall barrier; for kthreads/idle tasks, that
  means finding a defined thread entry point

- make sure it can't get into a recursive loop

- make sure each return address is a valid text address

- properly detect generated code hacks like function graph tracing and
  kretprobes


> > > I had to introduce a marker symbol kthread_return_to_user to tell
> > > the normal origin of a kernel thread.
> > > 
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > I haven't looked at the code, but the commit log doesn't inspire much
> > confidence.  It's missing everything I previously asked for in the
> > powerpc version.
> > 
> > There's zero mention of objtool.  What analysis was done to indicate
> > that we can rely on frame pointers?
> > 
> > Such a frame pointer analysis should be included in the commit log.  It
> > should describe *at least* the following:
> > 
> > - whether inline asm statements with call/branch instructions will
> >   confuse GCC into skipping the frame pointer setup if it considers the
> >   function to be a leaf function;
> 
> There's a reasonable chance that the out-of-line LL/SC atomics could confuse
> GCC into thinking callers are leaf functions. That's the only inline asm that
> I'm aware of with BL instructions (how calls are made on arm64).
>
> > - whether hand-coded non-leaf assembly functions can accidentally omit
> >   the frame pointer prologue setup;
> 
> Most of our assembly doesn't setup stackframes, and some of these are non-leaf,
> e.g. __cpu_suspend_enter.
> 
> Also, I suspect our entry assembly may violate/confuse assumptions here. I've
> been working to move more of that to C, but that isn't yet complete.

My experience with arm64 is very limited, but it sounds like it has some
of the same issues as x86.  In which case we may need to port objtool to
arm64.

> > - whether GCC can generally be relied upon to get arm64 frame pointers
> >   right, in both normal operation and edge cases.
> > 
> > The commit log should also describe whether the unwinder itself can be
> > considered reliable for all edge cases:
> > 
> > - detection and reporting of preemption and page faults;
> > 
> > - detection and recovery from function graph tracing;
> > 
> > - detection and reporting of other unexpected conditions,
> >   including when the unwinder doesn't reach the end of the stack.
> 
> We may also have NMIs (with SDEI).

NMIs shouldn't be an issue because livepatch only unwinds blocked tasks.

-- 
Josh
