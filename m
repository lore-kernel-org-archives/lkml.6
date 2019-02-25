Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5528C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F9920663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rIZjaLBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfBYOwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:52:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60776 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfBYOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S+LIXnC8AJDaC+I7uH7DrqjN46AAjGo2UM8VAdAW8f4=; b=rIZjaLBg+FyWtf65ifG6Qc/qk
        vN6aUO4XaQilavyT3YhISQ/xzOlqXYoFC1ylTYJApEy7wF8RLj/Cty466F/BRtLlpfGT1rbsNPBmO
        /HPBiiWBhzjpdh3q19N3tbaedIreTOPy7jZFeosRKHljNDkl9dLUNCwbuOK8dgL+30safTc27PEJw
        JANhwBoblW/B0t/7rlMTYIYxo4vBkV/UP2YyKqKAi0GwhokrAX960db2BEDTMdzMyv1iO9Ku5NxyG
        nO9MvaR/WPCsbo5Y4deV32RJedXeWXS0f7YAWwCyIwrGjaEe/ahw87FaQyPe2WoON9zd5m6kNcwSv
        jTnE2nJhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyHcZ-0004ic-F9; Mon, 25 Feb 2019 14:52:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5F422020F094; Mon, 25 Feb 2019 15:52:40 +0100 (CET)
Date:   Mon, 25 Feb 2019 15:52:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190225145240.GB32534@hirez.programming.kicks-ass.net>
References: <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
 <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
 <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
 <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
 <20190225083309.GI32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225083309.GI32477@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 09:33:09AM +0100, Peter Zijlstra wrote:
> On Sun, Feb 24, 2019 at 09:26:45AM -0800, Linus Torvalds wrote:
> > PeterZ, do you remember the particular use case that triggered that
> > commit 7c4788950ba5 ("x86/uaccess, sched/preempt: Verify access_ok()
> > context")?
> 
> This one, if I'm not mistaken.
> 
> ---
> 
> commit ae31fe51a3cceaa0cabdb3058f69669ecb47f12e
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Tue Nov 22 10:57:42 2016 +0100
> 
>     perf/x86: Restore TASK_SIZE check on frame pointer
>     
>     The following commit:
>     
>       75925e1ad7f5 ("perf/x86: Optimize stack walk user accesses")
>     
>     ... switched from copy_from_user_nmi() to __copy_from_user_nmi() with a manual
>     access_ok() check.
>     
>     Unfortunately, copy_from_user_nmi() does an explicit check against TASK_SIZE,
>     whereas the access_ok() uses whatever the current address limit of the task is.
>     
>     We are getting NMIs when __probe_kernel_read() has switched to KERNEL_DS, and
>     then see vmalloc faults when we access what looks like pointers into vmalloc
>     space:

Also note that this was before we did:

commit 88b0193d9418c00340e45e0a913a0813bc6c8c96
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue May 9 18:00:04 2017 +0100

    perf/callchain: Force USER_DS when invoking perf_callchain_user()
    
    Perf can generate and record a user callchain in response to a synchronous
    request, such as a tracepoint firing. If this happens under set_fs(KERNEL_DS),
    then we can end up walking the user stack (and dereferencing/saving whatever we
    find there) without the protections usually afforded by checks such as
    access_ok.
    
    Rather than play whack-a-mole with each architecture's stack unwinding
    implementation, fix the root of the problem by ensuring that we force USER_DS
    when invoking perf_callchain_user from the perf core.
    
    Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Acked-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index c04917cad1bf..1b2be63c8528 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -229,12 +229,18 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		}
 
 		if (regs) {
+			mm_segment_t fs;
+
 			if (crosstask)
 				goto exit_put;
 
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+
+			fs = get_fs();
+			set_fs(USER_DS);
 			perf_callchain_user(&ctx, regs);
+			set_fs(fs);
 		}
 	}
 
