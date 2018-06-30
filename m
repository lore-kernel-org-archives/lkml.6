Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0566FC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C6D280D3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8C6D280D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935998AbeF3BGO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:06:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:23619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934989AbeF3BGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317272"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:07 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v7 10/29] fpga: dfl: add dfl_fpga_port_ops support.
Date:   Sat, 30 Jun 2018 08:53:17 +0800
Message-Id: <1530320016-24712-11-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, other DFL driver modules may need to access some port
operations, e.g. disable / enable port for partial reconfiguration in
FME module. In order to avoid dependency between port and FME modules,
this patch introduces the dfl_fpga_port_ops support in DFL framework.
A global dfl_fpga_port_ops list is added in the DFL framework, and
it allows other DFL modules to use these port operations registered
to this list, even in virtualization case, the port platform device
is turned into VF / guest VM and hidden in host, the registered
port_ops is still usable. It resolves the dependency issues between
modules, but once get port ops API returns a valid port ops, that
means related port driver module has been module_get to prevent from
unexpected unload, and put port ops API must be invoked after use.

These APIs introduced by this patch is listed below:
 * dfl_fpga_port_ops_add
   add one port ops to the global list.

 * dfl_fpga_port_ops_del
   del one port ops from the global list.

 * dfl_fpga_port_ops_get / dfl_fpga_port_ops_put
   get/put the port ops before/after use.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v6: add more comments and improve API naming to dfl_fpga_port_xxx.
    add Acked-by from Alan.
v7: fix kbuild issue and typos.
---
 drivers/fpga/dfl.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/fpga/dfl.h | 21 +++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index e2c72c5..421668a 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -136,6 +136,85 @@ static enum dfl_id_type dfh_id_to_type(u32 id)
 	return DFL_ID_MAX;
 }
 
+/*
+ * introduce a global port_ops list, it allows port drivers to register ops
+ * in such list, then other feature devices (e.g. FME), could use the port
+ * functions even related port platform device is hidden. Below is one example,
+ * in virtualization case of PCIe-based FPGA DFL device, when SRIOV is
+ * enabled, port (and it's AFU) is turned into VF and port platform device
+ * is hidden from system but it's still required to access port to finish FPGA
+ * reconfiguration function in FME.
+ */
+
+static DEFINE_MUTEX(dfl_port_ops_mutex);
+static LIST_HEAD(dfl_port_ops_list);
+
+/**
+ * dfl_fpga_port_ops_get - get matched port ops from the global list
+ * @pdev: platform device to match with associated port ops.
+ * Return: matched port ops on success, NULL otherwise.
+ *
+ * Please note that must dfl_fpga_port_ops_put after use the port_ops.
+ */
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev)
+{
+	struct dfl_fpga_port_ops *ops = NULL;
+
+	mutex_lock(&dfl_port_ops_mutex);
+	if (list_empty(&dfl_port_ops_list))
+		goto done;
+
+	list_for_each_entry(ops, &dfl_port_ops_list, node) {
+		/* match port_ops using the name of platform device */
+		if (!strcmp(pdev->name, ops->name)) {
+			if (!try_module_get(ops->owner))
+				ops = NULL;
+			goto done;
+		}
+	}
+
+	ops = NULL;
+done:
+	mutex_unlock(&dfl_port_ops_mutex);
+	return ops;
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_get);
+
+/**
+ * dfl_fpga_port_ops_put - put port ops
+ * @ops: port ops.
+ */
+void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops)
+{
+	if (ops && ops->owner)
+		module_put(ops->owner);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_put);
+
+/**
+ * dfl_fpga_port_ops_add - add port_ops to global list
+ * @ops: port ops to add.
+ */
+void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops)
+{
+	mutex_lock(&dfl_port_ops_mutex);
+	list_add_tail(&ops->node, &dfl_port_ops_list);
+	mutex_unlock(&dfl_port_ops_mutex);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_add);
+
+/**
+ * dfl_fpga_port_ops_del - remove port_ops from global list
+ * @ops: port ops to del.
+ */
+void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops)
+{
+	mutex_lock(&dfl_port_ops_mutex);
+	list_del(&ops->node);
+	mutex_unlock(&dfl_port_ops_mutex);
+}
+EXPORT_SYMBOL_GPL(dfl_fpga_port_ops_del);
+
 /**
  * dfl_fpga_dev_feature_uinit - uinit for sub features of dfl feature device
  * @pdev: feature device.
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 14d4731..654e0f6 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -130,6 +130,27 @@
 /* Latency tolerance reporting. '1' >= 40us, '0' < 40us.*/
 #define PORT_CTRL_LATENCY	BIT_ULL(2)
 #define PORT_CTRL_SFTRST_ACK	BIT_ULL(4)		/* HW ack for reset */
+/**
+ * struct dfl_fpga_port_ops - port ops
+ *
+ * @name: name of this port ops, to match with port platform device.
+ * @owner: pointer to the module which owns this port ops.
+ * @node: node to link port ops to global list.
+ * @get_id: get port id from hardware.
+ * @enable_set: enable/disable the port.
+ */
+struct dfl_fpga_port_ops {
+	const char *name;
+	struct module *owner;
+	struct list_head node;
+	int (*get_id)(struct platform_device *pdev);
+	int (*enable_set)(struct platform_device *pdev, bool enable);
+};
+
+void dfl_fpga_port_ops_add(struct dfl_fpga_port_ops *ops);
+void dfl_fpga_port_ops_del(struct dfl_fpga_port_ops *ops);
+struct dfl_fpga_port_ops *dfl_fpga_port_ops_get(struct platform_device *pdev);
+void dfl_fpga_port_ops_put(struct dfl_fpga_port_ops *ops);
 
 /**
  * struct dfl_feature_driver - sub feature's driver
-- 
1.8.3.1

