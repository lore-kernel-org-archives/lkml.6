Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELsVYkWAXWaA92VjwCBSiF7p+9FRO3jF08weAgWRKLx/n8qg1V4J80SDGcgwcMRBls3ddsLm
ARC-Seal: i=1; a=rsa-sha256; t=1520296001; cv=none;
        d=google.com; s=arc-20160816;
        b=fbW+h3/nXAalbQ9LCWFU9+hdEKxFv2hPVikzQAnxWVZdRBJagrCnmkTCRyt6nXkR6E
         0BQ3ArOKhLlCe6aQMtbLQD0c3a5zm7/L3oHmE7TIGWhnhwuI39Cs2o9pO8HmRsoZAN1R
         jRwOyJA0nQIcbYEj0paFjsWYJ0kCjmohF/izlOWfYeq5F6h+89g5jsEHiYi66YjH2xhd
         IW/9cXvPDIj/f0vkuT3c10/oiHIptqQVl5DAtCct+Pb9cBgk+M3PhTjnGa5pDt2+6kpN
         QO2QGU+RglIhPqbGpKl3w2HZAqCF8y5dYVxUWDsSqMgPe7n9lVr3QW40R3pgUE0BLuGS
         V81A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=wXLTMKWi8TLRfsX0c0LMB93k8rT9pEe7faOUktaxoBk=;
        b=uGz3zKg+H2h6Vc44Xf+elORa1tpMhIzRFJ9kYIlwS2PvhNyJX28HZK913vjOj8yAhD
         3EFCecCoa13sDekaIagetBy4e5h7PGZ3MTr2R9yB3VvjK9wlF1Y9YQcQyBRYogfmYaBo
         +BNQSAL0baXgk+dRQ7+8LGF+W4y1BDmpgx+gGkVpprntyS2jkjaRzc7E5DzcEd0jmsbO
         IVo1lftuOP1QNlYCYzROgdutg7MaWom12yv7i/DmPr3Tcz6OsDEcrqQaLonia1YMmWx2
         H+fBv4rbk2loTem+DjAgefG0KwFMjn97qLoqP+cWdp++Ww6s7FekAhLwqKy+ueqo6So1
         6/zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JgvwmDWJ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=JgvwmDWJ;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 44/65] kaiser: PCID 0 for kernel and 128 for user
Date: Mon,  5 Mar 2018 19:25:17 -0500
Message-Id: <20180306002538.1761-45-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=953
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145900041900563?=
X-GMAIL-MSGID: =?utf-8?q?1594145900041900563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Why was 4 chosen for kernel PCID and 6 for user PCID?
No good reason in a backport where PCIDs are only used for Kaiser.

