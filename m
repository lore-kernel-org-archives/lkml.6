Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867BC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11A812075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11A812075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbeLNB0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:26:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLNB0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:26:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6514D4ACD6;
        Fri, 14 Dec 2018 01:26:51 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEB756012B;
        Fri, 14 Dec 2018 01:26:49 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 08/15] drm/nouveau: Remove unnecessary VCPI checks in nv50_msto_cleanup()
Date:   Thu, 13 Dec 2018 20:25:37 -0500
Message-Id: <20181214012604.13746-9-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 14 Dec 2018 01:26:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to look at the port's VCPI allocation before calling
drm_dp_mst_deallocate_vcpi(), as we already have msto->disabled to let
us avoid cleaning up an msto more then once. The DP MST core will never
call drm_dp_mst_deallocate_vcpi() on it's own, which is presumably what
these checks are meant to protect against.

More importantly though, we're about to stop clearing mstc->port in the
next commit, which means if we could potentially hit a use-after-free
error if we tried to check mstc->port->vcpi here. So to make life easier
for anyone who bisects this code in the future, use msto->disabled
instead to check whether or not we need to deallocate VCPI instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 641252208e67..0f7d72518604 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -704,14 +704,17 @@ nv50_msto_cleanup(struct nv50_msto *msto)
 	struct nv50_mstc *mstc = msto->mstc;
 	struct nv50_mstm *mstm = mstc->mstm;
 
+	if (!msto->disabled)
+		return;
+
 	NV_ATOMIC(drm, "%s: msto cleanup\n", msto->encoder.name);
-	if (mstc->port && mstc->port->vcpi.vcpi > 0 && !nv50_msto_payload(msto))
+
+	if (mstc->port)
 		drm_dp_mst_deallocate_vcpi(&mstm->mgr, mstc->port);
-	if (msto->disabled) {
-		msto->mstc = NULL;
-		msto->head = NULL;
-		msto->disabled = false;
-	}
+
+	msto->mstc = NULL;
+	msto->head = NULL;
+	msto->disabled = false;
 }
 
 static void
-- 
2.19.2

