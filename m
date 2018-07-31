Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FD1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A4D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQWFdBoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A4D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732310AbeGaUlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:41:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43784 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbeGaUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:41:29 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so7559783plv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF9UpcqWCQAPpTAYxBGWl2YKXDfCJhhLRmXour3w3OY=;
        b=TQWFdBoE6fDW3+ojfccdOKCF4n+hPOnUqIpUomM77kF65HNnzRy3s4Cg4XdoQEj9m+
         R5zj9gOIqHAuT9bBPI0Rd4m6QEuy7PnlUmbtzdvOpzExAM5cTIYqmOHLCu3IvMa+akjK
         n7WbASlFcJDSJo2EZHIJQap9WLiZV/vWZeU4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gF9UpcqWCQAPpTAYxBGWl2YKXDfCJhhLRmXour3w3OY=;
        b=S7knymP6NodB+2LQNu9y9ddEU5H1Komr34UW4uG6yYgjViMyOu1IeOLousmPg8XwPT
         CT9FV/K1fmqO/7QW8eHSuTMCFBdziyD6T6OrOoOqbF+awW05b8ahgHET/SIRE1qX29CY
         d7Kete6CKdOlgJS9Q+PjPVyGuan3+gkp84ZXjIUPlWZrZjpEHkn6kyrQm3WzqPr2wUhY
         pJcoe0TNIO/JNDRs0GR7RiOqOvPiIU0ZbOp4gafxt8MN6Ug1tkmo6H/ATAp/kK9xf+M+
         Ef84otFJQ+4UNByGntMIUIy1rjWV3uuBzooGQer0BMDyorJqDlKLJ1J1CWtyRaRFdf2i
         M+Pg==
X-Gm-Message-State: AOUpUlGQiWJwIIGPVBeeOLm7OX+88mcYhApx0WqGE0PV5PLtIdi/19Xx
        24L0VMiFeqrAEqDnsQ2lShdzfw==
X-Google-Smtp-Source: AAOMgpcqzJc3hmXPEdwz13ByOlAarWASYs+m/Q4qcT9wftzAhBtfdbuPziO/G7gZsw26X4RIlk7YDw==
X-Received: by 2002:a17:902:aa07:: with SMTP id be7-v6mr21362210plb.109.1533063589092;
        Tue, 31 Jul 2018 11:59:49 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e132-v6sm27797567pfc.49.2018.07.31.11.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:59:48 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     linux-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v6 5/5] arm64: dts: qcom: pm8998: Add pm8998 thermal zone
Date:   Tue, 31 Jul 2018 11:59:17 -0700
Message-Id: <20180731185917.176074-5-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
In-Reply-To: <20180731185917.176074-1-mka@chromium.org>
References: <20180731185917.176074-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal zone uses spmi-temp-alarm as sensor, the trip points
correspond to the PMIC thermal stages 1 and 2. The critical trip
point at 125°C disables the partial PMIC shutdown at stage 2.

Without an IIO input the sensor only reports a limited number of
temperatures:

- 37°C for temperatures below 105°C
- 107°C for temperatures >= 105°C and < 125°C
- 127°C for temperatures >= 125°C

(the numbers correspond to a stage 1 threshold of 105°C)

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- added 'Reviewed-by: Douglas Anderson <dianders@chromium.org>' tag

Changes in v5:
- removed 'stage2-shutdown-disabled' property from spmi-temp-alarm
- updated commit message

Changes in v4:
- updated trip point temperatures to match stage 1 and 2 ones
- disabled stage 2 shutdown
- updated commit message

Changes in v3:
- moved 'thermal-zones' node to the beginning of the .dtsi

Changes in v2:
- defined 'thermal-zones' node in pm8998.dtsi instead of using a label
  to refer to it
- use 105°C hardware trip point as critical trip point
- reduced number of trip points to 2
- lowered temperature of passive trip point
- updated trip point names and added labels
- updated commit message
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 7eea94701b23..34c259ba3919 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -3,6 +3,31 @@
 
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
+
+/ {
+	thermal-zones {
+		pm8998 {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&pm8998_temp>;
+
+			trips {
+				pm8998_alert0: pm8998-alert0 {
+					temperature = <105000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+				pm8998_crit: pm8998-crit {
+					temperature = <125000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
 
 &spmi_bus {
 	pm8998_lsid0: pmic@0 {
-- 
2.18.0.345.g5c9ce644c3-goog

