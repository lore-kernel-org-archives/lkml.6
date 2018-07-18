Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F05ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D022086D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 16:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D022086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbeGRRgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:36:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48054 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731327AbeGRRgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:36:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60583ADEC;
        Wed, 18 Jul 2018 16:57:13 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Noah Massey <noah.massey@gmail.com>
Subject: [PATCH v4 3/3] lib/test_crc: Add test cases for crc calculation
Date:   Thu, 19 Jul 2018 00:55:45 +0800
Message-Id: <20180718165545.1622-4-colyli@suse.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718165545.1622-1-colyli@suse.de>
References: <20180718165545.1622-1-colyli@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a kernel module to test the consistency of multiple crc
calculation in Linux kernel. It is enabled with CONFIG_TEST_CRC enabled.

The test results are printed into kernel message, which look like,

test_crc: crc64_be: FAILED (0x03d4d0d85685d9a1, expected 0x3d4d0d85685d9a1f)

kernel 0day system has framework to check kernel message, then the above
result can be handled by 0day system. If crc calculation inconsistency
happens, it can be detected quite soon.

lib/test_crc.c is a testing frame work for many crc consistency
testings. For now, there is only one test caes for crc64_be().

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Noah Massey <noah.massey@gmail.com>
---
Changelog:
v4: Improve error statistic and failure message display by suggestion
    from Andy Shevchenko and Noah Massey.
    Fixes for review commennts of v3
v3: Add test cases passed/failed statistic
    More fixes for review comments of v2
v2: Fixes for review comments of v1
v1: Initial version.

 lib/Kconfig.debug | 10 +++++
 lib/Makefile      |  1 +
 lib/test_crc.c    | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+)
 create mode 100644 lib/test_crc.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8838d1158d19..a9c1de0c2a7d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1911,6 +1911,16 @@ config TEST_SYSCTL
 
 	  If unsure, say N.
 
+config TEST_CRC
+	tristate "CRC calculation test driver"
+	depends on CRC64
+	help
+	  This builds the "test_crc" module. This driver enables to test the
+	  CRC calculation consistency to make sure new modification does not
+	  break existing checksum calculation.
+
+	  if unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 40c215181687..224d047d026a 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_FIND_BIT_BENCHMARK) += find_bit_benchmark.o
 obj-$(CONFIG_TEST_BPF) += test_bpf.o
 obj-$(CONFIG_TEST_FIRMWARE) += test_firmware.o
 obj-$(CONFIG_TEST_SYSCTL) += test_sysctl.o
+obj-$(CONFIG_TEST_CRC) += test_crc.o
 obj-$(CONFIG_TEST_HASH) += test_hash.o test_siphash.o
 obj-$(CONFIG_TEST_KASAN) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
diff --git a/lib/test_crc.c b/lib/test_crc.c
new file mode 100644
index 000000000000..324e8ad419d7
--- /dev/null
+++ b/lib/test_crc.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * CRC test driver
+ *
+ * Copyright (C) 2018 Coly Li <colyli@suse.de>
+ *
+ * This module provides an simple framework to check the consistency of
+ * Linux kernel CRC calculation routines in lib/crc*.c. This driver
+ * requires CONFIG_CRC* items to be enabled if the associated routines are
+ * tested here. The test results will be printed to kernel message
+ * when this test driver is loaded.
+ *
+ * Current test routines are,
+ * - crc64_be()
+ */
+
+#include <linux/module.h>
+#include <linux/crc64.h>
+
+struct crc_test_record {
+	char	*name;
+	u64	data[4];
+	u64	initval;
+	u64	expval;
+	void	(*handler)(struct crc_test_record *rec);
+};
+
+int failed_tests;
+int total_tests;
+
+static void chk_and_msg(const char *name, u64 crc, u64 expval)
+{
+	total_tests++;
+	if (crc == expval)
+		return;
+
+	pr_err("test_crc: %s: FAILED:(0x%016llx, expected 0x%016llx)\n",
+		name, crc, expval);
+	failed_tests++;
+}
+
+/* Add your crc test cases here */
+static void test_crc64_be(struct crc_test_record *rec)
+{
+	u64 crc;
+
+	crc = crc64_be(rec->initval, rec->data, sizeof(rec->data));
+	chk_and_msg(rec->name, crc, rec->expval);
+}
+
+/*
+ * Set up your crc test initial data here.
+ * Do not change the existing items, they are hard coded with
+ * pre-calculated values.
+ */
+static struct crc_test_record test_data[] = {
+	{ .name		= "crc64_be",
+	  .data		= { 0x42F0E1EBA9EA3693, 0x85E1C3D753D46D26,
+			    0xC711223CFA3E5BB5, 0x493366450E42ECDF },
+	  .initval	= 0x61C8864680B583EB,
+	  .expval	= 0xb2c863673f4292bf,
+	  .handler	= test_crc64_be,
+	},
+	{}
+};
+
+static int __init test_crc_init(void)
+{
+	int i;
+
+	failed_tests = 0;
+	total_tests = 0;
+
+	pr_info("Kernel CRC consistency testing:\n");
+	for (i = 0; test_data[i].name; i++)
+		test_data[i].handler(&test_data[i]);
+
+	if (failed_tests == 0)
+		pr_info("test_crc: all %d tests passed\n", i);
+	else
+		pr_err("test_crc: %d cases tested, %d passed, %d failed\n",
+		       total_tests, total_tests - failed_tests, failed_tests);
+
+	return (failed_tests == 0) ? 0 : -EINVAL;
+}
+late_initcall(test_crc_init);
+
+static void __exit test_crc_exit(void) { }
+module_exit(test_crc_exit);
+
+MODULE_DESCRIPTION("CRC consistency testing driver");
+MODULE_AUTHOR("Coly Li <colyli@suse.de>");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

