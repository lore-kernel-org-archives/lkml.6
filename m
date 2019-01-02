Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2AFC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87643218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbfABHRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:17:45 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:36498 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728880AbfABHRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:17:44 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07551633|-1;CH=green;FP=17056299853541838585|2|1|5|0|-1|-1|-1;HT=e02c03292;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.DgPl9gA_1546413451;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.DgPl9gA_1546413451)
          by smtp.aliyun-inc.com(10.147.41.121);
          Wed, 02 Jan 2019 15:17:39 +0800
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        liaoweixiong <liaoweixiong@allwinnertech.com>
Subject: [RFC v3 2/2] pstore/rom: add sample for pstore_rom
Date:   Wed,  2 Jan 2019 15:17:28 +0800
Message-Id: <1546413448-20538-3-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546413448-20538-1-git-send-email-liaoweixiong@allwinnertech.com>
References: <1546413448-20538-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a sample for pstore_rom, using general ram rather than block device.
According to pstore_rom, the data will be saved to ram buffer if not
register device path and apis for panic. So, it can only used to dump
Oops and some things will not reboot.

Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
---
 fs/pstore/Kconfig  |  9 +++++++++
 fs/pstore/Makefile |  2 ++
 fs/pstore/rombuf.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)
 create mode 100644 fs/pstore/rombuf.c

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index abf0453..426b5ea 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -159,3 +159,12 @@ config PSTORE_ROM
 	help
 	  This enables panic and oops message to be logged to a block dev
 	  where it can be read back at some later point.
+
+config PSTORE_ROMBUF
+	tristate "romoop buffer sample"
+	depends on PSTORE_ROM
+	help
+	  This is a sample for pstore rom, but do NOT have a block dev.
+	  According to pstore_rom, the data will be saved to ram buffer and
+	  dropped when reboot. So, it can only used to dump Oops and some
+	  things will not reboot.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index ea38d6e..21c1226 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -15,3 +15,5 @@ obj-$(CONFIG_PSTORE_RAM)	+= ramoops.o
 
 obj-$(CONFIG_PSTORE_ROM)	+= romoops.o
 romoops-y += romzone.o
+
+obj-$(CONFIG_PSTORE_ROMBUF)	+= rombuf.o
diff --git a/fs/pstore/rombuf.c b/fs/pstore/rombuf.c
new file mode 100644
index 0000000..bb21a85
--- /dev/null
+++ b/fs/pstore/rombuf.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *
+ * rombuf.c: ROM Oops/Panic logger
+ *
+ * Copyright (C) 2019 liaoweixiong <liaoweixiong@gallwinnertech.com>
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
+ */
+#define pr_fmt(fmt) "rombuf: " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pstore_rom.h>
+
+struct romz_info rombuf_info = {
+	.owner = THIS_MODULE,
+	.name = "rombuf",
+	.part_size = 512 * 1024,
+	.dmesg_size = 64 * 1024,
+	.dump_oops = true,
+};
+
+static int __init rombuf_init(void)
+{
+	return romz_register(&rombuf_info);
+}
+module_init(rombuf_init);
+
+static void __exit rombuf_exit(void)
+{
+	romz_unregister(&rombuf_info);
+}
+module_exit(rombuf_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("liaoweixiong <liaoweixiong@allwinnertech.com>");
+MODULE_DESCRIPTION("Sample for Pstore ROM with Oops logger");
-- 
1.9.1

