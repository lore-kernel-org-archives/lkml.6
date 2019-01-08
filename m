Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B36C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803DD20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soYTQG0b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbfAHTaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:30:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34865 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730550AbfAHTaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:30:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id x85-v6so4433017ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XUflO4G4Dd3EM/eG7jeSYEDT6AoE9me3ht4t1gspZk=;
        b=soYTQG0bq+WP+8/CnlLdsctJTfpWE99LXcVyiDRYxCwxnONaQir+4fDmulkNhNza/4
         lhzCBPP/4/2gn2ZbjETTH48hV1e38ke4oJ4uOmYMeFGrGgqOvkfkESl5+IF5O5r0qxe1
         ZQnCEM0/+pqEFAwfJClgvOKCSG1BCPGISdlDEs4s/quN0NNvHjauVkm2Y6cyRmYM2R69
         hUpr51f+k+rGEa2dtnPYL2FYTdmMeiQyO7USe4velZAIhyNWvfDs81dKP4aBqCZfY0Jn
         2/CwNAO1sNBJnyEuvUFkU6oahAuLcaebdadkyIunT7PUdL1q+6XbhhSc/mC6v37j87NH
         r8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5XUflO4G4Dd3EM/eG7jeSYEDT6AoE9me3ht4t1gspZk=;
        b=uBBTB86YS/iiTxm+k992KJTbjQsyiCfY11W1cuqAfMw8yvBsnXPrIB3HGo12MNj0xp
         bHVun+nskLlsw+7vw+5NW9v0XlnyKDL6bwun4uW2MXjufsrw7T9uSEjm0L17+qPvWciO
         Q3B32lJrXvOVDP3il3zL8+K0qU1oeBqtoVwR59TM+cJeEqnVZWgxX/tRe0jOILPbpbuI
         8Y0Vg2VDI3d9P9p5HPUkiZLYjoFh+f/6hWLDKhxOrV2yjwsXDjN9cmJQPoqIC2SM/BP/
         iyPknM9555+W+f7RMuL981stRrSx+DldptuH/48KvawDcw4cAI4bmuaq0+IjDQ/4Ucy2
         YwNg==
X-Gm-Message-State: AJcUukdzw2FyOApiGlwrr0pbuLh/Q6YGnyf257jk78/r7z/Y/D9Yvk93
        Q4WoWz2tFiccyIGBk0QUk3o=
X-Google-Smtp-Source: ALg8bN5T39rO5PA2D9Bl4KSEQT29+0y8fiQbOsB9r+jbMTGusrVNJl/jReg4hZNDRJtfUVadw9XdSw==
X-Received: by 2002:a2e:4442:: with SMTP id r63-v6mr1811885lja.79.1546975800393;
        Tue, 08 Jan 2019 11:30:00 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:59 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Alexey Brodkin <abrodkin@synopsys.com>
Subject: [PATCH v3 09/12] drm/arc: do not reply on drmP.h from drm_gem_cma_helper.h
Date:   Tue,  8 Jan 2019 20:29:36 +0100
Message-Id: <20190108192939.15255-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drmP.h was the only header file in the past and a lot
of files rely on that drmP.h defines everything.
The goal is to one day to delete drmP.h and
as a step towards this it will no longer be included in the
headers files in include/drm/

To prepare arc/ for this add dependencies that
othwewise was pulled in by drmP.h from drm_gem_cma_helper.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Noralf Trønnes <noralf@tronnes.org>
Cc: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
---
 drivers/gpu/drm/arc/arcpgu_crtc.c | 2 ++
 drivers/gpu/drm/arc/arcpgu_drv.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/arc/arcpgu_crtc.c b/drivers/gpu/drm/arc/arcpgu_crtc.c
index 62f51f70606d..155ab177ce0b 100644
--- a/drivers/gpu/drm/arc/arcpgu_crtc.c
+++ b/drivers/gpu/drm/arc/arcpgu_crtc.c
@@ -16,8 +16,10 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_gem_cma_helper.h>
+#include <drm/drm_vblank.h>
 #include <drm/drm_plane_helper.h>
 #include <linux/clk.h>
 #include <linux/platform_data/simplefb.h>
diff --git a/drivers/gpu/drm/arc/arcpgu_drv.c b/drivers/gpu/drm/arc/arcpgu_drv.c
index 206a76abf771..39a79f5718c4 100644
--- a/drivers/gpu/drm/arc/arcpgu_drv.c
+++ b/drivers/gpu/drm/arc/arcpgu_drv.c
@@ -16,12 +16,18 @@
 
 #include <linux/clk.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_device.h>
+#include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_fb_cma_helper.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
 
 #include "arcpgu.h"
 #include "arcpgu_regs.h"
-- 
2.12.0

