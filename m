Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtDIxar8Jp7deidNPGAQYfKE7ds5aSqfSi+tI+a1l/STnKUOPuiIP+4PttOeKwiLUyp3c3R
ARC-Seal: i=1; a=rsa-sha256; t=1520295972; cv=none;
        d=google.com; s=arc-20160816;
        b=ch47PBGLfBDbWjwvhEhbI1xhdWrpXrlT2z+sqn4gGmocxroDRrdkA/J4jHdExa/g4R
         jdCK7DW6N4FFPmxcXNoIXIBEs2ugx03I7jxnT9SiqZmcCt8Jnnff3bzHHZdBVbrKqmPR
         ak0Uc80eiHNO84KEVhLlllWJoGak1CwP3IZgGXgCjfG97v8XryA2fSX/udkhRcdSWWux
         JVMX6nboB9kbyItjwTm/w0VA+CJRsG/nP+08o2hwO66e7W4qSLaktToFj9VOtydoTk1m
         7wHdPLfzwWux8K3lIU6BDtGDPQFWfhvrLqI3nfOAzIyqQqnhS/lrni92+BUzqPUk8BOo
         1oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=otHhPS2Xtqdl+OJrvNJSD0ms96hggNmFVdjQtPvXJzU=;
        b=jxF1yC+Bgt03IqCzwLJJ1Qri91VlOO0cy/LjaioT4mo2dYhzq3LYWspmZdx7XhxWjE
         sJd4wzTjQglGMsJW8iejTLG4VcKTG0dVm+W5pfOZ8DoEDvJdYKEogaKE/3F8W8yInycD
         ort6MKqOVHKaToxwuTsyQ3OMKiqJvAdcZA4AW1D83XsvOf3LlgsEbt9ubjO1gmN84E+4
         JXr3EORXZY84KlBOgkNpkseeBRIm/hPZo0VNJEjaDiJf55VGXTs+MghLvuBTu+oClesR
         LL7q+GIDQpQn+mW9IPIBsPXZ9pVBBwsrQ5YinDBtZl5R6shVX7JOwC5EeM+CsRuV8Ms8
         N2Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KW5JbozY;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=KW5JbozY;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 14/65] x86/mm: Remove flush_tlb() and flush_tlb_current_task()
Date: Mon,  5 Mar 2018 19:24:47 -0500
Message-Id: <20180306002538.1761-15-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145870011409611?=
X-GMAIL-MSGID: =?utf-8?q?1594145870011409611?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit 29961b59a51f8c6838a26a45e871a7ed6771809b upstream.

I was trying to figure out what how flush_tlb_current_task() would
possibly work correctly if current->mm != current->active_mm, but I
realized I could spare myself the effort: it has no callers except
the unused flush_tlb() macro.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/e52d64c11690f85e9f1d69d7b48cc2269cd2e94b.1492844372.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 227d6f0e79f809e448d3157fbfd00eb54dcbb54e)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h |  9 ---------
 arch/x86/mm/tlb.c               | 17 -----------------
 2 files changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 433eeaafe498..d9ee4674c235 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -197,7 +197,6 @@ static inline void __flush_tlb_one(unsigned long addr)
 /*
  * TLB flushing:
  *
- *  - flush_tlb() flushes the current mm struct TLBs
  *  - flush_tlb_all() flushes all processes TLBs
  *  - flush_tlb_mm(mm) flushes the specified mm context TLB's
  *  - flush_tlb_page(vma, vmaddr) flushes one page
@@ -229,11 +228,6 @@ static inline void flush_tlb_all(void)
 	__flush_tlb_all();
 }
 
-static inline void flush_tlb(void)
-{
-	__flush_tlb_up();
-}
-
 static inline void local_flush_tlb(void)
 {
 	__flush_tlb_up();
@@ -295,14 +289,11 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
 
 extern void flush_tlb_all(void);
-extern void flush_tlb_current_task(void);
 extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned long vmflag);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
-#define flush_tlb()	flush_tlb_current_task()
-
 void native_flush_tlb_others(const struct cpumask *cpumask,
 				struct mm_struct *mm,
 				unsigned long start, unsigned long end);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 4ce6569ad963..262abde154eb 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -265,23 +265,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
 	smp_call_function_many(cpumask, flush_tlb_func, &info, 1);
 }
 
-void flush_tlb_current_task(void)
-{
-	struct mm_struct *mm = current->mm;
-
-	preempt_disable();
-
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-
-	/* This is an implicit full barrier that synchronizes with switch_mm. */
-	local_flush_tlb();
-
-	trace_tlb_flush(TLB_LOCAL_SHOOTDOWN, TLB_FLUSH_ALL);
-	if (cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), mm, 0UL, TLB_FLUSH_ALL);
-	preempt_enable();
-}
-
 /*
  * See Documentation/x86/tlb.txt for details.  We choose 33
  * because it is large enough to cover the vast majority (at
-- 
2.16.2
