Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABBDC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3C62098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 23:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3C62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJEGaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 02:30:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbeJEG37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 02:29:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3FD9C04B925;
        Thu,  4 Oct 2018 23:34:10 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 891BD67C7E;
        Thu,  4 Oct 2018 23:34:09 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] drm/nouveau: Fix nv50_mstc->best_encoder()
Date:   Thu,  4 Oct 2018 19:33:47 -0400
Message-Id: <20181004233353.5388-3-lyude@redhat.com>
In-Reply-To: <20181004233353.5388-1-lyude@redhat.com>
References: <20181004233353.5388-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 04 Oct 2018 23:34:11 +0000 (UTC)
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

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org

Changes since v2:
- Remove usage of atomic MST helper for now, since that got replaced
  with a much simpler solution

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9da0bdfe1e1c..f58fc12f0a07 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -881,22 +881,16 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
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

