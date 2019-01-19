Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA10C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCE2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu+4f/o4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfASIlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:41:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36893 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfASIkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so12189782lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QN6lWunl3v34UryC8Jt0OOMGcLPbeFY0PRXCON6TUk=;
        b=Mu+4f/o45xbjDykI1TejVs6m3QsSuUEFufnIbTyDOm+gJScr36RfwPXiwiTgOmj5P6
         9dL+rkkMRfnKz1CONQ9WN5g5wHie4/CVeAonStFVoFaiJ5leAdvZZoUP9zIjms48zu2x
         DN1/VClzgjBBSdOXPpaYDPhVFEtzF5U0yJH0SSfTlhbmfmE3lJzVOEH3nvwGhSVKwY43
         ORzZcBIQfKC5fygGLaVAfLeNrL1j5Alt9h3F32lp5/i2gOtBRzSYdjmHcIYSn86vcNeZ
         Mfv6T884vpKvLdUgcQLGJNN0kDWy0Z9uJutJRieGwXQc/Cq6CJa/t47iZ5kqEh7aRiRf
         LxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/QN6lWunl3v34UryC8Jt0OOMGcLPbeFY0PRXCON6TUk=;
        b=LfEJVUcU8Kh5tQW85K0GBKPRPLT0bpPmdSLIsmkMFUb8z7ArmzQyzuPCjRKpJD5UNG
         M/+GRlAlr+621qR+Tg9LAWyO/1mTGeZii7qA8Oyf4nY/EyO+bFoAe6Sfv0dqVYbILusk
         oxcnXo1A2K6APh0Na/38vwewkotCxCPoDCE2SxE6dhjuTyC06XhoZHMdEw07PGT7ZAAp
         mlXjeAUrvmBYbOnuEUOcZj1oTUsSrr+xFADNPvcWeSMxXYilzPSreSJ2P4BV2WWUkeVF
         FGtl/ApSieoMyxiWT6oQWKUuDBgIbjoWE4kTpMSkHUjid1Zbn3N1dhKS6dHMYRYGIcLr
         u8+g==
X-Gm-Message-State: AJcUukfe64ddFlVsa2q4jhCWF2S124w6MSea5zI9+epEFBvCK93YSJDl
        UVGcx2qGKSJHGeJ7nbUzgJg=
X-Google-Smtp-Source: ALg8bN5eDbtgyem+6ppWs3revLqLSHgY01ImK604wU4I61/pcO3UjWOGrz0Q35Q2gTq8iX4syLCrQg==
X-Received: by 2002:a19:ec16:: with SMTP id b22mr15153380lfa.65.1547887243408;
        Sat, 19 Jan 2019 00:40:43 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:42 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] drm/bridge: cdns: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:12 +0100
Message-Id: <20190119084014.5355-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused cdns to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm x86 and arm allmodconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index ce9496d13986..4b73d0969468 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -8,11 +8,13 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <video/mipi_display.h>
 
 #include <linux/clk.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
-- 
2.12.0

