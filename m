Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038F7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9638821566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9638821566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeI0L0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:26:45 -0400
Received: from [222.66.158.132] ([222.66.158.132]:15829 "EHLO
        SHSQR01.unisoc.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726590AbeI0L0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:26:45 -0400
X-Greylist: delayed 5124 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 07:26:44 EDT
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
        by SHSQR01.unisoc.com with ESMTP id w8R3hFVR038733
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:43:15 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTP id w8R3dgo4033808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 27 Sep 2018 11:39:43 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Thu, 27 Sep 2018 11:41:39
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
Date:   Thu, 27 Sep 2018 11:41:37 +0800
Message-ID: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com w8R3dgo4033808
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
	trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace. For clarification,
I'm also adding a two new code comments describing how this one
is special.

The warning appears to have shown up after patch e7273ff49acf
("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
changed the number assignment from '15' to '8', but as far as I can
tell has existed since the IPI tracepoints were first introduced.
If we decide to backport this patch to stable kernels, we probably
need to backport e7273ff49acf as well.

Resubmiting this patch is because that I found coverity is complaining
the issue this patch fixed, and also I got the traces like below:
"ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
the TPS of suspend_resume[1] rather than ipi_raise.

[1]
https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/smp.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23ea..7a88f16 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0978282..123be77 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -75,6 +75,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	_smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.7.4

