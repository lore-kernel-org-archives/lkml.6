Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E74FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4552420672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ZED3XNr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4552420672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeLJQSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45982 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbeLJQR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so11069544wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=htHh1EHvwq+E445n98FFCiPzlmj0F1X/K1ZswWL2Ewo=;
        b=ZED3XNr27UkPRzb+tgfN8jqTQHr5Ws6I1Rf0utQDRSqaDDi4uqkn2Cd2F3TcHfTCmA
         zIvhq+voOUeGP7yvtlFI8EOgpCuKHIlQL/1yZpFlqFIOv26AVsv1AGdR9dUfodGuW/iT
         J1MGjR2PoCl8lJuyCQpaPDmhIbFGX/BW5meoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htHh1EHvwq+E445n98FFCiPzlmj0F1X/K1ZswWL2Ewo=;
        b=WU1HEnPmN7d3eXAqy+QIF21Vl6hvX4A5bG6yzAZc1M6rFpO+BfX9RYEMZPW1lf5nh9
         sBn266bMHwtk8ew1PgRTbB2cvLPvL5pBlRKtia5aA5D+oSiLGerIOVxUlak5sqEJI+u6
         s+PIMIykK4GbrJwuMvts3YjFdHqs3nypJBfFg2M0d0Z3zA4yxFvbO/2iJcJjdc64xS0Y
         i+8FYqpwpVXOyWz+hWS7jigV2iNEfidZptEDgzD5QZWOP9Jo567fS1/VFG5eQ2GDHEyc
         AcR9Yn8nbbcwvBn7y9YRboGctB7oINikDm+LfRz/Oj29Zd2laGM4DK8NQgahyyLdOTC0
         saiw==
X-Gm-Message-State: AA+aEWY334tNd8rqyVVRugihb8nsWWuy3snGw8CoC/SSfyhMl+0hKmbu
        JtsrcJSaa/nV5ifzmZevKjGI7A==
X-Google-Smtp-Source: AFSGD/VEBKqsAcVyrh59AfZgmRINtJXwNFUQJW4oylcHw1xHvwExzJIjXON+Bb1dzmDGzo+X0yDCpw==
X-Received: by 2002:a05:6000:110f:: with SMTP id z15mr10003279wrw.136.1544458677841;
        Mon, 10 Dec 2018 08:17:57 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:57 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 08/17] drm/sun4i: sun6i_mipi_dsi: Fix DSI hbp timing value
Date:   Mon, 10 Dec 2018 21:47:20 +0530
Message-Id: <20181210161729.29720-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hbp maximum value by subtracting
hsync_start with hdisplay which is front porch value, but the
hbp refers to back porch.

Back porch value is calculating by subtracting htotal with
hsync_end as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hbp as
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
=> (panel->lcd_hbp - timmings->hor_sync_time)
=> (timmings->hor_back_porch + timmings->hor_sync_time -
    timmings->hor_sync_time)
=> timmings->hor_back_porch
=> mode->htotal - mode->hsync_end

So, update the MIPI-DSI hbp value accordingly.

Tested on 2-lane, 4-lane DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index cb41fea4f3ee..81151d7633f9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -482,7 +482,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HBP_PACKET_OVERHEAD	6
 	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->hsync_start - mode->hdisplay) * Bpp - HBP_PACKET_OVERHEAD);
+		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
 
 	/*
 	 * The frontporch is set using a blanking packet (4 bytes +
-- 
2.18.0.321.gffc6fa0e3

