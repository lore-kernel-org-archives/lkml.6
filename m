Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDA2C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB202086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZdMzlfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfASIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 03:40:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41364 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbfASIkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 03:40:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so13565548ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 00:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lVdSxad1eREzQaMM2zTwEdkEkNEXB56rMNuGRhxTrn0=;
        b=LZdMzlfIEi/DG7iM9ZN1I+nKBSwW6i7kRZzp9P814vCJ6mkhv3jZbPMech/VgEpugY
         AjU4KSmUbWzCex3zC6kqbhwpfuVC3xmzvTR76YFl83iX4LAFsuVG1KcsWEyULAtMRpKZ
         vZ96JEvXHwoCrOE8BWCitpuaBTSfqnstwfvz0Vmf0WBgD/YUXCmX1AG9L95u9v6YB1/n
         zHR6eMAsc9Rii13iK/HujVt6ala6NIgPQ+XC4hFWaSEWNKqdRAoJEaTtF+IV1y+Caqwd
         6A0EP0FprNcDkTKTGfBIx+eTqUyoeX2gBTpDveftJEB/T/XXkjb2jUVf/YCJLZC9Z3Ky
         X7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=lVdSxad1eREzQaMM2zTwEdkEkNEXB56rMNuGRhxTrn0=;
        b=q2MDAkHIHHYLu+EH4UJ5lKFIDHx5Apb4JkeWYIAEWB1QqLF4Kj5FnMGHAso6ZGCUVx
         e9a1PEVS5ja41u84DjycH1dgpGEuJ3h7uvS5c7+gle0pT0Zjqp1dhCBwWC+U5T1c8lXT
         tMsLJnQvM0huIG0fUf7XdLu5e3V46pPqXZ/GUNnJ01V5IfKbYQGQ0vWstB8NIXnI6ZAW
         wnRLAtOEDsTGWQGDSZJ5FuJIZWzL/IeQMp0OPW/FA5u8PDnoxki+e/nIB32oipgxUREQ
         og7k33nRu3u5IA0GQksr3MkRhop1BbFz3/C7r0I6/j0gKdlOSO75FIrXQM6C4bjaBxgW
         +0Bw==
X-Gm-Message-State: AJcUukdXnZGQJD9HjmrZBpvszhi37AcpaR6bfrMlvFikzKWbaCqXh7to
        KZ1AQNNnxIl/+tCujTVskqE=
X-Google-Smtp-Source: ALg8bN7f0j7Ejm5Cfc/lh02A1elnOMgWOQcx3BjKzusLRe9AcW1iNJxEFwHngOk8Iv53Bai+0S1TMA==
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr14831924lji.133.1547887240879;
        Sat, 19 Jan 2019 00:40:40 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id p23sm1187109lfh.47.2019.01.19.00.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 00:40:40 -0800 (PST)
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
Subject: [PATCH v5 2/6] drm/hisilicon/kirin: prepare for drmP.h removal from drm_modeset_helper.h
Date:   Sat, 19 Jan 2019 09:40:10 +0100
Message-Id: <20190119084014.5355-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190119084014.5355-1-sam@ravnborg.org>
References: <20190119084014.5355-1-sam@ravnborg.org>
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

v2:
- Sort list of include files

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
index b4c7af3ab6ae..009c8cb39ac4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -17,12 +17,17 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/delay.h>
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
+#include <drm/drm_of.h>
+#include <drm/drm_print.h>
 
 #include "dw_dsi_reg.h"
 
-- 
2.12.0

