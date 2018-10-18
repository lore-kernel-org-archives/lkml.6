Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0858EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20632145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20632145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJRO0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:26:08 -0400
Received: from alexa-out-tai-02.qualcomm.com ([103.229.16.227]:19987 "EHLO
        alexa-out-tai-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727351AbeJRO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:26:07 -0400
X-Greylist: delayed 527 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Oct 2018 10:26:05 EDT
X-IronPort-AV: E=Sophos;i="5.54,395,1534780800"; 
   d="scan'208";a="1369258"
Received: from ironmsg01-tai.qualcomm.com ([10.249.140.6])
  by alexa-out-tai-02.qualcomm.com with ESMTP; 18 Oct 2018 14:16:51 +0800
X-IronPort-AV: E=McAfee;i="5900,7806,9049"; a="17679162"
Received: from c-fan-gv.ap.qualcomm.com (HELO c-fan-gv) ([10.231.253.105])
  by ironmsg01-tai.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Oct 2018 14:16:50 +0800
From:   Teng Fei Fan <tengfei@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, will.deacon@arm.com,
        linux-arm-msm@vger.kernel.org, tengfei@codeaurora.org,
        Russell King <linux@arm.linux.org.uk>
Subject: [PATCH] arm: kernel: add support for detecting armv8 cpu cache information
Date:   Thu, 18 Oct 2018 14:16:47 +0800
Message-Id: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for cacheinfo on 32bit ARMv8 platform.
Add support for detecting cpu cache information cpu cache information
via sysfs for 32bit armv8 platform. And export to sysfs then userspace
can get from /sys/devices/system/cpu/cpuX/cache.

Signed-off-by: Teng Fei Fan <tengfei@codeaurora.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/cachetype.h |  38 ++++++++++++
 arch/arm/kernel/Makefile         |   3 +-
 arch/arm/kernel/cacheinfo.c      | 128 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/kernel/cacheinfo.c

diff --git a/arch/arm/include/asm/cachetype.h b/arch/arm/include/asm/cachetype.h
index 01509ae..f639c64 100644
--- a/arch/arm/include/asm/cachetype.h
+++ b/arch/arm/include/asm/cachetype.h
@@ -1,6 +1,31 @@
 #ifndef __ASM_ARM_CACHETYPE_H
 #define __ASM_ARM_CACHETYPE_H
 
+/*
+ * NumSets, bits[27:13] - (Number of sets in cache) - 1
+ * Associativity, bits[12:3] - (Associativity of cache) - 1
+ * LineSize, bits[2:0] - (Log2(Number of words in cache line)) - 2
+ */
+#define CCSIDR_EL1_WRITE_THROUGH	BIT(31)
+#define CCSIDR_EL1_WRITE_BACK		BIT(30)
+#define CCSIDR_EL1_READ_ALLOCATE	BIT(29)
+#define CCSIDR_EL1_WRITE_ALLOCATE	BIT(28)
+#define CCSIDR_EL1_LINESIZE_MASK	0x7
+#define CCSIDR_EL1_LINESIZE(x)		((x) & CCSIDR_EL1_LINESIZE_MASK)
+#define CCSIDR_EL1_ASSOCIATIVITY_SHIFT	3
+#define CCSIDR_EL1_ASSOCIATIVITY_MASK	0x3ff
+#define CCSIDR_EL1_ASSOCIATIVITY(x) \
+	(((x) >> CCSIDR_EL1_ASSOCIATIVITY_SHIFT) \
+	& CCSIDR_EL1_ASSOCIATIVITY_MASK)
+#define CCSIDR_EL1_NUMSETS_SHIFT	13
+#define CCSIDR_EL1_NUMSETS_MASK		0x7fff
+#define CCSIDR_EL1_NUMSETS(x) \
+	(((x) >> CCSIDR_EL1_NUMSETS_SHIFT) & CCSIDR_EL1_NUMSETS_MASK)
+
+#define CACHE_LINESIZE(x)	(16 << CCSIDR_EL1_LINESIZE(x))
+#define CACHE_NUMSETS(x)	(CCSIDR_EL1_NUMSETS(x) + 1)
+#define CACHE_ASSOCIATIVITY(x)	(CCSIDR_EL1_ASSOCIATIVITY(x) + 1)
+
 #define CACHEID_VIVT			(1 << 0)
 #define CACHEID_VIPT_NONALIASING	(1 << 1)
 #define CACHEID_VIPT_ALIASING		(1 << 2)
@@ -80,6 +105,14 @@ static inline unsigned int read_ccsidr(void)
 	asm volatile("mrc p15, 1, %0, c0, c0, 0" : "=r" (val));
 	return val;
 }
+
+static inline unsigned int read_clidr(void)
+{
+	unsigned int val;
+
+	asm volatile("mrc	p15, 1, %0, c0, c0, 1" : "=r" (val));
+	return val;
+}
 #else /* CONFIG_CPU_V7M */
 #include <linux/io.h>
 #include "asm/v7m.h"
@@ -93,6 +126,11 @@ static inline unsigned int read_ccsidr(void)
 {
 	return readl(BASEADDR_V7M_SCB + V7M_SCB_CCSIDR);
 }
