Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09E8C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A6E2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ThZ9KEoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62A6E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJIHEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:07 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeJIHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:06 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98Nnqvo126361;
        Mon, 8 Oct 2018 18:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042592;
        bh=3uC4YX3i2GahEKMhydzhXXxO77zZOflGn5HPNJiU2+k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ThZ9KEoWRoHFh1u+FOaUoxtuPmwMM90arV6T1MoPQ/ALIZQHtp5TpxXQ0J9wlsUoh
         xw3NoQNsh3+VBoN1ViU2aFWH3W24FXU5CHHjVvzPCykMsTNNpi9k2/n0MBOD91ZT2N
         PtUD7z0eeMvyv64wyqAJn1ONyQN2BuEneLqi7uls=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnqXu023944;
        Mon, 8 Oct 2018 18:49:52 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:52 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:51 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98Nnp7m023110;
        Mon, 8 Oct 2018 18:49:51 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnpx25216;
        Mon, 8 Oct 2018 18:49:51 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 02/11] dt-bindings: phy: add cpsw port interface mode selection phy bindings
Date:   Mon, 8 Oct 2018 18:49:40 -0500
Message-ID: <20181008234949.15416-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181008234949.15416-1-grygorii.strashko@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPSW Port's Interface Mode Selection PHY (phy-gmii-sel) DT Bindings

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 .../devicetree/bindings/phy/ti-phy-gmii-sel.txt    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt

diff --git a/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
new file mode 100644
index 0000000..fd81421
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/ti-phy-gmii-sel.txt
@@ -0,0 +1,68 @@
+CPSW Port's Interface Mode Selection PHY Tree Bindings
+-----------------------------------------------
+
+TI am335x/am437x/dra7(am5)/dm814x CPSW3G Ethernet Subsystem supports
+two 10/100/1000 Ethernet ports with selectable G/MII, RMII, and RGMII interfaces.
+The interface mode is selected by configuring the MII mode selection register(s)
+(GMII_SEL) in the System Control Module chapter (SCM). GMII_SEL register(s) and
+bit fields placement in SCM are different between SoCs while fields meaning
+is the same.
+                                               +--------------+
+        +-------------------------------+      |SCM           |
+        |                     CPSW      |      |  +---------+ |
+        |        +--------------------------------+gmii_sel | |
+        |        |                      |      |  +---------+ |
+        |   +----v---+     +--------+   |      +--------------+
+        |   |Port 1..<--+-->GMII/MII<------->
+        |   |        |  |  |        |   |
+        |   +--------+  |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RMII   <------->
+        |               +-->        |   |
+        |               |  +--------+   |
+        |               |               |
+        |               |  +--------+   |
+        |               |  | RGMII  <------->
+        |               +-->        |   |
+        |                  +--------+   |
+        +-------------------------------+
+
+CPSW Port's Interface Mode Selection PHY describes MII interface mode between
+CPSW Port and Ethernet PHY which depends on Eth PHY and board configuration.
+
+CPSW Port's Interface Mode Selection PHY device should defined as child device
+of SCM node (scm_conf) and can be attached to each CPSW port node using standard
+PHY bindings (See phy/phy-bindings.txt).
+
+Required properties:
+- compatible		: Should be "ti,am3352-phy-gmii-sel" for am335x platform
+			  "ti,dra7xx-phy-gmii-sel" for dra7xx/am57xx platform
+			  "ti,am43xx-phy-gmii-sel" for am43xx platform
+			  "ti,dm814-phy-gmii-sel" for dm814x platform
+- #phy-cells		: must be 2.
+			  cell 1 - CPSW port number (starting from 1)
+			  cell 2 - RMII refclk mode
+- syscon-scm		: phandle on SCM node (mfd/syscon.txt)
+
+Examples:
+	phy_gmii_sel: phy-gmii-sel {
+		compatible = "ti,am3352-phy-gmii-sel";
+		syscon-scm = <&scm_conf>;
+		#phy-cells = <2>;
+	};
+
+	mac: ethernet@4a100000 {
+		compatible = "ti,am335x-cpsw","ti,cpsw";
+		...
+
+		cpsw_emac0: slave@4a100200 {
+			...
+			phys = <&phy_gmii_sel 1 1>;
+		};
+
+		cpsw_emac1: slave@4a100300 {
+			...
+			phys = <&phy_gmii_sel 2 1>;
+		};
+	};
-- 
2.10.5

