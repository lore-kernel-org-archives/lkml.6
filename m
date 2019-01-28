Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A047C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7462086C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfA1VEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:04:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58802 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbfA1VEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:04:02 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E375FC0C7C88;
        Mon, 28 Jan 2019 21:04:01 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 129921948E;
        Mon, 28 Jan 2019 21:03:57 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        stable@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <karolherbst@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: Don't WARN_ON VCPI allocation failures
Date:   Mon, 28 Jan 2019 16:03:50 -0500
Message-Id: <20190128210352.18066-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 21:04:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is much louder then we want. VCPI allocation failures are quite
normal, since they will happen if any part of the modesetting process is
interrupted by removing the DP MST topology in question. So just print a
debugging message on VCPI failures instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: f479c0ba4a17 ("drm/nouveau/kms/nv50: initial support for DP 1.2 multi-stream")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v4.10+
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 2e8a5fd9b262..09a9c747c7bb 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -811,7 +811,8 @@ nv50_msto_enable(struct drm_encoder *encoder)
 
 	slots = drm_dp_find_vcpi_slots(&mstm->mgr, mstc->pbn);
 	r = drm_dp_mst_allocate_vcpi(&mstm->mgr, mstc->port, mstc->pbn, slots);
-	WARN_ON(!r);
+	if (!r)
+		DRM_DEBUG_KMS("Failed to allocate VCPI\n");
 
 	if (!mstm->links++)
 		nv50_outp_acquire(mstm->outp);
-- 
2.20.1

