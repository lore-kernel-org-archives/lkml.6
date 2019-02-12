Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408DFC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AE12083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DDKaRtFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbfBLODI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:03:08 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55491 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfBLODF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:03:05 -0500
Received: by mail-wm1-f66.google.com with SMTP id r17so3038789wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dulm1bU9WtsfyglzYBfpic3H5/a+/roIjKv2vYQ8/qg=;
        b=DDKaRtFgKO7VzFN3HDS4BSseE07cHdEL2YnMBj5rNfi4sdbaVkIJHhlvDCSgVwbNgc
         wcTWHqrO4lr5n1X2fyNzKUlAyr94HWE1W4vyjSIlMWbgs6O0YqrUBsXo4X0R42s8W9+A
         3+4PA7KeXrPYmDkwPdLwp9KEltX4bvhCs9rf5nWy9x1Q24o9NM0DR3/6M7Pmw45c97Wt
         M2wrfLuZy4gAqor7FHhhDO9sKcuU8ywd8BMXZtwGSXWPWAr5b6kcStJPlpuoqwvgAoi3
         PZY76QWsSBEVeqzXnvkiHgjwmKSSLuBdR55cJf0DqQofKrr0G+b7MwjgnLnwZX9BZI1r
         IWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dulm1bU9WtsfyglzYBfpic3H5/a+/roIjKv2vYQ8/qg=;
        b=HB6woTI6DQkJhJoPz7KgT0RFiYDZXZ7GxqUGUhtBhW2xBzgM+Ek+sY+7FFh1z0GtB6
         1FpEhuKm2YbDVkTZX2xIppBh+bY7DFz5xV/4VrMPkQHFZ6xqggjLMw0GXZ/LTeVzsJ/a
         3dPk9W8nRMgj4hrGf8yAMFyxRRutg+dHZpvOrH+87bHg2mPRJvLBM3zgZshPxyMUNFRa
         DSobnua07RLcvTlMOOwptOiQ8Ar2uCRiXW0aq65R1AXJUybvEpoSI9T5TQoPXK3pP1+Q
         7g7l3NWI0WTb1DHd1VVooXIHIhz2dzBBwqf7HfSB3G8f1gaPze6gaiwQ5sldSFRsFpU+
         7s/A==
X-Gm-Message-State: AHQUAuYqwk7oQFelcgoduUC3jmmH2IxbBMmKORiYhuyotd/VvN9vMrLe
        XUDJXGxl/YCwPtke0A1HG032aQ==
X-Google-Smtp-Source: AHgI3IYMiZchpHwXlRRXUxNBcje3WNreoRMlf+KDfkg3zQC6oxYJP3FScpJukr1yLGZK+OO4ykSc/Q==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2886191wmh.119.1549980183432;
        Tue, 12 Feb 2019 06:03:03 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g10sm23435678wrq.81.2019.02.12.06.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:03:02 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] vendor-prefixes: Add prefix for Shenzhen SEI Robotics Co., Ltd
Date:   Tue, 12 Feb 2019 15:02:58 +0100
Message-Id: <20190212140259.9537-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212140259.9537-1-narmstrong@baylibre.com>
References: <20190212140259.9537-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for the Shenzhen SEI Robotics Co., Ltd, a chinese ODM
specialized in Android TV HDMI Stick, OTT Box, Hybrid STB,
Smart Home Gateway & more.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 4615d4b9d11e..921ad8f88ed3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -343,6 +343,7 @@ sandisk	Sandisk Corporation
 sbs	Smart Battery System
 schindler	Schindler
 seagate	Seagate Technology PLC
+seirobotics	Shenzhen SEI Robotics Co., Ltd
 semtech	Semtech Corporation
 sensirion	Sensirion AG
 sff	Small Form Factor Committee
-- 
2.20.1

