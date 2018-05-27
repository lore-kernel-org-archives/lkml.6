Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeE0VyS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:54:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42204 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbeE0VyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:54:15 -0400
From: Colin King <colin.king@canonical.com>
To: Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/nouveau/disp: avoid potential overflow on shift of int value
Date: Sun, 27 May 2018 22:54:11 +0100
Message-Id: <20180527215411.24701-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The constant values being shifted are 32 bit integers and may potentially
overflow on the shift.  Avoid this potential overflow by making them
unsigned long long values before the shift.

Detected by CoverityScan, CID#1469383, 1469400 ("Unintentional
integer overflow")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
index 29e6dd58ac48..99b94802ed63 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/changf119.c
@@ -52,7 +52,7 @@ void
 gf119_disp_chan_intr(struct nv50_disp_chan *chan, bool en)
 {
 	struct nvkm_device *device = chan->disp->base.engine.subdev.device;
-	const u64 mask = 0x00000001 << chan->chid.user;
+	const u64 mask = 0x00000001ULL << chan->chid.user;
 	if (!en) {
 		nvkm_mask(device, 0x610090, mask, 0x00000000);
 		nvkm_mask(device, 0x6100a0, mask, 0x00000000);
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
index 57719f675eec..43ae3b092e43 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/channv50.c
@@ -166,7 +166,7 @@ void
 nv50_disp_chan_intr(struct nv50_disp_chan *chan, bool en)
 {
 	struct nvkm_device *device = chan->disp->base.engine.subdev.device;
-	const u64 mask = 0x00010001 << chan->chid.user;
+	const u64 mask = 0x00010001ULL << chan->chid.user;
 	const u64 data = en ? 0x00010000 : 0x00000000;
 	nvkm_mask(device, 0x610028, mask, data);
 }
-- 
2.17.0
