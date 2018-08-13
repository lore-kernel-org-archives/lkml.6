Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F348CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95BCE21781
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nYFVJEJ9";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TDesG14a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95BCE21781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbeHMQSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 12:18:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbeHMQSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 12:18:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D89C160BE7; Mon, 13 Aug 2018 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167388;
        bh=O7a3cPIqbgTbIG2ZsrcPmCPprozaIufiALfQnGQn/VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYFVJEJ9TYClkdlcGdDwKkOCcAcgnZU7C9tOD33itBB6FOnuxeB8KFxZsVg4gapN4
         KcDz58u45vK0ZxCrZbm/b1xre01hRyX/vw+tdFN5raCDxE+yJN5o93aDs7YxKngoYo
         kdp6MmZPK/7Y2Kywp3ZOpgI7N7pWzPqSKsvdkpTk=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A841C60B22;
        Mon, 13 Aug 2018 13:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534167387;
        bh=O7a3cPIqbgTbIG2ZsrcPmCPprozaIufiALfQnGQn/VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDesG14aglL5tPHxf9IkK9YxfyCPaPbUrX0bIAi78FNmwmtPogTvtEffzRQSB8EaO
         1Gy3JqUKT2oD1aK0SuYjFxvS2NIZ6O/nDgnTfuuBEn0dVFVIRjePlD5kUY/sgGR2VB
         OGw7hw4dNkg266Qg/M36vuUzPMJO9C4CGegcAJF0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A841C60B22
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     mark.rutland@arm.com, robh@kernel.org, sudeep.holla@arm.com,
        linux@arm.linux.org.uk, ctatlor97@gmail.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        linux-pm@vger.kernel.org, sboyd@codeaurora.org,
        linux@armlinux.org.uk, thierry.escande@linaro.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        niklas.cassel@linaro.org
Cc:     sricharan@codeaurora.org
Subject: [PATCH 01/14] ARM: Add Krait L2 register accessor functions
Date:   Mon, 13 Aug 2018 19:05:54 +0530
Message-Id: <1534167367-17545-2-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
References: <1534167367-17545-1-git-send-email-sricharan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@codeaurora.org>

Krait CPUs have a handful of L2 cache controller registers that
live behind a cp15 based indirection register. First you program
the indirection register (l2cpselr) to point the L2 'window'
register (l2cpdr) at what you want to read/write.  Then you
read/write the 'window' register to do what you want. The
l2cpselr register is not banked per-cpu so we must lock around
accesses to it to prevent other CPUs from re-pointing l2cpdr
underneath us.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/common/Kconfig                   |  3 ++
 arch/arm/common/Makefile                  |  1 +
 arch/arm/common/krait-l2-accessors.c      | 48 +++++++++++++++++++++++++++++++
 arch/arm/include/asm/krait-l2-accessors.h |  9 ++++++
 4 files changed, 61 insertions(+)
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h

diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index e5ad070..c8e1986 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -7,6 +7,9 @@ config DMABOUNCE
 	bool
 	select ZONE_DMA
 
+config KRAIT_L2_ACCESSORS
+	bool
+
 config SHARP_LOCOMO
 	bool
 
diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 3157be4..219a260 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -7,6 +7,7 @@ obj-y				+= firmware.o
 
 obj-$(CONFIG_SA1111)		+= sa1111.o
 obj-$(CONFIG_DMABOUNCE)		+= dmabounce.o
+obj-$(CONFIG_KRAIT_L2_ACCESSORS) += krait-l2-accessors.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomo.o
 obj-$(CONFIG_SHARP_PARAM)	+= sharpsl_param.o
 obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
diff --git a/arch/arm/common/krait-l2-accessors.c b/arch/arm/common/krait-l2-accessors.c
new file mode 100644
index 0000000..9a97dda
--- /dev/null
+++ b/arch/arm/common/krait-l2-accessors.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, The Linux Foundation. All rights reserved.
+
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#include <asm/barrier.h>
+#include <asm/krait-l2-accessors.h>
+
+static DEFINE_RAW_SPINLOCK(krait_l2_lock);
+
+void krait_set_l2_indirect_reg(u32 addr, u32 val)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krait_l2_lock, flags);
+	/*
+	 * Select the L2 window by poking l2cpselr, then write to the window
+	 * via l2cpdr.
+	 */
+	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
+	isb();
+	asm volatile ("mcr p15, 3, %0, c15, c0, 7 @ l2cpdr" : : "r" (val));
+	isb();
+
+	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
+}
+EXPORT_SYMBOL(krait_set_l2_indirect_reg);
+
+u32 krait_get_l2_indirect_reg(u32 addr)
+{
+	u32 val;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&krait_l2_lock, flags);
+	/*
+	 * Select the L2 window by poking l2cpselr, then read from the window
+	 * via l2cpdr.
+	 */
+	asm volatile ("mcr p15, 3, %0, c15, c0, 6 @ l2cpselr" : : "r" (addr));
+	isb();
+	asm volatile ("mrc p15, 3, %0, c15, c0, 7 @ l2cpdr" : "=r" (val));
+
+	raw_spin_unlock_irqrestore(&krait_l2_lock, flags);
+
+	return val;
+}
+EXPORT_SYMBOL(krait_get_l2_indirect_reg);
diff --git a/arch/arm/include/asm/krait-l2-accessors.h b/arch/arm/include/asm/krait-l2-accessors.h
new file mode 100644
index 0000000..a5f2cdd
--- /dev/null
+++ b/arch/arm/include/asm/krait-l2-accessors.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASMARM_KRAIT_L2_ACCESSORS_H
+#define __ASMARM_KRAIT_L2_ACCESSORS_H
+
+extern void krait_set_l2_indirect_reg(u32 addr, u32 val);
+extern u32 krait_get_l2_indirect_reg(u32 addr);
+
+#endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

