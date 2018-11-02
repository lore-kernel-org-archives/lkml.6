Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F461C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B08D2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 19:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B08D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbeKCEcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:32:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52474 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeKCEcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:32:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA2JNlpx077280;
        Fri, 2 Nov 2018 14:23:47 -0500
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA2JNlx5045107
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Nov 2018 14:23:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 2 Nov
 2018 14:23:47 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 2 Nov 2018 14:23:47 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA2JNfvV000522;
        Fri, 2 Nov 2018 14:23:45 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-can@vger.kernel.org>
CC:     <wg@grandegger.com>, <mkl@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 1/6] phy: Add max_bitrate attribute & phy_get_max_bitrate()
Date:   Sat, 3 Nov 2018 00:56:11 +0530
Message-ID: <20181102192616.28291-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181102192616.28291-1-faiz_abbas@ti.com>
References: <20181102192616.28291-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some subsystems (eg. CAN) the physical layer capabilities are
the limiting factor in the datarate of the device. Typically, the
physical layer transceiver does not provide a way to discover this
limitation at runtime. Thus this information needs to be represented as
a phy attribute which is read from the device tree.

Therefore, add an optional max_bitrate attribute to the generic phy
sybsystem. Also add the complementary API which enables the consumer
to get max_bitrate.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 include/linux/phy/phy.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 03b319f89a34..31574464f09f 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -72,6 +72,7 @@ struct phy_ops {
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_bitrate;
 	enum phy_mode		mode;
 };
 
@@ -179,6 +180,10 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
 {
 	phy->attrs.bus_width = bus_width;
 }
+static inline int phy_get_max_bitrate(struct phy *phy)
+{
+	return phy->attrs.max_bitrate;
+}
 struct phy *phy_get(struct device *dev, const char *string);
 struct phy *phy_optional_get(struct device *dev, const char *string);
 struct phy *devm_phy_get(struct device *dev, const char *string);
-- 
2.18.0

