Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754070AbeDTBSG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 21:18:06 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35728 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbeDTBSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 21:18:03 -0400
X-Google-Smtp-Source: AIpwx4/NRh5pj5WfsAF3o58/We9u73p2UY0+7zlp3OCSFnc0P6VyTuyNRmcZzHpt64M7q4BDIgpssg==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH v3] rpmsg: qcom_smd: Access APCS through mailbox framework
Date: Thu, 19 Apr 2018 18:17:57 -0700
Message-Id: <20180420011757.22389-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to acquire the APCS IPC through the mailbox framework and fall
back to the old syscon based approach, to allow us to move away from
using the syscon.

Reviewed-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Added comment about mbox_send_message() return value.

 .../devicetree/bindings/soc/qcom/qcom,smd.txt      |  8 ++-
 drivers/rpmsg/Kconfig                              |  1 +
 drivers/rpmsg/qcom_smd.c                           | 67 ++++++++++++++++------
 3 files changed, 56 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
index ea1dc75ec9ea..234ae2256501 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd.txt
@@ -22,9 +22,15 @@ The edge is described by the following properties:
 	Definition: should specify the IRQ used by the remote processor to
 		    signal this processor about communication related updates
 
-- qcom,ipc:
+- mboxes:
 	Usage: required
 	Value type: <prop-encoded-array>
+	Definition: reference to the associated doorbell in APCS, as described
+		    in mailbox/mailbox.txt
+
+- qcom,ipc:
+	Usage: required, unless mboxes is specified
+	Value type: <prop-encoded-array>
 	Definition: three entries specifying the outgoing ipc bit used for
 		    signaling the remote processor:
 		    - phandle to a syscon node representing the apcs registers
diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index 0fe6eac46512..2e4fb4ffd562 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -39,6 +39,7 @@ config RPMSG_QCOM_GLINK_SMEM
 
 config RPMSG_QCOM_SMD
 	tristate "Qualcomm Shared Memory Driver (SMD)"
+	depends on MAILBOX
 	depends on QCOM_SMEM
 	select RPMSG
 	help
diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index bc0b30657230..3ff271a44bef 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -14,6 +14,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/mailbox_client.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of_irq.h>
@@ -107,6 +108,8 @@ static const struct {
  * @ipc_regmap:		regmap handle holding the outgoing ipc register
  * @ipc_offset:		offset within @ipc_regmap of the register for ipc
  * @ipc_bit:		bit in the register at @ipc_offset of @ipc_regmap
+ * @mbox_client:	mailbox client handle
+ * @mbox_chan:		apcs ipc mailbox channel handle
  * @channels:		list of all channels detected on this edge
  * @channels_lock:	guard for modifications of @channels
  * @allocated:		array of bitmaps representing already allocated channels
@@ -129,6 +132,9 @@ struct qcom_smd_edge {
 	int ipc_offset;
 	int ipc_bit;
 
+	struct mbox_client mbox_client;
+	struct mbox_chan *mbox_chan;
+
 	struct list_head channels;
 	spinlock_t channels_lock;
 
@@ -366,7 +372,17 @@ static void qcom_smd_signal_channel(struct qcom_smd_channel *channel)
 {
 	struct qcom_smd_edge *edge = channel->edge;
 
-	regmap_write(edge->ipc_regmap, edge->ipc_offset, BIT(edge->ipc_bit));
+	if (edge->mbox_chan) {
+		/*
+		 * We can ignore a failing mbox_send_message() as the only
+		 * possible cause is that the FIFO in the framework is full of
+		 * other writes to the same bit.
+		 */
+		mbox_send_message(edge->mbox_chan, NULL);
+		mbox_client_txdone(edge->mbox_chan, 0);
+	} else {
+		regmap_write(edge->ipc_regmap, edge->ipc_offset, BIT(edge->ipc_bit));
+	}
 }
 
 /*
@@ -1326,27 +1342,37 @@ static int qcom_smd_parse_edge(struct device *dev,
 	key = "qcom,remote-pid";
 	of_property_read_u32(node, key, &edge->remote_pid);
 
-	syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
-	if (!syscon_np) {
-		dev_err(dev, "no qcom,ipc node\n");
-		return -ENODEV;
-	}
+	edge->mbox_client.dev = dev;
+	edge->mbox_client.knows_txdone = true;
+	edge->mbox_chan = mbox_request_channel(&edge->mbox_client, 0);
+	if (IS_ERR(edge->mbox_chan)) {
+		if (PTR_ERR(edge->mbox_chan) != -ENODEV)
+			return PTR_ERR(edge->mbox_chan);
 
-	edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
-	if (IS_ERR(edge->ipc_regmap))
-		return PTR_ERR(edge->ipc_regmap);
+		edge->mbox_chan = NULL;
 
-	key = "qcom,ipc";
-	ret = of_property_read_u32_index(node, key, 1, &edge->ipc_offset);
-	if (ret < 0) {
-		dev_err(dev, "no offset in %s\n", key);
-		return -EINVAL;
-	}
+		syscon_np = of_parse_phandle(node, "qcom,ipc", 0);
+		if (!syscon_np) {
+			dev_err(dev, "no qcom,ipc node\n");
+			return -ENODEV;
+		}
 
-	ret = of_property_read_u32_index(node, key, 2, &edge->ipc_bit);
-	if (ret < 0) {
-		dev_err(dev, "no bit in %s\n", key);
-		return -EINVAL;
+		edge->ipc_regmap = syscon_node_to_regmap(syscon_np);
+		if (IS_ERR(edge->ipc_regmap))
+			return PTR_ERR(edge->ipc_regmap);
+
+		key = "qcom,ipc";
+		ret = of_property_read_u32_index(node, key, 1, &edge->ipc_offset);
+		if (ret < 0) {
+			dev_err(dev, "no offset in %s\n", key);
+			return -EINVAL;
+		}
+
+		ret = of_property_read_u32_index(node, key, 2, &edge->ipc_bit);
+		if (ret < 0) {
+			dev_err(dev, "no bit in %s\n", key);
+			return -EINVAL;
+		}
 	}
 
 	ret = of_property_read_string(node, "label", &edge->name);
@@ -1452,6 +1478,8 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
 	return edge;
 
 unregister_dev:
+	if (!IS_ERR_OR_NULL(edge->mbox_chan))
+		mbox_free_channel(edge->mbox_chan);
 	put_device(&edge->dev);
 	return ERR_PTR(ret);
 }
@@ -1480,6 +1508,7 @@ int qcom_smd_unregister_edge(struct qcom_smd_edge *edge)
 	if (ret)
 		dev_warn(&edge->dev, "can't remove smd device: %d\n", ret);
 
+	mbox_free_channel(edge->mbox_chan);
 	device_unregister(&edge->dev);
 
 	return 0;
-- 
2.16.2
