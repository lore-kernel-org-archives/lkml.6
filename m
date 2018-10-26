Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C5ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D72920651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z/54ZxHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D72920651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeJZXVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:21:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39048 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbeJZXVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:21:38 -0400
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so3238pla.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D7lpI0032ckljqWxd5MKeqF8bO9v9lcI3LVfhs/Q60g=;
        b=Z/54ZxHSCcZEI10NsF/NUqaNHrhdZ7pQLL/DAAQN0ge47Tmdp9F4pe9l2N08LJhE6p
         XwgGqBY7/WXh4fFqAquiSszal8LDiQHZAG+c20B9lZjgMDNyuEHq5GRWSExMursGffXD
         3AB4nsv3DxMVq7o7n0z1tONzEME6kO66+G9lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D7lpI0032ckljqWxd5MKeqF8bO9v9lcI3LVfhs/Q60g=;
        b=nhTznw3SoOzP6+CIssilGg0bIGzOT5FrFNS29Fz9B7fUmLtX2ubIatuy+5yLW4gY+A
         s6RbVGdYH/6AlbMt10Vbr1SYx2n7KNyHfNEFCdheoOw0URanGl7ZljlbTAaSmvdv5/BQ
         i0uig2Fi+YY+11IrppInQCkJyThI3byaooL7GRTHIX86zY7EBsL1Z7ihfXqw1sdvm+0c
         SM6zHZbxaOtmkCI4o/JqfQOA+jsrE0P6fXFXJB+V1iCfbT8ehb7Os09UaZo5LrRhzevp
         fnBO2WhTvfM7fTfOf0ygtUjsoPoGLsyYUoBiy1Y+YDD79W3W0kHZ3SZZIbKvnjp9WJ7U
         2OoA==
X-Gm-Message-State: AGRZ1gIiyua62rtQ7lYc34NiQsuIsrMVEe+cfALlQFasBPuDKlqYVtAk
        iuxtw76KtcNFGPHV/EuLFwpmvQ==
X-Google-Smtp-Source: AJdET5dJ5LJZm4D61hO5lp28Zm+zdXyFPxQUFWzENOd9cvfV3l6atMx85qUxmJwtg7YSMX6gt8mKjQ==
X-Received: by 2002:a17:902:f01:: with SMTP id 1-v6mr3831894ply.8.1540565058294;
        Fri, 26 Oct 2018 07:44:18 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:17 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 01/25] clk: sunxi-ng: a64: Fix gate bit of DSI DPHY
Date:   Fri, 26 Oct 2018 20:13:20 +0530
Message-Id: <20181026144344.27778-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI DPHY gate bit on MIPI DSI clock register is bit 15
not bit 30.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- collect Stephen Ack
- add tested credit
Changes for v2:
- none

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index f7d297368eb2..019d67bf97c4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -581,7 +581,7 @@ static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
 static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
 				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(31), CLK_SET_RATE_PARENT);
+				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);
-- 
2.18.0.321.gffc6fa0e3

