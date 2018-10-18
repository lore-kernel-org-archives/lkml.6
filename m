Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D152C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31D22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TMYguQOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31D22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbeJSFM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:12:59 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33053 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbeJSFM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:12:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so14878887plp.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vPFTWN6zkNfJc9He9beXBm7dfztDsRrm25G1lDnMPhc=;
        b=TMYguQOpZs9/KWTcDkHX7kVNjJ8CpHj8E+tlLDHtGAMJFf8es4sZ8VYkUPX2DHHco6
         0Yiygc13fROdD0artvEWgTECCSCh7/7p2AdQOLvVA6R+M81KCr8rH8EO/wYkvk7AjlO5
         CeSRrE5mNaveiH4FW540lU9sGiX9oRga5K8z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vPFTWN6zkNfJc9He9beXBm7dfztDsRrm25G1lDnMPhc=;
        b=uhty3vODPr0BrxY5zprgFk70NAeoV42fAzLR34WYmcAQHDFHRx7nbSrs6Rby7dyd+7
         1Y16hkZY8QiqohrDVisUQQqPnD/OwERwxAZW9ZR1hpZlfsbFAKau1urKvT8Oet9Y0ihZ
         5oB1qcaHQ5mX/AURqubmuilj3s0N8u8WbNfkIujtQlWtjRzSOv8fxsySskcvKD+W+aWL
         /JAdobf1CZu021MndhW7YRXsU7I6oqQs8/l+XjhKyAoTzR4i92lJBiP0PhBpNQvau2vA
         XUdQJPPhovwPhTpP235ZxHU+ADNjCnsdNzdWnWQSmOodoJEPx1MuoqtP+DDlquoTvNza
         FE2A==
X-Gm-Message-State: ABuFfoj07Dm02mk8LC7M5A8obl4DWIUDsgKdFpCKxjFP2OVK8YLp7cMM
        h948O9exVRpZd5aBLwCoR84EZw==
X-Google-Smtp-Source: ACcGV63c8vxi2C4mIJx1dV4GuOQ8CHbqt8NR1/d4qjue/bQ8kDvFsUO1O8YD59MBEARNqdCeBzVqoA==
X-Received: by 2002:a17:902:654e:: with SMTP id d14-v6mr31242785pln.292.1539897007352;
        Thu, 18 Oct 2018 14:10:07 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id i29-v6sm35133678pfj.82.2018.10.18.14.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 14:10:06 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        swboyd@chromium.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 5/5] arm64: dts: qcom: sdm845: Add USB PHY lane two
Date:   Thu, 18 Oct 2018 14:09:33 -0700
Message-Id: <20181018210933.113592-6-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181018210933.113592-1-evgreen@chromium.org>
References: <20181018210933.113592-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds the second lane registers for the USB PHY, now that the
QMP phy bindings have been updated. This way the driver can stop
reaching beyond its register region to get at the second lane.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9c72edb678ec..f28c50e93f5a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1188,10 +1188,12 @@
 				 <&gcc GCC_USB3_PHY_PRIM_BCR>;
 			reset-names = "phy", "common";
 
-			usb_1_ssphy: lane@88e9200 {
+			usb_1_ssphy: lanes@88e9200 {
 				reg = <0x88e9200 0x128>,
 				      <0x88e9400 0x200>,
 				      <0x88e9c00 0x218>,
+				      <0x88e9600 0x128>,
+				      <0x88e9800 0x200>,
 				      <0x88e9a00 0x100>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
@@ -1219,10 +1221,12 @@
 				 <&gcc GCC_USB3_PHY_SEC_BCR>;
 			reset-names = "phy", "common";
 
-			usb_2_ssphy: lane@88eb200 {
+			usb_2_ssphy: lanes@88eb200 {
 				reg = <0x88eb200 0x128>,
 				      <0x88eb400 0x1fc>,
 				      <0x88eb800 0x218>,
+				      <0x88eb600 0x128>,
+				      <0x88eb800 0x1fc>,
 				      <0x88e9600 0x70>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
-- 
2.16.4

