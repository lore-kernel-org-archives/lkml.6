Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD43C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167F820671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iaTVQzRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167F820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbeGZLc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:32:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbeGZLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:32:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so1136163wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ENZofE7rLYWcxjfiJCIPIpNi/ojvJ4EzE7VCTDWknw=;
        b=iaTVQzRPR68G71onRxYzKrl0jnyqMsbEuojHp/v7P/n9rLmoTXeDvN95OFxc/fAb5m
         ov5Ujg/k+XQWt280017CcjZ2G3pzurhprf02oLUVKYOBeEUhaRLRGCcV4nUs47s96jJE
         NzlWaDvn88zCjBInlNTB5UYjSARXxcozwUhmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ENZofE7rLYWcxjfiJCIPIpNi/ojvJ4EzE7VCTDWknw=;
        b=RT0NC29rPDIHGlagH8CFeg1AF6+G6o5hkpMSJKgcwncDT3pDb7H4qZWp3clKiSMKqP
         Dx5jyZ7qNoe6njuonvd0A5EfVjKtntr5GQuuEwDr2VVs+TTcsTAryfVmjHOQBIhPjpQp
         njZ+s1erkNsvxvMAxThy0JD1E2BzxKo169O1a7BYp/amkNS+kkXZLTMEk9YJxaC/TAo/
         +NNwdybdN50Lan9IJICdKMSo7b76/IduxFz0E50IYOpE6e1Jnwq4UKB0zV+igqVBCzuc
         wfW6JBTaptEuFIP5/YjzztSPQLu4iqZXh4i95jgUBp4muHQmVUa91mEXkxWIlkTSQYpA
         yYiw==
X-Gm-Message-State: AOUpUlESYGqhzwqONKedXvWoAMMD1za4VF1qS6bOGBNCpDj9VzbYcsqN
        3E5qpOtYIgzxmranO/ehvJa7ZQ==
X-Google-Smtp-Source: AAOMgpc93GjpvuDnBUdfhapO3IV36MkxqATqFz/RVaEdADxVgbdwdT5JU297wXO2MjlZIWgBnG3mgQ==
X-Received: by 2002:adf:9226:: with SMTP id 35-v6mr1021208wrj.44.1532600175977;
        Thu, 26 Jul 2018 03:16:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id f6-v6sm957303wrp.30.2018.07.26.03.16.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:16:15 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        baolin.wang@linaro.org, Sudeep.Holla@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 2/7] clocksource/drivers/timer-mediatek: Add system timer bindings
Date:   Thu, 26 Jul 2018 12:15:25 +0200
Message-Id: <1532600131-28168-2-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

This patch adds bindings of new "System Timer" on Mediatek SoCs.

Remove RTC clock in the same time because it is not used by
both "General Purpose Timer" and "System Timer" now.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/mediatek,mtk-timer.txt          | 34 +++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index b1fe7e9..18d4d01 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,19 +1,25 @@
-Mediatek MT6577, MT6572 and MT6589 Timers
----------------------------------------
+Mediatek Timers
+---------------
+
+Mediatek SoCs have two different timers on different platforms,
+- GPT (General Purpose Timer)
+- SYST (System Timer)
+
+The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
-	* "mediatek,mt2701-timer" for MT2701 compatible timers
-	* "mediatek,mt6580-timer" for MT6580 compatible timers
-	* "mediatek,mt6589-timer" for MT6589 compatible timers
-	* "mediatek,mt7623-timer" for MT7623 compatible timers
-	* "mediatek,mt8127-timer" for MT8127 compatible timers
-	* "mediatek,mt8135-timer" for MT8135 compatible timers
-	* "mediatek,mt8173-timer" for MT8173 compatible timers
-	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
-- reg: Should contain location and length for timers register.
-- clocks: Clocks driving the timer hardware. This list should include two
-	clocks. The order is system clock and as second clock the RTC clock.
+	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
+	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
+	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
+	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
+	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
+	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
+	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
+	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
+	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+- reg: Should contain location and length for timer register.
+- clocks: Should contain system clock.
 
 Examples:
 
@@ -21,5 +27,5 @@ Examples:
 		compatible = "mediatek,mt6577-timer";
 		reg = <0x10008000 0x80>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>, <&rtc_clk>;
+		clocks = <&system_clk>;
 	};
-- 
2.7.4

