Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CE5E9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3FA208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3FA208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933714AbeFLK1h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:27:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:34367 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933242AbeFLKWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:22:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:22:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66321945"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:22:42 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v6 11/29] fpga: dfl: add dfl_fpga_check_port_id function.
Date:   Tue, 12 Jun 2018 18:10:25 +0800
Message-Id: <1528798243-2029-12-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
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
index 789da5b..d679e64 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -214,6 +214,28 @@ void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops)
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
index 4048110..a03a796 100644
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

