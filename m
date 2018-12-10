Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD20C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2F720821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F664yrZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2F720821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbeLJTc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:32:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45981 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbeLJTcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:32:25 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so5412202pgc.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TB4CubCCv2J0vg1InnwwYpoBAEDbGjF7uzSgq9J7LE=;
        b=F664yrZrWvcyYkGJfh/POuueG6pQb0D3POrznckgzZEtNN9ZzxIMMIJdaSAs7Pl6Qn
         v7H3TcluCyPiCnN69OEmW5DZ1DD8dqqUFfz4fWuS0KcXiNCOlvz9/Rtw3Pd/w+8Ri3Kr
         iXKQW9B1UdpJRCdpRvkYzJbW1CDNku/flKXjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TB4CubCCv2J0vg1InnwwYpoBAEDbGjF7uzSgq9J7LE=;
        b=Jw3Cd3PK085MFZlI8D1dqLO2sw5s0xg0AOadnKBZBtlxuOqguTSNRPOwaOFUdH4JH+
         pRXCoiKXdPxBI9ASX8AummCM1aoZX4Jn7gfM/Y5+A3k1x8yGy3WqD+8nRPd4Lu3LydUp
         yty5+jraNmnX2SgREFG85SpTLQ8CD+KvVYGPrtGTWRCrnNSzmeYa8CjqVFcGwkEa18tW
         nlIoqHnJKJDGUSJj5w+tmRmbGpQoAF711LCj4jsbOSGV8TBDG0Bg8Lttjlw8Bojl/s45
         +UUnoTOkMUVMyZ5zf0b64SLzzwnV7uQ4jCSo/dvO62i0rBFTIInh3yn4fBNrg48sipsA
         EiyA==
X-Gm-Message-State: AA+aEWYH9xZ8ZdLVx4UYA5936HxdlYvAEclDv5aQkZjB3vlyYw6KNlQO
        0ccewNSqUVZXWj6RHFKcgFifPw==
X-Google-Smtp-Source: AFSGD/WPyrjNEiZtwHiW3kclha943AaFZ30hf3jO3Rlu+3QtRTFOoVJNaG7foA5vdFQMeRo1CXaCzg==
X-Received: by 2002:a62:b9a:: with SMTP id 26mr13633816pfl.196.1544470344628;
        Mon, 10 Dec 2018 11:32:24 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v5sm23737875pgn.5.2018.12.10.11.32.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:32:23 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <andy.gross@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-soc@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: qcom: msm8996: Fix QMP PHY #clock-cells
Date:   Mon, 10 Dec 2018 11:32:05 -0800
Message-Id: <20181210193207.242080-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210193207.242080-1-evgreen@chromium.org>
References: <20181210193207.242080-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move #clock-cells into the child node and set it to 0 to conform to the
proper binding specification.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---

Changes in v2: None

 arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b29fe80d72883..44a494c70fa11 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -760,7 +760,6 @@
 		phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x34000 0x488>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -783,6 +782,7 @@
 				reg = <0x035000 0x130>,
 					<0x035200 0x200>,
 					<0x035400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_0_pipe_clk_src";
@@ -796,6 +796,7 @@
 				reg = <0x036000 0x130>,
 					<0x036200 0x200>,
 					<0x036400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_1_pipe_clk_src";
@@ -809,6 +810,7 @@
 				reg = <0x037000 0x130>,
 					<0x037200 0x200>,
 					<0x037400 0x1dc>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "pcie_2_pipe_clk_src";
@@ -822,7 +824,6 @@
 		phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x7410000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -844,6 +845,7 @@
 				reg = <0x7410200 0x200>,
 					<0x7410400 0x130>,
 					<0x7410600 0x1a8>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 
 				clock-output-names = "usb3_phy_pipe_clk_src";
-- 
2.18.1

