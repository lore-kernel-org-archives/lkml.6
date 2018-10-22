Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857DDC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A873820665
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 20:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kd34SoKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A873820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbeJWFMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 01:12:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45679 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729316AbeJWFMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 01:12:20 -0400
Received: by mail-pg1-f195.google.com with SMTP id s3-v6so6353371pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xLKlsnGFS9lkOakWGrRUVip4OrwSbxaV3uwLy7WzbJU=;
        b=Kd34SoKvFVAsliANZ34ORX9svKrP4CBcZpjhfPQsVhKREknqty/Wp2c+lEQcOrR0rw
         lGt8fNLT1zpqD/lETX2SRW5BGvBop9hVM4E27/ipzXGuPdeBKkSVAgU0K83Y5OM8uCux
         PATHV0Rpebk9wN+kE11j2ifRd4F2TBRFmWVZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xLKlsnGFS9lkOakWGrRUVip4OrwSbxaV3uwLy7WzbJU=;
        b=KSmibdLMdsrcb6OQNdGzstWVx6jxG/vDR3Ro2XT4JhiX3JazEroDv/RK/ymnSXeiXd
         URvJEuU/LcQR2513LIPaQX6DGWNunqKmszTb3k55HBPq0FW2PyOHjJ82/lbvkxhC78uN
         2c/24kxHXBHFVjHLg5p7J793jMHdtvyINr1TQ2wOBTJqET0qm7Nyp5Dh7OA438QAb5LO
         zwBSEq0zBOOZFeG4FDT4Q2Sb1wIvg0TC0hWZLR0WXRiQuWYC2iEOEBI1g+3AyA81+ZMI
         MqGSlYIIHD36+WHHjj2ow11qIlT+42fNXw4mPJ5jaOZ4xZe8R7uFFe7rXXGgwuzzF0Ig
         Ifqg==
X-Gm-Message-State: ABuFfojXAGudrfT78ThT+fy9pKx6V1JEBANm2HIvva28Yybk19m21Z7t
        cFYM3pHv7+ia3rcggmc7Lm8oAQ==
X-Google-Smtp-Source: ACcGV61ot8WiSzRBoekld2wpjbn+m0Tua2QBpPz2suG3Fwig4q1rRDWuhXz2mZ2mPSrZDIEiqNP1iw==
X-Received: by 2002:a63:4045:: with SMTP id n66-v6mr21584034pga.244.1540241534119;
        Mon, 22 Oct 2018 13:52:14 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a11-v6sm37216041pfn.66.2018.10.22.13.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:52:13 -0700 (PDT)
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
Subject: [PATCH v3 4/5] arm64: dts: qcom: sdm845: Add UFS nodes for sdm845-mtp
Date:   Mon, 22 Oct 2018 13:51:01 -0700
Message-Id: <20181022205102.74825-5-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181022205102.74825-1-evgreen@chromium.org>
References: <20181022205102.74825-1-evgreen@chromium.org>
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

