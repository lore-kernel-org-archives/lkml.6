Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED02CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40BD20685
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Rs6xvWDN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40BD20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732870AbeKMVQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:16:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42805 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732462AbeKMVQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:16:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so3133212pln.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zfLa7sOo1lPPoVacUZ5Wanit4VpAlBcSuHBOx71Xco4=;
        b=Rs6xvWDNKx/2kr5ZDh/eLGXdZ7x8iZcX497FqxPOSjkZHI2He0DEYAQvKpMvFtUAtN
         fpLnj8F8Z/d9WA98jr2PexIoAjJnOtD8X2AHodTeaBwXsaMtZL8bQUaLGdCN7Qc/teVJ
         zzNd/g19/v6JVTnR97ln19D553AyUdmslsDMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zfLa7sOo1lPPoVacUZ5Wanit4VpAlBcSuHBOx71Xco4=;
        b=kSV8EO7bowkPNDG+QVPbGf3QNYP1jqiDnAde/cEqgR6OrGEkWtQawKONK6WlcvJYNL
         lfewY082cx2RoIu9GDEENEBqidDbhQeRAujYKsBUuDq5DLwEH/2JGNVC+2CntLmsbaiV
         ODZER9OTDGJuTxgT20LrY0EwpNTsUzuc0ciBXNHO2aHMmjLcStYw8Ie8XpgpyvjgNFTf
         5zhIZY1c7P/LpNZWXsm2qASDKM5d9S6MwxqFPEky4LSOgE+A9QR35pANchTOQc3LfdiS
         N7NgegbFat/uMV72j1mRvcK3rIEk5bI66wTzOlHryUnH/VCg/60W/SGFd3yGT9ArQkJO
         DA5w==
X-Gm-Message-State: AGRZ1gI9eeTUtJCnvi1eIf2RaVqBhTRQM9dLOKfBs4DKbh3pNrxuFkcl
        TnY6hIgt1MO/UCxNN2cRxhgzrw==
X-Google-Smtp-Source: AJdET5fWCIG/PUktT+gP9Mmm+M3x5yd8MyWqp6NN4xZFCdugq5/WFQYO+nejiwyaDMX4n3VL12WXyw==
X-Received: by 2002:a17:902:7d89:: with SMTP id a9mr4191221plm.242.1542107917482;
        Tue, 13 Nov 2018 03:18:37 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:18:36 -0800 (PST)
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
Subject: [PATCH v4 17/26] dt-bindings: sun6i-dsi: Add VCC-DSI supply property
Date:   Tue, 13 Nov 2018 16:46:24 +0530
Message-Id: <20181113111633.20189-18-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the Allwinner MIPI DSI controllers are supply with
VCC-DSI pin. which need to supply for some of the boards to
trigger the power.

So, document the supply property so-that the required board
can eable it via device tree.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9fa6e7a758ad..adc7cdf129dd 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -28,6 +28,9 @@ Required properties:
     first port should be the input endpoint, usually coming from the
     associated TCON.
 
+Optional properties:
+  - vcc-dsi-supply: the VCC-DSI power supply of the DSI encoder
+
 Any MIPI-DSI device attached to this should be described according to
 the bindings defined in ../mipi-dsi-bus.txt
 
-- 
2.18.0.321.gffc6fa0e3

