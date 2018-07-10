Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE767C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA79420B6F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA79420B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbeGJSdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:33:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732621AbeGJSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:33:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 93513D0B;
        Tue, 10 Jul 2018 18:33:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rakib Mullick <rakib.mullick@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Janne Huttunen <janne.huttunen@nokia.com>
Subject: [PATCH 4.14 34/53] irq/core: Fix boot crash when the irqaffinity= boot parameter is passed on CPUMASK_OFFSTACK=y kernels(v1)
Date:   Tue, 10 Jul 2018 20:25:10 +0200
Message-Id: <20180710182500.766216757@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182458.736721865@linuxfoundation.org>
References: <20180710182458.736721865@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rakib Mullick <rakib.mullick@gmail.com>

commit 10d94ff4d558b96bfc4f55bb0051ae4d938246fe upstream.

When the irqaffinity= kernel parameter is passed in a CPUMASK_OFFSTACK=y
kernel, it fails to boot, because zalloc_cpumask_var() cannot be used before
initializing the slab allocator to allocate a cpumask.

So, use alloc_bootmem_cpumask_var() instead.

Also do some cleanups while at it: in init_irq_default_affinity() remove
an #ifdef via using cpumask_available().

Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171026045800.27087-1-rakib.mullick@gmail.com
Link: http://lkml.kernel.org/r/20171101041451.12581-1-rakib.mullick@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Janne Huttunen <janne.huttunen@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/irqdesc.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -27,7 +27,7 @@ static struct lock_class_key irq_desc_lo
 #if defined(CONFIG_SMP)
 static int __init irq_affinity_setup(char *str)
 {
-	zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
+	alloc_bootmem_cpumask_var(&irq_default_affinity);
 	cpulist_parse(str, irq_default_affinity);
 	/*
 	 * Set at least the boot cpu. We don't want to end up with
@@ -40,10 +40,8 @@ __setup("irqaffinity=", irq_affinity_set
 
 static void __init init_irq_default_affinity(void)
 {
-#ifdef CONFIG_CPUMASK_OFFSTACK
-	if (!irq_default_affinity)
+	if (!cpumask_available(irq_default_affinity))
 		zalloc_cpumask_var(&irq_default_affinity, GFP_NOWAIT);
-#endif
 	if (cpumask_empty(irq_default_affinity))
 		cpumask_setall(irq_default_affinity);
 }


