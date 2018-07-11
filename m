Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB0CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8A20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="cmOnzPKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CA8A20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbeGKLeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:34:02 -0400
Received: from 8bytes.org ([81.169.241.247]:37384 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbeGKLeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:01 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 90E74715; Wed, 11 Jul 2018 13:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308600; bh=Hav1IUA8t2cPKpgp4yckMuXOqky9jmo+BHWZdTZpH90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmOnzPKaoCsujY+x1U8rnAAIVssULkVOEk+V4dKoqDBri/5EAx+2wWLAVuAX/04iM
         fhGLCcxgUuVdbmbvXmGOhpQDPGcQ1gM07Jnkwip5TKy7+aNj0bGb0uikZGuHNtefAn
         IogzQWZDJNZgWQ2JswLVrfGSYVD0uc+HNV2GRVDTOi/Tahax5jWOgmDCU+NxBl6nLR
         3H0Ery0DnHrvW2N9zWWaEOJ1fvPcsTJE0jpOsF08mOQ7D4MfhIRspJeR91BIUWuoXw
         dx00iwk5oQn8rOoglJePkDrTbtNVpMQtK8N0n6mLwawSAcEquuRhABQacPNzqD4udW
         W5pTLgwoJ4NJg==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 03/39] x86/entry/32: Load task stack from x86_tss.sp1 in SYSENTER handler
Date:   Wed, 11 Jul 2018 13:29:10 +0200
Message-Id: <1531308586-29340-4-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index ab2d949..36d77d3 100644
--- a/arch/x86/kernel/asm-offsets_32.c
+++ b/arch/x86/kernel/asm-offsets_32.c
@@ -47,7 +47,7 @@ void foo(void)
 	BLANK();
 
 	/* Offset from the sysenter stack to tss.sp0 */
-	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp0) -
+	DEFINE(TSS_entry_stack, offsetof(struct cpu_entry_area, tss.x86_tss.sp1) -
 	       offsetofend(struct cpu_entry_area, entry_stack_page.stack));
 
 #ifdef CONFIG_STACKPROTECTOR
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 0ae659d..ec62cc7 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -290,6 +290,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(cpu_current_top_of_stack,
 		       (unsigned long)task_stack_page(next_p) +
 		       THREAD_SIZE);
+	/* SYSENTER reads the task-stack from tss.sp1 */
+	this_cpu_write(cpu_tss_rw.x86_tss.sp1, next_p->thread.sp0);
 
 	/*
 	 * Restore %gs if needed (which is common)
-- 
2.7.4

