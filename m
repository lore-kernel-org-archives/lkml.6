Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsIVTuNNyhILl8ZWc0Tb0BkOQQbX6vcL9bZTzTWvH2HfQg5iB08MV9C8iL8jjBXzWe99epl
ARC-Seal: i=1; a=rsa-sha256; t=1520245570; cv=none;
        d=google.com; s=arc-20160816;
        b=U/VArVkae9YhCscXu8kXswwPM6Lu09P3n+kkXKhmCOSifITrIaMXBA2A7MYp5T25fu
         dVYjLQsZhMNXwSbcUOFfb/GGjtpHLOBqEbJLBpCn/W37cxRrw8t4wPoEnKdwKJY5mUQ+
         3aUIW3BcRLCV8YXSJDNIPOXE2mWFFZH41kycjw4vTE/GMoO9RhkM9gwws2r+RWsRXd6f
         jsO6dWXxT/LoBsN2rroYkBLGcKYor1KWxD96wOzIinr/iDX0Ylszz+VOknDJmTzv0V1x
         mMTP3p7xb40WakQOKqnVO7EFWvvlfnMOnvqNnwNSCQspA7QRhnMo5Ig5aENNhdb4oQNS
         ouBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hdsRAwqz5z3IOtY48u7JLP4JHKEq8P0HRQlMJ07/mYo=;
        b=SzuD5oI3WPY6UaFqdGiEtZFH7APs3MyutZ2RRj3m+NYQ0h+pHtxebDnlIc3z3LJD04
         5MQK0FT+BkXSFF0WqFWYPBn0YNMl2/zbkL/dNb9fMW7ocaOx59E9igvizIlH1KJ4TZmZ
         Alx5D1vVtVpv12PILnhrO4kovJttbQ3YSIFKbiqRZB2CrwFgmdND/RHkQMD4j7CgiSCd
         3TtQQUgZDh1acIO9B152FZ3MwEPGu8f3lNSziRufyjKok/Tg3tGAistreliGVpWVr84n
         lnDq278mSRajseB1Tb+7i/2L+TzonC47Mm1Cd18ftMcFivZp+0P/B/TvcDDv9zi4xVLB
         Mpzg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IGx/dwWr;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=IGx/dwWr;
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
Subject: [PATCH 02/34] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
Date: Mon,  5 Mar 2018 11:25:31 +0100
Message-Id: <1520245563-8444-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093018278639837?=
X-GMAIL-MSGID: =?utf-8?q?1594093018278639837?=
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
