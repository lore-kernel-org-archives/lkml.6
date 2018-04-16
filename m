Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/hlORU7p/ytFJdN/YvDMfTAJhdlGMFc3b5zgg7f1XqVBqHu7cL/rZ0k/Fo2VlGZ86zQDHl
ARC-Seal: i=1; a=rsa-sha256; t=1523892339; cv=none;
        d=google.com; s=arc-20160816;
        b=Y4SHlkaEdDKbGUtqnmbPxEDwpfaOnQQUH1O6M9gm1Mdv3/pXUparV26XYflZUPVY4C
         CEo5NEyhhDJRa/B1JMSd+vE+JXsMT+bfmn5iy0JvobNuVQhtnVIqAGVxu7BEiRJNa1Jw
         Xoc5ibPc1rxN7d2AQ3ssbw3TErIEdCqTeQmbAmhsFbiOtPREoPAcXHOsh3I8puhUbg+A
         zuLRDd+B4Rvu9cq0TIacyV9jRg0iKikgMNinSj33COZHcBoBcqgP+RxmJLZynxDXO0X5
         SOKAmhE2++9L5wKq65i3SsatQ/Ci99lCfdluij5mCZp3Y52vmMP1lMuQCwTlaZxbIRPi
         zj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=79DLp5R+WcU06oOf27QHmMntCacXl56x7Z5lQK9JwSw=;
        b=BCWCvbQWa3bi9SLkUSyqTPE7mdYvdX9fAdNR+s7rW+9HNJYw+4mrZPHal63aaqJTfe
         yBM8gIm7dzgcH2Crbqgxu9qYbrbpMcbkZgZ98BtUnzewx8B1cxy2jCMKEZlquBkWRS7l
         NXhds8W/z+JRaDxPadwz59conSp7pZ7S7qeZIMrhdnj6hnFZ7N3OkhVt/rMemGi4xmsn
         u95iAo99ZlWwVcM1LsxezapDOeGsnUZjoWC+LQOI+3bV3YL3R/P3WtBJkwjg2GGOQZWg
         /M1IQqyvNbrJHNk1ntyceqcMngjKAFvZe6Ia+nZpFlxYxKakQ5y5TWMt3X+0yYmWdYRj
         /aPQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=cK9yaLfF;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=cK9yaLfF;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 02/35] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
Date: Mon, 16 Apr 2018 17:24:50 +0200
Message-Id: <1523892323-14741-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916933905431613?=
X-GMAIL-MSGID: =?utf-8?q?1597916933905431613?=
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
