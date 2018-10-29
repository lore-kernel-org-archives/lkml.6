Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1313C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21D220827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21D220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeJ2SQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:16:08 -0400
Received: from foss.arm.com ([217.140.101.70]:37228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbeJ2SQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:16:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 828CA341;
        Mon, 29 Oct 2018 02:28:18 -0700 (PDT)
Received: from salmiak (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA4623F557;
        Mon, 29 Oct 2018 02:28:15 -0700 (PDT)
Date:   Mon, 29 Oct 2018 09:28:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
Message-ID: <20181029092812.j7q5gfwxc3qq4vye@salmiak>
References: <20181026142008.D922868C94@newverein.lst.de>
 <20181026142157.B8FAA68C97@newverein.lst.de>
 <20181026153704.7g34j3gtlklepyvb@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026153704.7g34j3gtlklepyvb@treble>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

I also have a few concerns here, as it is not clear to me precisely what is
required from arch code. Is there any documentation I should look at?

On Fri, Oct 26, 2018 at 10:37:04AM -0500, Josh Poimboeuf wrote:
> On Fri, Oct 26, 2018 at 04:21:57PM +0200, Torsten Duwe wrote:
> > Enhance the stack unwinder so that it reports whether it had to stop
> > normally or due to an error condition; unwind_frame() will report
> > continue/error/normal ending and walk_stackframe() will pass that
> > info. __save_stack_trace() is used to check the validity of a stack;
> > save_stack_trace_tsk_reliable() can now trivially be implemented.
> > Modify arch/arm64/kernel/time.c as the only external caller so far
> > to recognise the new semantics.

There are a number of error conditions not currently handled by the unwinder
(mostly in the face of stack corruption), for which there have been prior
discussions on list.

Do we care about those cases, or do we consider things best-effort in the face
of stack corruption?

> > I had to introduce a marker symbol kthread_return_to_user to tell
> > the normal origin of a kernel thread.
> > 
> > Signed-off-by: Torsten Duwe <duwe@suse.de>
> 
> I haven't looked at the code, but the commit log doesn't inspire much
> confidence.  It's missing everything I previously asked for in the
> powerpc version.
> 
> There's zero mention of objtool.  What analysis was done to indicate
> that we can rely on frame pointers?
> 
> Such a frame pointer analysis should be included in the commit log.  It
> should describe *at least* the following:
> 
> - whether inline asm statements with call/branch instructions will
>   confuse GCC into skipping the frame pointer setup if it considers the
>   function to be a leaf function;

There's a reasonable chance that the out-of-line LL/SC atomics could confuse
GCC into thinking callers are leaf functions. That's the only inline asm that
I'm aware of with BL instructions (how calls are made on arm64).

> - whether hand-coded non-leaf assembly functions can accidentally omit
>   the frame pointer prologue setup;

Most of our assembly doesn't setup stackframes, and some of these are non-leaf,
e.g. __cpu_suspend_enter.

Also, I suspect our entry assembly may violate/confuse assumptions here. I've
been working to move more of that to C, but that isn't yet complete.

> - whether GCC can generally be relied upon to get arm64 frame pointers
>   right, in both normal operation and edge cases.
> 
> The commit log should also describe whether the unwinder itself can be
> considered reliable for all edge cases:
> 
> - detection and reporting of preemption and page faults;
> 
> - detection and recovery from function graph tracing;
> 
> - detection and reporting of other unexpected conditions,
>   including when the unwinder doesn't reach the end of the stack.

We may also have NMIs (with SDEI).

Thanks,
Mark.
