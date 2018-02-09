Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x2263p3+4qMWTHdpSLvmOLQkptLP68rrcSqcS5nJtY+90wzOAeHLkKzTrYv1ADL4Ta1GLNLUP
ARC-Seal: i=1; a=rsa-sha256; t=1518168355; cv=none;
        d=google.com; s=arc-20160816;
        b=rrDVaubYvZIzAHUvGZvI3+aptC3t17/S1m6RmDDCtgjitgtOWJOR5JpQRD44zdWlry
         5XpL+ecXMwFRVyLo6U1Ej+FFAGhmk54Zk0nhbCATZVEiw1SsE8ToIGOASFyTv+HSb9A5
         XgjgPBuRl2lLtsPD+R9u/OduesPr0Ni8gGWs/FdbZfOdozupWbQbdyyLyzRF86MhejRI
         4vzVF+rwvH82mXoyZJTC4Nerzw6okcXmQbOIqcqrcEHCMIZpHdgDuymH8FBGjF1gxoi0
         rIyMLKpSbvu7z5zmRHbhlwM6QeoyjNJqtGBQpd1NprOXUgjIgE7115HBSNmPgxWYPSGj
         IRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hdsRAwqz5z3IOtY48u7JLP4JHKEq8P0HRQlMJ07/mYo=;
        b=QkvOP0K7RWa9dIoCOqNc4OPWSmmqzF5K1RyA+9YgSouXvfZkvFOZqBjuP8huJihYbY
         PNR2i5Nisr9DME7FNGjKOrAdUESYTsKDK/CX5j7941EMdGuB//9wKAEMe2R4vKn4Gfm+
         c9Pn+2H3Uqi+JjmoI5tkfLIFJ5HcN3XJFUNLkC+QMoCX8aJDnn0Jg/YRaTPG4s46TzQp
         G15nQ2ZQAf25jA0Fxv3PwIqB/90SeLu/+JHtx+iSND5bBTHaWxMQ9UOvlB7v6VwyB3i0
         lkWmJLpGFnBic7COsmjEjCI7gx5xadsdH/Wg0ORw/r4ZtznJEoI05w3kLgo/QXiGVBgo
         0Aww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=exQ9b/Ki;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=exQ9b/Ki;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 02/31] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
Date: Fri,  9 Feb 2018 10:25:11 +0100
Message-Id: <1518168340-9392-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914900354784624?=
X-GMAIL-MSGID: =?utf-8?q?1591914900354784624?=
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
index 2a35b1e..e659776 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -413,7 +413,7 @@ ENTRY(xen_sysenter_target)
  * 0(%ebp) arg6
  */
 ENTRY(entry_SYSENTER_32)
-	movl	TSS_sysenter_sp0(%esp), %esp
+	movl	TSS_entry_stack(%esp), %esp
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	%ebp			/* pt_regs->sp (stashed in bp) */
diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index fa1261e..f452bfd 100644
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
