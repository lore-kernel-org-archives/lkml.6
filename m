Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E327C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431E6208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayjNbFIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 431E6208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeJPC1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:27:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39293 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeJPC1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:27:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id e67-v6so741071plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ogGQSy3dAWO6K9za/agsvOo3IJdF2oHNe8AuFMdfokI=;
        b=ayjNbFIMWUbEYOOTbf9xYFPjVipvqTvsLCX66z9P7KANNUtZ/j36x9xGvQ9pBtxNg8
         4te2B+0UbjF7VnKVrxeABrCAQfmivkd53ojOu9+cWsqhFGc3GoZ5Z5nMmSSMD70HBd82
         hBMwcZ74R6snIts9YiEHEJgERwfxZ+t94iuGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ogGQSy3dAWO6K9za/agsvOo3IJdF2oHNe8AuFMdfokI=;
        b=WRp00/QIQJkl7QVH8TdeUe8WTx6qAPU3CoJVL05oYrnTAw9XJS9T7CS5OkjgPXvINo
         BGGvEWD8QqFV3taIiVeVk5AE8i9Wqw7uHP+HJJoyq2dOnrWFHyDRmIryc9x4IUxPI8sm
         KkfLuwB4aGmxL/gxe0UcrI9zi2dPfEU2fE3NjJYJJO40e0oEl2QmD2JA3eRo/Tj/c6I/
         UFNWiFYE/fFmlSdBp4XdyK2GTOeoasqcVmpRD1hL3HGnoC6h1jPZ5U85Aw4lQlPUiCOU
         7kdGa5DMoXnH8fiQ/nrFndBN017f2PBbxLahNoLdc62y/m0stDasD5mP75OmmV9ZKCe6
         NoTg==
X-Gm-Message-State: ABuFfojQjn4I7hYhPQN2d3CcuXoy0PLYyNo6AAFGLcugpgWWxPfnDQG3
        tVJuzS5TXx/v6FE2bQZ5ZpGenDgRr7A=
X-Google-Smtp-Source: ACcGV6111i38Uc/bLWng6KmGvLu7blqcTfj73LKPTvoNPKTZoKsqsSlkpqq9I72NiEblXBapvEN1WA==
X-Received: by 2002:a17:902:263:: with SMTP id 90-v6mr18103770plc.190.1539628862759;
        Mon, 15 Oct 2018 11:41:02 -0700 (PDT)
Received: from localhost ([49.248.168.189])
        by smtp.gmail.com with ESMTPSA id l26-v6sm19276104pfg.161.2018.10.15.11.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:41:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        edubezval@gmail.com, andy.gross@linaro.org, vkoul@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v1 3/4] arm64: dts: qcom: qcs404: Add tsens controller
Date:   Tue, 16 Oct 2018 00:10:42 +0530
Message-Id: <f1dccd5d6fa08572237ccb3716f2f0ddab54ba40.1539627762.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1539627762.git.amit.kucheria@linaro.org>
References: <cover.1539627762.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qcs404 has a single TSENS IP block with 10 sensors. The calibration data
is stored in an eeprom (qfprom) that is accessed through the nvmem
framework. We add the qfprom node to allow the tsens sensors to be
calibrated correctly.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index e1e2ba9cbfcd..dfd65c53cf5f 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -273,6 +273,26 @@
 			status = "okay";
 		};
 
+		qfprom: qfprom@a4000 {
+			compatible = "qcom,qfprom";
+			reg = <0xa4000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			tsens_caldata: caldata@d0 {
+				reg = <0x1f8 0x14>;
+			};
+		};
+
+		tsens: thermal-sensor@4a9000 {
+			compatible = "qcom,qcs404-tsens", "qcom,tsens-v1";
+			reg = <0x4a9000 0x1000>, /* TM */
+			      <0x4a8000 0x1000>; /* SROT */
+			nvmem-cells = <&tsens_caldata>;
+			nvmem-cell-names = "calib";
+			#qcom,sensors = <10>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		apcs_glb: mailbox@b011000 {
 			compatible = "qcom,qcs404-apcs-apps-global", "syscon";
 			reg = <0xb011000 0x1000>;
-- 
2.17.1

