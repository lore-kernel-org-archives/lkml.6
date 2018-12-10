Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E779DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF2C2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lG3ASyZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF2C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbeLJTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:32:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41723 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeLJTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:32:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so5872740pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=flcoDxk9QhkrALtbQaThbmkDokRRAjFz0YSPQB/zs+0=;
        b=lG3ASyZjtISA0UNLI+7qeUmnpQ8L9q+DwXusNlUvdX7nbmZvli3coXhGUvf5h9hQID
         5t1GO8RcQKyTA1L4NlmuBMDFWa84fe5wC3Fqnul9ptVCvxelpgfPlmvd/GeOcg95jb6o
         /7hvkouwYkOyXNtqBroN5M7gek71T4/ICqpRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=flcoDxk9QhkrALtbQaThbmkDokRRAjFz0YSPQB/zs+0=;
        b=J0lwh1buQ/Dg6cB+0xyoLrEZVo5MxbVNm/XeG9kNHm/ZyzYluOeVu1Eq+cbjH8WsG3
         TrZZr66VpYKugHEPfYxsB+R8qyYbxMKg1/+H9V49jCeXUQhz0rlwLghyPYef4U2zVQpN
         eoQZk7TMxy7FP41650EneQOxingkf6lfpcRS9mEiHGZQkv+XPIgJThTeCAIdCq+x4ijH
         hF1ptcXWoBmfE2H5w3MdlzkpXHg6pM+9fsCp6aj43lgt++QFd4HResU7lPkR7a/lcmeF
         /+u6prm9NHER9XAfzOmC/behqlUtXNdaUrvbV9RypW69r2h+hoaVU5QvuCT1cB7u1skd
         6DHQ==
X-Gm-Message-State: AA+aEWbscQDciyshzh/m7O9PgGffbXo3aieFZO6XNteINiG4QQrCozBe
        GvcGpYA5nSr3ggjZWLXdHKWVbA==
X-Google-Smtp-Source: AFSGD/WfQMqfqjVXB3ajey8U6C7/hzqTg8mgMR7bMvhf8DMtgLmF3/RK2StvKnOqnWPEdsHEukv/CA==
X-Received: by 2002:a62:9111:: with SMTP id l17mr13513428pfe.200.1544470341192;
        Mon, 10 Dec 2018 11:32:21 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v5sm23737875pgn.5.2018.12.10.11.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:32:20 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: phy-qcom-qmp: Move #clock-cells to child
Date:   Mon, 10 Dec 2018 11:32:04 -0800
Message-Id: <20181210193207.242080-2-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210193207.242080-1-evgreen@chromium.org>
References: <20181210193207.242080-1-evgreen@chromium.org>
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
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2: None

 .../devicetree/bindings/phy/qcom-qmp-phy.txt          | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index c7a71e67ebdf5..68c67eeef7758 100644
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
@@ -94,6 +90,9 @@ Required properties for child node of PCIe and USB3 qmp phys:
 		- "pcie20_phy0_pipe_clk"	Pipe Clock parent
 			(or)
 		  "pcie20_phy1_pipe_clk"
+ - #clock-cells: must be 0
+    - Phy pll outputs pipe clocks for pipe based PHYs. These clocks are then
+      gate-controlled by the gcc.
 
  - resets: a list of phandles and reset controller specifier pairs,
 	   one for each entry in reset-names.
@@ -104,7 +103,6 @@ Example:
 	phy@34000 {
 		compatible = "qcom,msm8996-qmp-pcie-phy";
 		reg = <0x34000 0x488>;
-		#clock-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
@@ -126,6 +124,7 @@ Example:
 			reg = <0x35000 0x130>,
 				<0x35200 0x200>,
 				<0x35400 0x1dc>;
+			#clock-cells = <0>;
 			#phy-cells = <0>;
 
 			clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
@@ -143,7 +142,6 @@ Example:
 	phy@88eb000 {
 		compatible = "qcom,sdm845-qmp-usb3-uni-phy";
 		reg = <0x88eb000 0x18c>;
-		#clock-cells = <1>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
@@ -163,6 +161,7 @@ Example:
 			      <0x88eb400 0x1fc>,
 			      <0x88eb800 0x218>,
 			      <0x88eb600 0x70>;
+			#clock-cells = <0>;
 			#phy-cells = <0>;
 			clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 			clock-names = "pipe0";
-- 
2.18.1

