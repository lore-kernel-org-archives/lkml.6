Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB14C46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E98822395
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E98822395
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHJAtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 20:49:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeHJAtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 20:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C63A440241C8;
        Thu,  9 Aug 2018 22:22:19 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5760B2026D66;
        Thu,  9 Aug 2018 22:22:19 +0000 (UTC)
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
Subject: [PATCH 2/2] drm/nouveau: Reset MST branching unit before enabling
Date:   Thu,  9 Aug 2018 18:22:06 -0400
Message-Id: <20180809222209.26226-3-lyude@redhat.com>
In-Reply-To: <20180809222209.26226-1-lyude@redhat.com>
References: <20180809222209.26226-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 09 Aug 2018 22:22:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 09 Aug 2018 22:22:19 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probing a new MST device, it's not safe to make any assumptions
about it's current state. While most well mannered MST hubs will just
disable the branching unit on hotplug disconnects, this isn't enough to
save us from various other scenarios that might have resulted in
something writing to the MST branching unit before we got control of it.
This could happen if a previous probe we tried failed, if we're booting
in kexec context and the hub is still in the state the last kernel put
it in, etc.

Luckily; there is no reason we can't just reset the branching unit
every time we enable a new topology. So, fix this by resetting it on
enabling new topologies to ensure that we always start off with a clean,
unmodified topology state on MST sinks.

This fixes occasional hard-lockups on my P50's laptop dock (e.g. AUX
times out all DPCD trasactions) observed after multiple docks, undocks,
and module reloads.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index cdb3ef7c5d86..61bc36e9c915 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1098,17 +1098,21 @@ nv50_mstm_enable(struct nv50_mstm *mstm, u8 dpcd, int state)
 	int ret;
 
 	if (dpcd >= 0x12) {
-		ret = drm_dp_dpcd_readb(mstm->mgr.aux, DP_MSTM_CTRL, &dpcd);
+		/* Even if we're enabling MST, start with disabling the
+		 * branching unit to clear any sink-side MST topology state
+		 * that wasn't set by us
+		 */
+		ret = drm_dp_dpcd_writeb(mstm->mgr.aux, DP_MSTM_CTRL, 0);
 		if (ret < 0)
 			return ret;
 
-		dpcd &= ~DP_MST_EN;
-		if (state)
-			dpcd |= DP_MST_EN;
-
-		ret = drm_dp_dpcd_writeb(mstm->mgr.aux, DP_MSTM_CTRL, dpcd);
-		if (ret < 0)
-			return ret;
+		if (state) {
+			/* Now, start initializing */
+			ret = drm_dp_dpcd_writeb(mstm->mgr.aux, DP_MSTM_CTRL,
+						 DP_MST_EN);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return nvif_mthd(disp, 0, &args, sizeof(args));
-- 
2.17.1

