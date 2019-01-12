Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF9C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082AD206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJpMmCfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfALTdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44330 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfALTdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so15707491lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZrZ53K+xQkfV/OdwjMV/+HTEs5OewoU6HUeqpYgO20=;
        b=YJpMmCfLKf/lQyX3k9bQ6FxY6mxJ6EmJUgACFuJ9c4AJWFm0aryrPAGp7pYFxXLwSh
         1HSseWl2zSvXr9yJChudyefTSTgHQ4XCzbpB/LvMwelLNbIB4+MLvIW9rLiaCFTus0/U
         8LHJ4kdyEi4ttwsPml+vJilTyj3ziyLbdwzAz6iukikA+CXfzq3POtVWgJARRvwA86p6
         eXwoj0RY3JIYACcSuOcX6ywWa6ruF8filBJdJHXoXMvWuLlQMQyG33Jkk4Izent36CTK
         83xt+kJDn5JmVEj2VZBYKQr4vt0R+0T090nocdRjvF+B9ItQaAndqG2OjaOc4btGPtmw
         EA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ZZrZ53K+xQkfV/OdwjMV/+HTEs5OewoU6HUeqpYgO20=;
        b=nYZ89OIDO6VrpbACYKCP3eorAdK4HUhWRPXHGXfohEsuFcjo13gtkIt3SWjJkNUU4Y
         xCI12miy0GrpThlfcri6WQcww9GfimxUU7mG04ze423BDc3J88Tio07F3XOTqSknscW/
         miwE8J3sUiZ19xO7zsY1qJXnUfQ+vz5i4KveqRInkX1Pmga05qjKxDwjUab7REuXElpM
         w50fw8Q64QtHGXP9jcukOdcJAAO3ozxdE6GKz9dhrxw2tvixus1vdWm/dsG7dcNrWr1E
         eQHnmOmkvQ59j85CPGByFeSe70Pg+F0TuhKYrPYNn5rtR4tPKtS2f/RVN+0GEt4iuUNJ
         Q2eQ==
X-Gm-Message-State: AJcUukccFni6dmawvFFONfWJKlTgqRvWLvOJ3Xs3Naob4xkMspAxVGVv
        GCHAun5cg0HRNbM5ouq7zWk=
X-Google-Smtp-Source: ALg8bN4sIi1fTs8F7bP+KRcZQwfpInbfdZpH1iFTIVjJhvmNxYteAQl2p4XbgRlqwbOVAZb1y5z6qQ==
X-Received: by 2002:a2e:7f04:: with SMTP id a4-v6mr12322130ljd.156.1547321613126;
        Sat, 12 Jan 2019 11:33:33 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:32 -0800 (PST)
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
Subject: [PATCH v4 5/8] drm/arcpgu: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:48 +0100
Message-Id: <20190112193251.20450-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused arcgpu to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.
List of include files sorted alphabetically.

Build tested on arm x86 and arm allmodconfig.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/arc/arcpgu_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arc/arcpgu_sim.c b/drivers/gpu/drm/arc/arcpgu_sim.c
index 6530d88f7293..b1119bc62630 100644
--- a/drivers/gpu/drm/arc/arcpgu_sim.c
+++ b/drivers/gpu/drm/arc/arcpgu_sim.c
@@ -14,8 +14,9 @@
  *
  */
 
-#include <drm/drm_crtc_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 
 #include "arcpgu.h"
 
-- 
2.12.0

