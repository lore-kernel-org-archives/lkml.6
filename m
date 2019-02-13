Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1426C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D499218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 23:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="axupwHCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390543AbfBMX0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 18:26:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46108 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390067AbfBMX0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 18:26:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id o6so1968090pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 15:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tTrz5iCREgQGXYUDyQ4vY7F8M1o2Gjn3QDNWgZd/TLo=;
        b=axupwHCWl0wuJEKGzGgbKByB637wsRkny0N9pdp60VtrWi34+nGnjhpAQSlk3sCdBx
         aeZzDIkbpfCrnqre4f9l3nhqIBts3uiC/8hMuwFIRdstH7TR4xzfFj8X2H2sECdB6LoO
         OjjAhCOQfTyMV4i9z+MxqC9hM2URbttTmmZp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTrz5iCREgQGXYUDyQ4vY7F8M1o2Gjn3QDNWgZd/TLo=;
        b=uVFe4EE74BJgbhuAwM2wngXgQ+bxnMb5H5iVqIpdpOksqIq7Qt3lx3TeiMMIKVPA/j
         9U0bAPvQtBAOObiEq0Rp1vWf22iqu1PB8KUYPmeB3yjAaapkozwJednJEczqhQhZLAmY
         mNQBw1IUpvLZtF1DQ5XvzbdOMknJlAIqOP5oefntlm4nitgxHKd8wsGsWoqOVOhL0Xad
         lQihUMq+dMAl/2ABD9EKnSwsnNOl2a56eRTu7orQWlhifbyLi+ZOW4PUFZ1SAycSKvM2
         vzyB7Ep1sLoZLgISFf7QMFebzT8x3ccjjteGEVe93uAj0LOe/y0bvewAa0Jyvt+JiIl8
         b0aQ==
X-Gm-Message-State: AHQUAubYOMcMcY78Mr6lx8IuDSjz/hv7C5WzZ3jPK8GCiscZMi2Mxrj2
        jgGr5fE+7nX+O8PiEc3LdHVFWw==
X-Google-Smtp-Source: AHgI3IZcwFyihgNlx4RQ6DFsU8JJ7gdAfJxyxUpSK4QBk41uq7EShRRB47nqsWSuGstLSo4O1A07Yw==
X-Received: by 2002:a17:902:ba90:: with SMTP id k16mr784980pls.214.1550100380615;
        Wed, 13 Feb 2019 15:26:20 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d129sm560660pfc.31.2019.02.13.15.26.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 15:26:19 -0800 (PST)
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
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/8] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Date:   Wed, 13 Feb 2019 15:25:20 -0800
Message-Id: <20190213232526.26995-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213232526.26995-1-evgreen@chromium.org>
References: <20190213232526.26995-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a required reset to the SDM845 UFS phy to express the PHY reset
bit inside the UFS controller register space. Before this change, this
reset was not expressed in the DT, and the driver utilized two different
callbacks (phy_init and phy_poweron) to implement a two-phase
initialization procedure that involved deasserting this reset between
init and poweron. This abused the two callbacks and diluted their
purpose.

That scheme does not work as regulators cannot be turned off in
phy_poweroff because they were turned on in init, rather than poweron.
The net result is that regulators are left on in suspend that shouldn't
be.

This new scheme gives the UFS reset to the PHY, so that it can fully
initialize itself in a single callback. We can then turn regulators on
during poweron and off during poweroff.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
I realize I'm not supposed to add a required property after the fact,
but given that the UFS DT nodes that would use this binding are not
yet upstream (and this would be the first), I was hoping to squeak by.

Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 5d181fc3cc18..4a78ba8b85bc 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -59,7 +59,8 @@ Required properties:
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset.
+		"cfg" for phy's ahb cfg block reset,
+		"ufsphy" for the PHY reset in the UFS controller.
 
 		For "qcom,ipq8074-qmp-pcie-phy" must contain:
 			"phy", "common".
@@ -74,7 +75,8 @@ Required properties:
 			"phy", "common".
 		For "qcom,sdm845-qmp-usb3-uni-phy" must contain:
 			"phy", "common".
-		For "qcom,sdm845-qmp-ufs-phy": no resets are listed.
+		For "qcom,sdm845-qmp-ufs-phy": must contain:
+			"ufsphy".
 
  - vdda-phy-supply: Phandle to a regulator supply to PHY core block.
  - vdda-pll-supply: Phandle to 1.8V regulator supply to PHY refclk pll block.
-- 
2.20.1

