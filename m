Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885D7C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471FC20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uEVjU6VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfBYIdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:33:20 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56754 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfBYIdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3veoblq21kpLpD4raey4v7/7e6+gqC+QPwr38zFfHFY=; b=uEVjU6VJ/MyLlnp5KkJuVP8jc
        q8hypTi1UOxinbqpl7ec0eq4jMW47oVRv73meuTzjLMty7sYCFdzsv2LY/VjDlrYODSX6R1icPVYF
        mrgFpCJrv9iyNarXOWomEbY3OmObFq4Wb5oA3lf5fTp9x2YW1vNeLEUhniHtn/WeFDCnu/OKdb5ky
        BkWcOqyodgVwNk4nvN+Kjx5QQ9KRkKON12n9tehIU+XyyzxnT0sIDlpcBKwqw7f+43hLDQa6/7kxd
        FlWKHEJyATz2SItkvLRrE+NZhkrobmp4GCUuxuAPlf3FAXNzFWMzG6N/72LV3PCVc7ujpnkPbL6jp
        lpRkeMBeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gyBhI-0004dE-4P; Mon, 25 Feb 2019 08:33:12 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E80D2026BE60; Mon, 25 Feb 2019 09:33:09 +0100 (CET)
Date:   Mon, 25 Feb 2019 09:33:09 +0100
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
Message-ID: <20190225083309.GI32477@hirez.programming.kicks-ass.net>
References: <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home>
 <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org>
 <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org>
 <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
 <20190225001757.519f40cd088c05fdd00a9397@kernel.org>
 <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjBD+MQfWP2Q4Zp8FP4HR4MdPACw1=iMbDZANdiBwXDAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2019 at 09:26:45AM -0800, Linus Torvalds wrote:
> PeterZ, do you remember the particular use case that triggered that
> commit 7c4788950ba5 ("x86/uaccess, sched/preempt: Verify access_ok()
> context")?

This one, if I'm not mistaken.

---

commit ae31fe51a3cceaa0cabdb3058f69669ecb47f12e
Author: Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue Nov 22 10:57:42 2016 +0100

    perf/x86: Restore TASK_SIZE check on frame pointer
    
    The following commit:
    
      75925e1ad7f5 ("perf/x86: Optimize stack walk user accesses")
    
    ... switched from copy_from_user_nmi() to __copy_from_user_nmi() with a manual
    access_ok() check.
    
    Unfortunately, copy_from_user_nmi() does an explicit check against TASK_SIZE,
    whereas the access_ok() uses whatever the current address limit of the task is.
    
    We are getting NMIs when __probe_kernel_read() has switched to KERNEL_DS, and
    then see vmalloc faults when we access what looks like pointers into vmalloc
    space:
    
      [] WARNING: CPU: 3 PID: 3685731 at arch/x86/mm/fault.c:435 vmalloc_fault+0x289/0x290
      [] CPU: 3 PID: 3685731 Comm: sh Tainted: G        W       4.6.0-5_fbk1_223_gdbf0f40 #1
      [] Call Trace:
      []  <NMI>  [<ffffffff814717d1>] dump_stack+0x4d/0x6c
      []  [<ffffffff81076e43>] __warn+0xd3/0xf0
      []  [<ffffffff81076f2d>] warn_slowpath_null+0x1d/0x20
      []  [<ffffffff8104a899>] vmalloc_fault+0x289/0x290
      []  [<ffffffff8104b5a0>] __do_page_fault+0x330/0x490
      []  [<ffffffff8104b70c>] do_page_fault+0xc/0x10
      []  [<ffffffff81794e82>] page_fault+0x22/0x30
      []  [<ffffffff81006280>] ? perf_callchain_user+0x100/0x2a0
      []  [<ffffffff8115124f>] get_perf_callchain+0x17f/0x190
      []  [<ffffffff811512c7>] perf_callchain+0x67/0x80
      []  [<ffffffff8114e750>] perf_prepare_sample+0x2a0/0x370
      []  [<ffffffff8114e840>] perf_event_output+0x20/0x60
      []  [<ffffffff8114aee7>] ? perf_event_update_userpage+0xc7/0x130
      []  [<ffffffff8114ea01>] __perf_event_overflow+0x181/0x1d0
      []  [<ffffffff8114f484>] perf_event_overflow+0x14/0x20
      []  [<ffffffff8100a6e3>] intel_pmu_handle_irq+0x1d3/0x490
      []  [<ffffffff8147daf7>] ? copy_user_enhanced_fast_string+0x7/0x10
      []  [<ffffffff81197191>] ? vunmap_page_range+0x1a1/0x2f0
      []  [<ffffffff811972f1>] ? unmap_kernel_range_noflush+0x11/0x20
      []  [<ffffffff814f2056>] ? ghes_copy_tofrom_phys+0x116/0x1f0
      []  [<ffffffff81040d1d>] ? x2apic_send_IPI_self+0x1d/0x20
      []  [<ffffffff8100411d>] perf_event_nmi_handler+0x2d/0x50
      []  [<ffffffff8101ea31>] nmi_handle+0x61/0x110
      []  [<ffffffff8101ef94>] default_do_nmi+0x44/0x110
      []  [<ffffffff8101f13b>] do_nmi+0xdb/0x150
      []  [<ffffffff81795187>] end_repeat_nmi+0x1a/0x1e
      []  [<ffffffff8147daf7>] ? copy_user_enhanced_fast_string+0x7/0x10
      []  [<ffffffff8147daf7>] ? copy_user_enhanced_fast_string+0x7/0x10
      []  [<ffffffff8147daf7>] ? copy_user_enhanced_fast_string+0x7/0x10
      []  <<EOE>>  <IRQ>  [<ffffffff8115d05e>] ? __probe_kernel_read+0x3e/0xa0
    
    Fix this by moving the valid_user_frame() check to before the uaccess
    that loads the return address and the pointer to the next frame.
    
    Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Vince Weaver <vincent.weaver@maine.edu>
    Cc: linux-kernel@vger.kernel.org
    Fixes: 75925e1ad7f5 ("perf/x86: Optimize stack walk user accesses")
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d31735f37ed7..9d4bf3ab049e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2352,7 +2352,7 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 		frame.next_frame     = 0;
 		frame.return_address = 0;
 
-		if (!access_ok(VERIFY_READ, fp, 8))
+		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
 
 		bytes = __copy_from_user_nmi(&frame.next_frame, fp, 4);
@@ -2362,9 +2362,6 @@ perf_callchain_user32(struct pt_regs *regs, struct perf_callchain_entry_ctx *ent
 		if (bytes != 0)
 			break;
 
-		if (!valid_user_frame(fp, sizeof(frame)))
-			break;
-
 		perf_callchain_store(entry, cs_base + frame.return_address);
 		fp = compat_ptr(ss_base + frame.next_frame);
 	}
@@ -2413,7 +2410,7 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		frame.next_frame	     = NULL;
 		frame.return_address = 0;
 
-		if (!access_ok(VERIFY_READ, fp, sizeof(*fp) * 2))
+		if (!valid_user_frame(fp, sizeof(frame)))
 			break;
 
 		bytes = __copy_from_user_nmi(&frame.next_frame, fp, sizeof(*fp));
@@ -2423,9 +2420,6 @@ perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs
 		if (bytes != 0)
 			break;
 
-		if (!valid_user_frame(fp, sizeof(frame)))
-			break;
-
 		perf_callchain_store(entry, frame.return_address);
 		fp = (void __user *)frame.next_frame;
 	}
