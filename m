Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C89CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61C32175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hrTSTlaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfBES7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 13:59:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40797 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbfBES7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 13:59:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so1895566plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UON7OxMkbcyx4dBjCMwtMDRMNV+fEUa23kFHyXWEN6c=;
        b=hrTSTlaJf5uGR2lhYgndzqrc3pBB8/5zBiGNEb7YqMZ+1XQb1F7aucNiK4RwL4jI/H
         cyidgCZWAc8h3D4V81xW8xcAOeBJ+3qJoycUmFLwsl9mR8Laur8AzW+U4JLtilLyb7/x
         BSKow+d/tLFhmGBD20XJWE7vujsxoJTTSHHl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UON7OxMkbcyx4dBjCMwtMDRMNV+fEUa23kFHyXWEN6c=;
        b=g9L0DKEbsVtq+n5kslr9t4Xwr7CQELj95e/ey7CdThO98QwPCgAQE3I/ICsbyTBB0d
         G0jG2CSaJKK7o0w+EBGU/WNUzS7vdARDLItPjSDgT59aBD5UKzIpzQxMx732XIJpPktn
         DyKRvdMXImd2IanJ6RkvqIqI7/gRJ+odJsQMASE2RQJXhMlyJsAoKl1JRhFmnI7F3K2P
         MZqK9OACLTmKiSZOZx6kyKsRO5/CyLIMi6n6gZ7l9onYj9i4P+rtkNBGK9zyw40ZCC/y
         h2QJphwb5BIjDak7RNL51TACZkENHknVH17m+2kD9xeX8bEueHQEmyt4z8HsDckgGtv/
         eF+w==
X-Gm-Message-State: AHQUAub9mqSay2C7NCYeAU2xaTCe+v56IvCMFduQWo/Sec73rUO/DhWa
        EygLMZuNA+vFw+gGqGHUpCzyqA==
X-Google-Smtp-Source: AHgI3IZrxC49eSdemK5iugv2rhw/I0v7CMEAH52Ac4U6xwcRFApgbIhuHzPqS5IucBwj0o/QpARHRw==
X-Received: by 2002:a17:902:f81:: with SMTP id 1mr6419022plz.174.1549393173719;
        Tue, 05 Feb 2019 10:59:33 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id m3sm6424435pfi.102.2019.02.05.10.59.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Feb 2019 10:59:33 -0800 (PST)
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
Subject: [PATCH v3 3/8] dt-bindings: phy: qcom-ufs: Add resets property
Date:   Tue,  5 Feb 2019 10:58:57 -0800
Message-Id: <20190205185902.106085-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205185902.106085-1-evgreen@chromium.org>
References: <20190205185902.106085-1-evgreen@chromium.org>
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

