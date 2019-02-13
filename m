Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B86C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C6F222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R9YuU2jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390972AbfBMX0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:30 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38603 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390321AbfBMX0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:23 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1988088plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iFzJHslHRuN7dshluGWs7x+KZ7HWieibqhqCVGvZ6jg=;
        b=R9YuU2jXMWyx2mG4N66ZCHrNaWwKlmyS4uX3sY30VIgk3eGyB5pVqVnt4qUGVSApRX
         aKK/RpL27Pe5zuO6I8ybDUJ6N9JNCKZz2u4TGpqsXDX8Dnwvz0VA3OvoyE//uDj8tbjW
         SsMS5qVFiR/g8ybN7SnOwtlKDquXyrsoNVrOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iFzJHslHRuN7dshluGWs7x+KZ7HWieibqhqCVGvZ6jg=;
        b=GMkUlHNMOBzfCIaKBihdCZu2OLDc3DOBMXzztDtGyMsU6SdzvlOuM+UrSWjViNJAed
         DlZQlFegiAMMjxkJorGnrgjCaVWF81ME2GvENldvXip69ffWksmKyW0OMdB0igSWPi8X
         X9jcTgWfEX7bDYYt+cEX1IP5FkjdjE6szGS/dPrq+lZ8NY3ZvUMr+R4gvDyBAO2sesZD
         pgpx470j400pKCMVzDcNg7Uesu7jfiggCE4EbjJx2L39xrLHAWRGvD9gW1VasQRZkIsF
         Xn+GVMIFWI4pNOoH8Knf7MQm7L7tkL+WAdajG6uovq2UuKdtTWlkel8v7ZEl6rDUd9Cw
         0YBw==
X-Gm-Message-State: AHQUAuaRy0Lza+9BiLH/Poqdyrr8soscgHlmW3qYAtxomBpVRAnXVeQ5
        Pg80k6MIMLPtyEY4zdqPBYET3Q==
X-Google-Smtp-Source: AHgI3Ia4uVR+Uag157wWj7qLTNfst/lpz/VJYvFyREwiwAKPub84ZOQgWxGVEwZX4fO0gx2nJ4j19Q==
X-Received: by 2002:a17:902:2e01:: with SMTP id q1mr772941plb.240.1550100382818;
        Wed, 13 Feb 2019 15:26:22 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:22 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 3/8] dt-bindings: phy: qcom-ufs: Add resets property
Date:   Wed, 13 Feb 2019 15:25:21 -0800
Message-Id: <20190213232526.26995-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a resets property to the PHY that represents the PHY reset
register in the UFS controller itself. This better describes the
complete specification of the PHY, and allows the PHY to perform
its initialization in a single function, rather than relying on
back-channel sequencing of initialization through the PHY framework.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
- Added resets to example (Stephen).

 Documentation/devicetree/bindings/ufs/ufs-qcom.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
index 21d9a93db2e9..fd59f93e9556 100644
--- a/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
+++ b/Documentation/devicetree/bindings/ufs/ufs-qcom.txt
@@ -29,6 +29,7 @@ Optional properties:
 - vdda-pll-max-microamp : specifies max. load that can be drawn from pll supply
 - vddp-ref-clk-supply   : phandle to UFS device ref_clk pad power supply
 - vddp-ref-clk-max-microamp : specifies max. load that can be drawn from this supply
+- resets : specifies the PHY reset in the UFS controller
 
 Example:
 
@@ -51,9 +52,11 @@ Example:
 			<&clock_gcc clk_ufs_phy_ldo>,
 			<&clock_gcc clk_gcc_ufs_tx_cfg_clk>,
 			<&clock_gcc clk_gcc_ufs_rx_cfg_clk>;
+		resets = <&ufshc 0>;
 	};
 
-	ufshc@fc598000 {
+	ufshc: ufshc@fc598000 {
+		#reset-cells = <1>;
 		...
 		phys = <&ufsphy1>;
 		phy-names = "ufsphy";
-- 
2.20.1

