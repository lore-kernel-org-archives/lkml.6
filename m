Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CCFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6E32082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 17:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MBYgtuPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE6E32082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeJYB5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 21:57:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42994 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeJYB5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 21:57:23 -0400
Received: by mail-pl1-f193.google.com with SMTP id t6-v6so2517936plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ES2N2VLQVI4lirarWcy5SEuftsKQCycdGdpfuMoPM4s=;
        b=MBYgtuPBJVy6OXxo+62q05//hlLXkUrmLKQ46y6paIxpznW/2mk0280LFb3VRirx63
         yFL7pLcWlkHyn9X5T6b0ufqnULsL5wiAcUSvC0z/icJXqa+/HUf7KQNNmKEHQbs3Hat0
         tcxBtx93uByDI9WMxeVF4+OvdzjqhMSQBo97E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ES2N2VLQVI4lirarWcy5SEuftsKQCycdGdpfuMoPM4s=;
        b=laBJ7s0GfzBkWQaWqFg6HDFlH/QE3lBzcsqOVwBJ55pATXAcqG2BeigYHvBZMF9E9z
         E6XIVUEXxvygN68yFfDsqawfwuz+uCaICJp03SW4+FD2xL+si9idXw90uMifPw/HgDhl
         0l1C4K3191QKNodRcSlsDh4DKYmDmg6FVq++wVltXmPGUZqHCZqD1KmJVt5t7dzfQt4o
         bmZzhKxKIZN13abtpyOADHpLvHonHVQVzThJ4Ab6hAXg0hcFRkDqbWsE/KwSyoGRzx7U
         u2ugVKwG2zfZ172Fd3QgNmJxiN0BkRy9Xx1M9OEsiSPhRjPsjjHhsgrFeX1D4EhITFJH
         EKPA==
X-Gm-Message-State: AGRZ1gKMLil49UZPoELdavIoPSv3DoArcbHdHGVlAbNsxHUqlsXPOEUY
        4EEiicLrHRHrw/87NO7m0sX+XA==
X-Google-Smtp-Source: AJdET5f33RrfXL4uZ6FqbaIsUI3GDMI+wCfK453YRwy6bKOOGgD3y/db4kI0nxbx0fnlej8k65Vuaw==
X-Received: by 2002:a17:902:9a07:: with SMTP id v7-v6mr3250258plp.14.1540402109037;
        Wed, 24 Oct 2018 10:28:29 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id v185-v6sm5674265pfv.48.2018.10.24.10.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 10:28:28 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Can Guo <cang@codeaurora.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Wed, 24 Oct 2018 10:27:34 -0700
Message-Id: <20181024172735.154304-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181024172735.154304-1-evgreen@chromium.org>
References: <20181024172735.154304-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

Enable the UFS host controller and PHY on sdm845-mtp.

Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index eedfaf8922e2..d5fddea71a85 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -356,6 +356,20 @@
 	status = "okay";
 };
 
+&ufshc1 {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vcc-max-microamp = <600000>;
+};
+
+&ufsphy1 {
+	status = "okay";
+
+	vdda-phy-supply = <&vdda_ufs1_core>;
+	vdda-pll-supply = <&vdda_ufs1_1p2>;
+};
+
 &usb_1 {
 	status = "okay";
 };
-- 
2.16.4

