Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC6ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958B520883
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VUnWbSQl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958B520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbeGXSip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:38:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36538 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388435AbeGXSip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:38:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6OHV8DN018161;
        Tue, 24 Jul 2018 12:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532453468;
        bh=/pLn/lk15zvgYyFcMQVp4Wa2efjVxVY60b5UNIHrQKU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VUnWbSQlgwmYSSPX4Ppdd9ljm+4Mdnv7GZMGXm3i9na7c9YURUYWIRLjDanLQpYfX
         HyLwLlfGRmfrr2lgH/o590Op6R1rqrBHiaZt2T9RilvqMuk6822pkq88r2YhbYS/9T
         UcmV7Z01JsNwUQ9/3VUIa/DSuC6mKuPn9IbqG2Qo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHV7Gp011388;
        Tue, 24 Jul 2018 12:31:07 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 24
 Jul 2018 12:31:07 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 24 Jul 2018 12:31:07 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6OHUt8V031458;
        Tue, 24 Jul 2018 12:31:05 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH v3 3/4] ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
Date:   Tue, 24 Jul 2018 23:01:49 +0530
Message-ID: <20180724173150.2701-4-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724173150.2701-1-vigneshr@ti.com>
References: <20180724173150.2701-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
incorrectly documented in the TRM. In fact, the bit positions are
swapped. Update the DT bindings for PCIe EP to reflect the same.

Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
v3;
Add Fixes tag

 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 1050da6c6d35..fc50d6a8e51a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -355,7 +355,7 @@
 				ti,hwmods = "pcie1";
 				phys = <&pcie1_phy>;
 				phy-names = "pcie-phy0";
-				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
 				status = "disabled";
 			};
 		};
-- 
2.18.0

