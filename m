Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F8D20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F8D20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeH3WkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:08 -0400
Received: from smtprelay0162.hostedemail.com ([216.40.44.162]:55570 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbeH3WkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 43B35181D32DE;
        Thu, 30 Aug 2018 18:36:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen04_1c37290c65728
X-Filterd-Recvd-Size: 13820
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Aug 2018 18:36:33 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/nouveau: Convert NV_PRINTK macros and uses to new nv_cli_<level> macros
Date:   Thu, 30 Aug 2018 11:36:27 -0700
Message-Id: <d5888335fbc1639bd45271d33ad30207fec3c07c.1535654026.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1535654026.git.joe@perches.com>
References: <cover.1535654026.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a more common logging style and reduce object size by calling
the nouveau_cli_printk function.

(size -t drivers/gpu/drm/nouveau/built-in.a x86/64 defconfig with nouveau)
   text    data     bss     dec     hex filename
1736437	 108484	   1048	1845969	 1c2ad1	(TOTALS) (new)
1737254  108484    1048 1846786  1c2e02 (TOTALS) (old)

Miscellanea:

o Add nv_cli_<level> macros that use nouveau_cli_printk
o Convert the NV_PRINTK uses to the new nv_cli_<level> macros
o Realign arguments of the conversions

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c  | 12 +++----
 drivers/gpu/drm/nouveau/nouveau_drv.h   | 12 ++++---
 drivers/gpu/drm/nouveau/nouveau_gem.c   | 62 ++++++++++++++++-----------------
 4 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index e67a471331b5..8196c5417dde 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -236,7 +236,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = nvkm_gr_units(gr);
 		break;
 	default:
-		NV_PRINTK(dbg, cli, "unknown parameter %lld\n", getparam->param);
+		nv_cli_dbg(cli, "unknown parameter %lld\n", getparam->param);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nouveau/nouveau_chan.c
index 92d3115f96b5..0c9c6172ea29 100644
--- a/drivers/gpu/drm/nouveau/nouveau_chan.c
+++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
@@ -51,7 +51,7 @@ nouveau_channel_killed(struct nvif_notify *ntfy)
 {
 	struct nouveau_channel *chan = container_of(ntfy, typeof(*chan), kill);
 	struct nouveau_cli *cli = (void *)chan->user.client;
-	NV_PRINTK(warn, cli, "channel %d killed!\n", chan->chid);
+	nv_cli_warn(cli, "channel %d killed!\n", chan->chid);
 	atomic_set(&chan->killed, 1);
 	return NVIF_NOTIFY_DROP;
 }
@@ -71,8 +71,8 @@ nouveau_channel_idle(struct nouveau_channel *chan)
 		}
 
 		if (ret) {
-			NV_PRINTK(err, cli, "failed to idle channel %d [%s]\n",
-				  chan->chid, nvxx_client(&cli->base)->name);
+			nv_cli_err(cli, "failed to idle channel %d [%s]\n",
+				   chan->chid, nvxx_client(&cli->base)->name);
 			return ret;
 		}
 	}
@@ -460,17 +460,17 @@ nouveau_channel_new(struct nouveau_drm *drm, struct nvif_device *device,
 
 	ret = nouveau_channel_ind(drm, device, arg0, pchan);
 	if (ret) {
-		NV_PRINTK(dbg, cli, "ib channel create, %d\n", ret);
+		nv_cli_dbg(cli, "ib channel create, %d\n", ret);
 		ret = nouveau_channel_dma(drm, device, pchan);
 		if (ret) {
-			NV_PRINTK(dbg, cli, "dma channel create, %d\n", ret);
+			nv_cli_dbg(cli, "dma channel create, %d\n", ret);
 			goto done;
 		}
 	}
 
 	ret = nouveau_channel_init(*pchan, arg0, arg1);
 	if (ret) {
-		NV_PRINTK(err, cli, "channel failed to initialise, %d\n", ret);
+		nv_cli_err(cli, "channel failed to initialise, %d\n", ret);
 		nouveau_channel_del(pchan);
 	}
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index 6110730d5df0..a45bd44ac782 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -240,14 +240,16 @@ nouveau_platform_device_create(const struct nvkm_device_tegra_func *,
 			       struct platform_device *, struct nvkm_device **);
 void nouveau_drm_device_remove(struct drm_device *dev);
 
-#define NV_PRINTK(l,c,f,a...) do {                                             \
-	struct nouveau_cli *_cli = (c);                                        \
-	dev_##l(_cli->drm->dev->dev, "%s: "f, _cli->name, ##a);                \
-} while(0)
-
 __printf(2, 3)
 void nouveau_cli_printk(struct nouveau_cli *cli, const char *fmt, ...);
 
