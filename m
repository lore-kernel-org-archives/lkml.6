Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F0C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF507206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef55gEoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfALTdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35319 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbfALTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id x85-v6so15745100ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ua+KYtDjU99eXAzjajXwPBVYip/9Dk3lifaGZRHFZ4w=;
        b=ef55gEojAY0MrCbCd74FPVgVsb6tUmhU1/w9paNg00RTvm8EsJ4UGaVbWWa5IzX15W
         JqV/5vE+sRiWdrpNK+YiTN/7SaoauHA4FqwtgNG7ty+HCA17/n1FgqoqdBkNgZ4oZBsi
         yXXu0HqN1j9/x5tGSe6AErBBYofdX0iw0gSAojyYg3ozb0Asw0zfVVcWS8j2oBMvcSoH
         B0y73pJfWrqKLvuDW+Zer1/oqqkv57Yw+n3lgb6FvbzYPDKf+INMyljcZc+Dgv6Te2dT
         GSHCPcxxgOmNA0ln0PuQq5t+VVTEpGUM12e5tOuKjNzLEDrR6lMdebMRywftBSSe3PaJ
         StKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ua+KYtDjU99eXAzjajXwPBVYip/9Dk3lifaGZRHFZ4w=;
        b=j8MEWgumOBcPRyGxo35515daP1CJLILEEMER00na75v9gokg0iLk/O/4sE3JyYVlwF
         jMKo4lu47GEnDDuav47dYFexGZI+SBzirN9aRbhEHpFDr3hxOx+20lc3VR1hWg6A+j5e
         qzfxVXZVZYPRa1GV1kX34pYwiGtGAZXzBXf1A+Ym+A/u8NCmTE0F52AJFcUlgo2Od9ep
         oKT4acBpv+qg73O63Tp/OIY7/kM620lzxMyrin/RZkmwARUmGHhZa1wLjqTSzEjPfukK
         q350e128kDDEiy8N764BlxWILgUG1wGLqbl9bIPj02H5VQpsA6zLGLNM6xXEyj+juIaX
         AuAg==
X-Gm-Message-State: AJcUukcHeHxzGJrnzvXuUAuXAwVYdd6t+rPtgWDCVIooNEnYFyTkmMnR
        XDHfVSrnqUpKFnteg8I2LeA=
X-Google-Smtp-Source: ALg8bN4zD8jnnP5A0WuYbQbG+AIbfE1pibqXmmcv6dFSyx0Q8Bdx6qDomXRbL2ISGcb81N6xzn0cLg==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr11154758ljk.128.1547321615972;
        Sat, 12 Jan 2019 11:33:35 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:35 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Christian Konig <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Zhou <David1.Zhou@amd.com>,
        Eric Anholt <eric@anholt.net>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Rob Clark <robdclark@gmail.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Sean Paul <sean@poorly.run>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Vincent Abriou <vincent.abriou@st.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v4 7/8] drmi/rcar-du: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:50 +0100
Message-Id: <20190112193251.20450-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused rcar-du to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.

Build tested on arm x86 and arm allmodconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/rcar-du/rcar_lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_lvds.c b/drivers/gpu/drm/rcar-du/rcar_lvds.c
index 534a128a869d..8010ed702509 100644
--- a/drivers/gpu/drm/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/rcar-du/rcar_lvds.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_graph.h>
-- 
2.12.0

