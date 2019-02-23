Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4733C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78ED920675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2vB15Nm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfBWNIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:08:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37849 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfBWNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so4238303wmg.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aFmdTDn+1DhlKxKeSwBRQMFH12sZspvNOM68gN8DFWg=;
        b=G2vB15NmEEv1XB4bfYMuhjNctr2a70JxJ/zvx37GB5wt6WquYw51tBA5XktIKFO8jn
         NAWphxrJ9A8/QNRxoSA718uc6c8JC2jm0e935vqXuJ5hliVk0DnSma0qM2H8UhKv+kR0
         joZolxC9lDojsCEZVIE60Lh5jcviPtz1FA+o34mBDNd+fQIk8FjpxNCmdNnNJ4kA6ydq
         kcMVV+jlIQl+xurqKehMsHmV5c9NYCxz0cLnXQyC2+sHphT/Iq1Tsh43LuseU0s25/GY
         3qx35JLiDY0ZlJ9ao0LTez0vlvUQnlHJ1r2exuuLIvFIxNgNz5yVeIFpGodzzD2OPI9b
         NjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aFmdTDn+1DhlKxKeSwBRQMFH12sZspvNOM68gN8DFWg=;
        b=A3XHNAtLUSLG8wXx8BQRQn09gWq9DRuF4J1gULEO+RqSG3rspwI7+UfHFJ812DIoCV
         m9MAM/wj011WOnbSASAK4EIwOpIGoa/xx/zHQgKQSGXuf8XaI/U99gU8RUy/VIRihXLm
         p3Ge0lJCgWJa/VpzVgwskhDDD4Knh/VSBwfGHkotKIIi6HsDvcfOE28uGM64RvGErDr8
         t2pcuFXRukUWlTLZFbMmoCpl5g0oS9naDkK504o5sgmQZJNcCXs2zYLhYr/fTYPHU0s8
         s50MWYlmjLrR8OunsJTRyJS0pXdrsdMvXSMNbtQNvv0xyOEJw9gSDSkjMcTigBOcfb2A
         vGWQ==
X-Gm-Message-State: AHQUAuZXFrNe+vlpayLMCrSzPhCuFC72Hh2IFiA7t6QomD42y/CoGJYq
        +UYuau/fRAguLG/xbwIx79LpQA==
X-Google-Smtp-Source: AHgI3IbE3e7b7DmxlFI6vJD7yNqU/qn8vC/LHML6Oc7tO9WjRks1opAdike7HqSq8I4x0oVa83U+iQ==
X-Received: by 2002:a1c:740d:: with SMTP id p13mr2192011wmc.46.1550927291672;
        Sat, 23 Feb 2019 05:08:11 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:10 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [PATCH 10/18] dt-bindings: timer: mediatek: update bindings for MT7629 SoC
Date:   Sat, 23 Feb 2019 14:06:58 +0100
Message-Id: <20190223130707.16704-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>

Update the binding for MT7629 SoC, which uses fallback compatible to
MT6765 SYST, so add more descriptions to distinguish it from the other
SoCs that use GPT.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/mediatek,mtk-timer.txt  | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 18d4d0166c76..ff7c567a7972 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,7 @@
-Mediatek Timers
+MediaTek Timers
 ---------------
 
-Mediatek SoCs have two different timers on different platforms,
+MediaTek SoCs have two different timers on different platforms,
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -9,6 +9,7 @@ The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
+	For those SoCs that use GPT
 	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
 	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
 	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
@@ -17,7 +18,11 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+
+	For those SoCs that use SYST
+	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
+	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
+
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
2.17.1

