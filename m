Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuMg1gXgcnzTmVbOJl/i9CfoWJdYHa0Nexsi+0iQ2vqyhyJ5LTDgF6I+dgM5VqILDSP0LYh
ARC-Seal: i=1; a=rsa-sha256; t=1520296010; cv=none;
        d=google.com; s=arc-20160816;
        b=IEUWSjCQgOP/ZZP7xk2qHxiImd5AQymm803c7cEYasWRHM8O57DFVs2g5NQkhZC+S6
         +V8kPV4q60lwzI46n3NiMSIQSLMCgwcciyt3ni2xdT9ttJA9iRBmtIfKmOVTh54mb5Rj
         cc5wmLQXpoop+7t21VMhdDt06dsbUE4HbzxjJu3o34gdk7JbmyoKTaWAnKVhMREx+cJn
         0/YiGHJBGHVSIGYq6JEAjB4p6KuTtbHGMhKPWF/nf5wmIJ+caZJsgLTdE6Ltk08bk+nC
         CEMzRA9pjUXWB3iSLik5qdz7XxLIr4SyOZhv92RYl3c/Ny6uEJPDB7N1Pe+pusORjRLF
         VnXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=DFQokVOoASB6/suVkhTq8r2ZrRph+1QQQs2yZDhN2k0=;
        b=JsQkAihpcOxtEN4zFqgzebC8+87zC4GwTqBjTxHK3AYwbuFr/HFLYpfZStvmKXB7Sv
         dXbohjtDmdiBQg8GsDWgFaEXev0OkoQmuu/lOH5cmZF0Ne6x5TtG93VC+ddcpzsjxsWv
         8mgEnAmqxD7DHIAa/iTFKmREFPG6GS64UdHTY8c2jW1blJKei4JC5e1rO6rbimwvmleE
         5+xDym8QmyY8l86k1/w9/H0ZF17Yp4h/QNnuS465UACv0sS96s6ochJC8/v5jjgTS/zx
         PldoLGwTG4K+iPzU+Dg3UqJYxtT3ARzYn3gtP01v9+LXiyyZ7AByxlNtlsjF7QBXta31
         HCYA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=dYzhe7H8;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=dYzhe7H8;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 55/65] kaiser: asm/tlbflush.h handle noPGE at lower level
Date: Mon,  5 Mar 2018 19:25:28 -0500
Message-Id: <20180306002538.1761-56-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145910232158790?=
X-GMAIL-MSGID: =?utf-8?q?1594145910232158790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

I found asm/tlbflush.h too twisty, and think it safer not to avoid
__native_flush_tlb_global_irq_disabled() in the kaiser_enabled case,
but instead let it handle kaiser_enabled along with cr3: it can just
use __native_flush_tlb() for that, no harm in re-disabling preemption.

(This is not the same change as Kirill and Dave have suggested for
upstream, flipping PGE in cr4: that's neat, but needs a cpu_has_pge
check; cr3 is enough for kaiser, and thought to be cheaper than cr4.)

Also delete the X86_FEATURE_INVPCID invpcid_flush_all_nonglobals()
preference from __native_flush_tlb(): unlike the invpcid_flush_all()
preference in __native_flush_tlb_global(), it's not seen in upstream
4.14, and was recently reported to be surprisingly slow.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 0651b3ad99dd59269e2ec883338ab8fba617e203)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tlbflush.h | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b376095a1fd9..6fdc8c399601 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -151,14 +151,6 @@ static inline void kaiser_flush_tlb_on_return_to_user(void)
 
 static inline void __native_flush_tlb(void)
 {
-	if (this_cpu_has(X86_FEATURE_INVPCID)) {
-		/*
-		 * Note, this works with CR4.PCIDE=0 or 1.
-		 */
-		invpcid_flush_all_nonglobals();
-		return;
-	}
-
 	/*
 	 * If current->mm == NULL then we borrow a mm which may change during a
 	 * task switch and therefore we must not be preempted while we write CR3
@@ -182,11 +174,8 @@ static inline void __native_flush_tlb_global_irq_disabled(void)
 		/* restore PGE as it was before */
 		native_write_cr4(cr4);
 	} else {
-		/*
-		 * x86_64 microcode update comes this way when CR4.PGE is not
-		 * enabled, and it's safer for all callers to allow this case.
-		 */
-		native_write_cr3(native_read_cr3());
+		/* do it with cr3, letting kaiser flush user PCID */
+		__native_flush_tlb();
 	}
 }
 
@@ -194,12 +183,6 @@ static inline void __native_flush_tlb_global(void)
 {
 	unsigned long flags;
 
-	if (kaiser_enabled) {
-		/* Globals are not used at all */
-		__native_flush_tlb();
-		return;
-	}
-
 	if (this_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
 		 * Using INVPCID is considerably faster than a pair of writes
@@ -255,11 +238,7 @@ static inline void __native_flush_tlb_single(unsigned long addr)
 
 static inline void __flush_tlb_all(void)
 {
-	if (cpu_has_pge)
-		__flush_tlb_global();
-	else
-		__flush_tlb();
-
+	__flush_tlb_global();
 	/*
 	 * Note: if we somehow had PCID but not PGE, then this wouldn't work --
 	 * we'd end up flushing kernel translations for the current ASID but
-- 
2.16.2
