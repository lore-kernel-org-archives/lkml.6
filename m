Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ACAC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75EEE208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZY6tr+zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EEE208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbeGaUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:41:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37593 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbeGaUlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:41:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id n7-v6so9540905pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pregnSMfkOaGBP4vqZw3v3Rj/ItF+UeK9Knvf5WfDP4=;
        b=ZY6tr+zYY40u8HIGlHlv7yUWn4nd25P9iTfaiSsJk0cobiYOamYX5s9xCpzYB6XMyv
         O9s+4uj0n05Wjf+zetTSTyamcEimvSziJ3UZiTjet5j2z3HW1KnBnVSjdef402dHCCqt
         LUngiV0pXnXmV5QF/u406B8pLXIM6P4IvQiLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pregnSMfkOaGBP4vqZw3v3Rj/ItF+UeK9Knvf5WfDP4=;
        b=ll9MVk+dqDIfUoqIhulk88YdMJwNCA1yPAl8+0iTHdMkjMO3lCuSq0/EW8e8iwsqK3
         olPFC087Vi9wt/vzarZt4qreAJ+DE1vMSAhsBGZa26Q6wndq5fl9HH/kB1npX4yTH834
         wIZtG+4GjhZ7+DBysEx1Iecujwm+RGDdtYd1p48ykXtZW998TG2sE1J2//PJs+eQmW+C
         f55j3JEUmu6++MC1YH+ofNR/HBhdgySaz/2dGkLNyb10qhPmAPYYjmKJy57JR/gs1j/x
         jDPc6dSRaRaz2J/GPsBPkjsdLDeREMoHzte8+T1GUclfPPfc5GQZovwMIYzq2RxiUlUx
         TB0w==
X-Gm-Message-State: AOUpUlFsF5AUfin/bqLiP6FstQva9ZIRxT8Uy3aJuGGnHuoEhyBpd5T+
        xgduJ9e+mj//2gpnSDT5i+N6BA==
X-Google-Smtp-Source: AAOMgpd8xxnEWfHqO2sUp+cEmFEzipR/+YKCkPW+qO2/mgpwGOvmtbpEcEIPjXdIVhWmcfUNUZmgUQ==
X-Received: by 2002:aa7:8591:: with SMTP id w17-v6mr23605077pfn.77.1533063583758;
        Tue, 31 Jul 2018 11:59:43 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e132-v6sm27797567pfc.49.2018.07.31.11.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:59:43 -0700 (PDT)
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
Subject: [PATCH v6 1/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
Date:   Tue, 31 Jul 2018 11:59:13 -0700
Message-Id: <20180731185917.176074-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation claims that the 'reg' property consists of two values,
the SPMI address and the length of the controller's registers. However
the SPMI bus to which it is added specifies "#size-cells = <0>;". Remove
the controller register length from the documentation of the field and the
example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- patch added to the series
---
 .../devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..86fb41fe772f 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -6,8 +6,7 @@ interrupt signal and status register to identify high PMIC die temperature.
 
 Required properties:
 - compatible:      Should contain "qcom,spmi-temp-alarm".
-- reg:             Specifies the SPMI address and length of the controller's
-                   registers.
+- reg:             Specifies the SPMI address.
 - interrupts:      PMIC temperature alarm interrupt.
 - #thermal-sensor-cells: Should be 0. See thermal.txt for a description.
 
@@ -20,7 +19,7 @@ Example:
 
 	pm8941_temp: thermal-alarm@2400 {
 		compatible = "qcom,spmi-temp-alarm";
-		reg = <0x2400 0x100>;
+		reg = <0x2400>;
 		interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
 		#thermal-sensor-cells = <0>;
 
-- 
2.18.0.345.g5c9ce644c3-goog

