Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57C8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825AD2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825AD2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeI0Pdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:33:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbeI0Pdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:39 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 63CD01117;
        Thu, 27 Sep 2018 09:16:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 62/88] drm/nouveau: Reset MST branching unit before enabling
Date:   Thu, 27 Sep 2018 11:03:43 +0200
Message-Id: <20180927090308.281386714@linuxfoundation.org>
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

commit fa3cdf8d0b092c4561f9f017dfac409eb7644737 upstream.

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
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/dispnv50/disp.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1098,17 +1098,21 @@ nv50_mstm_enable(struct nv50_mstm *mstm,
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


