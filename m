Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3672C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FC220877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 05:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Kjs+UAA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67FC220877
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeIYL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 07:26:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55568 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIYL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 07:26:56 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8P5L6ca055826;
        Tue, 25 Sep 2018 00:21:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537852866;
        bh=fjF9HZbvcu0Z1MzF3QlSMLBF+Rnjc3iSIAtXSFFGTBU=;
        h=From:To:CC:Subject:Date;
        b=Kjs+UAA79abeewkHNnh9/XZH88upY+x5KejAJRC4sdAX3IRYcPJYhsaQo9zgkMXiD
         6ni1nNNpN5ZdpjWqEA+zSHAzNgb7SunKq2Im5+JJdZmMH3KGshrgNGRE5TQ0nJ+Rsm
         hoYT62JLbMUFXoOpm01p6SFrijFKbG+IHf5ldG4Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P5L61N013956;
        Tue, 25 Sep 2018 00:21:06 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 25
 Sep 2018 00:21:06 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 25 Sep 2018 00:21:06 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8P5L2iI020310;
        Tue, 25 Sep 2018 00:21:04 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4] ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
Date:   Tue, 25 Sep 2018 10:51:51 +0530
Message-ID: <20180925052151.9537-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This patch is split from v3 here:
https://lore.kernel.org/patchwork/cover/967020/
Patch can be applied standalone and has no dependencies on other patches
in v3.

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
2.19.0

