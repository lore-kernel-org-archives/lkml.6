Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADA5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126FC22507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 01:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126FC22507
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbeKMLuk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:50:40 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:34354 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeKMLuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:50:39 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7103665A020BC664B8D4;
        Tue, 13 Nov 2018 09:54:47 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAD1siwI083379;
        Tue, 13 Nov 2018 09:54:44 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111309545505-10299766 ;
          Tue, 13 Nov 2018 09:54:55 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        wang.yi59@zte.com.cn, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, bp@suse.de
Subject: [PATCH] x86/irq: Fix -Wmissing-prototypes warning for init_IRQ()
Date:   Tue, 13 Nov 2018 09:56:29 +0800
Message-Id: <1542074189-3208-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-13 09:54:55,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-13 09:54:40
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wAD1siwI083379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building kernel with W=1:
arch/x86/kernel/irqinit.c:79:13: warning: no previous prototype for ‘init_IRQ’ [-Wmissing-prototypes]
 void __init init_IRQ(void)
             ^

Add the missing declaration in head file to fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 arch/x86/include/asm/irq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/irq.h b/arch/x86/include/asm/irq.h
index 2395bb7..399a9c5 100644
--- a/arch/x86/include/asm/irq.h
+++ b/arch/x86/include/asm/irq.h
@@ -41,6 +41,8 @@ static inline int irq_canonicalize(int irq)
 
 extern void init_ISA_irqs(void);
 
+extern void __init init_IRQ(void);
+
 #ifdef CONFIG_X86_LOCAL_APIC
 void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
 				    bool exclude_self);
-- 
1.8.3.1

