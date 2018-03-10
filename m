Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt9SnVVou7t/LnsSwi2lINrzqnnWCA8qX55zx8lsBujEW/UAZS01K2dbZSY0R0G/w1skf6H
ARC-Seal: i=1; a=rsa-sha256; t=1520641182; cv=none;
        d=google.com; s=arc-20160816;
        b=jb0DW0MDPxMbo6K7vYrv4nHKcgE7ZoibkR+LaMwoxcFYtUOXREE4ahx4m8ukJ0JHZv
         yBRQvehv0/6l8C9RT1czMBa9exEutVrzg6Fygf7X20JjmxIm/fhk/Fg9qiOLJ1vSYf3h
         dODBpbtIRCLfnm4Yo0neYkrUtzvZmwYyl0T6qbeO6T72odVx3ppR+NpY5po6yQE0neUw
         iYQXxpWXDpwxx8m1/i7OQstn7BukjyBjKkLSacyJ4P287vT4T/WBpX8Z7Le+a8k8n2zl
         5PlOItZ8QkzRQJOOgpCH9jLCinMtLdoDMB9xsbHogxX3lfxZVk3Mo3y47KL+FcL1qEcQ
         624w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LYvmrzCcUqbQKx4M8OrEDXr8CKU/e1Cg6SDvhUOeYYI=;
        b=zm4KpAeWkV3TXrZWeKdZf0pTEilO+7jRJUhTb9/d2jViUNbsIe29MjjihaOW2dEkFW
         xewAFgAby+QnWuJ5g7VwjKTd1xUlImSj5KvFh2Yxccjx/BRsEvs/W7EEKvaaySSqdHS4
         VgJLXX60rQ8Sz+uelNMAn1k6cM+KD1El5pPUYS5cOOIBB+D0PS3wbsmzx06x5ICK6gNa
         kSrXML5Ro6023Yz8+zFs4+9+mreLMHzpZmqm41vEvG37e/V0zivRAeX1J6sxuW49PFxJ
         QWbgrSeHJuB6HrdVYm/CIv8xBGZnBelT6DjU1xrjg9tZLeZG0vwEmcec9x3d8sm4jG+Q
         NQBA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <JBeulich@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arch@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	Andy Lutomirski <luto@kernel.org>,
	alan@linux.intel.com,
	Jinpu Wang <jinpu.wang@profitbricks.com>,
	Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 4.4 11/36] x86/syscall: Sanitize syscall table de-references under speculation fix
Date: Fri,  9 Mar 2018 16:18:27 -0800
Message-Id: <20180310001807.821338686@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594507848831732989?=
X-GMAIL-MSGID: =?utf-8?q?1594507848831732989?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Slaby <jslaby@suse.cz>

In 4.4.118, we have commit c8961332d6da (x86/syscall: Sanitize syscall
table de-references under speculation), which is a backport of upstream
commit 2fbd7af5af86. But it fixed only the C part of the upstream patch
-- the IA32 sysentry. So it ommitted completely the assembly part -- the
64bit sysentry.

Fix that in this patch by explicit array_index_mask_nospec written in
assembly. The same was used in lib/getuser.S.

However, to have "sbb" working properly, we have to switch from "cmp"
against (NR_syscalls-1) to (NR_syscalls), otherwise the last syscall
number would be "and"ed by 0. It is because the original "ja" relies on
"CF" or "ZF", but we rely only on "CF" in "sbb". That means: switch to
"jae" conditional jump too.

Final note: use rcx for mask as this is exactly what is overwritten by
the 4th syscall argument (r10) right after.

Reported-by: Jan Beulich <JBeulich@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: alan@linux.intel.com
Cc: Jinpu Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/entry/entry_64.S |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -178,12 +178,14 @@ GLOBAL(entry_SYSCALL_64_after_swapgs)
 	jnz	tracesys
 entry_SYSCALL_64_fastpath:
 #if __SYSCALL_MASK == ~0
-	cmpq	$__NR_syscall_max, %rax
+	cmpq	$NR_syscalls, %rax
 #else
 	andl	$__SYSCALL_MASK, %eax
-	cmpl	$__NR_syscall_max, %eax
+	cmpl	$NR_syscalls, %eax
 #endif
-	ja	1f				/* return -ENOSYS (already in pt_regs->ax) */
+	jae	1f				/* return -ENOSYS (already in pt_regs->ax) */
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq	%r10, %rcx
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
@@ -276,12 +278,14 @@ tracesys_phase2:
 	RESTORE_C_REGS_EXCEPT_RAX
 	RESTORE_EXTRA_REGS
 #if __SYSCALL_MASK == ~0
-	cmpq	$__NR_syscall_max, %rax
+	cmpq	$NR_syscalls, %rax
 #else
 	andl	$__SYSCALL_MASK, %eax
-	cmpl	$__NR_syscall_max, %eax
+	cmpl	$NR_syscalls, %eax
 #endif
-	ja	1f				/* return -ENOSYS (already in pt_regs->ax) */
+	jae	1f				/* return -ENOSYS (already in pt_regs->ax) */
+	sbb	%rcx, %rcx			/* array_index_mask_nospec() */
+	and	%rcx, %rax
 	movq	%r10, %rcx			/* fixup for C */
 #ifdef CONFIG_RETPOLINE
 	movq	sys_call_table(, %rax, 8), %rax
