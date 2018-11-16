Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB85C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95F22086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gQD9oYMw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95F22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390208AbeKQCxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:53:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46294 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390166AbeKQCxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:53:20 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so8438400ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDd9dwA7Hm3WuIogwPjaX9WwN0ho9g9ngVvPoG/csZ0=;
        b=gQD9oYMwThWN8kj06UxshzAdzal6EVUtSUhSdsEaXUcctoiObYz8MyTBzXf4a34rWM
         ddKz8bnDNbe4PwV0NMRIVM5TmFhc1Pv763Lo4G3gNp3KM7IxOQmUGySJoqmobi7hVl+T
         ngG+/XgcFfVlWbqNYdsd42p28A3Axvx2lqajE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDd9dwA7Hm3WuIogwPjaX9WwN0ho9g9ngVvPoG/csZ0=;
        b=EQHmH1yMt+/XVnEqcJG/2Y5vmVr0kzqvLPgBhp7j75XdLJPyzRdSL/wAgT0CGIimmo
         JjRZxDPGSXb9JQ5htZesoOBViVelIADRpg4KarMHDgJgAP5+ivH5R0Y7WZgCG3Qa2TZX
         k4S1t3PBPgcyVhnh1+3ITWqni4/eDQtyIW40Nhi+iMzOO1TjOR5FmhxG/iXkLaRSrZJs
         gYebzGX7XGRKabxv2j9bOKqP9Eftd0PbZZwj1vF1dj2Oj8WNHMcH5U1YlY7PRJz0soyZ
         kep9K5CvwUR6AzxnBGeCqhP1r4KAuhYApLH+CKojsG+M47SGKUFPB12PS/ynsRSHxbhr
         NSXA==
X-Gm-Message-State: AGRZ1gJHwd+zjTT8aZkVgpRR5HfWjYKdcQh4D3StgXP8XhYLYhAuZvxM
        oeXuLBL9bpIE0merhbJSpNGB7w==
X-Google-Smtp-Source: AJdET5foe954ne/ZJRo/LsEbnW6Tmi3EDZpn+VLwY6I7yD0dzmArTSXooBVraL8h8KbMPNDKAHTbLw==
X-Received: by 2002:a17:902:d03:: with SMTP id 3-v6mr9444498plu.66.1542386415050;
        Fri, 16 Nov 2018 08:40:15 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id p5-v6sm34622213pfb.109.2018.11.16.08.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:40:14 -0800 (PST)
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
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 05/12] drm/sun4i: tcon: Export get tcon0 routine
Date:   Fri, 16 Nov 2018 22:09:09 +0530
Message-Id: <20181116163916.29621-6-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181116163916.29621-1-jagan@amarulasolutions.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes tcon attributes like tcon divider, clock rate etc are
needed in interface drivers like DSI. So for such cases interface
driver must probe the respective tcon and get the attributes.
Instead of probing tcon explictly, better export the existing
sun5i_get_tcon0 so-that the relevant interface can reuse.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun4i_tcon.c | 3 ++-
 drivers/gpu/drm/sun4i/sun4i_tcon.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index c78cd35a1294..6e85a33c6828 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
  * are located in TCON0. This helper returns a pointer to TCON0's
  * sun4i_tcon structure, or NULL if not found.
  */
-static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 {
 	struct sun4i_drv *drv = drm->dev_private;
 	struct sun4i_tcon *tcon;
@@ -235,6 +235,7 @@ static struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm)
 
 	return NULL;
 }
+EXPORT_SYMBOL(sun4i_get_tcon0);
 
 void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
 			const struct drm_encoder *encoder)
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
index 3d492c8be1fc..195deb9db57a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
@@ -273,6 +273,7 @@ struct sun4i_tcon {
 struct drm_bridge *sun4i_tcon_find_bridge(struct device_node *node);
 struct drm_panel *sun4i_tcon_find_panel(struct device_node *node);
 
+struct sun4i_tcon *sun4i_get_tcon0(struct drm_device *drm);
 void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable);
 void sun4i_tcon_mode_set(struct sun4i_tcon *tcon,
 			 const struct drm_encoder *encoder,
-- 
2.18.0.321.gffc6fa0e3

