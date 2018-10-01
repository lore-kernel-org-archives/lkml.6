Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10B62089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10B62089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbeJAS4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:56:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54392 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbeJAS4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04359308A964;
        Mon,  1 Oct 2018 12:19:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD1376266E;
        Mon,  1 Oct 2018 12:19:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C49E19AD2; Mon,  1 Oct 2018 14:19:11 +0200 (CEST)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/bochs: add edid support.
Date:   Mon,  1 Oct 2018 14:19:11 +0200
Message-Id: <20181001121911.27140-3-kraxel@redhat.com>
In-Reply-To: <20181001121911.27140-1-kraxel@redhat.com>
References: <20181001121911.27140-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Mon, 01 Oct 2018 12:19:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent qemu (latest master branch, upcoming 3.1 release) got support
for EDID data.  This patch adds guest driver support.

EDID support in qemu is not (yet) enabled by default, so please use
'qemu -device VGA,edid=on' for testing.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  1 +
 drivers/gpu/drm/bochs/bochs_hw.c  | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/bochs/bochs_kms.c | 16 +++++++++++++---
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 375bf92cd0..055d7b437a 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -70,6 +70,7 @@ struct bochs_device {
 	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
+	struct edid *edid;
 
 	/* drm */
 	struct drm_device  *dev;
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index a39b0343c1..21a769e48c 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -47,6 +47,41 @@ static void bochs_dispi_write(struct bochs_device *bochs, u16 reg, u16 val)
 	}
 }
 
+static int bochs_load_edid(struct bochs_device *bochs)
+{
+	uint8_t *blob;
+	size_t i, len;
+	uint8_t num_exts;
+
+	if (!bochs->mmio)
+		return -1;
+
+	if ((readb(bochs->mmio+0) != 0x00 ||
+	     readb(bochs->mmio+1) != 0xff))
+		return -1;
+
+	num_exts = readb(bochs->mmio + 126);
+	len = EDID_LENGTH * (1 + num_exts);
+	if (len > 0x400 /* vga register offset */)
+		return -1;
+
+	kfree(bochs->edid);
+	bochs->edid = kmalloc(len, GFP_KERNEL);
+	blob = (void *)bochs->edid;
+	for (i = 0; i < len; i++) {
+		blob[i] = readb(bochs->mmio+i);
+	}
+
+	if (!drm_edid_is_valid(bochs->edid)) {
+		DRM_ERROR("EDID is not valid, ignoring.\n");
+		kfree(bochs->edid);
+		bochs->edid = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 int bochs_hw_init(struct drm_device *dev, uint32_t flags)
 {
 	struct bochs_device *bochs = dev->dev_private;
@@ -133,6 +168,9 @@ int bochs_hw_init(struct drm_device *dev, uint32_t flags)
 	}
 
 noext:
+	if (bochs_load_edid(bochs) == 0)
+		DRM_INFO("Found EDID data blob.\n");
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ca5a9afdd5..008c5f0aaf 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -181,10 +181,17 @@ static void bochs_encoder_init(struct drm_device *dev)
 
 static int bochs_connector_get_modes(struct drm_connector *connector)
 {
-	int count;
+	struct bochs_device *bochs =
+		container_of(connector, struct bochs_device, connector);
+	int count = 0;
 
-	count = drm_add_modes_noedid(connector, 8192, 8192);
-	drm_set_preferred_mode(connector, defx, defy);
+	if (bochs->edid)
+		count = drm_add_edid_modes(connector, bochs->edid);
+
+	if (!count) {
+		count = drm_add_modes_noedid(connector, 8192, 8192);
+		drm_set_preferred_mode(connector, defx, defy);
+	}
 	return count;
 }
 
@@ -239,6 +246,9 @@ static void bochs_connector_init(struct drm_device *dev)
 	drm_connector_helper_add(connector,
 				 &bochs_connector_connector_helper_funcs);
 	drm_connector_register(connector);
+
+	if (bochs->edid)
+		drm_connector_update_edid_property(connector, bochs->edid);
 }
 
 
-- 
2.9.3

