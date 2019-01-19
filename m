Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775CFC6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CAE2086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBoCSZ7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfASIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42539 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfASIko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so13563853lja.9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLMKi3hqiauseLdXJSy00zuhigYyytKjbkgO+kLy/D0=;
        b=SBoCSZ7PuMYaXp5BvDxFHNP31hCPVsA5hmZmo/5Gis8a9lqBJeDQ21dNcThpXz3hPN
         7AigCX7z/hcCZaqbKSeI+Q83aLkmarI+I9IJm+cOeQWSXeQINHH8vmZYCQjuKU0sTZgT
         Davch/Yx0kfc8u/cWDfogPxXNnHAEtv3wS8/auBS8pco3C/NnZ0R8d3ULcPQK/j2jfiq
         Y5Eizmo+BZgHYv3axr9u6x3TukEfORMUArG3es4bMPo1oy7mBwd+cr8yiOz2CykSzuL5
         mQn24ik/lZBX9D9J/gQky0q2LedicHzJODrzFEesLTLlaHhKyLRhTAEPW7uGIdhpM4M2
         ihcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=oLMKi3hqiauseLdXJSy00zuhigYyytKjbkgO+kLy/D0=;
        b=N0X0DEv7OvZONrLfXk+C3X2u72vHp/hynapoJ8fFdBPwQfYn+nkcbzreXzJBeUOGT7
         1oqenitrFjnCKwxjFjrtibdfWXh2XLlWXwRNsy7MDxr7a8ER5fp8i1UYe924Q3jIzJWd
         Rj0oRRvegtk1vY3txhI7Cgbd/uZawl+SyP0+j/B8DSQBobo2BE1ylOIP7TKRy8az5QtJ
         gS8yZ0uxRQFgoEAY0A6bVH4q1ERV2CCE+wENOIskOJompMmXZy57fIVMxkQJkBHJrFjR
         CrdiJ++iPLcW4kfLPo6vL/3jv1emVnX4LeWhZU7Rujw37UJXsCa35J3+vf9WINRhaCDY
         abJw==
X-Gm-Message-State: AJcUukddFIxbUJ28d4PQHf8lQLg1mdF8vFbwTiNekyPPYJSMIqTw4v2i
        P61sNP7Mopu7C5+5vzFYPC4=
X-Google-Smtp-Source: ALg8bN7R+XeNZf1u90GP6DivdX41T6ge6oRwmjXn3Sb3btz9yWiww/8JbykjfcyJos0nt6tlOHf5oA==
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr13769113ljt.159.1547887242161;
        Sat, 19 Jan 2019 00:40:42 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:41 -0800 (PST)
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
Subject: [PATCH v5 3/6] drm/arcpgu: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:11 +0100
Message-Id: <20190119084014.5355-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
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
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
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

