Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4538C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9621D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9621D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeLNB1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:27:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbeLNB1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:27:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CEE8C03BC9B;
        Fri, 14 Dec 2018 01:27:07 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B91A8600C5;
        Fri, 14 Dec 2018 01:27:05 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <karolherbst@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [WIP PATCH 11/15] drm/nouveau: Grab payload lock in nv50_msto_payload()
Date:   Thu, 13 Dec 2018 20:25:40 -0500
Message-Id: <20181214012604.13746-12-lyude@redhat.com>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 14 Dec 2018 01:27:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Going through the currently programmed payloads isn't safe without
holding mgr->payload_lock, so actually do that and warn if anyone tries
calling nv50_msto_payload() in the future without grabbing the right
locks.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 157d208d37b5..67f7bf97e5d9 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -680,6 +680,8 @@ nv50_msto_payload(struct nv50_msto *msto)
 	struct nv50_mstm *mstm = mstc->mstm;
 	int vcpi = mstc->port->vcpi.vcpi, i;
 
+	WARN_ON(!mutex_is_locked(&mstm->mgr.payload_lock));
+
 	NV_ATOMIC(drm, "%s: vcpi %d\n", msto->encoder.name, vcpi);
 	for (i = 0; i < mstm->mgr.max_payloads; i++) {
 		struct drm_dp_payload *payload = &mstm->mgr.payloads[i];
@@ -733,6 +735,8 @@ nv50_msto_prepare(struct nv50_msto *msto)
 			       (0x0100 << msto->head->base.index),
 	};
 
+	mutex_lock(&mstm->mgr.payload_lock);
+
 	NV_ATOMIC(drm, "%s: msto prepare\n", msto->encoder.name);
 	if (mstc->port->vcpi.vcpi > 0) {
 		struct drm_dp_payload *payload = nv50_msto_payload(msto);
@@ -748,7 +752,9 @@ nv50_msto_prepare(struct nv50_msto *msto)
 		  msto->encoder.name, msto->head->base.base.name,
 		  args.vcpi.start_slot, args.vcpi.num_slots,
 		  args.vcpi.pbn, args.vcpi.aligned_pbn);
+
 	nvif_mthd(&drm->display->disp.object, 0, &args, sizeof(args));
+	mutex_unlock(&mstm->mgr.payload_lock);
 }
 
 static int
-- 
2.19.2

