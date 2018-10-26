Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07BF0C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF72C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V5YdT1/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF72C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJZXWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:22:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42142 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJZXWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:22:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id i4-v6so635738pgq.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVRNMokL+W5QoyKoWUV5pE0kc2iWWL0MLvzndReDF1w=;
        b=V5YdT1/l3Yz1J970D4epM3oWJ2wjiQLWGohq3RBi3Ppq+eJLE1CRCHQOrYsh4U/VDq
         Z52ug+9VwZr+NmHpz3f6QIPib5DfU+z/j/GmZaOgZ3H07tP7SYt5HLfvxyJYdQNctPV1
         cMYu5Lak1vTDgYSQuyjDpJfjCTMfuprH2yyOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVRNMokL+W5QoyKoWUV5pE0kc2iWWL0MLvzndReDF1w=;
        b=hlXMSR909y+QPuTmT4QIjgrKfOiQNz+KlqrrzPk3stjGK7/TCtEBRsrPrBOsS5bhzN
         2OBUMoVVlk8yNlKtVb8TrC997qx2sqA8hGeP0pzJ8L0xjLu97eiZzohiQVDvr+aJqIlI
         iQOi0XOnq0umhd1xb3PXpN4lu8RJDUKYUsAZEOQUBI0g4rQiHdIfMLoI+UshemHLGANR
         po/+w0VqM4/cnHOkwMmc00oL2oxTBDDtqOm3AFFLmZ4GFNwJEvTA3zNK711jMjKY1Kgs
         abvCVc6tQCxgfvLT/CifWxxtDGTJfxZNl9xb11ZyR01EgG+Klila6DeQDBG8MAVhNAPx
         BjQw==
X-Gm-Message-State: AGRZ1gL5b2D4KhqP8tm5Lg4nypMuOMR2sghUMGwUT6qxAxaccM7hLxaY
        +EHWvTksJp1XCQjcXNEOcqntTQ==
X-Google-Smtp-Source: AJdET5etpZ6TDNZrXZ5prFQGg/uyFIFNwVuKmkoddw6Y1yZkMR8kNgOj7/B1IDhcatC9qSq6ohWbYg==
X-Received: by 2002:a63:4f61:: with SMTP id p33-v6mr3749528pgl.71.1540565086365;
        Fri, 26 Oct 2018 07:44:46 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id z22-v6sm12044467pgv.24.2018.10.26.07.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:44:45 -0700 (PDT)
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
Subject: [PATCH v3 06/25] drm/sun4i: sun6i_mipi_dsi: Add DSI Generic short write 2 param transfer
Date:   Fri, 26 Oct 2018 20:13:25 +0530
Message-Id: <20181026144344.27778-7-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181026144344.27778-1-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Short transfer write support for DCS and Generic transfer types
share similar way to process command sequence in DSI block so
add generic write 2 param transfer type macro so-that the panels
which are requesting similar transfer type may process properly.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Tested-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- add tested credit
Changes for v2:
- none

 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 8e9c76febca2..fc8560607147 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -871,6 +871,7 @@ static ssize_t sun6i_dsi_transfer(struct mipi_dsi_host *host,
 	switch (msg->type) {
 	case MIPI_DSI_DCS_SHORT_WRITE:
 	case MIPI_DSI_DCS_SHORT_WRITE_PARAM:
+	case MIPI_DSI_GENERIC_SHORT_WRITE_2_PARAM:
 		ret = sun6i_dsi_dcs_write_short(dsi, msg);
 		break;
 
-- 
2.18.0.321.gffc6fa0e3

