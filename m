Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82AEC476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D30F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D30F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbeGLRVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 13:21:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727092AbeGLRVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 13:21:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 162A1701E6;
        Thu, 12 Jul 2018 17:11:08 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-214.rdu2.redhat.com [10.10.120.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6272142F20;
        Thu, 12 Jul 2018 17:11:07 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Archit Taneja <architt@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Expose nv50 MST structures in disp.h
Date:   Thu, 12 Jul 2018 13:10:46 -0400
Message-Id: <20180712171056.26359-2-lyude@redhat.com>
In-Reply-To: <20180712171056.26359-1-lyude@redhat.com>
References: <20180712171056.26359-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 17:11:08 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 12 Jul 2018 17:11:08 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're about to need this so that we can hook up dp_mst_info into debugfs
so we can walk the encoder list and find each mst mgr.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 34 ------------------------
 drivers/gpu/drm/nouveau/dispnv50/disp.h | 35 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index d9da69c83ae7..f76fe5f260a4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -568,40 +568,6 @@ nv50_hdmi_enable(struct drm_encoder *encoder, struct drm_display_mode *mode)
 /******************************************************************************
  * MST
  *****************************************************************************/
-#define nv50_mstm(p) container_of((p), struct nv50_mstm, mgr)
-#define nv50_mstc(p) container_of((p), struct nv50_mstc, connector)
-#define nv50_msto(p) container_of((p), struct nv50_msto, encoder)
-
-struct nv50_mstm {
-	struct nouveau_encoder *outp;
-
-	struct drm_dp_mst_topology_mgr mgr;
-	struct nv50_msto *msto[4];
-
-	bool modified;
-	bool disabled;
-	int links;
-};
-
-struct nv50_mstc {
-	struct nv50_mstm *mstm;
-	struct drm_dp_mst_port *port;
-	struct drm_connector connector;
-
-	struct drm_display_mode *native;
-	struct edid *edid;
-
-	int pbn;
-};
-
-struct nv50_msto {
-	struct drm_encoder encoder;
-
-	struct nv50_head *head;
-	struct nv50_mstc *mstc;
-	bool disabled;
-};
-
 static struct drm_dp_payload *
 nv50_msto_payload(struct nv50_msto *msto)
 {
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.h b/drivers/gpu/drm/nouveau/dispnv50/disp.h
index e48c5eb35b49..5ba7093f3c74 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.h
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.h
@@ -3,6 +3,7 @@
 #include <nvif/mem.h>
 
 #include "nouveau_display.h"
+#include "nouveau_encoder.h"
 
 struct nv50_disp {
 	struct nvif_disp *disp;
@@ -65,6 +66,40 @@ struct nv50_dmac {
 	struct mutex lock;
 };
 
+#define nv50_mstm(p) container_of((p), struct nv50_mstm, mgr)
+#define nv50_mstc(p) container_of((p), struct nv50_mstc, connector)
+#define nv50_msto(p) container_of((p), struct nv50_msto, encoder)
+
+struct nv50_mstm {
+	struct nouveau_encoder *outp;
+
+	struct drm_dp_mst_topology_mgr mgr;
+	struct nv50_msto *msto[4];
+
+	bool modified;
+	bool disabled;
+	int links;
+};
+
+struct nv50_mstc {
+	struct nv50_mstm *mstm;
+	struct drm_dp_mst_port *port;
+	struct drm_connector connector;
+
+	struct drm_display_mode *native;
+	struct edid *edid;
+
+	int pbn;
+};
+
+struct nv50_msto {
+	struct drm_encoder encoder;
+
+	struct nv50_head *head;
+	struct nv50_mstc *mstc;
+	bool disabled;
+};
+
 int nv50_dmac_create(struct nvif_device *device, struct nvif_object *disp,
 		     const s32 *oclass, u8 head, void *data, u32 size,
 		     u64 syncbuf, struct nv50_dmac *dmac);
-- 
2.17.1

