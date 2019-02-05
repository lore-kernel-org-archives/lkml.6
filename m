Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B10DC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6092175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Aas1a+AI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbfBES7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:32 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47034 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfBES7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id o6so1880026pls.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvo9vkE2z4ukp0XCRY8v+Ly8mGLi9zihvjjjcTgDx70=;
        b=Aas1a+AIRTx2Uo7LT4d5xTmzN2/j1ee5NoEOj+vB5IhpdSbOgRj9nF8fNSyEExQ0zd
         Nltl3NYwE5mjKnr1ujKE//bJezVYYPjiLWEjBi8f2X+Rq1w9k2sVGKMGfkj/Te3FBbMC
         gScjNNo8dCicWYwXAV/htmNH/ovLbtmFd7sf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvo9vkE2z4ukp0XCRY8v+Ly8mGLi9zihvjjjcTgDx70=;
        b=PMFuKDm2pF+AKHeRb0LkU5wa8SOgbIVFA3ghIIyKUglGTjt0WooP9DkITH7I/yC3v2
         jlknBdo4um9FOKrieMu23P+Y1kOApUejrMAmLQctsnaUIPHi4v09vQ/6t7qC0aUHt7ot
         sx3j2jhnIO+25pt9RnCbuvQdIne4Ej4qTYvPBXqBz0/DPJDM69tyyYgvpUWlqXDRtCVx
         /eMC4YaKHSLwUaW1jk3Z7bR61rr2NVs2gNtX3D90lM5OiwwvegPX2p/FqMW4jZNi84KA
         Jc3MxuMQ5ZsycEZ1i0KE+33ffZrGnnUXxPKjt2FhYzc+GOg1sVzoBdOJH9jhK0Ar4wjk
         Viog==
X-Gm-Message-State: AHQUAuaNHIJ/IWr/3hROil12jWlxQlta4xIFNG04X01fyuor8U7cHMtT
        vIWlBGfs+kg2+SIDYSZ8v6KbxA==
X-Google-Smtp-Source: AHgI3IZt/fXho4vFm07w01VCCpBkivq3kFzwcmgZfPnCarigAJPjTLTuspKz9NiNrpkoFA08zs00AQ==
X-Received: by 2002:a17:902:9a9:: with SMTP id 38mr6498039pln.204.1549393171250;
        Tue, 05 Feb 2019 10:59:31 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m3sm6424435pfi.102.2019.02.05.10.59.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:59:30 -0800 (PST)
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
Subject: [PATCH v3 2/8] dt-bindings: phy-qcom-qmp: Add UFS PHY reset
Date:   Tue,  5 Feb 2019 10:58:56 -0800
Message-Id: <20190205185902.106085-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
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

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
index 4ff26dbf4310..49b8a5eed3cd 100644
--- a/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
+++ b/Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt
@@ -56,7 +56,8 @@ Required properties:
 	   one for each entry in reset-names.
  - reset-names: "phy" for reset of phy block,
 		"common" for phy common block reset,
-		"cfg" for phy's ahb cfg block reset.
+		"cfg" for phy's ahb cfg block reset,
+		"ufsphy" for the PHY reset in the UFS controller.
 
 		For "qcom,ipq8074-qmp-pcie-phy" must contain:
 			"phy", "common".
@@ -70,7 +71,8 @@ Required properties:
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

