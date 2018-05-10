Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757391AbeEJNsr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:48:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757097AbeEJNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:48:46 -0400
Date: Thu, 10 May 2018 15:48:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180510134841.GE12217@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1805010925140.19413@macbook-air>
 <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air>
 <20180501220458.p3rgwzh3jcqt4jmm@treble>
 <20180502205009.codkvscnh4j4hm6b@treble>
 <alpine.DEB.2.21.1805041033230.6376@macbook-air>
 <20180504162557.iodmglq3duomz6c2@treble>
 <alpine.DEB.2.21.1805051134230.11518@macbook-air>
 <20180505182912.llj7jb3v7yd43t5h@treble>
 <20180506234935.yq6zxjetlpldpzz7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180506234935.yq6zxjetlpldpzz7@treble>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 06:49:35PM -0500, Josh Poimboeuf wrote:

> Deja vu.  Most of these are related to perf PEBS, similar to the
> following issue:
> 
>   b8000586c90b ("perf/x86/intel: Cure bogus unwind from PEBS entries")
> 
> This is basically the ORC version of that.  setup_pebs_sample_data() is
> assembling a franken-pt_regs which ORC isn't happy about.  RIP is
> inconsistent with some of the other registers (like RSP and RBP).
> 
> Peter, any ideas?

Urgh..

Something like so perhaps? It's a bit of a hack, but I couldn't quickly
think of something nicer.


diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707b2a96e516..86f0c15dcc2d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2997,6 +2997,9 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		}
 		if (x86_pmu.pebs_aliases)
 			x86_pmu.pebs_aliases(event);
+
+		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
+			event->attr.sample_type |= __PERF_SAMPLE_CALLCHAIN_EARLY;
 	}
 
 	if (needs_branch_stack(event)) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8a10a045b57b..2115ac8336b4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1183,17 +1183,21 @@ static void setup_pebs_sample_data(struct perf_event *event,
 		data->data_src.val = val;
 	}
 
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happend between the record and
+	 * PMI.
+	 */
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		data->callchain = perf_callchain(event, iregs);
+
 	/*
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
 
@@ -1212,15 +1216,8 @@ static void setup_pebs_sample_data(struct perf_event *event,
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
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b8e288a1f740..55b93cd0d48a 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -143,6 +143,8 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
 
 	PERF_SAMPLE_MAX = 1U << 20,		/* non-ABI */
+
+	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1UL << 63,
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67612ce359ad..27c9e0f99f30 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6380,7 +6380,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
 
-		data->callchain = perf_callchain(event, regs);
+		if (!(sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY))
+			data->callchain = perf_callchain(event, regs);
+
 		size += data->callchain->nr;
 
 		header->size += size * sizeof(u64);
