Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5933120836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pfj5nu98";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="NNDNpoGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5933120836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966310AbeFSNpw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:45:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38042 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965599AbeFSNpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:45:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 07DD060AD8; Tue, 19 Jun 2018 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415944;
        bh=J2JUgs4pL71TrKM4IOX4grlOi3A9w2bY6WbtrRKIC80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pfj5nu98yquX9e6oEFn8eXbMOFF259YpRQedDCK9gtgr5V8BIsYnuDrySWUztvxQb
         1NeQGlbU867kFAfmMQsj3rfB0Is7nV++d9X/w0B/ZY9qG29Mm9RUcEhhbDY/c38E/x
         5uBijr36ZoqgK/qwf5HvJFvXrZKlQ+ZdfrCVc63k=
Received: from srichara-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sricharan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9E7B360AD8;
        Tue, 19 Jun 2018 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529415942;
        bh=J2JUgs4pL71TrKM4IOX4grlOi3A9w2bY6WbtrRKIC80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNDNpoGKXibWvcH5lRJ1jv32fopnXUDyrDJCIxIMjt0kqyg5lfmV6ienC1xKWST5M
         BVGwj9w/mwlFYkok3NEgYh1GW6P9JaPCrAO/TlKFvSuCUsGJlaRYAwu9ZhiQIsYLBV
         ckaFKtTHzRdXtSLc6x9n1tS5L9XA/bPkfhHLULr0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9E7B360AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From:   Sricharan R <sricharan@codeaurora.org>
To:     robh@kernel.org, viresh.kumar@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org,
        linux@armlinux.org.uk, andy.gross@linaro.org,
        david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux@arm.linux.org.uk,
        thierry.escande@linaro.org, ctatlor97@gmail.com
Cc:     sricharan@codeaurora.org
Subject: [PATCH v10 01/14] ARM: Add Krait L2 register accessor functions
Date:   Tue, 19 Jun 2018 19:15:12 +0530
Message-Id: <1529415925-28915-2-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
References: <1529415925-28915-1-git-send-email-sricharan@codeaurora.org>
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
index 70b4a14..eec6cd1 100644
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
1.9.1

