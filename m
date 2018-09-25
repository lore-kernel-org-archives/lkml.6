Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4B0C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE5420880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bE81JUs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE5420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeIZDMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:12:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeIZDMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:12:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so12424889pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 14:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eyasd9LeN0Hq1bLAqjqNpTccpozPBLiTCraE4fo/jEU=;
        b=bE81JUs2T6Vh7EI6r0VSoMPyUZLy/eEzJDErbSuRtbczvTgvkadRbGu98ieiOBCrOV
         +Jw6oVJVEPGZVM0o/mdQeqQpDGqCC4QAe2+vI7XwOpVURTtoStm63FgO5fgtYz3LBCHO
         Ulpz2qC/aMXhhhRjguZ22nxu2vU8cqw26F2dU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eyasd9LeN0Hq1bLAqjqNpTccpozPBLiTCraE4fo/jEU=;
        b=CRuWoy+abCzjj6vv/aAVGdLfAo00vNSgorjEicbVVEsQpQN9gjXMwx/MC/S/gVxBOi
         ljYDl3iwTl13xwVlBodvXyGahmrukYKi9T3Ne3GywFomzfg1sOv59Duxo9AIzaP/zpPn
         aCGTB2UgCxpfo/kcG2zBWd4pzwVBM/s2Ib37obb4YY4Vru6B85280fA6xLhEaxtUKKR0
         cT9y9BBt37UeRIGVEiXH3HitQJMrSytivbYNz8ZxemQejHadyulOOTFRrLgh9ohfdyuw
         Bbey2rKfjN4J//UDvZ9GVtJGWoQpN7+aC4RNdRCuzf003jG3+DazPbpskZY7yj/2K5ai
         ZIVQ==
X-Gm-Message-State: ABuFfojNwiQxNIUi4W5EOsk99lK8s2lp4PTxHnMax/hyDSxodUIgD65k
        dcugQ1/1OHRaTxuQbb/iWTMstA==
X-Google-Smtp-Source: ACcGV61BBUqpTiOLOmZyehaUCvjSAYdCsdXRkBZyrvPM0Yv8HeVuc5eaGotRTPC5zwVSsjgLdocdrg==
X-Received: by 2002:a63:fa49:: with SMTP id g9-v6mr2715055pgk.18.1537909390331;
        Tue, 25 Sep 2018 14:03:10 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y4-v6sm3704061pfl.188.2018.09.25.14.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:03:09 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] dt-bindings: Add bindings for aliases node
Date:   Tue, 25 Sep 2018 14:02:55 -0700
Message-Id: <20180925210255.172734-1-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a global binding for the 'aliases' node. This includes an initial list
of standardized alias names for some hardware components that are commonly
found in 'aliases'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 Documentation/devicetree/bindings/aliases.txt | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/aliases.txt

diff --git a/Documentation/devicetree/bindings/aliases.txt b/Documentation/devicetree/bindings/aliases.txt
new file mode 100644
index 000000000000..d64ed1c7eb34
--- /dev/null
+++ b/Documentation/devicetree/bindings/aliases.txt
@@ -0,0 +1,47 @@
+The aliases node
+----------------
+
+The aliases node contains properties that represent aliases to device tree
+nodes. The name of the property is the alias name, the value is the path of
+a the device tree node that corresponds to the alias. The path may be
+specified as a string or a phandle.
+
+Alias names are often suffixed with a numeric ID, especially when there may
+be multiple instances of the same type. The ID typically corresponds to the
+hardware layout, it may also be used by drivers for a stable mapping of
+device names and hardware entities.
+
+Alias names
+-----------
+
+The devicetree specification doesn't require the use of specific alias
+names to refer to hardware entities of a given type, however the Linux
+kernel aims for a certain level of consistency.
+
+The following standardized alias names shall be used for their
+corresponding hardware components:
+
+  bluetoothN		Bluetooth controller
+  ethernetN		Ethernet interface
+  gpioN			GPIO controller
+  i2cN			i2c bus
+  mmcN			MMC bus
+  rtcN			Real time clock
+  serialN		UART port
+  spiN			SPI bus
+  wifiN			Wireless network interface
+
+The above list is not exhaustive and will be extended over time. Please
+send patches to devicetree@vger.kernel.org if you think a hardware
+component and its alias name should be on the list.
+
+Example
+-------
+
+aliases {
+	bluetooth0 = "/soc/serial@fdf01000/bluetooth";
+	rtc0 = &rtc0;
+	wifi0 = &wlcore;
+};
+
+(based on arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts)
-- 
2.19.0.605.g01d371f741-goog

