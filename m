Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELusXYWzJVIz3X79ustdwTrXzgjk8rdFdVU5p3Ck6d36/qC1j+tKQpMoo4Q1JhXtBGXsy8yP
ARC-Seal: i=1; a=rsa-sha256; t=1520296001; cv=none;
        d=google.com; s=arc-20160816;
        b=YrB6jCNBg4IPrBzqlg+I2wRJ4zM/wv89uEwutF3C1jJ14dU9M6nQJF+mntnsnLadaa
         ao4lSHEePV2R3K0dOW8vINQhlxyaIqndW+fv2EX1+XGp/P54DRLebUjA/ipkldZ+uoV2
         yEy8SDt0+Ps4+6IcV0syq6+e5i4HGSbJkiNrYWwm7hL55DREUqF5G6TqRznjJF8cRblT
         Pi/EvUHY8ESMdfrhtKXAus/yA+f7jL+tJogVE0YKjSfgoMtN1aky97BjZ/GRSwOj33XA
         As0KiQdnxsmJ5iHPdKae+S4Mno2xL2UrrWh/71SieqEjPnCSLlHOSAKfN2LY4ZjslFlz
         eKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=GP3aZBW+wYkXmT7tVXV41ikbR3d0vCHXr3BUaiw83a0=;
        b=f+f/9tS4tNuR6ZRjrwVRLBRQ5bili9uqq9wfRsKBh57yGiWzF9zdVRGxT4+p13uOBX
         UVOa1ojjq0hzKIqA9E2lN62cxe0wmFFbpYARcH8LOFbBhyOQ3vV7jEGSarra8zxZ90g8
         3pe84LGOLY/Kr3FW39ozqMXOfE7atXE8ZJYO30Fw0+y9YbhlLYvjJurV8dAcPa82x+CH
         In8DL0FJq7ur65Oj2muYexWYcjHBglgzpXBkDX2eYZETlOmZ8YXRzas2Bou6qumRS8y+
         PIDFITYOIriPPjumwyAkz1yDzHVjnnW7PSrnkab9ekdDrCYzWydklD5EfaAbohOMPwS4
         p25g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=myK8cFh/;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=myK8cFh/;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 45/65] kaiser: x86_cr3_pcid_noflush and x86_cr3_pcid_user
Date: Mon,  5 Mar 2018 19:25:18 -0500
Message-Id: <20180306002538.1761-46-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145900457240587?=
X-GMAIL-MSGID: =?utf-8?q?1594145900457240587?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Mostly this commit is just unshouting X86_CR3_PCID_KERN_VAR and
X86_CR3_PCID_USER_VAR: we usually name variables in lower-case.

But why does x86_cr3_pcid_noflush need to be __aligned(PAGE_SIZE)?
Ah, it's a leftover from when kaiser_add_user_map() once complained
about mapping the same page twice.  Make it __read_mostly instead.
(I'm a little uneasy about all the unrelated data which shares its
page getting user-mapped too, but that was so before, and not a big
deal: though we call it user-mapped, it's not mapped with _PAGE_USER.)

And there is a little change around the two calls to do_nmi().
Previously they set the NOFLUSH bit (if PCID supported) when
forcing to kernel context before do_nmi(); now they also have the
NOFLUSH bit set (if PCID supported) when restoring context after:
nothing done in do_nmi() should require a TLB to be flushed here.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 20268a10ffecd9fcc04880b21fc99a9192394599)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/kaiser.h | 11 +++++------
 arch/x86/kernel/entry_64.S    |  8 ++++----
 arch/x86/mm/kaiser.c          | 13 +++++++------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 110a73e0572d..48d8d70dd8c7 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -25,7 +25,7 @@
 .macro _SWITCH_TO_KERNEL_CR3 reg
 movq %cr3, \reg
 andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
-orq  X86_CR3_PCID_KERN_VAR, \reg
+orq  x86_cr3_pcid_noflush, \reg
 movq \reg, %cr3
 .endm
 
@@ -37,11 +37,10 @@ movq \reg, %cr3
  * not enabled): so that the one register can update both memory and cr3.
  */
 movq %cr3, \reg
