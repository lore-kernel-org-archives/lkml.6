Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83482C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B6A2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B6A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbeKGM7Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:59:25 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:40988 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbeKGM7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:59:25 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 24C2BE1CC6FCDF7699CC;
        Wed,  7 Nov 2018 11:30:54 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wA73Ul02002684;
        Wed, 7 Nov 2018 11:30:47 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018110711310776-9096906 ;
          Wed, 7 Nov 2018 11:31:07 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: [PATCH] x86/irq: fix build warning in irq.c
Date:   Wed, 7 Nov 2018 11:32:37 +0800
Message-Id: <1541561557-42247-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-07 11:31:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-07 11:30:40
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wA73Ul02002684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following warnings:
arch/x86/kernel/irq.c:270:28: warning: no previous prototype for ‘smp_x86_platform_ipi’ [-Wmissing-prototypes]
 __visible void __irq_entry smp_x86_platform_ipi(struct pt_regs *regs)
                            ^
arch/x86/kernel/irq.c:301:16: warning: no previous prototype for ‘smp_kvm_posted_intr_ipi’ [-Wmissing-prototypes]
 __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs)
                ^
arch/x86/kernel/irq.c:314:16: warning: no previous prototype for ‘smp_kvm_posted_intr_wakeup_ipi’ [-Wmissing-prototypes]
 __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs)
                ^
arch/x86/kernel/irq.c:328:16: warning: no previous prototype for ‘smp_kvm_posted_intr_nested_ipi’ [-Wmissing-prototypes]
 __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs)
                ^

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/include/asm/irq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 2395bb7..4c9855a 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -30,6 +30,9 @@ static inline int irq_canonicalize(int irq)
 
 #ifdef CONFIG_HAVE_KVM
 extern void kvm_set_posted_intr_wakeup_handler(void (*handler)(void));
+extern __visible void smp_kvm_posted_intr_ipi(struct pt_regs *regs);
+extern __visible void smp_kvm_posted_intr_wakeup_ipi(struct pt_regs *regs);
+extern __visible void smp_kvm_posted_intr_nested_ipi(struct pt_regs *regs);
 #endif
 
 extern void (*x86_platform_ipi_callback)(void);
@@ -44,6 +47,8 @@ static inline int irq_canonicalize(int irq)
 #ifdef CONFIG_X86_LOCAL_APIC
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
+
+extern __visible void smp_x86_platform_ipi(struct pt_regs *regs);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
 #endif
 
-- 
1.8.3.1

