Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7FBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB8F2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 04:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k/U5KQRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAB8F2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeKOOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 09:20:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35458 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbeKOOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 09:20:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id v9-v6so9022206pff.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 20:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unRYDw9DEcNk9vR7FwPu/Jgntc5FVOSU2XbYUOkcXyg=;
        b=k/U5KQRq16YbYz5FSidO9xXd9ostErwtDHN/k/6Qj5ybSypKrub5iMcaxM7TjC1sUp
         QHBKLpi5NlNcKmAoGRg2ToJjUJrcOC8+s2teuqUKhrXQjpYV6GDOazHVzY2XEDa4YYqX
         +nQcHJX7bG3gvEylL9pwdYxjuKNxy8qrxhPdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unRYDw9DEcNk9vR7FwPu/Jgntc5FVOSU2XbYUOkcXyg=;
        b=Y4wBY17hgBY86Iqy9D7/nY1SwszkOMkDpeLwmoPOvRuxhZGAWntSNBKx/Qb44LFLgn
         qImualTlrKnl/vOWjOoICeG/kXzQCwqW29MXwMlenf1BoB3UtTbXHuWvKuaNxWC1Kze0
         HykifVKGQQ59WDWEXZGMswRafh9h54w9Su3/zU/XK32VIuWrtNR/X2y+brMI3BmIv7jR
         ya3dljTU8puWT2aF8SLdR8bsgUfdcaQl8KlzWzo0ZqTk2FtOJ61QcmWeq4ktIef/CYor
         mMkpewJcbJSWKlInK0Mk2W34AAXD9JK731yAAD8mw0ESWxzZoXhDjaFX1b3C2/HOj0SW
         X1MA==
X-Gm-Message-State: AGRZ1gJsTYkqid2EPtzIbtQz2xI6uVy9i6kEdx+rI1ZkrlU4/kNPHOBJ
        mYNiWzoivxW5AbER3/lQVzRfGUEeq9A=
X-Google-Smtp-Source: AJdET5e7X2Bxl76vEddfTP3HbamnEoMP/as4cLXlTm3C24vF5saPvQeLWNa4MBuS6wcmYzkCaYRQrw==
X-Received: by 2002:a62:9a09:: with SMTP id o9-v6mr4920191pfe.229.1542255242261;
        Wed, 14 Nov 2018 20:14:02 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id d11sm10976297pgi.25.2018.11.14.20.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 20:14:00 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] ASoC: rt5663: Add documentation for power supply support
Date:   Thu, 15 Nov 2018 12:13:33 +0800
Message-Id: <20181115041334.79446-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
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
 Fixed the commit title of v1.

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
2.19.1.930.g4563a0d9d0-goog

