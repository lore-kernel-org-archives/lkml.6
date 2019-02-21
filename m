Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E5FE2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2p8tQSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfBUGoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:44:20 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37792 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfBUGoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:44:17 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so13275091pfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7Yr9vEc/l4o43TBE4xflrGGNZVonCgFBLEOcOC3hQI=;
        b=G2p8tQSdmUhGj5hEsUOPpftbQK8T7esBBYI3XENQcBSekPfoGYZibqiAdiOIexiSCq
         W7sz8vO7Lw6gQzktD3z9XhE8XPB8H/Ty2Uos8jk2PrEiuG0Z5NkYYQwZz3pFwnJfQskZ
         6JBIPdTseXKjSyvfY5NJh3NOOmy0qUkNN9CmSsCyBDzBGedZK+JrzlP4aZ13KaDBaSUS
         EZclkMmtQ1IoxFqhDl/glc16TqMWv42oikVXimtbVmU3qyBm1L6iqe9H2jp/zH3BKPQ1
         BXBoTnDc7ieGF4GmyV4a/hrnY+CWq7PyTjFnLpFFDOMNp9Jlg+4YlFFx0w7P12eql0OE
         fTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7Yr9vEc/l4o43TBE4xflrGGNZVonCgFBLEOcOC3hQI=;
        b=tL08H4/g5rrzq68eM3hIP/4SqNg2THHCdShYIK2S/STPDgdCQz+G9WtxHJpaBxZpDE
         Hn1lJH1xNlvGVeULgtE5MEvgMKivlpG0CKe8WpD1JOr9aXm2gKTVlBgmPIxfAbUi+VCt
         e9XijBS2tyzRuhqAALpTMlfkEEIYzWbYTKYVAyXT32mv58K6bRuUZp4wxygaqh/B7TQp
         QYenToYYKkAKySOidefz0PSYleAk6KG9ZAdmjuzEjpsyMntLPkUuKdqaDoOJgW8UczsD
         4St4qvovwzPik0lTJbI9UeHKXYPe40gePVx01IK/N3HlfraWaNKwPEpH/6/ogMl9fKpF
         /8kQ==
X-Gm-Message-State: AHQUAuZhbPKLBMPw3fR5ZONGKxGuBJUFFu7JEFOufn1JJQe9IBMa1lnn
        vxh829QKeDeuc3yUSg56qQPAKQ==
X-Google-Smtp-Source: AHgI3Ib9yqSWNGDv0oxJLTQU42sXrkWByJ33LDqsRQHuoyPdA4nX4m9DT5xpLf8X3lS5PP7G07sMbQ==
X-Received: by 2002:a63:4652:: with SMTP id v18mr19820926pgk.356.1550731456125;
        Wed, 20 Feb 2019 22:44:16 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b4sm22777892pgq.57.2019.02.20.22.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 22:44:15 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: qcom: qcs404: Add rpmpd node
Date:   Wed, 20 Feb 2019 22:44:34 -0800
Message-Id: <20190221064434.2760-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190221064434.2760-1-bjorn.andersson@linaro.org>
References: <20190221064434.2760-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rpmpd node on the qcs404 and define the available levels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 35 ++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index 6c86b267da82..1ceb0432af55 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-qcs404.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -240,6 +241,40 @@
 				compatible = "qcom,rpmcc-qcs404";
 				#clock-cells = <1>;
 			};
+
+			rpmpd: power-controller {
+				compatible = "qcom,qcs404-rpmpd";
+				#power-domain-cells = <1>;
+				operating-points-v2 = <&rpmpd_opp_table>;
+
+				rpmpd_opp_table: opp-table {
+					compatible = "operating-points-v2";
+
+					rpmpd_opp1: opp1 {
+						opp-level = <1>;
+					};
+
+					rpmpd_opp2: opp2 {
+						opp-level = <2>;
+					};
+
+					rpmpd_opp3: opp3 {
+						opp-level = <3>;
+					};
+
+					rpmpd_opp4: opp4 {
+						opp-level = <4>;
+					};
+
+					rpmpd_opp5: opp5 {
+						opp-level = <5>;
+					};
+
+					rpmpd_opp6: opp6 {
+						opp-level = <6>;
+					};
+				};
+			};
 		};
 	};
 
-- 
2.18.0

