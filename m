Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61756C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209D920863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dey1Ix9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209D920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbeK3JVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:21:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37961 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbeK3JVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:21:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so1718029pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bP09pPsXf42T9CIhAyRDjGi1txaGVY1M+gjxYfwLzTc=;
        b=dey1Ix9FlQnYJjuEP87TulNMr3tOL3jFcGmfci6IBhriMKkuvfoR/6i+yMlN1e3UUJ
         OzFdtSdrW5rTjsOCQ3a75qpRrxvHwEnwpaBNVyVOAt1qw0NXkux/vjTcyia8CKH62BFN
         o3AofoLhiFQx0CezcOboG3fEo/dRTsMqcyPbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bP09pPsXf42T9CIhAyRDjGi1txaGVY1M+gjxYfwLzTc=;
        b=TjW9eCuMi07LP5fi8xgljJBYf3yDnFroqZNdrXhdOonOuDlrHCE7SVd+1wynPfRK4f
         QKqK2+43yGLsd8tJxVLMvtpMjy6Tv/tbJ5xotyluegEj7fuNQ/NCyALnMDVMdXkJSHG7
         wVe3vcWOAl1+G3LMO7uXmvep9+RYmCEOQWCNHvs+GN9bVRTtm4WbnzxavLHILv793+4b
         M2E/yalFbHB+py7i9airb1yjWg7FKJ1Z+huuMS00qCn6SXEuIHT3pW5U/T9UHg3X1kil
         IHDcld07Mvez/OtJY9+j+FVhKixmz48K9TrPVGFZGtZ16nal791L7bxL5Dl9R4onBnPR
         o/UQ==
X-Gm-Message-State: AA+aEWYUehqfetdgC+EZfpBf+nDxNasUDC3Z5vfummQyeHHOt8ywygMk
        iv4zzf8TEWFVLwMdtJrZKrYA5+2T9bQ=
X-Google-Smtp-Source: AFSGD/XQsbXA9jf85glzSn5/uAW7iEAOHbjpPW7TD+RWRQMZqcLaJvsMfB5+4VhlnwFQnXB6CtV55w==
X-Received: by 2002:a62:5182:: with SMTP id f124mr3171044pfb.238.1543529674780;
        Thu, 29 Nov 2018 14:14:34 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id c67sm4697690pfg.170.2018.11.29.14.14.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 14:14:34 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] dt-bindings: phy-qcom-qmp: Move #clock-cells to child
Date:   Thu, 29 Nov 2018 14:13:54 -0800
Message-Id: <20181129221357.67417-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181129221357.67417-1-evgreen@chromium.org>
References: <20181129221357.67417-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The phy-qcom-qmp bindings specified #clock-cells as 1. This was never used
because of_clk_add_provider() was never called, so there was no way anybody
could reference these clocks from DT. Furthermore, even if they could be
accessed, the bindings never specified what should go in that additional
cell.

Fix these incomplete and broken bindings. Move the #clock-cells into the
child node, since that is the actual clock provider, and not all
instances of qcom-qmp-phy are clock providers. Also set #clock-cells to
zero, since there's nothing to pass to it.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 .../devicetree/bindings/phy/qcom-qmp-phy.txt          | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index f7b532125a4d9..41a1074228ba7 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -25,10 +25,6 @@ Required properties:
   - For all others:
     - The reg-names property shouldn't be defined.
 
- - #clock-cells: must be 1 (PCIe and USB3 PHYs only)
-    - Phy pll outputs a bunch of clocks for Tx, Rx and Pipe
-      interface (for pipe based PHYs). These clock are then gate-controlled
-      by gcc.
  - #address-cells: must be 1
  - #size-cells: must be 1
  - ranges: must be present
@@ -106,6 +102,9 @@ Required properties for child node of PCIe and USB3 qmp phys:
 		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
 			(or)
 		  "pcie20_phy1_pipe_clk"
+ - #clock-cells: must be 0
+    - Phy pll outputs pipe clocks for pipe based PHYs. These clocks are then
+      gate-controlled by the gcc.
 
 Required properties for child node of PHYs with lane reset, AKA:
 	"qcom,msm8996-qmp-pcie-phy"
@@ -118,7 +117,6 @@ Example:
 	phy@34000 {
 		compatible = "qcom,msm8996-qmp-pcie-phy";
 		reg = <0x34000 0x488>;
-		#clock-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
@@ -140,6 +138,7 @@ Example:
 			reg = <0x35000 0x130>,
 				<0x35200 0x200>,
 				<0x35400 0x1dc>;
+			#clock-cells = <0>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
@@ -157,7 +156,6 @@ Example:
 	phy@88eb000 {
 		compatible = "qcom,sdm845-qmp-usb3-uni-phy";
 		reg = <0x88eb000 0x18c>;
-		#clock-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
@@ -177,6 +175,7 @@ Example:
 			      <0x88eb400 0x1fc>,
 			      <0x88eb800 0x218>,
 			      <0x88eb600 0x70>;
+			#clock-cells = <0>;
 			#phy-cells = <0>;
 			clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 			clock-names = "pipe0";
-- 
2.18.1

