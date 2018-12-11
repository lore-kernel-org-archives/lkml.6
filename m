Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BE6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7828320870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hyGRahYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7828320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbeLKQWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:22:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55964 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbeLKPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:44:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so2675553wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3D2raQMukEX70jUMwg9ACQ2h5hM2z+quJDGcBrzJ8g=;
        b=hyGRahYJJLKok3h32nnGoLViknE8anNZs9YI5GT56/Vt48MNn/PkLM3UqJviVTWPzP
         L1LRXA6bhbyJZdFIYy7ab0Ej1zIEUvJ+Segh1H795+ZTdRNkq4cfyGGg5SueUzC+XdS8
         v8SCR5m2Dx0phrgNyZjEzaYiIZGBOCXBV76HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s3D2raQMukEX70jUMwg9ACQ2h5hM2z+quJDGcBrzJ8g=;
        b=QjYucgrpU4B2/FlKDuCc7ZEpIWSFhfd/I/ENUb0XnvehaE1kVmFNtKUZqFKKzrSJMN
         kzW21piU0yKUF9fEU+QYeu3voCONNDJYomFKHw5vvT/JPXkZ7KxRDBGWxchDS+O8dMNU
         fBoOo7rvx3r6ZnhZdNii24OdGWkijlWlTvYD0D84mFpnjSvG5kv7Dop/mQF9du0L/rHc
         McVJ2ZLVpDmM+Q2kQm2AAULn4T16Z3ynqUyWdV9rvOxiWYaKSIDlooSZeB+VXFdkBfJJ
         rXa+rP/EypJJeW34SSRukfmeImg8F33lNZznbdR29UmGp6pYrkUNmf22bXceMStC7CRg
         YgOw==
X-Gm-Message-State: AA+aEWZ6lTaUQwojnt4lAg4+YIoYMI8/N3oP4BbQmefj0WrOb/pX1/xG
        Ve4q+0LlFnEvMaHx3tRwHweMbw==
X-Google-Smtp-Source: AFSGD/WjWACLP9wS5srXpaS0qZ/2WaeabJ20I8a+HCcLVOObRojo82UC5NcbU1uNKYglWfecRtH3PQ==
X-Received: by 2002:a1c:da92:: with SMTP id r140mr2920707wmg.136.1544543051990;
        Tue, 11 Dec 2018 07:44:11 -0800 (PST)
Received: from localhost.localdomain (ip-160-131.sn-213-198.clouditalia.com. [213.198.160.131])
        by smtp.gmail.com with ESMTPSA id t70sm396499wmd.36.2018.12.11.07.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 07:44:11 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 1/2] dt-bindings: panel: Add Sitronix ST7701 panel documentation
Date:   Tue, 11 Dec 2018 21:13:57 +0530
Message-Id: <20181211154358.25293-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel
with inbuilt ST7701 chip.

The default regulator names in ST7701 chip is renamed in Techstar TS8550B
so, add specific binding names for them.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v5:
- found the chip from vendor, so added new chip binding
- here is v4: https://patchwork.kernel.org/patch/10680333/

 .../display/panel/sitronix,st7701.txt         | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
new file mode 100644
index 000000000000..ccd17597f1f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.txt
@@ -0,0 +1,30 @@
+Sitronix ST7701 based LCD panels
+
+ST7701 designed for small and medium sizes of TFT LCD display, is
+capable of supporting up to 480RGBX864 in resolution. It provides
+several system interfaces like MIPI/RGB/SPI.
+
+Techstar TS8550B is 480x854, 2-lane MIPI DSI LCD panel which has
+inbuilt ST7701 chip.
+
+Required properties:
+- compatible: must be "sitronix,st7701" and one of
+  * "techstar,ts8550b"
+- reset-gpios: a GPIO phandle for the reset pin
+
+Required properties for techstar,ts8550b:
+- reg: DSI virtual channel used by that screen
+- VCC-supply: analog regulator for MIPI circuit
+- IOVCC-supply: I/O system regulator
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "techstar,ts8550b", "sitronix,st7701";
+	reg = <0>;
+	VCC-supply = <&reg_dldo2>;
+	IOVCC-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

