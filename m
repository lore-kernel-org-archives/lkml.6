Return-Path: <tim.c.chen@linux.intel.com>
X-Google-Smtp-Source: AH8x2277qb/gZTe7gXW7W2xYLs8BF+GTlyrmia7gLmSwKtzliFwHRVTq4fqq2WRDvLC/Kn+gFHSe
ARC-Seal: i=1; a=rsa-sha256; t=1517859308; cv=none;
        d=google.com; s=arc-20160816;
        b=Yb8GAQLRgA+r0qR3Oez8gxTBJoggeXAsb7fd7nR9aOOr/vrRHIYVzBq/plZi1TEZbs
         zhW+x5dYCcVG8pP7u9+HQeJR3SQBB+JawPqtpJO0m6qAjPAM0ea5BbsoDRmmRcQl1X7v
         dyrjXSb44aq2QDRru39oF82i2BeM+RDfN505KsD3Sldb0TV/Y1Q9jNR9l9v/zlxXoSAm
         caVG/2KmBRerbvFu8s902OSAVwlhsRkl7SP92qOlQHrNF/EibpEHJKkecRlUEOu9AVr8
         ffxtk6zJ0aOpWNN/OcXKhCxYjJkKS5VP//RkHZWGYDizOatdQxcMXV9VZarN1eGloK25
         Wvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :arc-authentication-results;
        bh=9ZPTtGUhV2nSF+c5XTKcaHKwRinNga1tmJrDF2ibV+I=;
        b=lAKfLQpathBSkqQbv5oxYQ3ny3C6IkALfWFO4rLuWVMRhOOF6xbSYZQspX92jWZOgX
         06nb2uDBS5nlUs09zUPknCkkDEW4+le+ZBgTCf+ymPHEOfCBq6eRDsAfGVCvAR9sJYBB
         if/V21TWZ0Vr5RN5322KjesTQZP8XGoDJuYzCbMhczNAvNUnfKjm7/EPFPSO0meztqH3
         yLDzJgPAM2Lwo58NRCBT1teGVkJ1HGJ5XATz6jv30i9kh73tGriEkkeWUeCv4TwFA6co
         qsX/S4KAx4SQea+AR1qtbjLbSLA+EXQXifVDhUUDMQ6jJPzeBe/HxEm80Az/CHNVJgUt
         jTWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tim.c.chen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tim.c.chen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tim.c.chen@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=tim.c.chen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="25018920"
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
To: David Woodhouse <dwmw2@infradead.org>, mingo@kernel.org, hpa@zytor.com,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, luto@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-mm <linux-mm@kvack.org>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
 <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
 <1517840309.31953.153.camel@infradead.org>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <a38f70bc-13a0-506a-2b8b-18877e6e6796@linux.intel.com>
Date: Mon, 5 Feb 2018 11:35:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <1517840309.31953.153.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590966106432961445?=
X-GMAIL-MSGID: =?utf-8?q?1591590842129770583?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/05/2018 06:18 AM, David Woodhouse wrote:
> On Tue, 2018-01-30 at 14:39 -0800, tip-bot for Tim Chen wrote:
>> Thanks to the reviewers and Andy Lutomirski for the suggestion of
>> using ctx_id which got rid of the problem of mm pointer recycling.
> 
> That one doesn't backport well to 4.9. Suggestions welcome.
> 

Will something like the following work for 4.9 using active_mm?
This patch is not really tested, but just
want to put it out here to see if this is a reasonable backport.

Tim

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a7655f6..4994db2 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -9,6 +9,7 @@
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
+#include <asm/nospec-branch.h>
 #include <asm/cache.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
@@ -75,6 +76,9 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 			struct task_struct *tsk)
 {
 	unsigned cpu = smp_processor_id();
+#ifdef CONFIG_SMP
+	struct mm_struct *active_mm = this_cpu_read(cpu_tlbstate.active_mm);
+#endif
 
 	if (likely(prev != next)) {
 		if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -91,6 +95,28 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 				set_pgd(pgd, init_mm.pgd[stack_pgd_index]);
 		}
 
+		/*
+		 * Avoid user/user BTB poisoning by flushing the branch
+		 * predictor when switching between processes. This stops
+		 * one process from doing Spectre-v2 attacks on another.
+		 *
+		 * As an optimization, flush indirect branches only when
+		 * switching into processes that disable dumping. This
+		 * protects high value processes like gpg, without having
+		 * too high performance overhead. IBPB is *expensive*!
+		 *
+		 * This will not flush branches when switching into kernel
+		 * threads. It will also not flush if we switch to idle
+		 * thread and back to the same process. It will flush if we
+		 * switch to a different non-dumpable process.
+		 */
+		if (tsk && tsk->mm &&
+#ifdef CONFIG_SMP
+		    next != active_mm &&
+#endif
+		    get_dumpable(tsk->mm) != SUID_DUMP_USER)
+			indirect_branch_prediction_barrier();
+
 #ifdef CONFIG_SMP
 		this_cpu_write(cpu_tlbstate.state, TLBSTATE_OK);
 		this_cpu_write(cpu_tlbstate.active_mm, next);
