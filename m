Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x224CWApOZOyIA7smLf8UI5pdM5twVE0tyxUeFqXtzIy7cS50kiDeg+BaWlGLms+ms4o0gd4K
ARC-Seal: i=1; a=rsa-sha256; t=1518168356; cv=none;
        d=google.com; s=arc-20160816;
        b=tTF81zLnsQD3IbImBz1GvwkyPPgebP4DYarsIU7Xjx+dCHZ6dSJ9EHKq2dFekaAAnj
         hiECYrCynVqQF3jJpqNkQ7oP1xNSUzjn4fXnzhm2MAaOLJcAT6i/0DeRKPA0ahdDWbLC
         RVWm2cNwwncFjNxAAxC3obU0soyO93c4dK6NFUcFy1CRMqzAtibSdfNXoxPcj/ljnN6S
         EzfLuUlsOGQZHQS2Thxm2/ANpkBWO1Wrb3cK4ydEg9WFzy0pjFktDyxv6f370KzE5rNe
         ZqxND3Knm4qpRW4BhJNCsi1t8TctlQ/lnzXh4YBpNXd9MgmnqbRhJXb5uXl2KFncCiUW
         UYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=NTVb4LONHnLz6w99SoQtjWWuv+4gRfgau5jr8PemZlw=;
        b=jKt1yo3x5OA6jjztOD1WjXjLv4teu4oH4S7kXlQ5blJVzLSyu+BlTmKOwWpIYBRF/q
         s7ruai2NBhfvYF65Txyg4ECqeZQH65P11IR9elUHt5LndjpQj6FUgvTHXC6TB+lf8ORB
         pg97U1HrGD6FjM+Efdzp6A7RmpzNz+sp9qO3+bGDTqKB9ozOPYQG0rI0R+oc6WXkehQv
         BECqOKhi5KkrmasLmTNUWhc71LTrIRt5lfoJW92eRNMq9+tpEifxpvYrD4XeyaxjgRgE
         Fr51vMskx+4/sHF8TkDLe5kMpRMeNKftecz1DV8sn0FicW2I3IRQU6Jh2OHWvPNZr+mW
         iK4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Js8FkR9l;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Js8FkR9l;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 03/31] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
Date: Fri,  9 Feb 2018 10:25:12 +0100
Message-Id: <1518168340-9392-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914902347185347?=
X-GMAIL-MSGID: =?utf-8?q?1591914902347185347?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

We want x86_tss.sp0 point to the entry stack later to use
it as a trampoline stack for other kernel entry points
besides SYSENTER.

So store the task stack pointer in x86_tss.sp1, which is
otherwise unused by the hardware, as Linux doesn't make use
of Ring 1.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/asm-offsets_32.c | 2 +-
 arch/x86/kernel/process_32.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/asm-offsets_32.c b/arch/x86/kernel/asm-offsets_32.c
index f452bfd..b97e48c 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -47,7 +47,7 @@ void foo(void)
 	BLANK();
 
 	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_CC_STACKPROTECTOR
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 5224c60..097d36a 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -292,6 +292,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
+	/* SYSENTER reads the task-stack from tss.sp1 */
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
-- 
2.7.4
