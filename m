Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD6FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108FF20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kmGup0ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108FF20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeGSWEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:04:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeGSWEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sOz92gF7dNoBX5WZPZGeDbOYpt12Sa53dEyw+gFHB5M=; b=kmGup0bak7zt5M8pW6bbToMdw
        92JOYt//b9zEp85fwt53Nu5HPBxUXBKII0D669xszNPlhY9tb7vX4vHoBkRI5wUBfY/OBYK6k1mj7
        RFmkVo6CtXhjJnzA7EoHoOV38JlK0pbCIYqyMLkfaLXaXbmr0i1TrmcGRSVbISoOfp3Z9tg5Ttef9
        nU1/dRBPKxL0Rhuw/J8PSN75kcrGv9AEx9DiochYJdnfneOOxf/F4bFnJea6kmjYTyMbh4Wre7m0H
        CWAVibzUHmvdNEIMUfHkNcAFmNm8ai4R9iSkHDTFEGqBI6ngJTKvzeAOH3udFmLF71k3cunrdxPM+
        a29H9kjJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fgGL6-0005up-05; Thu, 19 Jul 2018 21:19:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DC2320275F38; Thu, 19 Jul 2018 23:19:54 +0200 (CEST)
Date:   Thu, 19 Jul 2018 23:19:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)
Message-ID: <20180719211954.GZ2512@hirez.programming.kicks-ass.net>
References: <60466ab6-311b-ad8d-2f79-32702174cb95@lab.ntt.co.jp>
 <20180719153347.buoe6pavpqc75zbb@treble>
 <20180719174311.GK2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719174311.GK2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 07:43:11PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 19, 2018 at 10:33:47AM -0500, Josh Poimboeuf wrote:
> > On Thu, Jul 19, 2018 at 01:33:54PM +0900, Prashant Bhole wrote:
> > > Hi Peter, Josh,
> > > 
> > > Found following bug. This bug can not be seen with this fix:
> > > https://lkml.org/lkml/2018/5/10/280.
> > 
> > Peter, care to clean that up and submit it?
> 
> Ah, thanks for the prod. Yes I'll go clean that up.

Here goes; Ingo could you stuff in perf/urgent ?

---
Subject: perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 10 May 2018 15:48:41 +0200

Vince reported the perf_fuzzer giving various unwinder warnings and
Josh reported:

On Sun, May 06, 2018 at 06:49:35PM -0500, Josh Poimboeuf wrote:

> Deja vu.  Most of these are related to perf PEBS, similar to the
> following issue:
>
>   b8000586c90b ("perf/x86/intel: Cure bogus unwind from PEBS entries")
>
> This is basically the ORC version of that.  setup_pebs_sample_data() is
> assembling a franken-pt_regs which ORC isn't happy about.  RIP is
> inconsistent with some of the other registers (like RSP and RBP).

And where the previous unwinder only needed BP,SP ORC also requires
IP. But we cannot spoof IP because then the sample will get displaced,
entirely negating the point of PEBS.

So cure the whole thing differently by doing the unwind early; this
does however require a means to communicate we did the unwind early.
We (ab)use an unused sample_type bit for this, which we set on events
that fill out the data->callchain before the normal
perf_prepare_sample().

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Debugged-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Tested-by: Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c    |    3 +++
 arch/x86/events/intel/ds.c      |   25 +++++++++++--------------
 include/linux/perf_event.h      |    1 +
 include/uapi/linux/perf_event.h |    2 ++
 kernel/events/core.c            |    6 ++++--
 5 files changed, 21 insertions(+), 16 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,6 +2997,9 @@ static int intel_pmu_hw_config(struct pe
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 	}
 
 	if (needs_branch_stack(event)) {
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1186,16 +1186,20 @@ static void setup_pebs_sample_data(struc
 	}
 
 	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happend between the record and
+	 * PMI.
+	 */
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		data->callchain = perf_callchain(event, iregs);
+
+	/*
 	 * We use the interrupt regs as a base because the PEBS record does not
 	 * contain a full regs set, specifically it seems to lack segment
 	 * descriptors, which get used by things like user_mode().
 	 *
 	 * In the simple case fix up only the IP for PERF_SAMPLE_IP.
-	 *
-	 * We must however always use BP,SP from iregs for the unwinder to stay
-	 * sane; the record BP,SP can point into thin air when the record is
-	 * from a previous PMI context or an (I)RET happend between the record
-	 * and PMI.
 	 */
 	*regs = *iregs;
 
@@ -1214,15 +1218,8 @@ static void setup_pebs_sample_data(struc
 		regs->si = pebs->si;
 		regs->di = pebs->di;
 
-		/*
-		 * Per the above; only set BP,SP if we don't need callchains.
-		 *
-		 * XXX: does this make sense?
-		 */
-		if (!(sample_type & PERF_SAMPLE_CALLCHAIN)) {
-			regs->bp = pebs->bp;
-			regs->sp = pebs->sp;
-		}
+		regs->bp = pebs->bp;
+		regs->sp = pebs->sp;
 
 #ifndef CONFIG_X86_32
 		regs->r8 = pebs->r8;
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1130,6 +1130,7 @@ extern void perf_callchain_kernel(struct
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
+extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1UL << 63,
 };
 
 /*
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6343,7 +6343,7 @@ static u64 perf_virt_to_phys(u64 virt)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
-static struct perf_callchain_entry *
+struct perf_callchain_entry *
 perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
@@ -6382,7 +6382,9 @@ void perf_prepare_sample(struct perf_eve
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		data->callchain = perf_callchain(event, regs);
+		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+			data->callchain = perf_callchain(event, regs);
+
 		size += data->callchain->nr;
 
 		header->size += size * sizeof(u64);
