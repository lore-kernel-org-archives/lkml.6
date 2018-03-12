Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuGdRnhlE1bLDlZCW9KxKcD5qdC2xub99rOgUAm9PNFjHPXI7Ri8MYrTRqEITc2tWnAOp11
ARC-Seal: i=1; a=rsa-sha256; t=1520824066; cv=none;
        d=google.com; s=arc-20160816;
        b=hcmnut4iLQtM7Vh4TjazaOF8g0kPSuDgfEyppQm7Wp5ubQX1H7j1G2YQNYLKJyGHSh
         V1WTZgL5xe9LBDwqKBK6yGZmLRbaNaTP3wlnjr7SQgpIaXxG7wybxo2PMvB4RFyARjwy
         BkIw0Fm/C/xzlnDWyoE6RG1+oL4G2wqM+jqn4bOwNySbTdDnymOR7Kj7aTXMvA45wVXO
         507LKjFxy5DjjSl9DOoYS3OP3smCdlcRM4hX8zJBg1KY5/vJ70B3XbM7Q3pPp3fERgmI
         2H54JZ444mqmQ66T8sBLhjfJdjNlQ2AEgwAHEmZjF4H64BJyX3Gj9QsDEQXP96VbgSQB
         Q+DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=93ORTVi7JzyF6DlXQwOYIfzmDNJz/a98SlPJzzqj5oE=;
        b=cpfv00Jl+DBxpV/keABHz4y6yoqT/8qLJb8MPCdr8iBgGDASd4+GKrP7pi76c6hjEd
         vs8uoEiw8odKZUcbisd3th4pKrEdU1ox3cDQGibPHdCczdzTa5dxea0FJtYu4ByXrKdK
         56P+C3H2a3apQjab2OfMSVah+F6aloiDQL/phVPTeSHRPdG4TY+YYpcSil/nDamb//rc
         JrrkZtmY2ZoQhnh2akmDc3kU1tukWmTTKrXPVc3JcG29HzwN+G7KZVUXNI8mpHTlAKX0
         yea3sspgUDj8MrQDe8AxZT1Ka+YEKd+fb+HWBvlkxKtdFvofN1W8HZMY8gl8nIfIFXgO
         elAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jiri Slaby" <jslaby@suse.cz>,
 kernel-hardening@lists.openwall.com, alan@linux.intel.com,
 "Jan Beulich" <JBeulich@suse.com>,
 linux-arch@vger.kernel.org,
 "Andy Lutomirski" <luto@kernel.org>,
 "Jinpu Wang" <jinpu.wang@profitbricks.com>,
 gregkh@linuxfoundation.org,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.932106069@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 087/104] x86/syscall: Sanitize syscall table
 de-references under speculation
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699616206088143?=
X-GMAIL-MSGID: =?utf-8?q?1594699616206088143?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben@decadent.org.uk>

commit 2fbd7af5af8665d18bcefae3e9700be07e22b681 upstream.

The upstream version of this, touching C code, was written by Dan Williams,
with the following description:

> The syscall table base is a user controlled function pointer in kernel
> space. Use array_index_nospec() to prevent any out of bounds speculation.
>
> While retpoline prevents speculating into a userspace directed target it
> does not stop the pointer de-reference, the concern is leaking memory
> relative to the syscall table base, by observing instruction cache
> behavior.

The x86_64 assembly version for 4.4 was written by Jiri Slaby, with
the following description:

> In 4.4.118, we have commit c8961332d6da (x86/syscall: Sanitize syscall
> table de-references under speculation), which is a backport of upstream
> commit 2fbd7af5af86. But it fixed only the C part of the upstream patch
> -- the IA32 sysentry. So it ommitted completely the assembly part -- the
> 64bit sysentry.
>
> Fix that in this patch by explicit array_index_mask_nospec written in
> assembly. The same was used in lib/getuser.S.
>
> However, to have "sbb" working properly, we have to switch from "cmp"
> against (NR_syscalls-1) to (NR_syscalls), otherwise the last syscall
> number would be "and"ed by 0. It is because the original "ja" relies on
> "CF" or "ZF", but we rely only on "CF" in "sbb". That means: switch to
> "jae" conditional jump too.
>
> Final note: use rcx for mask as this is exactly what is overwritten by
> the 4th syscall argument (r10) right after.

In 3.2 the x86_32 syscall table lookup is also written in assembly.
So I've taken Jiri's version and added similar masking in entry_32.S,
using edx as the temporary.  edx is clobbered by SAVE_REGS and seems
to be free at this point.

In 3.2 the x86_64 entry code also lacks syscall masking for x32.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Jan Beulich <JBeulich@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: alan@linux.intel.com
Cc: Jinpu Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -429,6 +429,8 @@ sysenter_past_esp:
 sysenter_do_call:
 	cmpl $(nr_syscalls), %eax
 	jae sysenter_badsys
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
 	call *sys_call_table(,%eax,4)
 sysenter_after_call:
 	movl %eax,PT_EAX(%esp)
@@ -512,6 +514,8 @@ ENTRY(system_call)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 syscall_call:
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
 	call *sys_call_table(,%eax,4)
 syscall_after_call:
 	movl %eax,PT_EAX(%esp)		# store the return value
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -517,8 +517,10 @@ ENTRY(system_call_after_swapgs)
 	testl $_TIF_WORK_SYSCALL_ENTRY,TI_flags(%rcx)
 	jnz tracesys
 system_call_fastpath:
-	cmpq $__NR_syscall_max,%rax
-	ja badsys
+	cmpq	$NR_syscalls, %rax
+	jae	badsys
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
@@ -646,8 +648,10 @@ tracesys:
 	 */
 	LOAD_ARGS ARGOFFSET, 1
 	RESTORE_REST
-	cmpq $__NR_syscall_max,%rax
-	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
+	cmpq	$NR_syscalls, %rax
+	jae	int_ret_from_sys_call		/* RAX(%rsp) set to -ENOSYS above */
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx	/* fixup for C */
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
