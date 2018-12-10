Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D2C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0881220672
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Fby41GOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0881220672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbeLJQSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40647 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbeLJQSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so11832003wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiAA/cUEr092LynkAnVQtsmpFwj1u/ZrP8Y7/2WzfF0=;
        b=Fby41GOV+1hziXy0cQmlduCVcOA7fyZ3cELSFpSyPAoOMg4bvRyz4+y4SEGMpt/ahS
         P6pZciUC8YqcGoUEFQ5MtL/+lmadFyOH56ST2kSp+/v2WQVdtgtFaYeUgoK2+LAS+rZI
         6NAxz1mjg5GSwnzbWzWJq2TwJEuQq7P67LSbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiAA/cUEr092LynkAnVQtsmpFwj1u/ZrP8Y7/2WzfF0=;
        b=I4sx8wID6cUknQuTSM0bwFqHrsAcoO6E4zkIXXkHAOJ9DrXew75YOrp1GYcjKXkxqw
         uzdnp++1HpLhwCUl+KuiokGUFCbbSCQgjY4p8dpfnDbwwdMY44WipedF48kx+1qT6DSQ
         4SVHn3N30nZcVjMT+Pke6gOGF3xFz++r0FaylcGB3/MLaz+30vu5yRX0ReDSsCNJ5qp2
         bj6E13xzN9QmJyUw2h+/yo9Oummt4qqcRoaURsOlcvq5eXS9HRxTKBoRkGTUy7bRDAm1
         IAEPuyXWYukAfrb0z9fdYV1LiSEKirnCXdPfV76jJMGMQ/w9/cf7BzmX6XA8GOkizK5c
         7ShQ==
X-Gm-Message-State: AA+aEWb1gMfZ8bndaJWFH6edNdNGtteTGGbbfl3CifTxi3x1DReJ4XSr
        M0Ve3N4ZYjB2qdhqmUvCPzIs3w==
X-Google-Smtp-Source: AFSGD/XfvcRdGmj8WQOq1Wc7vWq4fKFJIXF0ufvWTlz2ZYxpONPT8VIJ6rZZCNnXhKal0kD3+aipNw==
X-Received: by 2002:a1c:de57:: with SMTP id v84mr10923097wmg.55.1544458679797;
        Mon, 10 Dec 2018 08:17:59 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:58 -0800 (PST)
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
Subject: [PATCH v5 09/17] drm/sun4i: sun6i_mipi_dsi: Fix DSI hblk timing calculation
Date:   Mon, 10 Dec 2018 21:47:21 +0530
Message-Id: <20181210161729.29720-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hblk is adding line with all porch timing values, or timings
values from htotal without sync time.

Current driver is subtracting htotal with hsa, but the hsa
is bounded with packet overhead. For real hblk calculation
needed by subtracting htotal with back and front porch values
and BSP code BPI-M64-bsp is eventually following the same.

BPI-M64-bsp is computing hbp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
=> (timmings->hor_total_time - timmings->hor_sync_time)
=> (mode->htotal - (mode->hsync_end - mode->hsync_start))

So, update the DSI hblk timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 81151d7633f9..4c95b3384ed9 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -495,7 +495,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	/*
 	 * hblk seems to be the line + porches length.
 	 */
-	hblk = mode->htotal * Bpp - hsa;
+	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

