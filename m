Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19916C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2421531
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dnYrgyE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC2421531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJTWBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:01:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbeJTWBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:01:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id z25-v6so5898383wmf.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNWpROxWe29p3q9Z0C7EayZeFSHYPnGAzOOI1Q5dO60=;
        b=dnYrgyE0MxkqngCnW/6v9ovG/mUZh1QgHE0jkcI78KCAGB0hfO4Sw3mbeRGX4WDPlY
         2ZWigwUocQLWqWLcwXuvF0IcXSZ1p4JP7ZTsFbRiwUws0KOYPu8j4Zy7zoOagsMJlh3d
         v4hYuK4IBjV949xxZKxT/Z7v77tanx4D2nS4W9L2swaTYPLLG8c2eV4dV70TwgQ3kmVk
         T2escrIN3fC5U01oUtGMIDbrX9dLrzBmyDVlscgIO7a8uf6pIcKxZt6XSlS/fM+Pcx3I
         /Qq2UVMgQ66XhhQruxuV7x2sGPib3qubgtFXgm0l2Q2y6ns8iZpMvqEYnGcKgLTe7f/v
         TQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNWpROxWe29p3q9Z0C7EayZeFSHYPnGAzOOI1Q5dO60=;
        b=mDjJPdgSpg2xby2+TwwfqewxZyEBc/Vbd1gKnVuhk6kaOXipWOli1yCibJsmWVrUEG
         yp8/JpydusjgUdz+/6XhDIEG9ygczPBeyh0TigZhZ+zIYZkPbxQgGSGgLRuKLlz8PUnh
         d0mlvheJemGBq+1Ijb88rJCdfVEJZUdMDpB3nUrNwb4bxzokYlYGkTTZx8Ye0m9/lhdw
         96rcN1ZLvpTFfU6tuMsdLneF/iSNcDnlYomOovrQbEwa5ep3nduEt7OsQgtphQTSJW4J
         5InHZXREExzswP+UpvWhwgRT1q0+FOcSbdbrfgmahlCYBtcQTCY6BsEjgkg9NQeP+ezT
         8geg==
X-Gm-Message-State: ABuFfojhdITKJv5yjW4rx08SC7lCGa21ApBOcXAemVLlyR4PMtGOfmhX
        fA49MzO8cwoGxi4/SiuounxByQ==
X-Google-Smtp-Source: ACcGV61/gojIdvvzHDzvUTdyMtxpxI0Z6zYztzNWOrVvQAIxG8+1dnJmikDaYNi0Sb+sGt7Uho0R0w==
X-Received: by 2002:a1c:890:: with SMTP id 138-v6mr8618552wmi.128.1540043437280;
        Sat, 20 Oct 2018 06:50:37 -0700 (PDT)
Received: from viisi.sifive.com ([37.152.39.96])
        by smtp.gmail.com with ESMTPSA id o4-v6sm16906615wrj.45.2018.10.20.06.50.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 06:50:36 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Wesley Terpstra <wesley@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Megan Wachs <megan@sifive.com>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 1/3] clk: analogbits: add Wide-Range PLL library
Date:   Sat, 20 Oct 2018 06:50:22 -0700
Message-Id: <20181020135024.28573-2-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181020135024.28573-1-paul.walmsley@sifive.com>
References: <20181020135024.28573-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common library code for the Analog Bits Wide-Range PLL (WRPLL) as
implemented in TSMC CLN28HPC.

There is no bus interface or register target associated with this PLL.
This library is intended to be used by drivers for IP blocks that
expose registers connected to the PLL configuration and status
signals.

Based on code originally written by Wesley Terpstra
<wesley@sifive.com>:
https://github.com/riscv/riscv-linux/commit/999529edf517ed75b56659d456d221b2ee56bb60

Cc: Wesley Terpstra <wesley@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Megan Wachs <megan@sifive.com>                                                                                                                    Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 MAINTAINERS                                   |   6 +
 drivers/clk/Kconfig                           |   1 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/analogbits/Kconfig                |   3 +
 drivers/clk/analogbits/Makefile               |   2 +
 drivers/clk/analogbits/wrpll-cln28hpc.c       | 387 ++++++++++++++++++
 include/linux/clk/analogbits-wrpll-cln28hpc.h |  99 +++++
 7 files changed, 499 insertions(+)
 create mode 100644 drivers/clk/analogbits/Kconfig
 create mode 100644 drivers/clk/analogbits/Makefile
 create mode 100644 drivers/clk/analogbits/wrpll-cln28hpc.c
 create mode 100644 include/linux/clk/analogbits-wrpll-cln28hpc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 48a65c3a4189..02c7b2b72a6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -911,6 +911,12 @@ F:	drivers/iio/adc/ltc2497*
 X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 
