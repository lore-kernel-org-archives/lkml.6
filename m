Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9B3C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E7F2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSVyATfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfALTd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:33:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44328 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbfALTdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:33:33 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so15707454lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 11:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KbLBdhYOvrrJnM0s7coeDX2LH3PzxTfZFPYDDnxo76Y=;
        b=HSVyATfJ5YINYDSZm46u5BICB4LUKbVXeggr0YmACOHRogamKlYkYNHEGfs7T2Xaw7
         fgHP0Ubj5Y5Ueovf6D1RjugsDKPBAd/yR0edhhGbyKsNQPFD7WSV9ubM743X+Le/h7lm
         aFOx8SmU+m0rOsJ14hFN7ZZBcQnrQbTNPdP+7k8Utwi2zeZYNXTDbVFVlJETRgoipcB1
         zdBJDwXGX2Esg04+746LMe1NYKfsdIL3ghjxPGz79aQ40ONcQgic0I9zka9EE4fzxHrx
         SOlh+v2clFvYGgCEdTV6QTYEdV6QQTnHRJcumaOpjGQv3mgxqdJ7OD2StbEh/BEDVjo2
         JRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=KbLBdhYOvrrJnM0s7coeDX2LH3PzxTfZFPYDDnxo76Y=;
        b=ZjzJcCaWpXJWwM3/y5NAku1+2iHn2PnCJKZbPHIanSBmRCNiXQHs1eKjA5jOZBuZ2G
         oq8zT5Mugz3haH0Ksx2MThHLd8PjGic92UODoa9r2u3kcDk0sv5jJOFxAXfzHtJfZw1g
         A/CqjbuEyJTJ50JFVolN78aHk9HeEOtYTZv/mHBWZ2qBvlTrAK9rXxz498kZAsYeUjIG
         n/U0k6P/8H7JJ+ALj2cu+nSwKLLKgrAwwHYbul8YleqiG38orAc1e9Nhs7A40UeFjQ+9
         30UimmNLivNKmzfgO7AbjLBWdRgLx/+wJ2Li2I0fquFFKj0Iqyv9YlPQ1fw7GDNrJ20/
         UN3A==
X-Gm-Message-State: AJcUukddccgl1NhWIvkxfIakWM8VSbvfNzbKM32e2Agv5/hzLvjN2oD3
        NybLEslp20tP8pCkIVLEJ/Y=
X-Google-Smtp-Source: ALg8bN5PvetYfQv+67D2M99l6oN908YASVBCZfJeigUhdXwLrdmVgIOCxgRK4bc9MxpoNrm96v1F7Q==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr12055660ljf.127.1547321611680;
        Sat, 12 Jan 2019 11:33:31 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id d82sm15624452lfd.82.2019.01.12.11.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 11:33:31 -0800 (PST)
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
Subject: [PATCH v4 4/8] drm/hisilicon/kirin: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 12 Jan 2019 20:32:47 +0100
Message-Id: <20190112193251.20450-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190112193251.20450-1-sam@ravnborg.org>
References: <20190112193251.20450-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of drmP.h is discouraged and removal of it from
drm_modeset_helper.h caused kirin to fail to build.

This patch introduce the necessary fixes to prepare for the
drmP.h removal from drm_modeset_helper.h.
List of include files sorted alphabetically.

Build tested on arm x86 allmodconfig using the following hack
to the Kconfig file:

| -       depends on DRM && OF && ARM64
| +       depends on DRM && OF && (ARM64 || (X86_64 && COMPILE_TEST))

Build failed on 32bit ARM - so the X86_64 hack was required.
The COMPILE_TEST hack is not submitted as the preferred fix
is something where we have coverage on 32bit ARM too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index b4c7af3ab6ae..7ffebdd843a2 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -16,13 +16,18 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/component.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 
-#include <drm/drm_of.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_device.h>
 #include <drm/drm_encoder_slave.h>
-#include <drm/drm_atomic_helper.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_print.h>
+#include <drm/drm_of.h>
 
 #include "dw_dsi_reg.h"
 
-- 
2.12.0