If we continue with those, then we shall need to add Andy Lutomirski's
4.13 commit 6c690ee1039b ("x86/mm: Split read_cr3() into read_cr3_pa()
and __read_cr3()"), which deals with the problem of read_cr3() callers
finding stray bits in the cr3 that they expected to be page-aligned;
and for hibernation, his 4.14 commit f34902c5c6c0 ("x86/hibernate/64:
Mask off CR3's PCID bits in the saved CR3").

But if 0 is used for kernel PCID, then there's no need to add in those
commits - whenever the kernel looks, it sees 0 in the lower bits; and
0 for kernel seems an obvious choice.

And I naughtily propose 128 for user PCID.  Because there's a place
in _SWITCH_TO_USER_CR3 where it takes note of the need for TLB FLUSH,
but needs to reset that to NOFLUSH for the next occasion.  Currently
it does so with a "movb $(0x80)" into the high byte of the per-cpu
quadword, but that will cause a machine without PCID support to crash.
Now, if %al just happened to have 0x80 in it at that point, on a
machine with PCID support, but 0 on a machine without PCID support...

(That will go badly wrong once the pgd can be at a physical address
above 2^56, but even with 5-level paging, physical goes up to 2^52.)

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 3b4ce0e1a17228eec71815d7997e49e403ebf2a7)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/kaiser.h        | 19 ++++++++++++-------
 arch/x86/include/asm/pgtable_types.h |  7 ++++---
 arch/x86/mm/tlb.c                    |  3 +++
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 009bca514c20..110a73e0572d 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -29,14 +29,19 @@ orq  X86_CR3_PCID_KERN_VAR, \reg
 movq \reg, %cr3
 .endm
 
-.macro _SWITCH_TO_USER_CR3 reg
+.macro _SWITCH_TO_USER_CR3 reg regb
+/*
+ * regb must be the low byte portion of reg: because we have arranged
+ * for the low byte of the user PCID to serve as the high byte of NOFLUSH
+ * (0x80 for each when PCID is enabled, or 0x00 when PCID and NOFLUSH are
+ * not enabled): so that the one register can update both memory and cr3.
+ */
 movq %cr3, \reg
 andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
 orq  PER_CPU_VAR(X86_CR3_PCID_USER_VAR), \reg
 js   9f
-// FLUSH this time, reset to NOFLUSH for next time
-// But if nopcid?  Consider using 0x80 for user pcid?
-movb $(0x80), PER_CPU_VAR(X86_CR3_PCID_USER_VAR+7)
+/* FLUSH this time, reset to NOFLUSH for next time (if PCID enabled) */
+movb \regb, PER_CPU_VAR(X86_CR3_PCID_USER_VAR+7)
 9:
 movq \reg, %cr3
 .endm
@@ -49,7 +54,7 @@ popq %rax
 
 .macro SWITCH_USER_CR3
 pushq %rax
-_SWITCH_TO_USER_CR3 %rax
+_SWITCH_TO_USER_CR3 %rax %al
 popq %rax
 .endm
 
@@ -61,7 +66,7 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 
 .macro SWITCH_USER_CR3_NO_STACK
 movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)
-_SWITCH_TO_USER_CR3 %rax
+_SWITCH_TO_USER_CR3 %rax %al
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 .endm
 
@@ -69,7 +74,7 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 
 .macro SWITCH_KERNEL_CR3 reg
 .endm
-.macro SWITCH_USER_CR3 reg
+.macro SWITCH_USER_CR3 reg regb
 .endm
 .macro SWITCH_USER_CR3_NO_STACK
 .endm
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index b3c77e6529c2..93554f37df99 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -111,16 +111,17 @@
 
 /* Mask for all the PCID-related bits in CR3: */
 #define X86_CR3_PCID_MASK       (X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_MASK)
+#define X86_CR3_PCID_ASID_KERN  (_AC(0x0,UL))
+
 #if defined(CONFIG_KAISER) && defined(CONFIG_X86_64)
-#define X86_CR3_PCID_ASID_KERN  (_AC(0x4,UL))
-#define X86_CR3_PCID_ASID_USER  (_AC(0x6,UL))
+/* Let X86_CR3_PCID_ASID_USER be usable for the X86_CR3_PCID_NOFLUSH bit */
+#define X86_CR3_PCID_ASID_USER	(_AC(0x80,UL))
 
 #define X86_CR3_PCID_KERN_FLUSH		(X86_CR3_PCID_ASID_KERN)
 #define X86_CR3_PCID_USER_FLUSH		(X86_CR3_PCID_ASID_USER)
 #define X86_CR3_PCID_KERN_NOFLUSH	(X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_KERN)
 #define X86_CR3_PCID_USER_NOFLUSH	(X86_CR3_PCID_NOFLUSH | X86_CR3_PCID_ASID_USER)
 #else
-#define X86_CR3_PCID_ASID_KERN  (_AC(0x0,UL))
 #define X86_CR3_PCID_ASID_USER  (_AC(0x0,UL))
 /*
  * PCIDs are unsupported on 32-bit and none of these bits can be
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 9c9657f139cd..749e2134bd7a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -50,6 +50,9 @@ static void load_new_mm_cr3(pgd_t *pgdir)
 		 * invpcid_flush_single_context(X86_CR3_PCID_ASID_USER) could
 		 * do it here, but can only be used if X86_FEATURE_INVPCID is
 		 * available - and many machines support pcid without invpcid.
+		 *
+		 * The line below is a no-op: X86_CR3_PCID_KERN_FLUSH is now 0;
+		 * but keep that line in there in case something changes.
 		 */
 		new_mm_cr3 |= X86_CR3_PCID_KERN_FLUSH;
 		kaiser_flush_tlb_on_return_to_user();
-- 
2.16.2
