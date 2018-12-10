Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC8C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA38A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="V/ScvD53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA38A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeLJQSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32913 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbeLJQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so6988386wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iu6bo30lI7sS+xNVJvtG33E9f/2Ed96R3LMOZkklEQk=;
        b=V/ScvD53nQq8q8RNbZwKLQaXHDUDSHeBK8qFTPi6210g4FA5YWqL+MjTPRV9xvIPA0
         T33N1XPkgDJTyx2LRFrRL1dG+IE5kTFWp64gJtU+urdyeYurxCnT6F2pzMZIwhMybXzg
         0QvJWttPKfrq+mIYia5Gvpq91Newb2CgaSZsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iu6bo30lI7sS+xNVJvtG33E9f/2Ed96R3LMOZkklEQk=;
        b=tD5S+DpOB9G0m+3fetBX5GcJe2KPkrfvA20CBzABqWZtklvx1tUEDq6eMYyVJscFFl
         fQjwuJpgGN/4KMT6PyE48X5wzx3nDjeLDfZZhcbEs8HRFiUo51Is/91oP5qJqYXa8ZLr
         +PYuhYODj2oQT9MEXJtEzhO13j+xOs2uzo6qgrEycQVHJhvWqbaNEIl5jzmElF5ctAnK
         a4UdO71QIJeNLsLDqtsTQqrhwlVSWPBtZY5MnSZH1vR3clzQcbGQDVBFljXAB3jA4RLa
         5ATC6O8hIzdrZV0ykPDY7BjDD9S/PlO5buqW200tj4jE1TZk+mSkTLzPgI1OwIWRfg3W
         MeZA==
X-Gm-Message-State: AA+aEWZ514ri7I8T31ucpWSduTjVvrK1gYK0WJ6c4szyO0XSScEm8+Zl
        1pG+a6nAygHs0UBAEsT9dVIY8g==
X-Google-Smtp-Source: AFSGD/X4QL8op0FfdcbGirGBh1dxiIlhCD60l+CuLwIUddllsDFHzpON/K3thRQdghvvcaUUBqcsOA==
X-Received: by 2002:a1c:e3d7:: with SMTP id a206mr10879717wmh.77.1544458683263;
        Mon, 10 Dec 2018 08:18:03 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.18.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:02 -0800 (PST)
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
Subject: [PATCH v5 11/17] drm/sun4i: sun6i_mipi_dsi: Fix DSI hfp timing value
Date:   Mon, 10 Dec 2018 21:47:23 +0530
Message-Id: <20181210161729.29720-12-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current driver is calculating hfp maximum value by subtracting
htotal with hsync_end which is front back value, but the
hpp refers to front porch.

Front porch value is calculating by subtracting hsync_start with
hdisplay as per drm_mode timings, and BSP code from BPI-M64-bsp
is eventually following the same.

BPI-M64-bsp is computing hfp as (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hbp = (hbp-hspw)*dsi_pixel_bits[format]/8 - (4+2);
dsi_hact = x * dsi_pixel_bits[format]/8;
dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
dsi_hfp = dsi_hblk - (4+dsi_hact+2) - (4+dsi_hbp+2);

Example,
u32 fmt = dsi_pixel_bits[format]/8;
=> ((ht-hspw)*fmt - 10) - (6 + x * fmt) - (6 + (hbp-hspw)*fmt - 6)
=> (ht - hspw - x - (hbp - hspw)) * fmt - 16
=> (ht - x - hbp) * fmt - 16
=> (ht - x - (timmings->hor_total_time - timmings->hor_front_porch - x)
* fmt - 16
=> (timmings->hor_total_time - x - timmings->hor_total_time +
timmings->hor_front_porch + x) * fmt - 16
=> timmings->hor_front_porch * fmt - 16

So, update the DSI hfp timing accordingly.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 07eba9ec469b..d8947be92f9d 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -490,7 +490,8 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	 */
 #define HFP_PACKET_OVERHEAD	6
 	hfp = max((unsigned int)HFP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HFP_PACKET_OVERHEAD);
+		  (mode->hsync_start - mode->hdisplay) * Bpp -
+		  HFP_PACKET_OVERHEAD);
 
 	/*
 	 * hblk seems to be the line + porches length.
-- 
2.18.0.321.gffc6fa0e3