+ANALOGBITS PLL LIBRARIES
+M:	Paul Walmsley <paul.walmsley@sifive.com>
+S:	Supported
+F:	drivers/clk/analogbits/*
+F:	include/linux/clk/analogbits*
+
 ANDES ARCHITECTURE
 M:	Greentime Hu <green.hu@gmail.com>
 M:	Vincent Chen <deanbo422@gmail.com>
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 292056bbb30e..a34ccfcb54ac 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -284,6 +284,7 @@ config COMMON_CLK_STM32H7
 	  Support for stm32h7 SoC family clocks
 
 source "drivers/clk/actions/Kconfig"
+source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
 source "drivers/clk/imgtec/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index a84c5573cabe..d59c11ddfc5e 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 
 # please keep this section sorted lexicographically by directory path name
 obj-y					+= actions/
+obj-y					+= analogbits/
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
 obj-$(CONFIG_ARC_PLAT_AXS10X)		+= axs10x/
diff --git a/drivers/clk/analogbits/Kconfig b/drivers/clk/analogbits/Kconfig
new file mode 100644
index 000000000000..5ccf7902f6e2
--- /dev/null
+++ b/drivers/clk/analogbits/Kconfig
@@ -0,0 +1,3 @@
+config CLK_ANALOGBITS_WRPLL_CLN28HPC
+	bool
+
diff --git a/drivers/clk/analogbits/Makefile b/drivers/clk/analogbits/Makefile
new file mode 100644
index 000000000000..d3c102c8b4e0
--- /dev/null
+++ b/drivers/clk/analogbits/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_CLK_ANALOGBITS_WRPLL_CLN28HPC)	+= wrpll-cln28hpc.o
+
diff --git a/drivers/clk/analogbits/wrpll-cln28hpc.c b/drivers/clk/analogbits/wrpll-cln28hpc.c
new file mode 100644
index 000000000000..ebdef859cbf5
--- /dev/null
+++ b/drivers/clk/analogbits/wrpll-cln28hpc.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * This library supports configuration parsing and reprogramming of
+ * the CLN28HPC variant of the Analog Bits Wide Range PLL.  The
+ * intention is for this library to be reusable for any device that
+ * integrates this PLL; thus the register structure and programming
+ * details are expected to be provided by a separate IP block driver.
+ *
+ * The bulk of this code is primarily useful for clock configurations
+ * that must operate at arbitrary rates, as opposed to clock configurations
+ * that are restricted by software or manufacturer guidance to a small,
+ * pre-determined set of performance points.
+ *
+ * References:
+ * - Analog Bits "Wide Range PLL Datasheet", version 2015.10.01
+ * - SiFive FU540-C000 Manual v1p0, Chapter 7 "Clocking and Reset"
+ */
+
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/clk/analogbits-wrpll-cln28hpc.h>
+
+/* MIN_INPUT_FREQ: minimum input clock frequency, in Hz (Fref_min) */
+#define MIN_INPUT_FREQ			7000000
+
+/* MAX_INPUT_FREQ: maximum input clock frequency, in Hz (Fref_max) */
+#define MAX_INPUT_FREQ			600000000
+
+/* MIN_POST_DIVIDE_REF_FREQ: minimum post-divider reference frequency, in Hz */
+#define MIN_POST_DIVR_FREQ		7000000
+
+/* MAX_POST_DIVIDE_REF_FREQ: maximum post-divider reference frequency, in Hz */
+#define MAX_POST_DIVR_FREQ		200000000
+
+/* MIN_VCO_FREQ: minimum VCO frequency, in Hz (Fvco_min) */
+#define MIN_VCO_FREQ			2400000000UL
+
+/* MAX_VCO_FREQ: maximum VCO frequency, in Hz (Fvco_max) */
+#define MAX_VCO_FREQ			4800000000ULL
+
+/* MAX_DIVQ_DIVISOR: maximum output divisor.  Selected by DIVQ = 6 */
+#define MAX_DIVQ_DIVISOR		64
+
+/* MAX_DIVR_DIVISOR: maximum reference divisor.  Selected by DIVR = 63 */
+#define MAX_DIVR_DIVISOR		64
+
+/* MAX_LOCK_US: maximum PLL lock time, in microseconds (tLOCK_max) */
+#define MAX_LOCK_US			70
+
+/*
+ * ROUND_SHIFT: number of bits to shift to avoid precision loss in the rounding
+ *              algorithm
+ */
+#define ROUND_SHIFT			20
+
+/*
+ * Private functions
+ */
+
+/**
+ * __wrpll_calc_filter_range() - determine PLL loop filter bandwidth
+ * @post_divr_freq: input clock rate after the R divider
+ *
+ * Select the value to be presented to the PLL RANGE input signals, based
+ * on the input clock frequency after the post-R-divider @post_divr_freq.
+ * This code follows the recommendations in the PLL datasheet for filter
+ * range selection.
+ *
+ * Return: The RANGE value to be presented to the PLL configuration inputs,
+ *         or -1 upon error.
+ */
+static int __wrpll_calc_filter_range(unsigned long post_divr_freq)
+{
+	u8 range;
+
+	if (post_divr_freq < MIN_POST_DIVR_FREQ ||
+	    post_divr_freq > MAX_POST_DIVR_FREQ) {
+		WARN(1, "%s: post-divider reference freq out of range: %lu",
+		     __func__, post_divr_freq);
+		return -1;
+	}
+
+	if (post_divr_freq < 11000000)
+		range = 1;
+	else if (post_divr_freq < 18000000)
+		range = 2;
+	else if (post_divr_freq < 30000000)
+		range = 3;
+	else if (post_divr_freq < 50000000)
+		range = 4;
+	else if (post_divr_freq < 80000000)
+		range = 5;
+	else if (post_divr_freq < 130000000)
+		range = 6;
+	else
+		range = 7;
+
+	return range;
+}
+
+/**
+ * __wrpll_calc_fbdiv() - return feedback fixed divide value
+ * @c: ptr to a struct analogbits_wrpll_cfg record to read from
+ *
+ * The internal feedback path includes a fixed by-two divider; the
+ * external feedback path does not.  Return the appropriate divider
+ * value (2 or 1) depending on whether internal or external feedback
+ * is enabled.  This code doesn't test for invalid configurations
+ * (e.g. both or neither of WRPLL_FLAGS_*_FEEDBACK are set); it relies
+ * on the caller to do so.
+ *
+ * Context: Any context.  Caller must protect the memory pointed to by
+ *          @c from simultaneous modification.
+ *
+ * Return: 2 if internal feedback is enabled or 1 if external feedback
+ *         is enabled.
+ */
+static u8 __wrpll_calc_fbdiv(struct analogbits_wrpll_cfg *c)
+{
+	return (c->flags & WRPLL_FLAGS_INT_FEEDBACK_MASK) ? 2 : 1;
+}
+
+/**
+ * __wrpll_calc_divq() - determine DIVQ based on target PLL output clock rate
+ * @target_rate: target PLL output clock rate
+ * @vco_rate: pointer to a u64 to store the computed VCO rate into
+ *
+ * Determine a reasonable value for the PLL Q post-divider, based on the
+ * target output rate @target_rate for the PLL.  Along with returning the
+ * computed Q divider value as the return value, this function stores the
+ * desired target VCO rate into the variable pointed to by @vco_rate.
+ *
+ * Context: Any context.  Caller must protect the memory pointed to by
+ *          @vco_rate from simultaneous access or modification.
+ *
+ * Return: a positive integer DIVQ value to be programmed into the hardware
+ *         upon success, or 0 upon error (since 0 is an invalid DIVQ value)
+ */
+static u8 __wrpll_calc_divq(u32 target_rate, u64 *vco_rate)
+{
+	u64 s;
+	u8 divq = 0;
+
+	if (!vco_rate) {
+		WARN_ON(1);
+		goto wcd_out;
+	}
+
+	s = div_u64(MAX_VCO_FREQ, target_rate);
+	if (s <= 1) {
+		divq = 1;
+		*vco_rate = MAX_VCO_FREQ;
+	} else if (s > MAX_DIVQ_DIVISOR) {
+		divq = ilog2(MAX_DIVQ_DIVISOR);
+		*vco_rate = MIN_VCO_FREQ;
+	} else {
+		divq = ilog2(s);
+		*vco_rate = target_rate << divq;
+	}
+
+wcd_out:
+	return divq;
+}
+
+/**
+ * __wrpll_update_parent_rate() - update PLL data when parent rate changes
+ * @c: ptr to a struct analogbits_wrpll_cfg record to write PLL data to
+ * @parent_rate: PLL input refclk rate (pre-R-divider)
+ *
+ * Pre-compute some data used by the PLL configuration algorithm when
+ * the PLL's reference clock rate changes.  The intention is to avoid
+ * computation when the parent rate remains constant - expected to be
+ * the common case.
+ *
+ * Returns: 0 upon success or -1 if the reference clock rate is out of range.
+ */
+static int __wrpll_update_parent_rate(struct analogbits_wrpll_cfg *c,
+				      unsigned long parent_rate)
+{
+	u8 max_r_for_parent;
+
+	if (parent_rate > MAX_INPUT_FREQ || parent_rate < MIN_POST_DIVR_FREQ)
+		return -1;
+
+	c->_parent_rate = parent_rate;
+	max_r_for_parent = div_u64(parent_rate, MIN_POST_DIVR_FREQ);
+	c->_max_r = min_t(u8, MAX_DIVR_DIVISOR, max_r_for_parent);
+
+	/* Round up */
+	c->_init_r = div_u64(parent_rate + MAX_POST_DIVR_FREQ - 1,
+			     MAX_POST_DIVR_FREQ);
+
+	return 0;
+}
+
+/*
+ * Public functions
+ */
+
+/**
+ * analogbits_wrpll_configure() - compute PLL configuration for a target rate
+ * @c: ptr to a struct analogbits_wrpll_cfg record to write into
+ * @target_rate: target PLL output clock rate (post-Q-divider)
+ * @parent_rate: PLL input refclk rate (pre-R-divider)
+ *
+ * Given a pointer to a PLL context @c, a desired PLL target output
+ * rate @target_rate, and a reference clock input rate @parent_rate,
+ * compute the appropriate PLL signal configuration values.  PLL
+ * reprogramming is not glitchless, so the caller should switch any
+ * downstream logic to a different clock source or clock-gate it
+ * before presenting these values to the PLL configuration signals.
+ *
+ * The caller must pass this function a pre-initialized struct
+ * analogbits_wrpll_cfg record: either initialized to zero (with the
+ * exception of the .name and .flags fields) or read from the PLL.
+ *
+ * Context: Any context.  Caller must protect the memory pointed to by @c
+ *          from simultaneous access or modification.
+ *
+ * Return: 0 upon success; anything else upon failure.
+ */
+int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg *c,
+					u32 target_rate,
+					unsigned long parent_rate)
+{
+	unsigned long ratio;
+	u64 target_vco_rate, delta, best_delta, f_pre_div, vco, vco_pre;
+	u32 best_f, f, post_divr_freq, fbcfg;
+	u8 fbdiv, divq, best_r, r;
+
+	if (!c)
+		return -1;
+
+	if (c->flags == 0) {
+		WARN(1, "%s called with uninitialized PLL config", __func__);
+		return -1;
+	}
+
+	fbcfg = WRPLL_FLAGS_INT_FEEDBACK_MASK | WRPLL_FLAGS_EXT_FEEDBACK_MASK;
+	if ((c->flags & fbcfg) == fbcfg) {
+		WARN(1, "%s called with invalid PLL config", __func__);
+		return -1;
+	}
+
+	if (c->flags == WRPLL_FLAGS_EXT_FEEDBACK_MASK) {
+		WARN(1, "%s: external feedback mode not currently supported",
+		     __func__);
+		return -1;
+	}
+
+	/* Initialize rounding data if it hasn't been initialized already */
+	if (parent_rate != c->_parent_rate) {
+		if (__wrpll_update_parent_rate(c, parent_rate)) {
+			pr_err("%s: PLL input rate is out of range\n",
+			       __func__);
+			return -1;
+		}
+	}
+
+	c->flags &= ~WRPLL_FLAGS_RESET_MASK;
+
+	/* Put the PLL into bypass if the user requests the parent clock rate */
+	if (target_rate == parent_rate) {
+		c->flags |= WRPLL_FLAGS_BYPASS_MASK;
+		return 0;
+	}
+	c->flags &= ~WRPLL_FLAGS_BYPASS_MASK;
+
+	/* Calculate the Q shift and target VCO rate */
+	divq = __wrpll_calc_divq(target_rate, &target_vco_rate);
+	if (divq == 0)
+		return -1;
+	c->divq = divq;
+
+	/* Precalculate the pre-Q divider target ratio */
+	ratio = div64_u64((target_vco_rate << ROUND_SHIFT), parent_rate);
+
+	fbdiv = __wrpll_calc_fbdiv(c);
+	best_r = 0;
+	best_f = 0;
+	best_delta = MAX_VCO_FREQ;
+
+	/*
+	 * Consider all values for R which land within
+	 * [MIN_POST_DIVR_FREQ, MAX_POST_DIVR_FREQ]; prefer smaller R
+	 */
+	for (r = c->_init_r; r <= c->_max_r; ++r) {
+		/* What is the best F we can pick in this case? */
+		f_pre_div = ratio * r;
+		f = (f_pre_div + (1 << ROUND_SHIFT)) >> ROUND_SHIFT;
+		f >>= (fbdiv - 1);
+
+		post_divr_freq = div_u64(parent_rate, r);
+		vco_pre = fbdiv * post_divr_freq;
+		vco = vco_pre * f;
+
+		/* Ensure rounding didn't take us out of range */
+		if (vco > target_vco_rate) {
+			--f;
+			vco = vco_pre * f;
+		} else if (vco < MIN_VCO_FREQ) {
+			++f;
+			vco = vco_pre * f;
+		}
+
+		delta = abs(target_rate - vco);
+		if (delta < best_delta) {
+			best_delta = delta;
+			best_r = r;
+			best_f = f;
+		}
+	}
+
+	c->divr = best_r - 1;
+	c->divf = best_f - 1;
+
+	post_divr_freq = div_u64(parent_rate, best_r);
+
+	/* Pick the best PLL jitter filter */
+	c->range = __wrpll_calc_filter_range(post_divr_freq);
+
+	return 0;
+}
+
+/**
+ * analogbits_wrpll_calc_output_rate() - calculate the PLL's target output rate
+ * @c: ptr to a struct analogbits_wrpll_cfg record to read from
+ * @parent_rate: PLL refclk rate
+ *
+ * Given a pointer to the PLL's current input configuration @c and the
+ * PLL's input reference clock rate @parent_rate (before the R
+ * pre-divider), calculate the PLL's output clock rate (after the Q
+ * post-divider)
+ *
+ * Context: Any context.  Caller must protect the memory pointed to by @c
+ *          from simultaneous modification.
+ *
+ * Return: the PLL's output clock rate, in Hz.
+ */
+unsigned long analogbits_wrpll_calc_output_rate(struct analogbits_wrpll_cfg *c,
+						unsigned long parent_rate)
+{
+	u8 fbdiv;
+	u64 n;
+
+	WARN(c->flags & WRPLL_FLAGS_EXT_FEEDBACK_MASK,
+	     "external feedback mode not yet supported");
+
+	fbdiv = __wrpll_calc_fbdiv(c);
+	n = parent_rate * fbdiv * (c->divf + 1);
+	n = div_u64(n, (c->divr + 1));
+	n >>= c->divq;
+
+	return n;
+}
+
+/**
+ * analogbits_wrpll_calc_max_lock_us() - return the time for the PLL to lock
+ * @c: ptr to a struct analogbits_wrpll_cfg record to read from
+ *
+ * Return the minimum amount of time (in microseconds) that the caller
+ * must wait after reprogramming the PLL to ensure that it is locked
+ * to the input frequency and stable.  This is likely to depend on the DIVR
+ * value; this is under discussion with the manufacturer.
+ *
+ * Return: the minimum amount of time the caller must wait for the PLL
+ *         to lock (in microseconds)
+ */
+unsigned int analogbits_wrpll_calc_max_lock_us(struct analogbits_wrpll_cfg *c)
+{
+	return MAX_LOCK_US;
+}
diff --git a/include/linux/clk/analogbits-wrpll-cln28hpc.h b/include/linux/clk/analogbits-wrpll-cln28hpc.h
new file mode 100644
index 000000000000..cc4268f16067
--- /dev/null
+++ b/include/linux/clk/analogbits-wrpll-cln28hpc.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_CLK_ANALOGBITS_WRPLL_CLN28HPC_H
+#define __LINUX_CLK_ANALOGBITS_WRPLL_CLN28HPC_H
+
+#include <linux/types.h>
+
+/* DIVQ_VALUES: number of valid DIVQ values */
+#define DIVQ_VALUES				6
+
+/*
+ * Bit definitions for struct analogbits_wrpll_cfg.flags
+ *
+ * WRPLL_FLAGS_BYPASS_FLAG: if set, the PLL is either in bypass, or should be
+ *	programmed to enter bypass
+ * WRPLL_FLAGS_RESET_FLAG: if set, the PLL is in reset
+ * WRPLL_FLAGS_INT_FEEDBACK_FLAG: if set, the PLL is configured for internal
+ *	feedback mode
+ * WRPLL_FLAGS_EXT_FEEDBACK_FLAG: if set, the PLL is configured for external
+ *	feedback mode (not yet supported by this driver)
+ *
+ * The flags WRPLL_FLAGS_INT_FEEDBACK_FLAG and WRPLL_FLAGS_EXT_FEEDBACK_FLAG are
+ * mutually exclusive.  If both bits are set, or both are zero, the struct
+ * analogbits_wrpll_cfg record is uninitialized or corrupt.
+ */
+#define WRPLL_FLAGS_BYPASS_SHIFT		0
+#define WRPLL_FLAGS_BYPASS_MASK		BIT(WRPLL_FLAGS_BYPASS_SHIFT)
+#define WRPLL_FLAGS_RESET_SHIFT		1
+#define WRPLL_FLAGS_RESET_MASK		BIT(WRPLL_FLAGS_RESET_SHIFT)
+#define WRPLL_FLAGS_INT_FEEDBACK_SHIFT	2
+#define WRPLL_FLAGS_INT_FEEDBACK_MASK	BIT(WRPLL_FLAGS_INT_FEEDBACK_SHIFT)
+#define WRPLL_FLAGS_EXT_FEEDBACK_SHIFT	3
+#define WRPLL_FLAGS_EXT_FEEDBACK_MASK	BIT(WRPLL_FLAGS_EXT_FEEDBACK_SHIFT)
+
+/**
+ * struct analogbits_wrpll_cfg - WRPLL configuration values
+ * @divr: reference divider value (6 bits), as presented to the PLL signals.
+ * @divf: feedback divider value (9 bits), as presented to the PLL signals.
+ * @divq: output divider value (3 bits), as presented to the PLL signals.
+ * @flags: PLL configuration flags.  See above for more information.
+ * @range: PLL loop filter range.  See below for more information.
+ * @_output_rate_cache: cached output rates, swept across DIVQ.
+ * @_parent_rate: PLL refclk rate for which values are valid
+ * @_max_r: maximum possible R divider value, given @parent_rate
+ * @_init_r: initial R divider value to start the search from
+ *
+ * @divr, @divq, @divq, @range represent what the PLL expects to see
+ * on its input signals.  Thus @divr and @divf are the actual divisors
+ * minus one.  @divq is a power-of-two divider; for example, 1 =
+ * divide-by-2 and 6 = divide-by-64.  0 is an invalid @divq value.
+ *
+ * When initially passing a struct analogbits_wrpll_cfg record, the
+ * record should be zero-initialized with the exception of the @flags
+ * field.  The only flag bits that need to be set are either
+ * WRPLL_FLAGS_INT_FEEDBACK or WRPLL_FLAGS_EXT_FEEDBACK.
+ *
+ * Field names beginning with an underscore should be considered
+ * private to the wrpll-cln28hpc.c code.
+ */
+struct analogbits_wrpll_cfg {
+	u8 divr;
+	u8 divq;
+	u8 range;
+	u8 flags;
+	u16 divf;
+	u32 _output_rate_cache[DIVQ_VALUES];
+	unsigned long _parent_rate;
+	u8 _max_r;
+	u8 _init_r;
+};
+
+/*
+ * Function prototypes
+ */
+
+int analogbits_wrpll_configure_for_rate(struct analogbits_wrpll_cfg *c,
+					u32 target_rate,
+					unsigned long parent_rate);
+
+unsigned int analogbits_wrpll_calc_max_lock_us(struct analogbits_wrpll_cfg *c);
+
+unsigned long analogbits_wrpll_calc_output_rate(struct analogbits_wrpll_cfg *c,
+						unsigned long parent_rate);
+
+#endif /* __LINUX_CLK_ANALOGBITS_WRPLL_CLN28HPC_H */
-- 
2.19.1

