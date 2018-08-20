Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC98C04AB9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F272174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 17:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F272174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbeHTUpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 16:45:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbeHTUpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 16:45:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D33F14021635;
        Mon, 20 Aug 2018 17:20:40 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-120-60.rdu2.redhat.com [10.10.120.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65F812157F49;
        Mon, 20 Aug 2018 17:20:40 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <karolherbst@gmail.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Fix GM107 disp dmac chan init on ThinkPad P50
Date:   Mon, 20 Aug 2018 13:20:27 -0400
Message-Id: <20180820172030.10963-3-lyude@redhat.com>
In-Reply-To: <20180820172030.10963-1-lyude@redhat.com>
References: <20180820172030.10963-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 20 Aug 2018 17:20:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 20 Aug 2018 17:20:40 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like how the P50 will occasionally leave the disp's core channel on
before nouveau starts initializing, it will occasionally do the same
thing with the rest of the dmac channel in addition to the core channel.
Example:

[    1.604375] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: no heads (0 3 4)
[    1.604858] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power -> always
[    1.605354] nouveau 0000:01:00.0: disp: outp 04:0006:0f81: aux power -> demand
[    1.605815] nouveau 0000:01:00.0: disp: outp 05:0002:0f81: no heads (0 3 2)
[    1.607289] nouveau 0000:01:00.0: disp: chid 0 mthd 0000 data 00000400 00001000 00000002
[    1.608818] nouveau 0000:01:00.0: disp: chid 1 mthd 0000 data 00000400 00001000 00000002
[    1.609500] nouveau 0000:01:00.0: disp: chid 2 mthd 0000 data 00000400 00001000 00000002

Which of course, later causes other parts of the card to start timing
out and failing. Closer inspection shows the same thing happening as
with our core channel; 0x610490 + (ctrl * 0x10) always has the same
unknown 0x000a0000 mask set when the phantom mthd failures start
appearing.

So, implement the same workaround we use for the core disp channel to
the rest of the disp channels.

This along with the previous patch fix random initialization failures
observed with the Thinkpad P50.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: stable@vger.kernel.org
---
 .../drm/nouveau/nvkm/engine/disp/dmacgf119.c  | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
index edf7dd0d931d..7bc91f260e27 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/dmacgf119.c
@@ -35,8 +35,8 @@ gf119_disp_dmac_bind(struct nv50_disp_chan *chan,
 				 chan->chid.user << 27 | 0x00000001);
 }
 
-void
-gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
+static bool
+gf119_disp_dmac_deactivate(struct nv50_disp_chan *chan)
 {
 	struct nvkm_subdev *subdev = &chan->disp->base.engine.subdev;
 	struct nvkm_device *device = subdev->device;
@@ -52,7 +52,16 @@ gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
 	) < 0) {
 		nvkm_error(subdev, "ch %d fini: %08x\n", user,
 			   nvkm_rd32(device, 0x610490 + (ctrl * 0x10)));
+		return false;
 	}
+
+	return true;
+}
+
+void
+gf119_disp_dmac_fini(struct nv50_disp_chan *chan)
+{
+	gf119_disp_dmac_deactivate(chan);
 }
 
 static int
@@ -63,6 +72,12 @@ gf119_disp_dmac_init(struct nv50_disp_chan *chan)
 	int ctrl = chan->chid.ctrl;
 	int user = chan->chid.user;
 
+	/* shut down the channel if it was left on, probably by the VBIOS */
+	if ((nvkm_rd32(device, 0x610490 + (ctrl * 0x10)) & 0x000a0000) == 0x000a0000 &&
+	    WARN_ON(!gf119_disp_dmac_deactivate(chan))) {
+		return -EBUSY;
+	}
+
 	/* initialise channel for dma command submission */
 	nvkm_wr32(device, 0x610494 + (ctrl * 0x0010), chan->push);
 	nvkm_wr32(device, 0x610498 + (ctrl * 0x0010), 0x00010000);
-- 
2.17.1

