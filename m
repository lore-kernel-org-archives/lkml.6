Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DFECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48602145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48602145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbeJRIya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:54:30 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:1559 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726943AbeJRIya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:54:30 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 17 Oct 2018 17:55:52 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 3FE96408AB;
        Wed, 17 Oct 2018 17:56:09 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Ingo Molnar <mingo@redhat.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin " <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>,
        <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Nadav Amit <namit@vmware.com>
Subject: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Date:   Wed, 17 Oct 2018 17:54:16 -0700
Message-ID: <20181018005420.82993-2-namit@vmware.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181018005420.82993-1-namit@vmware.com>
References: <20181018005420.82993-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is sometimes beneficial to prevent preemption for very few
instructions, or prevent preemption for some instructions that precede
a branch (this latter case will be introduced in the next patches).

To provide such functionality on x86-64, we use an empty REX-prefix
(opcode 0x40) as an indication that preemption is disabled for the
following instruction.

It is expected that this opcode is not in common use.

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/entry/entry_64.S            | 10 ++++++++++
 arch/x86/include/asm/nospec-branch.h | 12 ++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cb8a5893fd33..31d59aad496e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -643,6 +643,16 @@ retint_kernel:
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
+
+	/*
+	 * Allow to use hint to prevent preemption on a certain instruction.
+	 * Consider an instruction with the first byte having REX prefix
+	 * without any bits set as an indication for preemption disabled.
+	 */
+	movq    RIP(%rsp), %rax
+	cmpb    $PREEMPT_DISABLE_PREFIX, (%rax)
+	jz	1f
+
 	call	preempt_schedule_irq
 	jmp	0b
 1:
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 80dc14422495..0267611eb247 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -52,6 +52,12 @@
 	jnz	771b;				\
 	add	$(BITS_PER_LONG/8) * nr, sp;
 
+/*
+ * An empty REX-prefix is an indication that preemption should not take place on
+ * this instruction.
+ */
+#define PREEMPT_DISABLE_PREFIX                 (0x40)
+
 #ifdef __ASSEMBLY__
 
 /*
@@ -148,6 +154,12 @@
 #endif
 .endm
 
+.macro preempt_disable_prefix
+#ifdef CONFIG_PREEMPT
+	.byte	PREEMPT_DISABLE_PREFIX
+#endif
+.endm
+
 #else /* __ASSEMBLY__ */
 
 #define ANNOTATE_NOSPEC_ALTERNATIVE				\
-- 
2.17.1

