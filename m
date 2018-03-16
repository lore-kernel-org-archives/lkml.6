Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELsqQ0YlnaiWaNTIGgOzEyskas9f7mRINdLF0L+ksp55IqOspHZjYNx15rwvqmmCf7GtNaAC
ARC-Seal: i=1; a=rsa-sha256; t=1521228599; cv=none;
        d=google.com; s=arc-20160816;
        b=OckTHJ0nPEwNnpIYOSyz/LZ3ZsAnwq3wa6OBG93m6t3ml6EoMNhAp6W7NI0Qy/egQD
         IV4GtA+yUWjJOyFFCtscaxlKvZWtc/GQv9tBjlcHmOcSYbIVzSaawcz0e7J6jXUibH56
         BsbV+2H8sdOOXGdlWoBCYgTeN0h7oy76vfEx7KCGNOevyg+eteoPo8HqBrD3CW6LCuMT
         RPkiecv2vcziND3j6wXkwUF8W1bqmuATCe7Z2olSH/YTG+9hp3+Ny8jV9mPLW2q+pBvJ
         mtFK1Xebv+ov4KXruRBFL8QJE8YxmPsXBjMhytNCTMRTmWIPqumg2hNdMaIvjF6Wc2V3
         9zVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=hdsRAwqz5z3IOtY48u7JLP4JHKEq8P0HRQlMJ07/mYo=;
        b=Z6L6uQQ7PYkNebh0wNYpGWCi2lpc4ijsY7zQj1uIG3xbTDujncx3Dkc29b2vcgKWR0
         uP887qNBVY1SfZOTo95ZcDJ+LrPq0LkzFDD9V9G1Blgplbpit+Uf8FZYsHbMfWXZN+oH
         6W86DKV3rELd5rq+PvuEyh1+j20BkXb8ey/E8+j5nRZGjlwOtOomikW/cPR9KHMK1c8U
         bCS2qwA/NuG07lrkyzggZN8cQkOFzzIpP+N+FYbIX6aU582W2fE3m626ZyzjSMOhosqf
         tnbGWKexLI4EuK0MRR//31bWtlFIf9ohXXJxiFj7jHZY7IcWTBQOnu852ugYvtUZj2TO
         iZJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=R1UnP2/d;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=R1UnP2/d;
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
Subject: [PATCH 02/35] x86/entry/32: Rename TSS_sysenter_sp0 to TSS_entry_stack
Date: Fri, 16 Mar 2018 20:29:20 +0100
Message-Id: <1521228593-3820-3-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123799447053077?=
X-GMAIL-MSGID: =?utf-8?q?1595123799447053077?=
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
