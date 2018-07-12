Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A37C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA7420842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA7420842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732593AbeGLRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:21:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732575AbeGLRVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:21:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3F9D401DEC7;
        Thu, 12 Jul 2018 17:11:08 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E7BB2142F20;
        Thu, 12 Jul 2018 17:11:08 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Hook up dp_mst_info in debugfs
Date:   Thu, 12 Jul 2018 13:10:47 -0400
Message-Id: <20180712171056.26359-3-lyude@redhat.com>
In-Reply-To: <20180712171056.26359-1-lyude@redhat.com>
References: <20180712171056.26359-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:11:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 17:11:08 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is very useful for checking what nouveau thinks the current state
of each MST topology looks like.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 47 ++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 963a4dba8213..82f10beed0df 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -32,13 +32,19 @@
 #include <nvif/class.h>
 #include <nvif/if0001.h>
 #include "nouveau_debugfs.h"
+#include "nouveau_encoder.h"
 #include "nouveau_drv.h"
+#include "dispnv50/disp.h"
+
+static inline struct nouveau_drm *node_to_nouveau(struct drm_info_node *node)
+{
+	return nouveau_drm(node->minor->dev);
+}
 
 static int
 nouveau_debugfs_vbios_image(struct seq_file *m, void *data)
 {
-	struct drm_info_node *node = (struct drm_info_node *) m->private;
-	struct nouveau_drm *drm = nouveau_drm(node->minor->dev);
+	struct nouveau_drm *drm = node_to_nouveau(m->private);
 	int i;
 
 	for (i = 0; i < drm->vbios.length; i++)
@@ -46,6 +52,42 @@ nouveau_debugfs_vbios_image(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int
+nouveau_debugfs_dp_mst_info(struct seq_file *m, void *unused)
+{
+	struct nouveau_drm *drm = node_to_nouveau(m->private);
+	struct drm_device *dev = drm->dev;
+	struct drm_encoder *encoder;
+	struct nv50_mstm *mstm;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	ret = drm_modeset_lock_single_interruptible(&dev->mode_config.connection_mutex);
+	if (ret)
+		goto out;
+
+	drm_for_each_encoder(encoder, dev) {
+		if (encoder->encoder_type != DRM_MODE_ENCODER_TMDS)
+			continue;
+
+		mstm = nouveau_encoder(encoder)->dp.mstm;
+		if (!mstm)
+			continue;
+
+		seq_printf(m, "MST encoder source %s\n", encoder->name);
+		drm_dp_mst_dump_topology(m, &mstm->mgr);
+	}
+
+	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+out:
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
+	return ret;
+}
+
 static int
 nouveau_debugfs_pstate_get(struct seq_file *m, void *data)
 {
@@ -182,6 +224,7 @@ static const struct file_operations nouveau_pstate_fops = {
 
 static struct drm_info_list nouveau_debugfs_list[] = {
 	{ "vbios.rom", nouveau_debugfs_vbios_image, 0, NULL },
+	{ "dp_mst_info", nouveau_debugfs_dp_mst_info, 0, NULL },
 };
 #define NOUVEAU_DEBUGFS_ENTRIES ARRAY_SIZE(nouveau_debugfs_list)
 
-- 
2.17.1

