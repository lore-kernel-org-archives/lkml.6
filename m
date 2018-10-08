Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D405FC6787A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D71A205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D71A205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbeJIFxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:53:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbeJIFxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:53:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 669103082A23;
        Mon,  8 Oct 2018 22:39:36 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 499DC105705C;
        Mon,  8 Oct 2018 22:39:35 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] drm/nouveau: Fix nv50_mstc->best_encoder()
Date:   Mon,  8 Oct 2018 18:39:18 -0400
Message-Id: <20181008223924.1103-3-lyude@redhat.com>
In-Reply-To: <20181008223924.1103-1-lyude@redhat.com>
References: <20181008223924.1103-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Oct 2018 22:39:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned in the previous commit, we currently prevent new modesets
on recently-removed MST connectors by returning no encoder from our
->best_encoder() callback once the MST port has disappeared. This is
wrong however, because it prevents legacy modesetting users from being
able to disable CRTCs on MST connectors after the connector's respective
topology has disappeared.

So, fix this by instead by just always returning a valid encoder.

Changes since v2:
- Remove usage of atomic MST helper for now, since that got replaced
  with a much simpler solution

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9f32b10c7c29..31b94bc9ec90 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -843,22 +843,16 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
 {
 	struct nv50_head *head = nv50_head(connector_state->crtc);
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[head->base.index]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[head->base.index]->encoder;
 }
 
 static struct drm_encoder *
 nv50_mstc_best_encoder(struct drm_connector *connector)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[0]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[0]->encoder;
 }
 
 static enum drm_mode_status
-- 
2.17.1

