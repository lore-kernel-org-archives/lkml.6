Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6F1C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5856B2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TCy7Tz8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5856B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730235AbeKFSGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:06:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33940 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbeKFSGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:06:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA68fefd053858;
        Tue, 6 Nov 2018 02:41:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541493700;
        bh=UBzj/3X+m7O1OSX6UGLTXUOkNfXMK3DrH6Z3c+tr/vo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TCy7Tz8Y6NuB3t3R1PduAki/ZOiJA5o7dD/V3NCzxxn1Jk2jiu3wH8zgWPtqN0jZz
         wOSkuw3MLo+hOmvkS0O10+30/Xz/jQicGzmAtDNBE/Cax1jdIBZkG8n+pNGPvLYEaI
         gn0mjyVizH8a1bgmn5UMt92L5RBN97qCjL0Ar4OM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA68feox024214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Nov 2018 02:41:40 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 6 Nov
 2018 02:41:40 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 6 Nov 2018 02:41:40 -0600
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA68fJ3n032677;
        Tue, 6 Nov 2018 02:41:36 -0600
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
Subject: [PATCH v3 04/13] firmware: ti_sci: Add RM mapping table for am654
Date:   Tue, 6 Nov 2018 14:10:56 +0530
Message-ID: <20181106084105.32483-5-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106084105.32483-1-lokeshvutla@ti.com>
References: <20181106084105.32483-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the resource mapping table for AM654 SoC as defined
in http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
Introduce a new compatible for AM654 "ti,am654-sci" for using
this resource map table.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v2:
- Added Reviewed-by tag

 .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
 drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index b56a02c10ae6..6f0cd31c1520 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
 
 Required properties:
 -------------------
-- compatible: should be "ti,k2g-sci"
+- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
+		should be "ti,am654-sci" for for TI AM654 SoC
 - mbox-names:
 	"rx" - Mailbox corresponding to receive path
 	"tx" - Mailbox corresponding to transmit path
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 987bfb29475c..c2f0815edab6 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2500,10 +2500,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
+	.rm_type_map = NULL,
+};
+
+static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
+	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
+	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
+	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
+	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
+	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
+	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
+	{.dev_id = 0, .type = 0x000}, /* end of table */
+};
+
+/* Description for AM654 */
+static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
+	.default_host_id = 12,
+	/* Conservative duration */
+	.max_rx_timeout_ms = 10000,
+	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
+	.max_msgs = 20,
+	.max_msg_size = 60,
+	.rm_type_map = ti_sci_am654_rm_type_map,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
 	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
+	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_of_match);
-- 
2.19.1

