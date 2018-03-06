Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELvv/TWQXjRBIq5ve793zNoW4oDN6sYkJW+p26JRTneC9dNtqM44QSPwBbXoppLGXZ8UCV6W
ARC-Seal: i=1; a=rsa-sha256; t=1520295975; cv=none;
        d=google.com; s=arc-20160816;
        b=NXcE8cSlvnYOv1y/HXoYGkRQWbZNxd0Ev8jhl83WXyK3uiO1HyVyIliJAf6xwuCaPP
         m+ihGpVo5T9Cx/XViGzIYQqFOT3nSfsZ6W7DhKf9NDE8Q9jvhY0gRrID6ZI2QScc/dZ7
         utjNGl370mgnW/kQiCIBidWK3wugY/j/FDDZlj5v057xtBZXoFu3d88xINcmiHrdQYqB
         HUypqmBnbnRH2jg5xPwylxmSe1XuN/8h03Rrm3HTs6p3dfeSyrJLxTgs+sYDFRsngeFk
         s8hBkNvJFuELtYg2RgkV/rfDYEtLf7CDroZ0IStPA9BWFnrXCzTSG2iQEkNzwogqQjog
         y0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=sCNMOQUDZr8V+yMvHHAHJYfQsXYhl0J+/XMnAI26+6Q=;
        b=FogUIWkC4TZHkfQf0wUjcuVuAXz+JQJMpOTxszso18ErU3kEIR9u7qyb8dEaVOoKXQ
         CMgG+cxWCLzSLKJZFIma12CJS3X+3vRdH+9b0pLWcBgSDlaFNybqsgvuDGrqFda3J+4H
         clbrWCt8dojBefHKOVT16ILK/u56mKYpbD6WYZN+6YjIg8f7zIdmkW0klTM9ATj9H+jM
         PpkDGMHif9foR5RNqLV5Mmz/tEPQSsgcRoMApjFThRCI+WN37Oa+bSm9iaDzIndH+Uvd
         mjkA0VcDMtNAp9J4m8A3Ck91TeNI3/O8nAJ3JvU9mczdRFjgp2lQJLsZrE8hqAKid93M
         P8MA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uF2hyP+h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=uF2hyP+h;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 16/65] x86/mm: Reimplement flush_tlb_page() using flush_tlb_mm_range()
Date: Mon,  5 Mar 2018 19:24:49 -0500
Message-Id: <20180306002538.1761-17-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145873175529221?=
X-GMAIL-MSGID: =?utf-8?q?1594145873175529221?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Lutomirski <luto@kernel.org>

commit ca6c99c0794875c6d1db6e22f246699691ab7e6b upstream.

flush_tlb_page() was very similar to flush_tlb_mm_range() except that
it had a couple of issues:

 - It was missing an smp_mb() in the case where
   current->active_mm != mm.  (This is a longstanding bug reported by Nadav Amit)

 - It was missing tracepoints and vm counter updates.

The only reason that I can see for keeping it at as a separate
function is that it could avoid a few branches that
flush_tlb_mm_range() needs to decide to flush just one page.  This
hardly seems worthwhile.  If we decide we want to get rid of those
branches again, a better way would be to introduce an
__flush_tlb_mm_range() helper and make both flush_tlb_page() and
flush_tlb_mm_range() use it.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bpetkov@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/3cc3847cf888d8907577569b8bac3f01992ef8f9.1495492063.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3efba6062a410a2a65fc9d6f53dca63db2602e65)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h |  6 +++++-
 arch/x86/mm/tlb.c               | 27 ---------------------------
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index d9ee4674c235..f23ee750bb68 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -289,11 +289,15 @@ static inline void flush_tlb_kernel_range(unsigned long start,
 		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)
 
 extern void flush_tlb_all(void);
-extern void flush_tlb_page(struct vm_area_struct *, unsigned long);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned long vmflag);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
+static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
+{
+	flush_tlb_mm_range(vma->vm_mm, a, a + PAGE_SIZE, VM_NONE);
+}
+
 void native_flush_tlb_others(const struct cpumask *cpumask,
 				struct mm_struct *mm,
 				unsigned long start, unsigned long end);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 95d5b4fff799..77fdf801efde 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -332,33 +332,6 @@ out:
 	preempt_enable();
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long start)
-{
-	struct mm_struct *mm = vma->vm_mm;
-
-	preempt_disable();
-
-	if (current->active_mm == mm) {
-		if (current->mm) {
-			/*
-			 * Implicit full barrier (INVLPG) that synchronizes
-			 * with switch_mm.
-			 */
-			__flush_tlb_one(start);
-		} else {
-			leave_mm(smp_processor_id());
-
-			/* Synchronize with switch_mm. */
-			smp_mb();
-		}
-	}
-
-	if (cpumask_any_but(mm_cpumask(mm), smp_processor_id()) < nr_cpu_ids)
-		flush_tlb_others(mm_cpumask(mm), mm, start, 0UL);
-
-	preempt_enable();
-}
-
 static void do_flush_tlb_all(void *info)
 {
 	count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
-- 
2.16.2
