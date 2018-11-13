Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C8EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CAA20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JHQCKb3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CAA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbeKMVQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36272 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732571AbeKMVQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id w24-v6so5865633plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ARbx+KiDqhCi74+cAhwo58RvKAVcTpf7hF3ar2UJsU4=;
        b=JHQCKb3ouLpMhros5NSlW2hLMj3imUXO9M715UlGt/sId7BEZJ0g/b7lgE3V43hI/d
         1tt0/kx0360VXsJk0OXfLrsg4LqquqQb1HFKoTBqlYM/5HVBCkpi9feuFAe/0v9z/YSg
         f/3Hmns1/suSl2ZVahLERdC0Cw2/xg/2qU4Sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ARbx+KiDqhCi74+cAhwo58RvKAVcTpf7hF3ar2UJsU4=;
        b=iEW1dfBMGNgWCVSghAr9mY1q0uRPzfnq2EmE4OY2s7ELt/L3f02Zz9XEy9R10BI2F6
         G4VbcsL5cjy6+i8d5F1+QF6V7GhsGJXEI+FOezIfQOCGU7cUCBwCGXhDVfaZOvM9ctDp
         WmiDzDoLIsYExzgWPExkzXaU9g1Iu6DEam/BHGUu3FMpxNykYnXon4GJtHcdOcoJS04Z
         aorPtOjmC9v9thD8VH9cnxZw566VaIv0pqeohZ6AWo/awMd9HmqEnh+6Vhd+cFvG/th2
         nPjq3Hz+c9s4WGsdJSdpf/b7UHPXuXv2sPFvOWlDz9FEW0YEqTmUxmQZ5N1hYPMqSKKE
         byog==
X-Gm-Message-State: AGRZ1gLAMeZghKUJHg0WmxWyIPTz4AvIm2NV1gbEOWU30HHoGr6uvB9s
        5/Gz8nY/wX4s5xhqtsBvlZ5ZMg==
X-Google-Smtp-Source: AJdET5c8qnTkL3Bax9dwaHakX90eiDYy3C8cReHGRejspZd7oWDtEXwkZRExiCjw+pmGt9mKg94TNw==
X-Received: by 2002:a17:902:b18c:: with SMTP id s12-v6mr4589153plr.16.1542107936124;
        Tue, 13 Nov 2018 03:18:56 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:55 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 20/26] dt-bindings: panel: Add Techstar TS8550B MIPI-DSI panel
Date:   Tue, 13 Nov 2018 16:46:27 +0530
Message-Id: <20181113111633.20189-21-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI
LCD panel. Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/techstar,ts8550b.txt        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt

diff --git a/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt b/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
new file mode 100644
index 000000000000..9d3056dd8bf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/techstar,ts8550b.txt
@@ -0,0 +1,22 @@
+Techstar TS8550B MIPI-DSI LCD Panel
+
+Techstar TS8550B MIPI DSI panel is 480x854, 2-lane MIPI DSI LCD panel.
+
+Required properties:
+- compatible: must be "techstar,ts8550b"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "techstar,ts8550b";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

