Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67580C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B9E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AbtvNVXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeLRSyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:54:18 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:55346 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLRSyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:54:17 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3CD8924E2808;
        Tue, 18 Dec 2018 10:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545159257; bh=9sw3xXmZzMD2r1pq0e6toINGoyuET/YizCJnsRVXBDc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AbtvNVXP9+o791uc/g/C/uYcKKKenE1jeDHA/Q9Jf1C9W059a2cTbOfff22ukJdMr
         37EO4b0elciThdTl4xZg+NFwe51fWOFFyZ7WMlh83E8wX/ajbZu6ekjH1QHNc4gdXq
         XYQ0NOaNLUWq7rljmUE86+TLr2VoqtztIvThK/0YN03P3+WeqMaLn2Pq/MrJCwIvjA
         kahcV6OU3NzQ++DI/nKzaL4my7ZXf48Q86ODGw1bmr1unNQpMEGln1Y0dR7HS53hi6
         iJZEAi7dcQumqCOmk+Wr8RHk1AEdD26X8jisV28B/OV+Ujr1pkMH98dST+aIkrDINt
         yRRSc0w+mHCJA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2460E5422;
        Tue, 18 Dec 2018 10:54:17 -0800 (PST)
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.104) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Dec 2018 10:54:17 -0800
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.105) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.103) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:14 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.10.161.70) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 19 Dec 2018 00:24:13 +0530
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Vineet Gupta" <vineet.gupta1@synopsys.com>
Subject: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Date:   Tue, 18 Dec 2018 10:53:59 -0800
Message-ID: <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.10.161.70]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

signal handling core calls ARCH show_regs() with preemption disabled
which causes __might_sleep functions such as mmput leading to lockdep
splat.  Workaround by re-enabling preemption temporarily.

This may not be as bad as it sounds since the preemption disabling
itself was introduced for a supressing smp_processor_id() warning in x86
code by commit 3a9f84d354ce ("signals, debug: fix BUG: using
smp_processor_id() in preemptible code in print_fatal_signal()")

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/troubleshoot.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 2885bec71fb8..c650d3de13e1 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -177,6 +177,12 @@ void show_regs(struct pt_regs *regs)
 	struct task_struct *tsk = current;
 	struct callee_regs *cregs;
 
+	/*
+	 * generic code calls us with preemption disabled, but some calls
+	 * here could sleep, so re-enable to avoid lockdep splat
+	 */
+	preempt_enable();
+
 	print_task_path_n_nm(tsk);
 	show_regs_print_info(KERN_INFO);
 
@@ -219,6 +225,8 @@ void show_regs(struct pt_regs *regs)
 	cregs = (struct callee_regs *)current->thread.callee_reg;
 	if (cregs)
 		show_callee_regs(cregs);
+
+	preempt_disable();
 }
 
 void show_kernel_fault_diag(const char *str, struct pt_regs *regs,
-- 
2.7.4

