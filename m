Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78844ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F71208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q75or7bH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F71208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbeGPRmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 13:42:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37482 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeGPRmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 13:42:53 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GHDXfk012022;
        Mon, 16 Jul 2018 12:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531761213;
        bh=yNiU62+LUUJjJ8oHNHDm+GTgqiqakLC7jsxAqpeTzxg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q75or7bHcJa6B0yrNXPVcyn9NMVU4QYvBL9JkzsWXaVst4JUvjMmtTglKi/GTuzkB
         qs20Sxgc4o+WpBC7kJS63snMI/qMXOdaSso8kePVQcBiP0jeBiuggLo9UW0nFKbl7O
         G07RUx5JtXfI1EpV0V9ZYOPHe4zpy3YA9YfBcLxE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GHDXKL006593;
        Mon, 16 Jul 2018 12:13:33 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 12:13:32 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 12:13:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GHDWdR002791;
        Mon, 16 Jul 2018 12:13:32 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <geert@linux-m68k.org>
Subject: [PATCH V2 2/2] firmware: ti_sci: Provide host-id as an optional dt parameter
Date:   Mon, 16 Jul 2018 12:13:28 -0500
Message-ID: <20180716171328.11674-3-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180716171328.11674-1-nm@ti.com>
References: <20180716171328.11674-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instrument's System Control Interface (TISCI) permits the
ability for Operating Systems to running in virtual machines to be
able to independently communicate with the firmware without the need
going through an hypervisor.

The "host-id" in effect is the hardware representation of the
host (example: VMs locked to a core) as identified to the System
Controller.

Provide support as an optional parameter implementation and use the
compatible data as default if one is not provided by device tree.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1:
* None

V1: https://patchwork.kernel.org/patch/10475309/
RFC: https://patchwork.kernel.org/patch/10447715/

 drivers/firmware/ti_sci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 7fa744793bc5..69ed1464175c 100644
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

