Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC85C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16DD21476
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w2bpsZxg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16DD21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJIHEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:04:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34600 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbeJIHEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:04:06 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w98NnqZs052731;
        Mon, 8 Oct 2018 18:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539042592;
        bh=/YUt4V04pjeIgvInpsN2sY9oZn1a18NB1gqu+pwAhzI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=w2bpsZxgWD7QdK/nBQZP39en4SurexjXwvRS+wix4WNt/MHLrLHlUnX2VMgWLKZXn
         KWcEGDJKLUEjIR54ZU7EMUPSZ2nNS1trqLBFLcJc+oWt4meDAfY37vuYIMLHlp+z4t
         Zg5gRkS0CWUprCQwjpyg+Mv4i8+h3IyLpyRyC8v0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnqZM023955;
        Mon, 8 Oct 2018 18:49:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 8 Oct
 2018 18:49:52 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 8 Oct 2018 18:49:52 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w98NnqCK023116;
        Mon, 8 Oct 2018 18:49:52 -0500
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w98Nnqx25224;
        Mon, 8 Oct 2018 18:49:52 -0500 (CDT)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [RFC PATCH 04/11] dt-bindings: net: ti: cpsw: switch to use phy-gmii-sel phy
Date:   Mon, 8 Oct 2018 18:49:42 -0500
Message-ID: <20181008234949.15416-5-grygorii.strashko@ti.com>
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

The cpsw-phy-sel driver was replaced with new PHY driver phy-gmii-sel, so
deprecate cpsw-phy-sel bindings and update CPSW binding to use phy-gmii-sel
PHY bindings.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/net/cpsw.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
index b3acebe..69d7ef8 100644
--- a/Documentation/devicetree/bindings/net/cpsw.txt
+++ b/Documentation/devicetree/bindings/net/cpsw.txt
@@ -22,7 +22,8 @@ Required properties:
 - cpsw-phy-sel		: Specifies the phandle to the CPSW phy mode selection
 			  device. See also cpsw-phy-sel.txt for it's binding.
 			  Note that in legacy cases cpsw-phy-sel may be
-			  a child device instead of a phandle.
+			  a child device instead of a phandle
+			  (DEPRECATED, use phy-gmii-sel PHY phandle).
 
 Optional properties:
 - ti,hwmods		: Must be "cpgmac0"
@@ -44,6 +45,7 @@ Optional properties:
 Slave Properties:
 Required properties:
 - phy-mode		: See ethernet.txt file in the same directory
+- phys			: phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
 
 Optional properties:
 - dual_emac_res_vlan	: Specifies VID to be used to segregate the ports
@@ -85,12 +87,14 @@ Examples:
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 1 0>;
 		};
 		cpsw_emac1: slave@1 {
 			phy_id = <&davinci_mdio>, <1>;
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 2 0>;
 		};
 	};
 
@@ -114,11 +118,13 @@ Examples:
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 1 0>;
 		};
 		cpsw_emac1: slave@1 {
 			phy_id = <&davinci_mdio>, <1>;
 			phy-mode = "rgmii-txid";
 			/* Filled in by U-Boot */
 			mac-address = [ 00 00 00 00 00 00 ];
+			phys = <&phy_gmii_sel 2 0>;
 		};
 	};
-- 
2.10.5

