Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14158C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE4208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VtKNsFx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE4208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbeGaUl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:41:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35488 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732211AbeGaUlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:41:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so1448673pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 11:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XWHD3U11wghvwRII1kRUIs8QoNbRmHkZbA9xigt5SRw=;
        b=VtKNsFx2fc4xr3o3dPJ+5VUohYwrqfLv+Nz4/VQ6QNzrkXlR5hx6vBnYUJbhiFQfor
         tlObU1KQ9ZDN9Amr1kPyYq0pZAKphBl3Krt/5fn8kG9SjDmGeYDocJzvLM8yJWgPuipe
         ruVm1RLrL/HC2wvq70MbYskCB8Bb3LjraFb/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XWHD3U11wghvwRII1kRUIs8QoNbRmHkZbA9xigt5SRw=;
        b=s1UXEIBCalPSOdSJRUP+OIZqIWz0KhMEzaPRba2iTmEP0Dd90PlJ7TzQrT0iem2ZHK
         iaJ1WFtXfQSFVvxoAIuHQQuxV+EoYdKEshJRHNintFBo+roRvLMOcU96CpmQ5vQov9UR
         hL1stp6SpxcHcvDGu8S1E2psAxALqTTIo4h6iZF1uxb3bS/Qze7auTSpX9hkVQcpDS5w
         iKBEA2FfFUDaFwK8+ubwZLg3hrk3mNfjO/u/MlRtmhykU2JqbewIkTWDIBlqj7oMibIK
         CDqAoEmHP1tGWXBvIRqdFliyHp2y4fZKrEYlQ1ThK4A61VjEqYk21SacM0wunamuTfp3
         qiPg==
X-Gm-Message-State: AOUpUlGKb23/3zAKTNys+77dgUMkqhoIwITVYDWW7BKoGNI99yGq9tQl
        QfjTp8miQIMV0kWB6rCboWH06A==
X-Google-Smtp-Source: AAOMgpcqwTmDD5Ozvi7ayuWDmQ9nKxaf3SQSygz6tb6gXrX94F7Q864clnedanKKUMCy8q4QEVrOxw==
X-Received: by 2002:aa7:824d:: with SMTP id e13-v6mr23441782pfn.97.1533063585006;
        Tue, 31 Jul 2018 11:59:45 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id e132-v6sm27797567pfc.49.2018.07.31.11.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 11:59:44 -0700 (PDT)
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
Subject: [PATCH v6 2/5] dt-bindings: thermal: qcom-spmi-temp-alarm: Improve thermal zone in example
Date:   Tue, 31 Jul 2018 11:59:14 -0700
Message-Id: <20180731185917.176074-2-mka@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v6:
- patch added to the series
---
 .../bindings/thermal/qcom-spmi-temp-alarm.txt         | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
index 86fb41fe772f..0273a92a2a84 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
+++ b/Documentation/devicetree/bindings/thermal/qcom-spmi-temp-alarm.txt
@@ -35,19 +35,14 @@ Example:
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
2.18.0.345.g5c9ce644c3-goog

