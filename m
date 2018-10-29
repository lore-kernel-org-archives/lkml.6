Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1F620824
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1F620824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbeJ3FlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:41:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbeJ3FlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 96AA830832DA;
        Mon, 29 Oct 2018 20:50:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83D8819489;
        Mon, 29 Oct 2018 20:50:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8D880B3DC7; Mon, 29 Oct 2018 21:50:53 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@redhat.com>, jani.nikula@linux.intel.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] drm/bochs: add edid support.
Date:   Mon, 29 Oct 2018 21:50:48 +0100
Message-Id: <20181029205048.13200-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Oct 2018 20:50:57 +0000 (UTC)
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
 drivers/gpu/drm/bochs/bochs.h     |  2 ++
 drivers/gpu/drm/bochs/bochs_hw.c  | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/bochs/bochs_kms.c | 20 +++++++++++++++++---
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index e7a69077e4..577a8b917c 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -66,6 +66,7 @@ struct bochs_device {
 	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
+	struct edid *edid;
 
 	/* drm */
 	struct drm_device  *dev;
@@ -126,6 +127,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 		      const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
 		      int x, int y, u64 addr);
+int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
 int bochs_mm_init(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index cacff73a64..c90a0d492f 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -69,6 +69,35 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
 #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
 #endif
 
+static int bochs_get_edid_block(void *data, u8 *buf,
+				unsigned int block, size_t len)
+{
+	struct bochs_device *bochs = data;
+	size_t i, start = block * EDID_LENGTH;
+
+	if (start + len > 0x400 /* vga register offset */)
+		return -1;
+
+	for (i = 0; i < len; i++) {
+		buf[i] = readb(bochs->mmio + start + i);
+	}
+	return 0;
+}
+
+int bochs_hw_load_edid(struct bochs_device *bochs)
+{
+	if (!bochs->mmio)
+		return -1;
+
+	kfree(bochs->edid);
+	bochs->edid = drm_do_get_edid(&bochs->connector,
+				      bochs_get_edid_block, bochs);
+	if (bochs->edid == NULL)
+		return -1;
+
+	return 0;
+}
+
 int bochs_hw_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
@@ -164,6 +193,7 @@ void bochs_hw_fini(struct drm_device *dev)
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
 	pci_release_regions(dev->pdev);
+	kfree(bochs->edid);
 }
 
 void bochs_hw_setmode(struct bochs_device *bochs,
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 9bc5b438ae..f87c284dd9 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -213,10 +213,17 @@ static void bochs_encoder_init(struct drm_device *dev)
 
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
 
@@ -271,6 +278,13 @@ static void bochs_connector_init(struct drm_device *dev)
 	drm_connector_helper_add(connector,
 				 &bochs_connector_connector_helper_funcs);
 	drm_connector_register(connector);
+
+	bochs_hw_load_edid(bochs);
+	if (bochs->edid) {
+		DRM_INFO("Found EDID data blob.\n");
+		drm_connector_attach_edid_property(connector);
+		drm_connector_update_edid_property(connector, bochs->edid);
+	}
 }
 
 
-- 
2.9.3

