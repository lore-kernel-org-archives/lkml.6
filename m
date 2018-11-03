Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9152AC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E88E2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 10:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="m8OxtSqN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E88E2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbeKCTUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 15:20:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45792 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727281AbeKCTUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 15:20:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id o19-v6so2120543pll.12
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQh0tuZ2hAQEjHoUC9QKXmQksrNiyamIN0Q5qO8zC0c=;
        b=m8OxtSqNuV73V8tWjYgHpyjiVE/7WW0euNVgtiafVS+UL/gBRFpJztSulsHUqMH6s/
         +ir8x8ne92OvGOo78xkxTOgwsqTGjrcz6ueC43QKmkhly2SMHHjXn+nNzKmweQVkug1C
         aG36zcpFkWEsuzbkk84l0ExrwSXtzvo76wSTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQh0tuZ2hAQEjHoUC9QKXmQksrNiyamIN0Q5qO8zC0c=;
        b=fE1Ugo70ZcgRF0zYKfDBgFV3JYcJj04qE2gMvfVfZ54JpDr+SrhQ0/ALp0+gYg9XvR
         HbD+nhw9OUzcoOgxiv0LtJkce8dTJ7knmESvaqxMgv4hApzCoLAVUX8jXAV3jgBv0BYZ
         hRGeRrHXuCwm9lkvVzDVwW9Sc9QdDLtzVD1pCUIxIm7LLT9X9QS19WnO7mMl8fAl/hH9
         HmgXg/moarjMojsRDXjfDhipOuYQe/OH1nMh9FgllWtflnsNnsEW0wDkTqJHR0TnAysr
         1k84ql5KxPkrV99C+izNbgLdGKJBO8vGdiiH0ywYSo25+Od58n6Q3utIH0paR8P7faed
         o/tg==
X-Gm-Message-State: AGRZ1gIrOczY/7mgfp9LtGIPUx9JMJ1J5t2i/9/ktyHGmUJtJY3meTlI
        RLS0pH/pONdS5pjiDcyYrtvcDg==
X-Google-Smtp-Source: AJdET5co6HBSmkyR3+nJstdmG+aMIQ/YeXFBJ5+1R0rTOwg3wKCJwtBITHmn30omsMCoAShKnmAHzg==
X-Received: by 2002:a17:902:a5cc:: with SMTP id t12-v6mr6717272plq.298.1541239784745;
        Sat, 03 Nov 2018 03:09:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:6094:3f7a:ed0a:fb74:1220:defe])
        by smtp.gmail.com with ESMTPSA id z79-v6sm28466823pfl.33.2018.11.03.03.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 03:09:44 -0700 (PDT)
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
Subject: [PATCH 03/10] drm/sun4i: sun6i_mipi_dsi: Setup burst mode timings
Date:   Sat,  3 Nov 2018 15:38:53 +0530
Message-Id: <20181103100900.30313-4-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181103100900.30313-1-jagan@amarulasolutions.com>
References: <20181103100900.30313-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Burst mode display timings are different from convectional
video mode so update the horizontal and vertical timings.

