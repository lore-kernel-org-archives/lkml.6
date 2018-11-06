Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C026120869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C026120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbeKFSGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:06:23 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34662 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeKFSGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:06:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68fSmO091941;
        Tue, 6 Nov 2018 02:41:28 -0600
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68fSuE127955
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:41:28 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:41:28 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:41:28 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3k032677;
        Tue, 6 Nov 2018 02:41:24 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 01/13] firmware: ti_sci: Add support to get TISCI handle using of_phandle
Date:   Tue, 6 Nov 2018 14:10:53 +0530
Message-ID: <20181106084105.32483-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

TISCI has been updated to have support for Resource management(likes
interrupts etc..). And there can be multiple device instances of a
resource type in a SoC. So every driver corresponding to a resource type
should get a TISCI handle so that it can make TISCI calls. And each
DT node corresponding to a device should exist under its corresponding
bus node as per the SoC architecture.

But existing apis in TISCI library assumes that all TISCI users are
child nodes of TISCI. Which is not true in the above case. So introduce
(devm_)ti_sci_get_by_phandle() apis that can be used by TISCI users
to get TISCI handle using of phandle property.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- None

 drivers/firmware/ti_sci.c              | 83 ++++++++++++++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h | 17 ++++++
 2 files changed, 100 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 69ed1464175c..f0cafa8a2ee9 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1781,6 +1781,89 @@ const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(devm_ti_sci_get_handle);
 
+/**
+ * ti_sci_get_by_phandle() - Get the TI SCI handle using DT phandle
+ * @np:		device node
+ * @propname:	property name containing phandle on TISCI node
+ *
+ * NOTE: The function does not track individual clients of the framework
+ * and is expected to be maintained by caller of TI SCI protocol library.
+ * ti_sci_put_handle must be balanced with successful ti_sci_get_by_phandle
+ * Return: pointer to handle if successful, else:
+ * -EPROBE_DEFER if the instance is not ready
+ * -ENODEV if the required node handler is missing
+ * -EINVAL if invalid conditions are encountered.
+ */
+const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
+						  const char *property)
+{
+	struct ti_sci_handle *handle = NULL;
+	struct device_node *ti_sci_np;
+	struct ti_sci_info *info;
+	struct list_head *p;
+
+	if (!np) {
+		pr_err("I need a device pointer\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	ti_sci_np = of_parse_phandle(np, property, 0);
+	if (!ti_sci_np)
+		return ERR_PTR(-ENODEV);
+
+	mutex_lock(&ti_sci_list_mutex);
+	list_for_each(p, &ti_sci_list) {
+		info = list_entry(p, struct ti_sci_info, node);
+		if (ti_sci_np == info->dev->of_node) {
+			handle = &info->handle;
+			info->users++;
+			break;
+		}
+	}
+	mutex_unlock(&ti_sci_list_mutex);
+	of_node_put(ti_sci_np);
+
+	if (!handle)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(ti_sci_get_by_phandle);
+
+/**
+ * devm_ti_sci_get_by_phandle() - Managed get handle using phandle
+ * @dev:	Device pointer requesting TISCI handle
+ * @propname:	property name containing phandle on TISCI node
+ *
+ * NOTE: This releases the handle once the device resources are
+ * no longer needed. MUST NOT BE released with ti_sci_put_handle.
+ * The function does not track individual clients of the framework
+ * and is expected to be maintained by caller of TI SCI protocol library.
+ *
+ * Return: 0 if all went fine, else corresponding error.
+ */
+const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
+						       const char *property)
+{
+	const struct ti_sci_handle *handle;
+	const struct ti_sci_handle **ptr;
+
+	ptr = devres_alloc(devm_ti_sci_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+	handle = ti_sci_get_by_phandle(dev_of_node(dev), property);
+
+	if (!IS_ERR(handle)) {
+		*ptr = handle;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return handle;
+}
+EXPORT_SYMBOL_GPL(devm_ti_sci_get_by_phandle);
+
 static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 				void *cmd)
 {
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 18435e5c6364..515587e9d373 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -217,6 +217,10 @@ struct ti_sci_handle {
 const struct ti_sci_handle *ti_sci_get_handle(struct device *dev);
 int ti_sci_put_handle(const struct ti_sci_handle *handle);
 const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev);
+const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
+						  const char *property);
+const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
+						       const char *property);
 
 #else	/* CONFIG_TI_SCI_PROTOCOL */
 
@@ -236,6 +240,19 @@ const struct ti_sci_handle *devm_ti_sci_get_handle(struct device *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+static inline
+const struct ti_sci_handle *ti_sci_get_by_phandle(struct device_node *np,
+						  const char *property)
+{
+	return ERR_PTR(-EINVAL);
+}
+
+static inline
+const struct ti_sci_handle *devm_ti_sci_get_by_phandle(struct device *dev,
+						       const char *property)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_TI_SCI_PROTOCOL */
 
 #endif	/* __TISCI_PROTOCOL_H */
-- 
2.19.1

