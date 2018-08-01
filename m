Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC8C46463
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A4C20841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91A4C20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733108AbeHAUOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:14:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404033AbeHATDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9E7251067;
        Wed,  1 Aug 2018 17:01:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 156/336] drm/nouveau/gem: lookup VMAs for buffers referenced by pushbuf ioctl
Date:   Wed,  1 Aug 2018 18:48:11 +0200
Message-Id: <20180801165035.095315584@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 19ca10d82e33bcfe92412c461fc3534ec1e14747 ]

We previously only did this for push buffers, but an upcoming patch will
need to attach fences to all VMAs to resolve another issue.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_dma.c |   10 +---------
 drivers/gpu/drm/nouveau/nouveau_dma.h |    5 ++---
 drivers/gpu/drm/nouveau/nouveau_gem.c |   19 ++++++++++++++++---
 3 files changed, 19 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_dma.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dma.c
@@ -80,18 +80,10 @@ READ_GET(struct nouveau_channel *chan, u
 }
 
 void
-nv50_dma_push(struct nouveau_channel *chan, struct nouveau_bo *bo,
-	      int delta, int length)
+nv50_dma_push(struct nouveau_channel *chan, u64 offset, int length)
 {
-	struct nouveau_cli *cli = (void *)chan->user.client;
 	struct nouveau_bo *pb = chan->push.buffer;
-	struct nouveau_vma *vma;
 	int ip = (chan->dma.ib_put * 2) + chan->dma.ib_base;
-	u64 offset;
-
-	vma = nouveau_vma_find(bo, &cli->vmm);
-	BUG_ON(!vma);
-	offset = vma->addr + delta;
 
 	BUG_ON(chan->dma.ib_free < 1);
 
--- a/drivers/gpu/drm/nouveau/nouveau_dma.h
+++ b/drivers/gpu/drm/nouveau/nouveau_dma.h
@@ -31,8 +31,7 @@
 #include "nouveau_chan.h"
 
 int nouveau_dma_wait(struct nouveau_channel *, int slots, int size);
-void nv50_dma_push(struct nouveau_channel *, struct nouveau_bo *,
-		   int delta, int length);
+void nv50_dma_push(struct nouveau_channel *, u64 addr, int length);
 
 /*
  * There's a hw race condition where you can't jump to your PUT offset,
@@ -151,7 +150,7 @@ FIRE_RING(struct nouveau_channel *chan)
 	chan->accel_done = true;
 
 	if (chan->dma.ib_max) {
-		nv50_dma_push(chan, chan->push.buffer, chan->dma.put << 2,
+		nv50_dma_push(chan, chan->push.addr + (chan->dma.put << 2),
 			      (chan->dma.cur - chan->dma.put) << 2);
 	} else {
 		WRITE_PUT(chan->dma.cur);
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -432,7 +432,20 @@ retry:
 			}
 		}
 
-		b->user_priv = (uint64_t)(unsigned long)nvbo;
+		if (cli->vmm.vmm.object.oclass >= NVIF_CLASS_VMM_NV50) {
+			struct nouveau_vmm *vmm = &cli->vmm;
+			struct nouveau_vma *vma = nouveau_vma_find(nvbo, vmm);
+			if (!vma) {
+				NV_PRINTK(err, cli, "vma not found!\n");
+				ret = -EINVAL;
+				break;
+			}
+
+			b->user_priv = (uint64_t)(unsigned long)vma;
+		} else {
+			b->user_priv = (uint64_t)(unsigned long)nvbo;
+		}
+
 		nvbo->reserved_by = file_priv;
 		nvbo->pbbo_index = i;
 		if ((b->valid_domains & NOUVEAU_GEM_DOMAIN_VRAM) &&
@@ -763,10 +776,10 @@ nouveau_gem_ioctl_pushbuf(struct drm_dev
 		}
 
 		for (i = 0; i < req->nr_push; i++) {
-			struct nouveau_bo *nvbo = (void *)(unsigned long)
+			struct nouveau_vma *vma = (void *)(unsigned long)
 				bo[push[i].bo_index].user_priv;
 
-			nv50_dma_push(chan, nvbo, push[i].offset,
+			nv50_dma_push(chan, vma->addr + push[i].offset,
 				      push[i].length);
 		}
 	} else


