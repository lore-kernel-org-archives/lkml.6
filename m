Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELth+C9GT47RBOo2mlhALzYZch3zot/+Eai0VuvnsoKdhPjDRqd+1PJBrs8ZWosZV3L4ciGy
ARC-Seal: i=1; a=rsa-sha256; t=1520824080; cv=none;
        d=google.com; s=arc-20160816;
        b=My78nVLB8+bIGqekpQleTbJYE6pnG0rQgxasQQNzwCguUj4vnlFpplqDQgd5p2cEGP
         WjxZtnUSZIM8LbSih0bMYJwz4xJLtwVvz0x4IGY04T7zdpJ8cNAuSnjELn8ZrINRgEqn
         zkX/3aqh7YpgPC8Cm3FAEYf8RT6VZUgiKrwBk6CWR+aa6/XqqttbNPsQIivcnry3UeIx
         y70wByAzHb+9NWCdxaYQuE9RsZwFn4P+iXArKO5S7V7RsKWrjf3/fuw4ULNjP2p/S/4y
         DqbGd1MoAJfbZUPxLYR9qSza5uqcgZJi4Mag/8Uo9e2C8oJivAV96CtmsULjVltw+tVi
         q1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=snKBt6MjN2NWESHz5In5LhcL22gjFCvqCIMVmk6e1oE=;
        b=PdhAjFJ/wa7eA7A7LHG7u/rZ+2+H+gMgcgo0XKqthVqQZvmYxBIPhi/DWrGdt2gWJP
         EJPEso4NuKycaKubfH04UuhUq15a3kHXOjafVZNXhQLboXgOt3Lw56miVnvH0BtnMhZ9
         bUVCEoCmx0aglEnugzaeWxaRB5C9t0n2Hkht3te96pdVE/5YMoBTzcB881xpYOM0/CQ7
         9bIhsg/lP9eJath8TqfJy2XxN8c44lQfbEXepEXjBcPrR9tc30IC3dK9hfhx0BpyAmrb
         GMXw3WFWeKsUde++DuXIgmg+6Tu1I7nLpkzvDD4ARcKsknNxU2IuT02oy0Y9CGKJO872
         gNrA==
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
 "Jinpu Wang" <jinpu.wang@profitbricks.com>,
 kernel-hardening@lists.openwall.com,
 "Jiri Slaby" <jslaby@suse.cz>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Jan Beulich" <JBeulich@suse.com>,
 alan@linux.intel.com,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Dan Williams" <dan.j.williams@intel.com>,
 gregkh@linuxfoundation.org, linux-arch@vger.kernel.org
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.93871245@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 56/76] x86/syscall: Sanitize syscall table
 de-references under speculation
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699616206088143?=
X-GMAIL-MSGID: =?utf-8?q?1594699630435159109?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

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

In 3.16 the x86_32 syscall table lookup is also written in assembly.
So I've taken Jiri's version and added similar masking in entry_32.S,
using edx as the temporary.  edx is clobbered by SAVE_REGS and seems
to be free at this point.

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
@@ -426,6 +426,8 @@ sysenter_past_esp:
 sysenter_do_call:
 	cmpl $(NR_syscalls), %eax
 	jae sysenter_badsys
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
 	call *sys_call_table(,%eax,4)
 sysenter_after_call:
 	movl %eax,PT_EAX(%esp)
@@ -503,6 +505,8 @@ ENTRY(system_call)
 	cmpl $(NR_syscalls), %eax
 	jae syscall_badsys
 syscall_call:
+	sbb %edx, %edx				/* array_index_mask_nospec() */
+	and %edx, %eax
 	call *sys_call_table(,%eax,4)
 syscall_after_call:
 	movl %eax,PT_EAX(%esp)		# store the return value
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -445,12 +445,14 @@ GLOBAL(system_call_after_swapgs)
 	jnz tracesys
 system_call_fastpath:
 #if __SYSCALL_MASK == ~0
-	cmpq $__NR_syscall_max,%rax
+	cmpq	$NR_syscalls, %rax
 #else
 	andl $__SYSCALL_MASK,%eax
-	cmpl $__NR_syscall_max,%eax
+	cmpl	$NR_syscalls, %eax
 #endif
-	ja badsys
+	jae	badsys
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
@@ -577,12 +579,14 @@ tracesys:
 	LOAD_ARGS ARGOFFSET, 1
 	RESTORE_REST
 #if __SYSCALL_MASK == ~0
-	cmpq $__NR_syscall_max,%rax
+	cmpq	$NR_syscalls, %rax
 #else
 	andl $__SYSCALL_MASK,%eax
-	cmpl $__NR_syscall_max,%eax
+	cmpl	$NR_syscalls, %eax
 #endif
-	ja   int_ret_from_sys_call	/* RAX(%rsp) set to -ENOSYS above */
+	jae	int_ret_from_sys_call		/* RAX(%rsp) set to -ENOSYS above */
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq %r10,%rcx	/* fixup for C */
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
