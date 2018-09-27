Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12EECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081C320836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081C320836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeI0Pai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:30:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55442 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeI0Pah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:30:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EFF041117;
        Thu, 27 Sep 2018 09:13:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 63/88] drm/nouveau: Only write DP_MSTM_CTRL when needed
Date:   Thu, 27 Sep 2018 11:03:44 +0200
Message-Id: <20180927090308.398041241@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit b26b4590dd53e012526342e749c423e6c0e73437 upstream.

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
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   45 +++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1121,31 +1121,58 @@ nv50_mstm_enable(struct nv50_mstm *mstm,
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
+	}
+
+	if (new_state == old_state) {
+		mutex_unlock(&mstm->mgr.lock);
+		return new_state;
 	}
 
-	ret = nv50_mstm_enable(mstm, dpcd[0], state);
+	ret = nv50_mstm_enable(mstm, dpcd[0], new_state);
 	if (ret)
-		return ret;
+		goto probe_error;
 
-	ret = drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, state);
+	mutex_unlock(&mstm->mgr.lock);
+
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


