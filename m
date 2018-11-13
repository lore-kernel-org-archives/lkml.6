Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51984C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1208F223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 11:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Lp6RzImk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1208F223D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeKMVPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 16:15:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33614 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732608AbeKMVPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 16:15:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id w22-v6so5865362plk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 03:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
        b=Lp6RzImk9zFDdByGIZQ22YEdQrE7uHU0DNLy4iGOCKR/rj7ThaKZsH/7WW5KOXEOnc
         0uQom4DLJkIv4V+lflKspqub1Q9MD8DWs/lJmXtUb0AgySySGt8z/uR3H6pe5HNqHdiy
         ZUgFnTxQoVQDMjSRjgpzALwURivXeucMmPjAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/FobAdk1F/zKxxqm1vIJo/CC8EUNzQ/B2arqE/fLkis=;
        b=FDvVGLIYhBJ2GqwE3l3wB5JEymeUfw4HYLtgTTA1OKe5KvNtIc90VEH2FF0Zg11TEf
         Up1NidhYN//ImEbIrgYdPdknmTx4LJK+2Y69I7NyDazSzegcLYq3vWaFgRpQWG8DLOCr
         Xo8BFD8vbWyA1w77zeSvEJN9gFM4oarfH/WuGa/9WwlXjqSEm7kUIiL1ouVxAOQVqPtb
         7G4N9tltfhy9szX8gEr9iA6hclyM9Tro39ahBGSdmC/IYKLYimcDQSsngEGoLXHwUQwR
         tNcPg/MPZIkncYwXaVz+9J6cB90QTjG14FB/i/oA+cje4uYFX/8IuYyjNbhymOtNWizb
         6bjQ==
X-Gm-Message-State: AGRZ1gI6MnvewJt1KgtPN+Cg4e8vZ24VkPV8KbKQjAjv7xtJu9SelSY7
        bb08FZG0Yre9WuDxqbxmOjsUpA==
X-Google-Smtp-Source: AJdET5fTaQ+FfQnyD51qgCEnp5Y3G48fpwTUV2horBazemheZqC9R97OWEihi14MAuMxJDHR4WTFeA==
X-Received: by 2002:a17:902:c5:: with SMTP id a63-v6mr4683490pla.201.1542107847654;
        Tue, 13 Nov 2018 03:17:27 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:3670:3f11:bc71:2ef7:4a39:e260])
        by smtp.gmail.com with ESMTPSA id 27-v6sm28531377pfm.36.2018.11.13.03.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 03:17:27 -0800 (PST)
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
Subject: [PATCH v4 06/26] dt-bindings: sun6i-dsi: Add compatible for A64 MIPI DSI
Date:   Tue, 13 Nov 2018 16:46:13 +0530
Message-Id: <20181113111633.20189-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181113111633.20189-1-jagan@amarulasolutions.com>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller on Allwinner A64 is similar to
Allwinner A31 without support of DSI mod clock.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 6a6cf5de08b0..9fa6e7a758ad 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

