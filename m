Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332C02145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 02:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fozUjd/w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332C02145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389253AbeKPMXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 07:23:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33793 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeKPMXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 07:23:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so9612938pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7KMfBGq1zleDXk2tIXwLz1VcjicjRlXzvKzqntLxKA=;
        b=fozUjd/wqKo2gI9UE3oy0U1Kp15FoToznX3ds/OJIiv+1Q2Gl/BBhLwm3yQujE5YEC
         z0f+0LwFYS7CtDNO39FB+WY9v4ObQfDqoYuNikNv2pQ2PX9sI30wNCttxXvoU3uQtg4s
         sClLTdKbEFKQ7brzlqi/Zbz1r4xDpV0Iih4Kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7KMfBGq1zleDXk2tIXwLz1VcjicjRlXzvKzqntLxKA=;
        b=lqYKY7+cTrJUE7B96+tTXjcq8cdwrBlBHksZy74x6MElXWkqPzZ+sGNwCLTiNIYbIQ
         WckC/C98n+9GR8ZH7SE/xnS/uUkaNiP+tlour+igZFkp29HAlsSf45wpy59HJZ0Xdfew
         ljeBVZDfiNSForh/ubaHqmLwVTfDZY7omPyF4uX09ITcgSyB3BVURAcysH35oebA7q4S
         EbD5LQNktceC3x7j4dYPp/iHFanpnOFkSQkvNGOl4NS0eVY+L5LGjRowlINImURP9LZN
         Yt/NuWOk3p5Ezw0K0wToVFXqsN980WzQYWL8uQj9CDjwwlrQVwvdWx1xbdGnLMMYa+Ai
         kgLA==
X-Gm-Message-State: AGRZ1gKrnPeJk2/aIXYM2spBNC4PVydb9L8vEhuhjFTpy5o/uan3pA1N
        KvXMuPXtbaOzfRTQaHqVUP8Gpu328RM=
X-Google-Smtp-Source: AJdET5dHFLsVfeS5YLjiQRb+huzDbocKza37UVlBgk0Jr5dhvGRn0MrWGGRED1tDr8hO3kfPGIh82g==
X-Received: by 2002:a62:8a0d:: with SMTP id y13-v6mr9115425pfd.142.1542334384485;
        Thu, 15 Nov 2018 18:13:04 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id b27sm19576389pfh.113.2018.11.15.18.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 18:13:03 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] ASoC: rt5663: Add documentation for power supply support
Date:   Fri, 16 Nov 2018 10:12:43 +0800
Message-Id: <20181116021243.179183-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rt5663 codec driver will support setting CPVDD and AVDD power supply
from device tree.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 Moved power supply properties to required properties.

 Documentation/devicetree/bindings/sound/rt5663.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 23386446c63d6..2a55e91334082 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -10,6 +10,10 @@ Required properties:
 
 - interrupts : The CODEC's interrupt output.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Optional properties:
 
 - "realtek,dc_offset_l_manual"
@@ -51,4 +55,6 @@ rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	avdd-supply = <&pp1800_a_alc5662>;
+	cpvdd-supply = <&pp3500_a_alc5662>;
 };
-- 
2.19.1.1215.g8438c0b245-goog

