Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33EAC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65F4A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HtJsnJqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65F4A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeKAVn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 17:43:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39593 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 17:43:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so8290361pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 05:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGdp9ZKJwg8hbaEdgskIM9KEKDkvXQybtx6r/e+gbsk=;
        b=HtJsnJqLEtbQXAM6V4qhfpHV1F6UqWAkFj9JYAmScvwteJ/RcpbYWxKqrt12I5W7zT
         HCbd7lgHWfuoRjydeU8fbYAsxL57hNzOEPsE5FTA0C7UoXxGK1wTlRZPhoUAKpusjOR9
         NipzD9xdWkwn2Ts85AJiN4c9VS0Uyj+Sgv+/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VGdp9ZKJwg8hbaEdgskIM9KEKDkvXQybtx6r/e+gbsk=;
        b=kcuNnIoVIkgITkWbNqVZTmKRemn+hO6hSZ1b8Mnd9Fe/y2ytYDLbZ3Cjj63oIMTq8Q
         mQUr8Ja1Us3i62TCFden0VFoyjHTSmCQLLCTJdTKCPWDD4zDSNAKJjYtH1wHKpJ/Rnhc
         tZ+RldIQK2MZJv5+WPUJPbvL8A3UX7i+JphHNjivnk+CPqvPvRGAcv/kXHivbTNok+hb
         1pfzFce2TKrcCMSls4Zt+leB9oXdkI6dYdpZwDlwHzEPyHVUg6P2KXULe4MjzR2G0irn
         UxjGSMc52wNHOOSNRkm4Z9C4sS5aYIQWMxUN/d05WFO0trBU2ljSPOhneJdvsB0H0HUG
         qkew==
X-Gm-Message-State: AGRZ1gIkUOEvKxTIXwqeibUO68El4plDK1UnlW+aDF8PiAfaVCkgr4rd
        5IgF1L9lXcVgIajDdXIVx8byzBS+Uw8=
X-Google-Smtp-Source: AJdET5eUtOLWKR9T0HY1zG37XFieaK02RE96eA7nllyLZpg4j/i2kMXrROCoihh46jIXwGXD1Qd4MQ==
X-Received: by 2002:a17:902:7b8e:: with SMTP id w14-v6mr7344061pll.289.1541076037267;
        Thu, 01 Nov 2018 05:40:37 -0700 (PDT)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id g20-v6sm10856210pfj.145.2018.11.01.05.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 05:40:35 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] CHROMIUM: ASoC: rt5663: Add documentation for power supply support
Date:   Thu,  1 Nov 2018 20:40:06 +0800
Message-Id: <20181101124007.243258-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
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
 Documentation/devicetree/bindings/sound/rt5663.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5663.txt b/Documentation/devicetree/bindings/sound/rt5663.txt
index 23386446c63d6..d4058dfde0392 100644
--- a/Documentation/devicetree/bindings/sound/rt5663.txt
+++ b/Documentation/devicetree/bindings/sound/rt5663.txt
@@ -36,6 +36,9 @@ Optional properties:
   "realtek,impedance_sensing_num" is 2. It means that there are 2 ranges of
   impedance in the impedance sensing function.
 
+- avdd-supply: Power supply for AVDD, providing 1.8V.
+- cpvdd-supply: Power supply for CPVDD, providing 3.5V.
+
 Pins on the device (for linking into audio routes) for RT5663:
 
   * IN1P
@@ -51,4 +54,6 @@ rt5663: codec@12 {
 	compatible = "realtek,rt5663";
 	reg = <0x12>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	avdd-supply = <&pp1800_a_alc5662>;
+	cpvdd-supply = <&pp3500_a_alc5662>;
 };
-- 
2.19.1.568.g152ad8e336-goog

