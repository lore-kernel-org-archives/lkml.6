Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELtjfaDNo324hKxEMnfgt5E25nCYOPeLMBsSDe/ygMR+JXO6+OVaWGMJugKYmTcMxXAjACUj
ARC-Seal: i=1; a=rsa-sha256; t=1520296002; cv=none;
        d=google.com; s=arc-20160816;
        b=EW+wftAaA786CfGxYF/3lYnmpRsX0aZ/GxAYHrIgNhXFWWAxk9YaZn/n58LMomMsGG
         MgeJXvWa6ZOgTvKlUJ0O1/PTy0JcOT25GJoKRfCa+bTWgAL7UMJHfQYV8fX1CBuq48uE
         x9IS8sMsY6RqWQ4YJHkrqUD3Hlhgk06dUKwEMP9LAkvj8JVsoYeq/xa5dICYhOk0bHyT
         13MUMYDhphAXk6BA0oi8YZw2fFpgZ//1OL7vQfMx5XN7QwuGtJTxAVDaRoDX3j+lze3I
         ps3pKFVvPXNKqCee/FUYIoQNM+4yP95v6hQw3wHKV8ztJW4RzpsPBHBrHujFt2RpQSP2
         phJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=9zYHfm0aV2xJkp60MRmLIrQ1ePe1CClNBltd0m9umss=;
        b=cNw144O5ss3wUy0fjXE7KuRkKEhLS8mJABmDJsJ6Q+olTmPoPYKHZftCkuRLws6nX9
         XuJfZT+io1b4q5OGC1BS3hF6JQHhBDO3D0fugxSgM/13M5cJPQfMEcRiJeEJPSQ/XWxg
         zSv+c8OTN2dJzcyw0dkK0GF5PgCHD2Z7Wf1O1rmCwL8NEtNqHq+W3doDid5pPwQaqDg3
         ZPi8lmihwrX9nhGp2PCFW0buEw+q2CV4oH4Qsw2dC7X6s9zcKWupBARJ9ftTYjJQTLyy
         /JU1XIeDPvmjJqgUy9ksOkDYLPkPvzJWuMfXmhP0TIkz+oonxgG9GAfCb1587Fry7dre
         cr5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XtPwHLQx;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XtPwHLQx;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 46/65] kaiser: paranoid_entry pass cr3 need to paranoid_exit
Date: Mon,  5 Mar 2018 19:25:19 -0500
Message-Id: <20180306002538.1761-47-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145901245870209?=
X-GMAIL-MSGID: =?utf-8?q?1594145901245870209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Neel Natu points out that paranoid_entry() was wrong to assume that
an entry that did not need swapgs would not need SWITCH_KERNEL_CR3:
paranoid_entry (used for debug breakpoint, int3, double fault or MCE;
though I think it's only the MCE case that is cause for concern here)
can break in at an awkward time, between cr3 switch and swapgs, but
its handling always needs kernel gs and kernel cr3.

Easy to fix in itself, but paranoid_entry() also needs to convey to
paranoid_exit() (and my reading of macro idtentry says paranoid_entry
and paranoid_exit are always paired) how to restore the prior state.
The swapgs state is already conveyed by %ebx (0 or 1), so extend that
also to convey when SWITCH_USER_CR3 will be needed (2 or 3).

(Yes, I'd much prefer that 0 meant no swapgs, whereas it's the other
way round: and a convention shared with error_entry() and error_exit(),
which I don't want to touch.  Perhaps I should have inverted the bit
for switch cr3 too, but did not.)

paranoid_exit() would be straightforward, except for TRACE_IRQS: it
did TRACE_IRQS_IRETQ when doing swapgs, but TRACE_IRQS_IRETQ_DEBUG
when not: which is it supposed to use when SWITCH_USER_CR3 is split
apart from that?  As best as I can determine, commit 5963e317b1e9
("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")
missed the swapgs case, and should have used TRACE_IRQS_IRETQ_DEBUG
there too (the discrepancy has nothing to do with the liberal use
of _NO_STACK and _UNSAFE_STACK hereabouts: TRACE_IRQS_OFF_DEBUG has
just been used in all cases); discrepancy lovingly preserved across
several paranoid_exit() cleanups, but I'm now removing it.

Neel further indicates that to use SWITCH_USER_CR3_NO_STACK there in
paranoid_exit() is now not only unnecessary but unsafe: might corrupt
syscall entry's unsafe_stack_register_backup of %rax.  Just use
SWITCH_USER_CR3: and delete SWITCH_USER_CR3_NO_STACK altogether,
before we make the mistake of using it again.

hughd adds: this commit fixes an issue in the Kaiser-without-PCIDs
part of the series, and ought to be moved earlier, if you decided
to make a release of Kaiser-without-PCIDs.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit fc8334e6b3e5d28afd4eec8a74493933f73b2784)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	arch/x86/entry/entry_64.S (not in this tree)
	arch/x86/kernel/entry_64.S (patched instead of that)