+#define nv_cli_err(cli, fmt, ...)					\
+	nouveau_cli_printk(cli, KERN_ERR fmt, ##__VA_ARGS__)
+#define nv_cli_warn(cli, fmt, ...)					\
+	nouveau_cli_printk(cli, KERN_WARNING fmt, ##__VA_ARGS__)
+#define nv_cli_dbg(cli, fmt, ...)					\
+	dev_dbg((cli)->drm->dev->dev, "%s: " fmt, (cli)->name, ##__VA_ARGS__)
+
 #define NV_FATAL(drm, fmt, ...)						\
 	nouveau_cli_printk(&(drm)->client, KERN_CRIT fmt, ##__VA_ARGS__)
 #define NV_ERROR(drm, fmt, ...)						\
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index b56524d343c3..b69232f60b41 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -382,7 +382,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 	ww_acquire_init(&op->ticket, &reservation_ww_class);
 retry:
 	if (++trycnt > 100000) {
-		NV_PRINTK(err, cli, "%s failed and gave up.\n", __func__);
+		nv_cli_err(cli, "%s failed and gave up\n", __func__);
 		return -EINVAL;
 	}
 
@@ -393,7 +393,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 
 		gem = drm_gem_object_lookup(file_priv, b->handle);
 		if (!gem) {
-			NV_PRINTK(err, cli, "Unknown handle 0x%08x\n", b->handle);
+			nv_cli_err(cli, "Unknown handle 0x%08x\n", b->handle);
 			ret = -ENOENT;
 			break;
 		}
@@ -405,8 +405,8 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 		}
 
 		if (nvbo->reserved_by && nvbo->reserved_by == file_priv) {
-			NV_PRINTK(err, cli, "multiple instances of buffer %d on "
-				      "validation list\n", b->handle);
+			nv_cli_err(cli, "multiple instances of buffer %d on validation list\n",
+				   b->handle);
 			drm_gem_object_put_unlocked(gem);
 			ret = -EINVAL;
 			break;
@@ -426,7 +426,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			}
 			if (unlikely(ret)) {
 				if (ret != -ERESTARTSYS)
-					NV_PRINTK(err, cli, "fail reserve\n");
+					nv_cli_err(cli, "fail reserve\n");
 				break;
 			}
 		}
@@ -435,7 +435,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			struct nouveau_vmm *vmm = &cli->vmm;
 			struct nouveau_vma *vma = nouveau_vma_find(nvbo, vmm);
 			if (!vma) {
-				NV_PRINTK(err, cli, "vma not found!\n");
+				nv_cli_err(cli, "vma not found!\n");
 				ret = -EINVAL;
 				break;
 			}
@@ -457,8 +457,8 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 		if (b->valid_domains & NOUVEAU_GEM_DOMAIN_GART)
 			list_add_tail(&nvbo->entry, &gart_list);
 		else {
-			NV_PRINTK(err, cli, "invalid valid domains: 0x%08x\n",
-				 b->valid_domains);
+			nv_cli_err(cli, "invalid valid domains: 0x%08x\n",
+				   b->valid_domains);
 			list_add_tail(&nvbo->entry, &both_list);
 			ret = -EINVAL;
 			break;
@@ -495,21 +495,21 @@ validate_list(struct nouveau_channel *chan, struct nouveau_cli *cli,
 					     b->write_domains,
 					     b->valid_domains);
 		if (unlikely(ret)) {
-			NV_PRINTK(err, cli, "fail set_domain\n");
+			nv_cli_err(cli, "fail set_domain\n");
 			return ret;
 		}
 
 		ret = nouveau_bo_validate(nvbo, true, false);
 		if (unlikely(ret)) {
 			if (ret != -ERESTARTSYS)
-				NV_PRINTK(err, cli, "fail ttm_validate\n");
+				nv_cli_err(cli, "fail ttm_validate\n");
 			return ret;
 		}
 
 		ret = nouveau_fence_sync(nvbo, chan, !!b->write_domains, true);
 		if (unlikely(ret)) {
 			if (ret != -ERESTARTSYS)
-				NV_PRINTK(err, cli, "fail post-validate sync\n");
+				nv_cli_err(cli, "fail post-validate sync\n");
 			return ret;
 		}
 
@@ -556,14 +556,14 @@ nouveau_gem_pushbuf_validate(struct nouveau_channel *chan,
 	ret = validate_init(chan, file_priv, pbbo, nr_buffers, op);
 	if (unlikely(ret)) {
 		if (ret != -ERESTARTSYS)
-			NV_PRINTK(err, cli, "validate_init\n");
+			nv_cli_err(cli, "validate_init\n");
 		return ret;
 	}
 
 	ret = validate_list(chan, cli, &op->list, pbbo, user_buffers);
 	if (unlikely(ret < 0)) {
 		if (ret != -ERESTARTSYS)
-			NV_PRINTK(err, cli, "validating bo list\n");
+			nv_cli_err(cli, "validating bo list\n");
 		validate_fini(op, NULL, NULL);
 		return ret;
 	}
@@ -617,7 +617,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 		uint32_t data;
 
 		if (unlikely(r->bo_index >= req->nr_buffers)) {
-			NV_PRINTK(err, cli, "reloc bo index invalid\n");
+			nv_cli_err(cli, "reloc bo index invalid\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -627,7 +627,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 			continue;
 
 		if (unlikely(r->reloc_bo_index >= req->nr_buffers)) {
-			NV_PRINTK(err, cli, "reloc container bo index invalid\n");
+			nv_cli_err(cli, "reloc container bo index invalid\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -635,7 +635,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 
 		if (unlikely(r->reloc_bo_offset + 4 >
 			     nvbo->bo.mem.num_pages << PAGE_SHIFT)) {
-			NV_PRINTK(err, cli, "reloc outside of bo\n");
+			nv_cli_err(cli, "reloc outside of bo\n");
 			ret = -EINVAL;
 			break;
 		}
@@ -644,7 +644,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 			ret = ttm_bo_kmap(&nvbo->bo, 0, nvbo->bo.mem.num_pages,
 					  &nvbo->kmap);
 			if (ret) {
-				NV_PRINTK(err, cli, "failed kmap for reloc\n");
+				nv_cli_err(cli, "failed kmap for reloc\n");
 				break;
 			}
 			nvbo->validate_mapped = true;
@@ -667,7 +667,7 @@ nouveau_gem_pushbuf_reloc_apply(struct nouveau_cli *cli,
 
 		ret = ttm_bo_wait(&nvbo->bo, false, false);
 		if (ret) {
-			NV_PRINTK(err, cli, "reloc wait_idle failed: %d\n", ret);
+			nv_cli_err(cli, "reloc wait_idle failed: %d\n", ret);
 			break;
 		}
 
@@ -713,20 +713,20 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 		goto out_next;
 
 	if (unlikely(req->nr_push > NOUVEAU_GEM_MAX_PUSH)) {
-		NV_PRINTK(err, cli, "pushbuf push count exceeds limit: %d max %d\n",
-			 req->nr_push, NOUVEAU_GEM_MAX_PUSH);
+		nv_cli_err(cli, "pushbuf push count exceeds limit: %d max %d\n",
+			   req->nr_push, NOUVEAU_GEM_MAX_PUSH);
 		return nouveau_abi16_put(abi16, -EINVAL);
 	}
 
 	if (unlikely(req->nr_buffers > NOUVEAU_GEM_MAX_BUFFERS)) {
-		NV_PRINTK(err, cli, "pushbuf bo count exceeds limit: %d max %d\n",
-			 req->nr_buffers, NOUVEAU_GEM_MAX_BUFFERS);
+		nv_cli_err(cli, "pushbuf bo count exceeds limit: %d max %d\n",
+			   req->nr_buffers, NOUVEAU_GEM_MAX_BUFFERS);
 		return nouveau_abi16_put(abi16, -EINVAL);
 	}
 
 	if (unlikely(req->nr_relocs > NOUVEAU_GEM_MAX_RELOCS)) {
-		NV_PRINTK(err, cli, "pushbuf reloc count exceeds limit: %d max %d\n",
-			 req->nr_relocs, NOUVEAU_GEM_MAX_RELOCS);
+		nv_cli_err(cli, "pushbuf reloc count exceeds limit: %d max %d\n",
+			   req->nr_relocs, NOUVEAU_GEM_MAX_RELOCS);
 		return nouveau_abi16_put(abi16, -EINVAL);
 	}
 
@@ -743,7 +743,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 	/* Ensure all push buffers are on validate list */
 	for (i = 0; i < req->nr_push; i++) {
 		if (push[i].bo_index >= req->nr_buffers) {
-			NV_PRINTK(err, cli, "push %d buffer not in list\n", i);
+			nv_cli_err(cli, "push %d buffer not in list\n", i);
 			ret = -EINVAL;
 			goto out_prevalid;
 		}
@@ -754,7 +754,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 					   req->nr_buffers, &op, &do_reloc);
 	if (ret) {
 		if (ret != -ERESTARTSYS)
-			NV_PRINTK(err, cli, "validate: %d\n", ret);
+			nv_cli_err(cli, "validate: %d\n", ret);
 		goto out_prevalid;
 	}
 
@@ -762,7 +762,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 	if (do_reloc) {
 		ret = nouveau_gem_pushbuf_reloc_apply(cli, req, bo);
 		if (ret) {
-			NV_PRINTK(err, cli, "reloc apply: %d\n", ret);
+			nv_cli_err(cli, "reloc apply: %d\n", ret);
 			goto out;
 		}
 	}
@@ -770,7 +770,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 	if (chan->dma.ib_max) {
 		ret = nouveau_dma_wait(chan, req->nr_push + 1, 16);
 		if (ret) {
-			NV_PRINTK(err, cli, "nv50cal_space: %d\n", ret);
+			nv_cli_err(cli, "nv50cal_space: %d\n", ret);
 			goto out;
 		}
 
@@ -785,7 +785,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 	if (drm->client.device.info.chipset >= 0x25) {
 		ret = RING_SPACE(chan, req->nr_push * 2);
 		if (ret) {
-			NV_PRINTK(err, cli, "cal_space: %d\n", ret);
+			nv_cli_err(cli, "cal_space: %d\n", ret);
 			goto out;
 		}
 
@@ -799,7 +799,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 	} else {
 		ret = RING_SPACE(chan, req->nr_push * (2 + NOUVEAU_DMA_SKIPS));
 		if (ret) {
-			NV_PRINTK(err, cli, "jmp_space: %d\n", ret);
+			nv_cli_err(cli, "jmp_space: %d\n", ret);
 			goto out;
 		}
 
@@ -837,7 +837,7 @@ nouveau_gem_ioctl_pushbuf(struct drm_device *dev, void *data,
 
 	ret = nouveau_fence_new(chan, false, &fence);
 	if (ret) {
-		NV_PRINTK(err, cli, "error fencing pushbuf: %d\n", ret);
+		nv_cli_err(cli, "error fencing pushbuf: %d\n", ret);
 		WIND_RING(chan);
 		goto out;
 	}
-- 
2.15.0

