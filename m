Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7087CC6778C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334E3280D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334E3280D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936131AbeF3BGX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:06:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:23619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935851AbeF3BGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317283"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:11 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v7 11/29] fpga: dfl: add dfl_fpga_check_port_id function.
Date:   Sat, 30 Jun 2018 08:53:18 +0800
Message-Id: <1530320016-24712-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds one common function in DFL framework. It uses
port_ops get_id callback to get port id and compare it with given
value. This function could be used as match function of the
dfl_fpga_cdev_find_port function.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v6: reabse and add Acked-by from Alan.
---
 drivers/fpga/dfl.c | 22 ++++++++++++++++++++++
 drivers/fpga/dfl.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 421668a..a9b521b 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -216,6 +216,28 @@ void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops)
 EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
 
 /**
+ * dfl_fpga_check_port_id - check the port id
+ * @pdev: port platform device.
+ * @pport_id: port id to compare.
+ *
+ * Return: 1 if port device matches with given port id, otherwise 0.
+ */
+int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id)
+{
+	struct dfl_fpga_port_ops *port_ops = dfl_fpga_port_ops_get(pdev);
+	int port_id;
+
+	if (!port_ops || !port_ops->get_id)
+		return 0;
+
+	port_id = port_ops->get_id(pdev);
+	dfl_fpga_port_ops_put(port_ops);
+
+	return port_id == *(int *)pport_id;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_check_port_id);
+
+/**
  * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
  * @pdev: feature device.
  */
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 654e0f6..a8b869e 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -151,6 +151,7 @@ struct dfl_fpga_port_ops {
 void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
 struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev);
 void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
+int dfl_fpga_check_port_id(struct platform_device *pdev, void *pport_id);
 
 /**
  * struct dfl_feature_driver - sub feature's driver
-- 
1.8.3.1

