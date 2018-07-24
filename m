Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E51BC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242E520880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242E520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbeGYA7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:59:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34023 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeGYA7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:59:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so3975036pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 16:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Exi7HMPcV1G1oRW8v/W+zZ9QH0uoOn9Qtr09/+QpU80=;
        b=MfdDFQMaFe3hc0mQX38eOMa8l2MRe0MG+mj7ZbnsGIhC53XvegOSd++amioPAEhfZV
         xAo+vzI1LQvZ6YFhpu9aWKR/UYjBTSMjVNylYLX7ovlf4c/uSvSEDeQwq77BvZlOg6cT
         JQycjjLVDoOzPS1FGLrOYKZ/GVkX1L8oBaBA849qKnoGiEYwAjFuNCThtMY83O1A4cZ4
         Ra/SM3WuLXSaDXCPrLXjGzq8A09Q6xU5/Aut5X6pqfPppyNwBnmILutNBBA7ecOcrVTU
         h04cBZXSEN2rdVvwMUQObMCYfd5ywErpL5eTCXwMehCvWJ+tOEwDydStcIlOqL5dNzti
         Ca4g==
X-Gm-Message-State: AOUpUlFooiqJmjO8EuRBf6G/eMXyIlBd+b9PJ2WcJgNzkB53KHB+qbDY
        yHt/2eLeeaS+mWzzooa3n9qN0A==
X-Google-Smtp-Source: AAOMgpcfsX1qzT2g7KZbUa2Pud9l+KrxKXDHYDPtCYgfi0MfPYfKViSyJ7OoDtldHnml5YgoyzALAg==
X-Received: by 2002:a62:e00a:: with SMTP id f10-v6mr19737599pfh.208.1532476245663;
        Tue, 24 Jul 2018 16:50:45 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id x65-v6sm7788035pfk.140.2018.07.24.16.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 16:50:44 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve thermal zone in example
Date:   Tue, 24 Jul 2018 16:50:35 -0700
Message-Id: <20180724235035.58146-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current example for a thermal zone isn't very useful as reference
since it would result in a hardware shutdown at 145°C, instead of
allowing the system to try to shutdown gracefully. Without an ADC
channel a maximum of two trip points is useful in practice for this
sensor, with temperatures corresponding to the stage 1 and stage 2
'hardware trip points'. A critical trip point at stage 2 may allow the
system to shutdown before a hardware shutdown at stage 3 kicks in. It
should be noted though that by default the chip performs a 'partial
shutdown' when the temperature reaches stage 2, which may prevent an
orderly shutdown. The 'partial shutdown' can be disabled by software.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 290ec06fa33a..cabf813595e5 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -36,19 +36,14 @@ Example:
 			thermal-sensors = <&pm8941_temp>;
 
 			trips {
-				passive {
-					temperature = <1050000>;
+				stage1 {
+					temperature = <105000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
-				alert {
+				stage2 {
 					temperature = <125000>;
 					hysteresis = <2000>;
-					type = "hot";
-				};
-				crit {
-					temperature = <145000>;
-					hysteresis = <2000>;
 					type = "critical";
 				};
 			};
-- 
2.18.0.233.g985f88cf7e-goog

