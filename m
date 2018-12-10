Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84B9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3D42086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j64vC5c9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3D42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeLJQSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:18:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36522 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbeLJQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:18:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so11946178wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7B7/bFXR+1ggUu89xO8Gq2xSzsCKM6R16uBfSc/xhAo=;
        b=j64vC5c9Sc06k6W+B4eLBoq2kgCKRSayqR6+DwNYYJNjxUTlZd4q2LFlL8wdHQbIdS
         GN8bfAAT6V0Z6CvtFGRSbP8FBcFaEPZFXe3U3iFXpeMidy4Bs/9QNzou1htKl46xI/hd
         emjQS/y7d9brelH5z5Gw0ZKvG8G2md8LcP4LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7B7/bFXR+1ggUu89xO8Gq2xSzsCKM6R16uBfSc/xhAo=;
        b=KbwmmmMUcpisv4l/ELMJGPB/dhRa2Jviv8KtgSZj1/12//HRsSLzyU8Z0pF6szK3i0
         jsynKbMywkco71wLJH/K0+SP7Tzc6/gTMi8TQt4JHcOr65oFPVEt3a798wKCmeLW8vyH
         twfSjnxTTr8K1kmEfB3A3jdhWyA6vK45LPQyu5h313u3ylfGnottjvTRG2czjON2MHyl
         xKHrtHrfBF+WT/jMUYa8VbySc5GASmcXgD9l1diYLGkH+8DDKZrdf+wociT8Y02SgHNi
         FuqYabK7QjTsCjm0WdnBm+5jCMNd/mBlTNLcfsXWGhsO02f5mDuxNxeO3gGjIJ5ZbKdM
         iNKQ==
X-Gm-Message-State: AA+aEWbK/9uzn6nBkI5xT1KM1nLg/ueI78NkG044RChmGnTHadrfpKLq
        lHAnh+kSIBKHKQNYKrcFu6zbNg==
X-Google-Smtp-Source: AFSGD/V6DS87dkTsDhODWaxBYnTVebM8xXCu4fOadguVykyXB9nHb9tTYImyri0myo8lgB3AF4v7zw==
X-Received: by 2002:a1c:d7d3:: with SMTP id o202mr11936226wmg.135.1544458681432;
        Mon, 10 Dec 2018 08:18:01 -0800 (PST)
Received: from localhost.localdomain (ip-162-59.sn-213-198.clouditalia.com. [213.198.162.59])
        by smtp.gmail.com with ESMTPSA id b13sm8397503wrn.28.2018.12.10.08.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:18:00 -0800 (PST)
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
Subject: [PATCH v5 10/17] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet overhead
Date:   Mon, 10 Dec 2018 21:47:22 +0530
Message-Id: <20181210161729.29720-11-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181210161729.29720-1-jagan@amarulasolutions.com>
References: <20181210161729.29720-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 10 bytes packet overhead for hblk where blank is set using
a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)

This is according to BSP code from BPI-M64-bsp (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);

So, add 10 bytes packet overhead for DSI hblk.

Tested on 2-lane, 4-lane MIPI-DSI LCD panels.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 4c95b3384ed9..07eba9ec469b 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/*
 	 * hblk seems to be the line + porches length.
+	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
+	 * payload + 2 bytes). So minimal size is 10 bytes
 	 */
-	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
+#define HBLK_PACKET_OVERHEAD	10
+	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD,
+		   (mode->htotal - (mode->hsync_end - mode->hsync_start)) *
+		   Bpp - HBLK_PACKET_OVERHEAD);
 
 	/*
 	 * And I'm not entirely sure what vblk is about. The driver in
-- 
2.18.0.321.gffc6fa0e3