---
 arch/x86/include/asm/kaiser.h |  8 --------
 arch/x86/kernel/entry_64.S    | 46 +++++++++++++++++++++++++++++++++----------
 2 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kaiser.h b/arch/x86/include/asm/kaiser.h
index 48d8d70dd8c7..3dc5f4c39b3e 100644
--- a/arch/x86/include/asm/kaiser.h
+++ b/arch/x86/include/asm/kaiser.h
@@ -63,20 +63,12 @@ _SWITCH_TO_KERNEL_CR3 %rax
 movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
 .endm
 
-.macro SWITCH_USER_CR3_NO_STACK
-movq %rax, PER_CPU_VAR(unsafe_stack_register_backup)
-_SWITCH_TO_USER_CR3 %rax %al
-movq PER_CPU_VAR(unsafe_stack_register_backup), %rax
-.endm
-
 #else /* CONFIG_KAISER */
 
 .macro SWITCH_KERNEL_CR3 reg
 .endm
 .macro SWITCH_USER_CR3 reg regb
 .endm
-.macro SWITCH_USER_CR3_NO_STACK
-.endm
 .macro SWITCH_KERNEL_CR3_NO_STACK
 .endm
 
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 0508420c6cde..3973c43903f5 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1300,7 +1300,11 @@ idtentry machine_check has_error_code=0 paranoid=1 do_sym=*machine_check_vector(
 /*
  * Save all registers in pt_regs, and switch gs if needed.
  * Use slow, but surefire "are we in kernel?" check.
- * Return: ebx=0: need swapgs on exit, ebx=1: otherwise
+ *
+ * Return: ebx=0: needs swapgs but not SWITCH_USER_CR3 in paranoid_exit
+ *         ebx=1: needs neither swapgs nor SWITCH_USER_CR3 in paranoid_exit
+ *         ebx=2: needs both swapgs and SWITCH_USER_CR3 in paranoid_exit
+ *         ebx=3: needs SWITCH_USER_CR3 but not swapgs in paranoid_exit
  */
 ENTRY(paranoid_entry)
 	XCPT_FRAME 1 15*8
@@ -1313,9 +1317,26 @@ ENTRY(paranoid_entry)
 	testl %edx,%edx
 	js 1f	/* negative -> in kernel */
 	SWAPGS
-	SWITCH_KERNEL_CR3
 	xorl %ebx,%ebx
-1:	ret
+1:
+#ifdef CONFIG_KAISER
+	/*
+	 * We might have come in between a swapgs and a SWITCH_KERNEL_CR3
+	 * on entry, or between a SWITCH_USER_CR3 and a swapgs on exit.
+	 * Do a conditional SWITCH_KERNEL_CR3: this could safely be done
+	 * unconditionally, but we need to find out whether the reverse
+	 * should be done on return (conveyed to paranoid_exit in %ebx).
+	 */
+	movq	%cr3, %rax
+	testl	$KAISER_SHADOW_PGD_OFFSET, %eax
+	jz	2f
+	orl	$2, %ebx
+	andq	$(~(X86_CR3_PCID_ASID_MASK | KAISER_SHADOW_PGD_OFFSET)), %rax
+	orq	x86_cr3_pcid_noflush, %rax
+	movq	%rax, %cr3
+2:
+#endif
+	ret
 	CFI_ENDPROC
 END(paranoid_entry)
 
@@ -1328,21 +1349,26 @@ END(paranoid_entry)
  * in syscall entry), so checking for preemption here would
  * be complicated.  Fortunately, we there's no good reason
  * to try to handle preemption here.
+ * On entry: ebx=0: needs swapgs but not SWITCH_USER_CR3
+ *           ebx=1: needs neither swapgs nor SWITCH_USER_CR3
+ *           ebx=2: needs both swapgs and SWITCH_USER_CR3
+ *           ebx=3: needs SWITCH_USER_CR3 but not swapgs
  */
-/* On entry, ebx is "no swapgs" flag (1: don't need swapgs, 0: need it) */
 ENTRY(paranoid_exit)
 	DEFAULT_FRAME
 	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF_DEBUG
-	testl %ebx,%ebx				/* swapgs needed? */
+	TRACE_IRQS_IRETQ_DEBUG
+#ifdef CONFIG_KAISER
+	testl   $2, %ebx			/* SWITCH_USER_CR3 needed? */
+	jz      paranoid_exit_no_switch
+	SWITCH_USER_CR3
+paranoid_exit_no_switch:
+#endif
+	testl	$1, %ebx			/* swapgs needed? */
 	jnz paranoid_exit_no_swapgs
-	TRACE_IRQS_IRETQ
-	SWITCH_USER_CR3_NO_STACK
 	SWAPGS_UNSAFE_STACK
-	jmp paranoid_exit_restore
 paranoid_exit_no_swapgs:
-	TRACE_IRQS_IRETQ_DEBUG
-paranoid_exit_restore:
 	RESTORE_EXTRA_REGS
 	RESTORE_C_REGS
 	REMOVE_PT_GPREGS_FROM_STACK 8
-- 
2.16.2
