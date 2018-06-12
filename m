Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B56B6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E9C208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E9C208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754332AbeFLK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:26:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:34367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933508AbeFLKW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:22:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:22:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66321990"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:22:55 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v6 16/29] fpga: dfl: fme: add DFL_FPGA_GET_API_VERSION/CHECK_EXTENSION ioctls support
Date:   Tue, 12 Jun 2018 18:10:30 +0800
Message-Id: <1528798243-2029-17-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DFL_FPGA_GET_API_VERSION and DFL_FPGA_CHECK_EXTENSION ioctls are common
ones which need to be supported by all feature devices drivers including
FME and AFU. Userspace application can use these ioctl interfaces to get
the API info and check if specific extension is supported or not in
current driver.

This patch implements above 2 ioctls in FPGA Management Engine (FME)
driver.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v2: switched to GPLv2 license.
v3: rename intel-fpga.h to fpga-dfl.h and rebased.
v4: fix SPDX license issue.
    add Acked-by from Alan and Moritz.
v5: rebase due to DFL framework API naming changes.
    add DFL_ prefix to IOCTL APIs.
v6: rebase and fix copyright time.
---
 Documentation/ioctl/ioctl-number.txt |  1 +
 drivers/fpga/dfl-fme-main.c          | 12 +++++++++
 include/uapi/linux/fpga-dfl.h        | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)
 create mode 100644 include/uapi/linux/fpga-dfl.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index a12488d..4b9afe4 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -322,6 +322,7 @@ Code  Seq#(hex)	Include File		Comments
 0xB3	00	linux/mmc/ioctl.h
 0xB4	00-0F	linux/gpio.h		<mailto:linux-gpio@vger.kernel.org>
 0xB5	00-0F	uapi/linux/rpmsg.h	<mailto:linux-remoteproc@vger.kernel.org>
+0xB6	all	linux/fpga-dfl.h
 0xC0	00-0F	linux/usb/iowarrior.h
 0xCA	00-0F	uapi/misc/cxl.h
 0xCA	10-2F	uapi/misc/ocxl.h
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 77d9ffc..889d669 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -16,6 +16,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fpga-dfl.h>
 
 #include "dfl.h"
 
@@ -116,6 +117,13 @@ static void fme_hdr_uinit(struct platform_device *pdev,
 	},
 };
 
+static long fme_ioctl_check_extension(struct dfl_feature_platform_data *pdata,
+				      unsigned long arg)
+{
+	/* No extension support for now */
+	return 0;
+}
+
 static int fme_open(struct inode *inode, struct file *filp)
 {
 	struct platform_device *fdev = dfl_fpga_inode_to_feature_dev(inode);
@@ -156,6 +164,10 @@ static long fme_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	dev_dbg(&pdev->dev, "%s cmd 0x%x\n", __func__, cmd);
 
 	switch (cmd) {
+	case DFL_FPGA_GET_API_VERSION:
+		return DFL_FPGA_API_VERSION;
+	case DFL_FPGA_CHECK_EXTENSION:
+		return fme_ioctl_check_extension(pdata, arg);
 	default:
 		/*
 		 * Let sub-feature's ioctl function to handle the cmd
diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
new file mode 100644
index 0000000..9ff26cb
--- /dev/null
+++ b/include/uapi/linux/fpga-dfl.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Header File for FPGA DFL User API
+ *
+ * Copyright (C) 2017-2018 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Kang Luwei <luwei.kang@intel.com>
+ *   Zhang Yi <yi.z.zhang@intel.com>
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
+ */
+
+#ifndef _UAPI_LINUX_FPGA_DFL_H
+#define _UAPI_LINUX_FPGA_DFL_H
+
+#define DFL_FPGA_API_VERSION 0
+
+/*
+ * The IOCTL interface for DFL based FPGA is designed for extensibility by
+ * embedding the structure length (argsz) and flags into structures passed
+ * between kernel and userspace. This design referenced the VFIO IOCTL
+ * interface (include/uapi/linux/vfio.h).
+ */
+
+#define DFL_FPGA_MAGIC 0xB6
+
+#define DFL_FPGA_BASE 0
+
+/**
+ * DFL_FPGA_GET_API_VERSION - _IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 0)
+ *
+ * Report the version of the driver API.
+ * Return: Driver API Version.
+ */
+
+#define DFL_FPGA_GET_API_VERSION	_IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 0)
+
+/**
+ * DFL_FPGA_CHECK_EXTENSION - _IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 1)
+ *
+ * Check whether an extension is supported.
+ * Return: 0 if not supported, otherwise the extension is supported.
+ */
+
+#define DFL_FPGA_CHECK_EXTENSION	_IO(DFL_FPGA_MAGIC, DFL_FPGA_BASE + 1)
+
+#endif /* _UAPI_LINUX_FPGA_DFL_H */
-- 
1.8.3.1

