Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1A6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32690223A0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:22:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32690223A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeHJAtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:49:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeHJAtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:49:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ABC8E8315E;
        Thu,  9 Aug 2018 22:22:17 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 424F72026D66;
        Thu,  9 Aug 2018 22:22:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/nouveau: Only write DP_MSTM_CTRL when needed
Date:   Thu,  9 Aug 2018 18:22:05 -0400
Message-Id: <20180809222209.26226-2-lyude@redhat.com>
In-Reply-To: <20180809222209.26226-1-lyude@redhat.com>
References: <20180809222209.26226-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 09 Aug 2018 22:22:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 09 Aug 2018 22:22:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nouveau will re-write the DP_MSTM_CTRL register for an MST
hub every time it receives a long HPD pulse on DP. This isn't actually
necessary and additionally, has some unintended side effects.

With the P50 I've got here, rewriting DP_MSTM_CTRL constantly seems to
make it rather likely (1 out of 5 times usually) that bringing up MST
with it's ThinkPad dock will fail and result in sideband messages timing
out in the middle. Afterwards, successive probes don't manage to get the
dock to communicate properly over MST sideband properly.

Many times sideband message timeouts from MST hubs are indicative of
either the source or the sink dropping an ESI event, which can cause
DRM's perspective of the topology's current state to go out of sync with
reality. While it's tough to really know for sure what's happening to
the dock, using userspace tools to write to DP_MSTM_CTRL in the middle
of the MST link probing process does appear to make things flaky. It's
possible that when we write to DP_MSTM_CTRL, the function that gets
triggered to respond in the dock's firmware temporarily puts it in a
state where it might end up not reporting an ESI to the source, or ends
up dropping a sideband message we sent it.

So, to fix this we make it so that when probing an MST topology, we
respect it's current state. If the dock's already enabled, we simply
read DP_MSTM_CTRL and disable the topology if it's value is not what we
expected. Otherwise, we perform the normal MST probing dance. We avoid
taking any action except if the state of the MST topology actually
changes.

This fixes MST sideband message timeouts and detection failures on my
P50 with its ThinkPad dock.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 45 ++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index f6c0b2aa9857..cdb3ef7c5d86 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1117,31 +1117,58 @@ nv50_mstm_enable(struct nv50_mstm *mstm, u8 dpcd, int state)
 int
 nv50_mstm_detect(struct nv50_mstm *mstm, u8 dpcd[8], int allow)
 {
-	int ret, state = 0;
+	struct drm_dp_aux *aux;
+	int ret;
+	bool old_state, new_state;
+	u8 mstm_ctrl;
 
 	if (!mstm)
 		return 0;
 
-	if (dpcd[0] >= 0x12) {
-		ret = drm_dp_dpcd_readb(mstm->mgr.aux, DP_MSTM_CAP, &dpcd[1]);
+	mutex_lock(&mstm->mgr.lock);
+
+	old_state = mstm->mgr.mst_state;
+	new_state = old_state;
+	aux = mstm->mgr.aux;
+
+	if (old_state) {
+		/* Just check that the MST hub is still as we expect it */
+		ret = drm_dp_dpcd_readb(aux, DP_MSTM_CTRL, &mstm_ctrl);
+		if (ret < 0 || !(mstm_ctrl & DP_MST_EN)) {
+			DRM_DEBUG_KMS("Hub gone, disabling MST topology\n");
+			new_state = false;
+		}
+	} else if (dpcd[0] >= 0x12) {
+		ret = drm_dp_dpcd_readb(aux, DP_MSTM_CAP, &dpcd[1]);
 		if (ret < 0)
-			return ret;
+			goto probe_error;
 
 		if (!(dpcd[1] & DP_MST_CAP))
 			dpcd[0] = 0x11;
 		else
-			state = allow;
+			new_state = allow;
 	}
 
-	ret = nv50_mstm_enable(mstm, dpcd[0], state);
+	if (new_state == old_state) {
+		mutex_unlock(&mstm->mgr.lock);
+		return new_state;
+	}
+
+	ret = nv50_mstm_enable(mstm, dpcd[0], new_state);
 	if (ret)
-		return ret;
+		goto probe_error;
+
+	mutex_unlock(&mstm->mgr.lock);
 
-	ret = drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, state);
+	ret = drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, new_state);
 	if (ret)
 		return nv50_mstm_enable(mstm, dpcd[0], 0);
 
-	return mstm->mgr.mst_state;
+	return new_state;
+
+probe_error:
+	mutex_unlock(&mstm->mgr.lock);
+	return ret;
 }
 
 static void
-- 
2.17.1

