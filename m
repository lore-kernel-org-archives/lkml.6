Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0260C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 141B52086B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 11:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f6QLWEmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 141B52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754535AbeGIL3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 07:29:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41373 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754490AbeGIL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 07:29:04 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so4076081wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1JqEW+Zyv2CqnsmBXNt/A0PwbfHTAHHNG/CWkFvPZKE=;
        b=f6QLWEmLD2lDqjkUZeGQ4embRvv0fJ4Xnkhyn6ucvT8PCBROXHsKAF2y8IBTADdpyV
         TAJlih0zolCTOWrmBDuGcMrNEH5GsQrZSDpcvn6AmOeicgn/JJ+7jHISr1ndwUDA0MEw
         mI3V2aGi1UMQssHmgtdsZ3/1F04WTyJtg1YOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1JqEW+Zyv2CqnsmBXNt/A0PwbfHTAHHNG/CWkFvPZKE=;
        b=N+w6vAuV4Xbuyr4QfLDxUyXEY3LN1CsAsbJSu3dde8Sc9pa15TL1V8rrWrCRVPYfTD
         bSUUbBuJH99OEAI3AHr771RUXn/eQtT97WK0taYiU6coqCHA0PMUdwr9g59whScalnyY
         +bs2iNhSqtABXRyh1poY3WrdE7HUi/LMA5mQTRM6tY9q9ChobwEzzCNrmbQNBXsBRST6
         kIZN6ifryQX5oWCXwrsc4HC/FobI3C17ALIe3zDqTW5HV83PUl7H/dbJXNQO+sn9fQCe
         TXUV8qSzTJLgKXNnUBuDpAam/56BtEFWN0FNihkk+f3aYL8L0Vj51i1nTWwqMT6EhSZf
         H85g==
X-Gm-Message-State: APt69E25NjWojcq4ESzSZgSfISVVIPDfQEyePxs31Ets0IaWVl1azpfI
        dXnSlFfcRpr6EfRtp8HbXDwcXE6EVd8=
X-Google-Smtp-Source: AAOMgpc36LrjMg1Od8mrmM+QQInZ8nbXLWINXxF30VJPXTOCMhvTnyTtbL9sNaAp4rYu0jPQzxYiiA==
X-Received: by 2002:adf:e90c:: with SMTP id f12-v6mr14129316wrm.126.1531135743226;
        Mon, 09 Jul 2018 04:29:03 -0700 (PDT)
Received: from localhost ([49.248.189.240])
        by smtp.gmail.com with ESMTPSA id x16-v6sm24804528wme.12.2018.07.09.04.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 04:29:02 -0700 (PDT)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, edubezval@gmail.com,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 7/7] arm64: dts: sdm845: Add tsens nodes
Date:   Mon,  9 Jul 2018 16:57:40 +0530
Message-Id: <742cf44d162523a66bb4ce60e15449dfbf88800a.1531133612.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1531133611.git.amit.kucheria@linaro.org>
References: <cover.1531133611.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SDM845 has two tsens blocks, one with 13 sensors and the other with 8
sensors. It uses version 2 of the TSENS IP, so use the fallback property to
allow more common code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb..d97ee00 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -221,6 +221,22 @@
 			#interrupt-cells = <2>;
 		};
 
+		tsens0: tsens@c222000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc263000 0x1ff>, /* TM */
+			      <0xc222000 0x1ff>; /* SROT */
+			#qcom,sensors = <13>;
+			#thermal-sensor-cells = <1>;
+		};
+
+		tsens1: tsens@c223000 {
+			compatible = "qcom,sdm845-tsens", "qcom,tsens-v2";
+			reg = <0xc265000 0x1ff>, /* TM */
+			      <0xc223000 0x1ff>; /* SROT */
+			#qcom,sensors = <8>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		spmi_bus: spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0xc440000 0x1100>,
-- 
2.7.4

