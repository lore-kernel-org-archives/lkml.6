Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E71EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282120821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aLvFswoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbeLJTcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:32:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45301 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbeLJTcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:32:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so5698099plm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 11:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r2LQEP+rTJhB7Ln3gMRprsA8GSi1B+37E2E3khXcTwU=;
        b=aLvFswoWqvMQSNm9A0vSdtRGl1mzgZxboWz9U6zzDnvvelf9neI2qnR4STzizx3/M+
         DlgwcnLDlTxpVLs8MpzufKB2Aa0c830VMW+6xfWDhFYkI+ucMVOIlJKSMcrWTbxYjVYx
         YA0zGIVShUgzDz6dZhcH977MtshBpzEt4oRa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r2LQEP+rTJhB7Ln3gMRprsA8GSi1B+37E2E3khXcTwU=;
        b=AkLnMjw1uukPf8xw3wYzRvhc9Mv63iEs7JJF3XVobeFLbAJXjWoFhHEV0F3HisSR/i
         XOC7H1YZ+2VCBqv8RYK3jXuc+05pRDbwp7d8LwvAi5LVY5MaAhIc3rDYvGyxfIiB4B5Q
         GfuJIRqZZAiefFmisRgI/iRMzUgI2RP2hHDgbMWj03IrQTQpVBojuiTmM8krqq/Hi/ri
         tSL/Vy5YnzwxE5DRiXAV5WJxr8NwPZVehYuz7CIfWbvPkvyz0LrkWhgEBjrE9rNvBKCx
         b6xncLcb0MVuzO4Co76cMFpOu4uVxnG/a5WcKG8/VhRnU4jNhrutp+G3Bo6oVAEddluB
         XP2w==
X-Gm-Message-State: AA+aEWYuVlz+Dhd43FZu41Mhs+JQyXvRcphQLaGht+KaCc6uyrQPXVF8
        dmG1AqCMTVSriq04XTOWq3eyxg==
X-Google-Smtp-Source: AFSGD/WxRvI4FGQNvUQ20ihEQaHSEH1NaB5DhPwJN3/nSDJGV49RAIi6TqaQ7lZe6leVdx3ZKsY4lg==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr13311689plk.7.1544470350417;
        Mon, 10 Dec 2018 11:32:30 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id v5sm23737875pgn.5.2018.12.10.11.32.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 11:32:29 -0800 (PST)
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
Subject: [PATCH v2 3/4] arm64: dts: qcom: sdm845: Fix QMP PHY #clock-cells
Date:   Mon, 10 Dec 2018 11:32:06 -0800
Message-Id: <20181210193207.242080-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181210193207.242080-1-evgreen@chromium.org>
References: <20181210193207.242080-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move #clock-cells into the child node for instances of the qcom-qmp-phy
nodes, and set it to zero, in accordance with the proper bindings. PHYs
that don't provide clocks don't have #clock-cells, and so are left alone.

Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---

Changes in v2: None

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 47bb7edc03afe..fedd6578776a2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -1170,7 +1170,6 @@
 			      <0x88e8000 0x10>;
 			reg-names = "reg-base", "dp_com";
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1192,6 +1191,7 @@
 				      <0x88e9600 0x128>,
 				      <0x88e9800 0x200>,
 				      <0x88e9a00 0x100>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -1203,7 +1203,6 @@
 			compatible = "qcom,sdm845-qmp-usb3-uni-phy";
 			reg = <0x88eb000 0x18c>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -1223,6 +1222,7 @@
 				      <0x88eb400 0x1fc>,
 				      <0x88eb800 0x218>,
 				      <0x88e9600 0x70>;
+				#clock-cells = <0>;
 				#phy-cells = <0>;
 				clocks = <&gcc GCC_USB3_SEC_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
-- 
2.18.1