+
+static inline unsigned int read_clidr(void)
+{
+	return readl_relaxed(BASEADDR_V7M_SCB + V7M_SCB_CLIDR);
+}
 #endif
 
 #endif
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index ad325a8..3abd6aa 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -18,7 +18,8 @@ CFLAGS_REMOVE_return_address.o = -pg
 obj-y		:= elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o reboot.o return_address.o \
 		   setup.o signal.o sigreturn_codes.o \
-		   stacktrace.o sys_arm.o time.o traps.o
+		   stacktrace.o sys_arm.o time.o traps.o \
+		   cacheinfo.o
 
 obj-$(CONFIG_ATAGS)		+= atags_parse.o
 obj-$(CONFIG_ATAGS_PROC)	+= atags_proc.o
diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
new file mode 100644
index 0000000..2880b34
--- /dev/null
+++ b/arch/arm/kernel/cacheinfo.c
@@ -0,0 +1,128 @@
+/*
+ *  ARM cacheinfo support
+ *
+ *  Copyright (C) 2015 ARM Ltd.
+ *  All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/bitops.h>
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/compiler.h>
+#include <linux/of.h>
+
+#include <asm/cachetype.h>
+#include <asm/processor.h>
+
+#define MAX_CACHE_LEVEL			7	/* Max 7 level supported */
+/* Ctypen, bits[3(n - 1) + 2 : 3(n - 1)], for n = 1 to 7 */
+#define CLIDR_CTYPE_SHIFT(level)	(3 * (level - 1))
+#define CLIDR_CTYPE_MASK(level)		(7 << CLIDR_CTYPE_SHIFT(level))
+#define CLIDR_CTYPE(clidr, level)	\
+	(((clidr) & CLIDR_CTYPE_MASK(level)) >> CLIDR_CTYPE_SHIFT(level))
+
+static inline enum cache_type get_cache_type(int level)
+{
+	unsigned int clidr;
+
+	if (level > MAX_CACHE_LEVEL)
+		return CACHE_TYPE_NOCACHE;
+	clidr = read_clidr();
+
+	return CLIDR_CTYPE(clidr, level);
+}
+
+/*
+ * Cache Size Selection Register(CSSELR) selects which Cache Size ID
+ * Register(CCSIDR) is accessible by specifying the required cache
+ * level and the cache type. We need to ensure that no one else changes
+ * CSSELR by calling this in non-preemtible context
+ */
+static unsigned int __attribute_const__ cache_get_ccsidr(unsigned int csselr)
+{
+	unsigned int ccsidr;
+
+	WARN_ON(preemptible());
+
+	/* Put value into CSSELR */
+	set_csselr(csselr);
+	isb();
+	ccsidr = read_ccsidr();
+
+	return ccsidr;
+}
+
+static void ci_leaf_init(struct cacheinfo *this_leaf,
+			 enum cache_type type, unsigned int level)
+{
+	bool is_icache = type & CACHE_TYPE_INST;
+	unsigned int tmp = cache_get_ccsidr((level - 1) << 1 | is_icache);
+
+	this_leaf->level = level;
+	this_leaf->type = type;
+	this_leaf->coherency_line_size = CACHE_LINESIZE(tmp);
+	this_leaf->number_of_sets = CACHE_NUMSETS(tmp);
+	this_leaf->ways_of_associativity = CACHE_ASSOCIATIVITY(tmp);
+	this_leaf->size = this_leaf->number_of_sets *
+	this_leaf->coherency_line_size * this_leaf->ways_of_associativity;
+	this_leaf->attributes =
+		((tmp & CCSIDR_EL1_WRITE_THROUGH) ? CACHE_WRITE_THROUGH : 0) |
+		((tmp & CCSIDR_EL1_WRITE_BACK) ? CACHE_WRITE_BACK : 0) |
+		((tmp & CCSIDR_EL1_READ_ALLOCATE) ? CACHE_READ_ALLOCATE : 0) |
+		((tmp & CCSIDR_EL1_WRITE_ALLOCATE) ? CACHE_WRITE_ALLOCATE : 0);
+}
+
+static int __init_cache_level(unsigned int cpu)
+{
+	unsigned int ctype, level, leaves;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+
+	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
+		ctype = get_cache_type(level);
+		if (ctype == CACHE_TYPE_NOCACHE) {
+			level--;
+			break;
+		}
+		/* Separate instruction and data caches */
+		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
+	}
+
+	this_cpu_ci->num_levels = level;
+	this_cpu_ci->num_leaves = leaves;
+	return 0;
+}
+
+static int __populate_cache_leaves(unsigned int cpu)
+{
+	unsigned int level, idx;
+	enum cache_type type;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
+
+	for (idx = 0, level = 1; level <= this_cpu_ci->num_levels &&
+	     idx < this_cpu_ci->num_leaves; idx++, level++) {
+		type = get_cache_type(level);
+		if (type == CACHE_TYPE_SEPARATE) {
+			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
+			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
+		} else {
+			ci_leaf_init(this_leaf++, type, level);
+		}
+	}
+	return 0;
+}
+
+DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
+DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

