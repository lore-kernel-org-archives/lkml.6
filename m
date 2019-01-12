Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63256C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D80E2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNJzszMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfALTde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:34 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32870 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfALTda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so15750961ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=89MFC7PzVXRSmDKlMJ5K+IukfdSMY05DYh7kT8q/Ruc=;
        b=tNJzszMBco6E5rCwXAcBQ7QDJlmuyjWDwCOFnGVlDmRSHus8C++W/WO0DKmsu0C09s
         PHdGavds5FQ838Aq45HHDenhf+aVsEj6dxAoSfHwsNCS6hJMfDMVnxiJFKGGN5OkRiQu
         UrMdaNBBWJkcOU5uhDN5B6m96aNivbsQCY0LHDCw5uXjT7ChWDLf7PFegkPPz79wB1qT
         FeZEDlcMIfnSoaeiKlW+TWEnv5RHnEk2fvuGgyxR0vuZGFQ7xFXceR8jRALxzQrGsUQf
         02R8abNtSnZiIe5mob4L/53Y69NB8GqJF8cheHi5vyVzXGl3nQCLzEDpaItpZ+SBG6X3
         5mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=89MFC7PzVXRSmDKlMJ5K+IukfdSMY05DYh7kT8q/Ruc=;
        b=Cs5NYt88JXFFYWg5JoMzVTURioEks04DQaanP3bhSyfIHQjWcz0w10UOD9PxIAcAep
         7G8EL2BFWGKGRN4b3VNldXq+cA6GUZD+ok8jCKXauheLJW1hSwwhWKVIzIQ6gCykVr7d
         F4txsnpwaH2R1G96h6wg2r0QCX6APXizc53fosM65Er6egyGW/wGIx2y3YOzqgcQYxZ/
         LIyfjfe/ahl//DCnNkIgeIbW4G9wNeVOo1VJ6VNQ+jSwVGn/h5QP6hwLIf3j8dXY6kMt
         h6MEIl8mDQxq6PbcJs6wUbncDPYAVDDpkPh/o16Jn45/JNBWYrOu0Lmv1gXYhkkvfTsC
         9yUQ==
X-Gm-Message-State: AJcUuke7xQxcbMrKXUnFLquXQDAfixLaNuW/N2+2uESO40xoRgqsljbp
        TP2QgbMmt2L04rKHONlL/XU=
X-Google-Smtp-Source: ALg8bN7kAPSZgjHPy5k0HkCJWWnna4Jzk894Ppuwhs0yQ35ZzT+0tQPPTkEjtPm8JM1rDQW9+NSUog==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr8257679ljo.10.1547321608796;
        Sat, 12 Jan 2019 11:33:28 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:28 -0800 (PST)
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
Subject: [PATCH v4 2/8] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h
Date:   Sat, 12 Jan 2019 20:32:45 +0100
Message-Id: <20190112193251.20450-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the quest to get rid of drmP.h move the newly
added EXPORT_SYMBOL_FOR_TESTS_ONLY to drm_util.h.
Fix the single user.

Add a note to drmP.h to avoid further use of it.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/drm_framebuffer.c |  1 +
 include/drm/drmP.h                | 11 ++++++-----
 include/drm/drm_util.h            | 10 ++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_framebuffer.c
index fcaea8f50513..7abcb265a108 100644
--- a/drivers/gpu/drm/drm_framebuffer.c
+++ b/drivers/gpu/drm/drm_framebuffer.c
@@ -27,6 +27,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_print.h>
+#include <drm/drm_util.h>
 
 #include "drm_internal.h"
 #include "drm_crtc_internal.h"
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index bc4cb3732407..3f5c577c9dbd 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -94,10 +94,11 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
-#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
-#else
-#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
-#endif
+/*
+ * NOTE: drmP.h is obsolete - do NOT add anything to this file
+ *
+ * Do not include drmP.h in new files.
+ * Work is ongoing to remove drmP.h includes from existing files
+ */
 
 #endif
diff --git a/include/drm/drm_util.h b/include/drm/drm_util.h
index f776a55e5508..0500da65b1d1 100644
--- a/include/drm/drm_util.h
+++ b/include/drm/drm_util.h
@@ -37,6 +37,16 @@
 #include <linux/kgdb.h>
 #include <linux/smp.h>
 
+/*
+ * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
+ * only be visible for drmselftests.
+ */
+#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
+#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
+#else
+#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
+#endif
+
 /**
  * for_each_if - helper for handling conditionals in various for_each macros
  * @condition: The condition to check
-- 
2.12.0

