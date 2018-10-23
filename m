Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219CC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586E220665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 15:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nDZYTJth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586E220665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbeJXAPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:15:53 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44078 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbeJXAPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:15:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id w3-v6so845442pgs.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NRiFnFQmO06c8gbDZJ9nZvUMTAdDKJG1daWAYZ4wH/4=;
        b=nDZYTJthbAS700AB0GYWsXHuRI/lQxkVQGqbVjw5wCthpdUJWsQd0pX9Mee9BytBXJ
         ERog5/JmmRuv07+siJz8L21I5wejxeyziltWB+uKKCS/w+1oZb6r7j/TONszUv5ViJ+w
         zKd/4nX+Z7RH7sYjWTuJsI1GQlnG//FS0MrqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NRiFnFQmO06c8gbDZJ9nZvUMTAdDKJG1daWAYZ4wH/4=;
        b=SzWQPZWUteqgwGV+VzF+vKvLQ65aWuawc3PNd7IUvorKfD21v7TWI0BKKFDCPf1axF
         bjfg9nL3X0Le1Tvo+cwex5r56XvGHg0U7evigYocLTdq7TL+/zE1f4SVQdmR2Ga+F5UT
         z+noaPBYVSRB2NbFnmnSKPzh9ueUVpTQmOA6Tk+4llXfKEj3veJtVs5LDug+qwQ9qKjx
         XhOnblT1K4GzuR4SjNKfZqNmb0WVUP0FeUoMLX59kKlt000U6Pezm7QJdU+Fxq2Bnkzt
         HGTvESDlwD16ehGkiPyO3iXrdWrRDp9Lfw7gr66+4WVXlRRTV1+vFTdDbpVfUffUr5hb
         brPg==
X-Gm-Message-State: ABuFfohgEIt1fQeS92joYo2PlaTnPgy7KYuB0nKjhtV0gXWmfd9qfcgV
        67EQ3By3eeD2ouuHTPqUDWCodA==
X-Google-Smtp-Source: ACcGV60fxKUNm5uI3h7V/PkBURRubPQ/BisaA0zjnkdAXt0zMc9lDipf+Y0FsdIdN/RqqPlJFCkRQg==
X-Received: by 2002:a63:1e5c:: with SMTP id p28-v6mr47912857pgm.376.1540309915327;
        Tue, 23 Oct 2018 08:51:55 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id o75-v6sm7442829pfg.0.2018.10.23.08.51.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 08:51:54 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 10/15] dt-bindings: panel: Add Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
Date:   Tue, 23 Oct 2018 21:20:30 +0530
Message-Id: <20181023155035.9101-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181023155035.9101-1-jagan@amarulasolutions.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bananapi S070WV20-CT16 ICN6211 is 800x480, 4-lane MIPI-DSI to RGB bridge panel,
the same panel PCB comes with parallel RBG which is supported via
panel-simple driver with "bananapi,s070wv20-ct16" compatible.

But this binding is specific for MIPI DSI to RGB bridge panels,
which usually accessed using MIPI DSI controller driver.

for information:
- "bananapi,s070wv20-ct16" compatible for parallel RGB panels
- "bananapi,s070wv20-ct16-icn6211" compatible for MIPI-DSI to RGB
bridge panels

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- Add detailed commit message
- Update the bindings as MIPI-DSI to RGB bridge

 .../panel/bananapi,s070wv20-ct16-icn6211.txt  | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt

diff --git a/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt
new file mode 100644
index 000000000000..68a89b6feaee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/bananapi,s070wv20-ct16-icn6211.txt
@@ -0,0 +1,21 @@
+Bananapi S070WV20-CT16 ICN6211 MIPI-DSI to RGB bridge
+
+Required properties:
+- compatible: must be "bananapi,s070wv20-ct16-icn6211"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+Example:
+panel@0 {
+	compatible = "bananapi,s070wv20-ct16-icn6211";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo1>;
+	reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	backlight = <&backlight_dsi>;
+};
-- 
2.18.0.321.gffc6fa0e3

