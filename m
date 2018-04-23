Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx497OVmYr1L1ghnfGCQGMoiouYefmWMn5Bw6Qy/TswdKuO05ijplBrLdieN4B6Mqln08ZKxP
ARC-Seal: i=1; a=rsa-sha256; t=1524498468; cv=none;
        d=google.com; s=arc-20160816;
        b=Kx7oS/TaSYGfW13YV0sBlQe9epheCEFnb6GkUvlXvTbFC+f7qnsXNUY6ed426Lqbc3
         kLA5zadKIowE9kC1DPe34G42sKpPubxkB6ab+K/zL3sNxWuUA78Vg3U+0th9gJRY2FLM
         g5Rjicu83IphhC2KSSUFs3HWX9gy5qLlxEGUTuIpa9eAPhJQSudz3xq2F5lMyGQTz0vh
         /65r7vjEVNnILuTKLQzu30N8qO2u7/8ltIlxLJ2NR1bCRjO/NQuoDdWKlfZxGLiCngSe
         Cjm/OmKoKrfC+1HhgucBT8Ss/1G5Zak7ZmfiFKnmycnH0TrSWgq1llGE3AA53xa07R7o
         l5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5T9WHrF2RxYDrEVlUM21Rm6lHtReRrNdR/Ri8/yymOg=;
        b=0+rLjThVDzTJq42+xVcCNq++t9bpFP3k4Of9VE3Xg6wdSu9oVSHSfWDX1kZmvSA7Tw
         1s2fgsL1ePGxAtIn9uqChPiOaxt3f/R0o046o7wOgoDQjlh9eMDWE7XRIyDgSE7KDHXK
         8XhBdsF83Dktbod1pQ14tAVL85FTusIr//0IOrEakBdOiYgJcooIukzIGng6/v3kpu4R
         SL49VS432yiVfwZ3urZdtM30d5cWKGMwBpekwt/RL/UCCl8ulb5S5CPMhUYYGtOYH1e+
         2vHGzYvRn2ZWFqsYQEyVw8PuG1n9GRzE+yYoZw35nHKZd7A6veKDc1PMRICIPpCxo7W8
         zA/g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FDcnEAoH;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=FDcnEAoH;
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
Subject: [PATCH 03/37] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
Date: Mon, 23 Apr 2018 17:47:06 +0200
Message-Id: <1524498460-25530-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552504623066312?=
X-GMAIL-MSGID: =?utf-8?q?1598552504623066312?=
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
index c6ac48f..5f05329 100644
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
