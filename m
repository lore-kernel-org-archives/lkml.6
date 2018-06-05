Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbeFEG1c (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 02:27:32 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37767 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeFEG05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 02:26:57 -0400
From: Nishanth Menon <nm@ti.com>
To: Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 2/3] firmware: ti_sci: Provide host-id as an optional dt parameter
Date: Tue, 5 Jun 2018 01:26:39 -0500
Message-ID: <20180605062640.3356-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180605062640.3356-1-nm@ti.com>
References: <20180605062640.3356-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instrument's System Control Interface (TISCI) permits the
ability for Operating Systems to running in virtual machines to be
able to independently communicate with the firmware without the need
going through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller.

Provide support as an optional parameter implementation and use the compatible
data as default if one is not provided by device tree.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/firmware/ti_sci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index b74a533ef35b..6b08ee815b24 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -66,14 +66,14 @@ struct ti_sci_xfers_info {
 
 /**
  * struct ti_sci_desc - Description of SoC integration
- * @host_id:		Host identifier representing the compute entity
+ * @default_host_id:	Host identifier representing the compute entity
  * @max_rx_timeout_ms:	Timeout for communication with SoC (in Milliseconds)
  * @max_msgs: Maximum number of messages that can be pending
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
  */
 struct ti_sci_desc {
-	u8 host_id;
+	u8 default_host_id;
 	int max_rx_timeout_ms;
 	int max_msgs;
 	int max_msg_size;
@@ -94,6 +94,7 @@ struct ti_sci_desc {
  * @chan_rx:	Receive mailbox channel
  * @minfo:	Message info
  * @node:	list head
+ * @host_id:	Host ID
  * @users:	Number of users of this instance
  */
 struct ti_sci_info {
@@ -110,6 +111,7 @@ struct ti_sci_info {
 	struct mbox_chan *chan_rx;
 	struct ti_sci_xfers_info minfo;
 	struct list_head node;
+	u8 host_id;
 	/* protected by ti_sci_list_mutex */
 	int users;
 
@@ -370,7 +372,7 @@ static struct ti_sci_xfer *ti_sci_get_one_xfer(struct ti_sci_info *info,
 
 	hdr->seq = xfer_id;
 	hdr->type = msg_type;
-	hdr->host = info->desc->host_id;
+	hdr->host = info->host_id;
 	hdr->flags = msg_flags;
 
 	return xfer;
@@ -1793,7 +1795,7 @@ static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
 
 /* Description for K2G */
 static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
-	.host_id = 2,
+	.default_host_id = 2,
 	/* Conservative duration */
 	.max_rx_timeout_ms = 1000,
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
@@ -1819,6 +1821,7 @@ static int ti_sci_probe(struct platform_device *pdev)
 	int ret = -EINVAL;
 	int i;
 	int reboot = 0;
+	u32 h_id;
 
 	of_id = of_match_device(ti_sci_of_match, dev);
 	if (!of_id) {
@@ -1833,6 +1836,19 @@ static int ti_sci_probe(struct platform_device *pdev)
 
 	info->dev = dev;
 	info->desc = desc;
+	ret = of_property_read_u32(dev->of_node, "ti,host-id", &h_id);
+	/* if the property is not present in DT, use a default from desc */
+	if (ret < 0) {
+		info->host_id = info->desc->default_host_id;
+	} else {
+		if (!h_id) {
+			dev_warn(dev, "Host ID 0 is reserved for firmware\n");
+			info->host_id = info->desc->default_host_id;
+		} else {
+			info->host_id = h_id;
+		}
+	}
+
 	reboot = of_property_read_bool(dev->of_node,
 				       "ti,system-reboot-controller");
 	INIT_LIST_HEAD(&info->node);
-- 
2.15.1
