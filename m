Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456F6C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB392082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WQedQFYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB392082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeKCTVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:21:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34911 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeKCTVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:21:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so2067826pgu.2
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2imflbytRpO7gkCpHkk9JbdaFJzsvanHLH6vmOR2Ts4=;
        b=WQedQFYB27qKIicxCsIp9R3QcdKeIIQ1l15TSlgLBG/fsemXobP2hah2s5T3ciQayb
         9VuNr+e2INxrXa3Q4pX17EmIb6NLAXVY7rOfjVJhzaXo1fSdAXrA8pmxjH3Ti52w54Pb
         9T+ZzALxyaGGYruwk/COn6FFs7Ij9+CNh9pt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2imflbytRpO7gkCpHkk9JbdaFJzsvanHLH6vmOR2Ts4=;
        b=hSDQg2nXf3U9JnKiRbqq0nBEGWTTJYaq9j+Pe03OOidyhvPoEvGPK3R9f+qS7XemTe
         JdHxG+L4ZZq8eKWnyoun4mLcGoOt69ooKJ2HIOvvG0UNZhoEel/jCGD6onOu8fgW+jPk
         ejJIw3gA6O30uk0XE2fq7DLyBoIpvbL+cUBNTFt/X0q14Qw6RfXTy9ADzbpIlyTvpzRK
         RQn5ba4xc23SBpSBewbRi0vYWefijWsY62PrTaRv7MczX7LiJAORhJvlwOSKO0dF8z2Y
         xeLicljgOcHjABe27fuPHn/JLT64w8EqkKMmSgHYCEq5fqg7GS5igSDmWukzXStyehX/
         F1Bw==
X-Gm-Message-State: AGRZ1gKqmGQYmfcx1Q8itl+wyERpyAHXZmcGZZf7NbOnen+L9wfDMo9S
        Bybi90xIIwSn2K9OEa12qe8Pjg==
X-Google-Smtp-Source: AJdET5ek/Nqi5OmdvH2lsDvbsku7f14QzmNTZhDKdMv2z3th5wKk0YllL1+0IJOX+JtZISwP/xjJqQ==
X-Received: by 2002:a63:aa48:: with SMTP id x8-v6mr13525222pgo.87.1541239820523;
        Sat, 03 Nov 2018 03:10:20 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.10.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:10:20 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 08/10] dt-bindings: panel: Add Feiyang FY07024DI26A30-D MIPI-DSI LCD panel
Date:   Sat,  3 Nov 2018 15:38:58 +0530
Message-Id: <20181103100900.30313-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feiyang FY07024DI26A30-D is 1024x600, 4-lane MIPI-DSI LCD panel.

Add dt-bingings for it.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../display/panel/feiyang,fy07024di26a30d.txt | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt

diff --git a/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
new file mode 100644
index 000000000000..82caa7b65ae8
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/feiyang,fy07024di26a30d.txt
@@ -0,0 +1,20 @@
+Feiyang FY07024DI26A30-D 7" MIPI-DSI LCD Panel
+
+Required properties:
+- compatible: must be "feiyang,fy07024di26a30d"
+- reg: DSI virtual channel used by that screen
+- avdd-supply: analog regulator dc1 switch
+- dvdd-supply: 3v3 digital regulator
+- reset-gpios: a GPIO phandle for the reset pin
+
+Optional properties:
+- backlight: phandle for the backlight control.
+
+panel@0 {
+	compatible = "feiyang,fy07024di26a30d";
+	reg = <0>;
+	avdd-supply = <&reg_dc1sw>;
+	dvdd-supply = <&reg_dldo2>;
+	reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD24 */
+	backlight = <&backlight>;
+};
-- 
2.18.0.321.gffc6fa0e3