-andq $(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), \reg
-orq  PER_CPU_VAR(X86_CR3_PCID_USER_VAR), \reg
+orq  PER_CPU_VAR(x86_cr3_pcid_user), \reg
 js   9f
 /* FLUSH this time, reset to NOFLUSH for next time (if PCID enabled) */
-movb \regb, PER_CPU_VAR(X86_CR3_PCID_USER_VAR+7)
+movb \regb, PER_CPU_VAR(x86_cr3_pcid_user+7)
 9:
 movq \reg, %cr3
 .endm
@@ -94,8 +93,8 @@ movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 */
 DECLARE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
 
-extern unsigned long X86_CR3_PCID_KERN_VAR;
-DECLARE_PER_CPU(unsigned long, X86_CR3_PCID_USER_VAR);
+extern unsigned long x86_cr3_pcid_noflush;
+DECLARE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 
 extern char __per_cpu_user_mapped_start[], __per_cpu_user_mapped_end[];
 
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 0f7bba928264..0508420c6cde 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1540,11 +1540,11 @@ ENTRY(nmi)
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
+	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
+	orq	x86_cr3_pcid_noflush, %rax
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
-	/* Add back kernel PCID and "no flush" bit */
-	orq	X86_CR3_PCID_KERN_VAR, %rax
 	movq	%rax, %cr3
 #endif
 	call	do_nmi
@@ -1779,11 +1779,11 @@ end_repeat_nmi:
 	/* Unconditionally use kernel CR3 for do_nmi() */
 	/* %rax is saved above, so OK to clobber here */
 	movq	%cr3, %rax
+	/* If PCID enabled, NOFLUSH now and NOFLUSH on return */
+	orq	x86_cr3_pcid_noflush, %rax
 	pushq	%rax
 	/* mask off "user" bit of pgd address and 12 PCID bits: */
 	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
-	/* Add back kernel PCID and "no flush" bit */
-	orq	X86_CR3_PCID_KERN_VAR, %rax
 	movq	%rax, %cr3
 #endif
 	DEFAULT_FRAME 0				/* XXX: Do we need this? */
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 7923190cd123..f6e85067d58e 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -29,8 +29,8 @@ DEFINE_PER_CPU_USER_MAPPED(unsigned long, unsafe_stack_register_backup);
  * This is also handy because systems that do not support PCIDs
  * just end up or'ing a 0 into their CR3, which does no harm.
  */
-__aligned(PAGE_SIZE) unsigned long X86_CR3_PCID_KERN_VAR;
-DEFINE_PER_CPU(unsigned long, X86_CR3_PCID_USER_VAR);
+unsigned long x86_cr3_pcid_noflush __read_mostly;
+DEFINE_PER_CPU(unsigned long, x86_cr3_pcid_user);
 
 /*
  * At runtime, the only things we map are some things for CPU
@@ -304,7 +304,8 @@ void __init kaiser_init(void)
 				  sizeof(gate_desc) * NR_VECTORS,
 				  __PAGE_KERNEL);
 
-	kaiser_add_user_map_early(&X86_CR3_PCID_KERN_VAR, PAGE_SIZE,
+	kaiser_add_user_map_early(&x86_cr3_pcid_noflush,
+				  sizeof(x86_cr3_pcid_noflush),
 				  __PAGE_KERNEL);
 }
 
@@ -384,8 +385,8 @@ void kaiser_setup_pcid(void)
 	 * These variables are used by the entry/exit
 	 * code to change PCID and pgd and TLB flushing.
 	 */
-	X86_CR3_PCID_KERN_VAR = kern_cr3;
-	this_cpu_write(X86_CR3_PCID_USER_VAR, user_cr3);
+	x86_cr3_pcid_noflush = kern_cr3;
+	this_cpu_write(x86_cr3_pcid_user, user_cr3);
 }
 
 /*
@@ -395,7 +396,7 @@ void kaiser_setup_pcid(void)
  */
 void kaiser_flush_tlb_on_return_to_user(void)
 {
-	this_cpu_write(X86_CR3_PCID_USER_VAR,
+	this_cpu_write(x86_cr3_pcid_user,
 			X86_CR3_PCID_USER_FLUSH | KAISER_SHADOW_PGD_OFFSET);
 }
 EXPORT_SYMBOL(kaiser_flush_tlb_on_return_to_user);
-- 
2.16.2
