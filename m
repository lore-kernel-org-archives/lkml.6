Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49MsgrI/WM9a059YUO0Hkt/abuUygv+o9aM/FcRb3MXwUeSDjA+PTSnNBTtxl9eq8GMfAPn
ARC-Seal: i=1; a=rsa-sha256; t=1524498468; cv=none;
        d=google.com; s=arc-20160816;
        b=vwdpMR9TKltaiQ94hjICDCHlljWX8OQ1JG1EzmrmwTplqWGFEA8E+pqw7gUXS9+6iL
         r3okmTnsb2Sii3To5k6HtzyXtXQ34OgB5S4xGezQlzwrpRnDzpkE2+Kfy4OtAPYLN16/
         ehbYkIdFpcNqML9OG5hEGMKwl/dm+96lDtQpavpXUvpwoiWsnvEWDjHBQQfPSFeUUTdb
         udypnxNwyCBsCCzp77KK0WJaTUwiAD3BDskjfO86fnoFeBoTGOgJS1tsaU6QtW1BlwZ+
         kD8KRQIIjvZFoUcv2bf7FErZI6EqblkBNRnfJ5cZ7LJBSh4GKZbLKS1emTYNrKrQkBuv
         72Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=79DLp5R+WcU06oOf27QHmMntCacXl56x7Z5lQK9JwSw=;
        b=NrIi+y7+Y06Fco2kHDV5BivfOxksoP45KNfM/L63gCLTd0MqPQh2yVpjX97flYogKC
         KGbFs/rTz2h8M8koHm4O1Zhof5cseKVCG8xrubvoYJvx6FJLZf6FSnYc5iGbNUClbesN
         cw5PoBGOfoGdzXYMep76AmdqUe7L8zEx8Ci6EoV/GI6t2ThJ69pA1N6/ofGmPTwALz9e
         elo4TTKIyIuJXjWcVn/9Vjxn8vCxcSBR0AlRfOikVTkTmJEdE3lltKxKLSm3vo9gLG50
         fp2I4htnjubBLNSqiHRqzLAfIa/I1VdOB0EGdRZl+Lm5GdiDuDVdPBOvVkZk0sPYmEO0
         5FFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=TAC/TnvM;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=TAC/TnvM;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 02/37] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
Date: Mon, 23 Apr 2018 17:47:05 +0200
Message-Id: <1524498460-25530-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504479691573?=
X-GMAIL-MSGID: =?utf-8?q?1598552504479691573?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

The stack address doesn't need to be stored in tss.sp0 if
we switch manually like on sysenter. Rename the offset so
that it still makes sense when we change its location.

We will also use this stack for all kernel-entry points, not
just sysenter. Reflect that in the name as well.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/entry/entry_32.S        | 2 +-
 arch/x86/kernel/asm-offsets_32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index bef8e2b..ec288be 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -412,7 +412,7 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
-	movl	TSS_sysenter_sp0(%esp), %esp
+	movl	TSS_entry_stack(%esp), %esp
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index f91ba53..c6ac48f 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -47,7 +47,7 @@ void foo(void)
 	BLANK();
 
 	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_sysenter_sp0, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_CC_STACKPROTECTOR
-- 
2.7.4