Reference code taken from BSP
(in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
dsi_hsa  = 0;
dsi_hbp  = 0;
dsi_hact = x*dsi_pixel_bits[format]/8;
dsi_hblk = dsi_hact;
dsi_hfp  = 0;
dsi_vblk = 0;

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 108 ++++++++++++++-----------
 1 file changed, 60 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 077b57ec964c..4965b2c71e4c 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -479,59 +479,71 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 
 	/* Do all timing calculations up front to allocate buffer space */
 
-	/*
-	 * A sync period is composed of a blanking packet (4 bytes +
-	 * payload + 2 bytes) and a sync event packet (4 bytes). Its
-	 * minimal size is therefore 10 bytes
-	 */
+	if (device->mode_flags == MIPI_DSI_MODE_VIDEO_BURST) {
+		hsa = 0;
+		hbp = 0;
+		hblk = mode->hdisplay * Bpp;
+		hfp = 0;
+		vblk = 0;
+	} else {
+		/*
+		 * A sync period is composed of a blanking packet (4 bytes +
+		 * payload + 2 bytes) and a sync event packet (4 bytes). Its
+		 * minimal size is therefore 10 bytes
+		 */
 #define HSA_PACKET_OVERHEAD	10
-	hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
-		  (mode->hsync_end - mode->hsync_start) * Bpp - HSA_PACKET_OVERHEAD);
-
-	/*
-	 * The backporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
+		hsa = max((unsigned int)HSA_PACKET_OVERHEAD,
+			  (mode->hsync_end - mode->hsync_start) * Bpp -
+			  HSA_PACKET_OVERHEAD);
+
+		/*
+		 * The backporch is set using a blanking packet (4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+		 */
 #define HBP_PACKET_OVERHEAD	6
-	hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
-		  (mode->htotal - mode->hsync_end) * Bpp - HBP_PACKET_OVERHEAD);
-
-	/*
-	 * hblk seems to be the line + porches length.
-	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
-	 * payload + 2 bytes). So minimal size is 10 bytes
-	 */
+		hbp = max((unsigned int)HBP_PACKET_OVERHEAD,
+			  (mode->htotal - mode->hsync_end) * Bpp -
+			  HBP_PACKET_OVERHEAD);
+
+		/*
+		 * hblk seems to be the line + porches length.
+		 * The blank is set using a blanking packet (4 bytes + 4 bytes
+		 * + payload + 2 bytes). So minimal size is 10 bytes
+		 */
 #define HBLK_PACKET_OVERHEAD	10
-	hblk_max = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
-	hblk_max -= HBLK_PACKET_OVERHEAD;
-	hblk = max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
-
-	/*
-	 * The frontporch is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 *
-	 * According to BSP code, extra 10 bytes(which is hblk packet overhead)
-	 * is adding for hfp packet overhead since hfp depends on hblk.
-	 */
+		hblk_max = (mode->htotal -
+			   (mode->hsync_end - mode->hsync_start)) * Bpp;
+		hblk_max -= HBLK_PACKET_OVERHEAD;
+		hblk = max_t(unsigned int, HBLK_PACKET_OVERHEAD, hblk_max);
+
+		/*
+		 * The frontporch is set using a blanking packet (4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+		 *
+		 * According to BSP code, extra 10 bytes(which is hblk packet
+		 * overhead) is adding for hfp packet overhead since hfp
+		 * depends on hblk.
+		 */
 #define HFP_PACKET_OVERHEAD	6
-	hfp_pkt_overhead = (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
-	hfp = max((unsigned int)hfp_pkt_overhead,
-		  (mode->hsync_start - mode->hdisplay) * Bpp -
-		  hfp_pkt_overhead);
-
-	/*
-	 * The vertical blank is set using a blanking packet (4 bytes +
-	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
-	 */
+		hfp_pkt_overhead = (HFP_PACKET_OVERHEAD + HBLK_PACKET_OVERHEAD);
+		hfp = max((unsigned int)hfp_pkt_overhead,
+			  (mode->hsync_start - mode->hdisplay) * Bpp -
+			  hfp_pkt_overhead);
+
+		/*
+		 * The vertical blank is set using a blanking packet (4 bytes +
+		 * payload + 2 bytes). Its minimal size is therefore 6 bytes
+		 */
 #define VBLK_PACKET_OVERHEAD	6
-	if (device->lanes == 4) {
-		int tmp;
-
-		tmp = (mode->htotal * Bpp) * mode->vtotal -
-		      (hblk + VBLK_PACKET_OVERHEAD);
-		vblk = (device->lanes - tmp % device->lanes);
-	} else {
-		vblk = 0;
+		if (device->lanes == 4) {
+			int tmp;
+
+			tmp = (mode->htotal * Bpp) * mode->vtotal -
+			      (hblk + VBLK_PACKET_OVERHEAD);
+			vblk = (device->lanes - tmp % device->lanes);
+		} else {
+			vblk = 0;
+		}
 	}
 
 	/* How many bytes do we need to send all payloads? */
-- 
2.18.0.321.gffc6fa0e3

