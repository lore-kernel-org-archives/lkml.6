Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C545AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B233243D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Vj4m4CL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B233243D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965307AbeF0O7P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:59:15 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43516 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeF0O7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:59:13 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5RCSxnn056417;
        Wed, 27 Jun 2018 07:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530102539;
        bh=RiMf3+UR+douiyEYInNUodkhkCSKhZXkOPBcoOeBMvM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vj4m4CL1eOnFEa4zswc9zao5UrSIjvGfSfLycs+1GRiNG+lNqRO1SZYrOiISMIHLi
         xIW7sFSI9R3peMe47W46dvaphZQTI7impf8oVHkVhIjhFtwVtW6TfVmm1HedgdYZUC
         AC8hfg0ylg36CylOCVq2fvqY6v2cR/jt4lE8O/Eg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSxSf010766;
        Wed, 27 Jun 2018 07:28:59 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 27
 Jun 2018 07:28:59 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 27 Jun 2018 07:28:58 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5RCSgMv027559;
        Wed, 27 Jun 2018 07:28:56 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v2 4/4] ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
Date:   Wed, 27 Jun 2018 17:59:19 +0530
Message-ID: <20180627122919.23926-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627122919.23926-1-vigneshr@ti.com>
References: <20180627122919.23926-1-vigneshr@ti.com>
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

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 7bfe7f28e3bd..27ad193e1a87 100644
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

