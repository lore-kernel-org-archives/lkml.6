Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76375C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC69920867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 08:44:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC69920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIDNIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:08:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:20193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727159AbeIDNIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:08:22 -0400
X-UUID: e1c54adad551484e917718c15536df87-20180904
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <shun-chih.yu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 788601963; Tue, 04 Sep 2018 16:44:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 4 Sep 2018 16:43:57 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 4 Sep 2018 16:43:57 +0800
From:   <shun-chih.yu@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srv_wsdupstream@mediatek.com>,
        Shun-Chih Yu <shun-chih.yu@mediatek.com>
Subject: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA controller for MT6765 SoC
Date:   Tue, 4 Sep 2018 16:43:46 +0800
Message-ID: <1536050626-21927-3-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1536050626-21927-1-git-send-email-shun-chih.yu@mediatek.com>
References: <1536050626-21927-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shun-Chih Yu <shun-chih.yu@mediatek.com>

MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
to memory-to-memory transfer through queue based descriptor management.

There are only 3 physical channels inside CQDMA, while the driver is
extended to support 32 virtual channels for multiple dma users to issue
dma requests onto the CQDMA simultaneously.

Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
---
 drivers/dma/mediatek/Kconfig     |   12 +
 drivers/dma/mediatek/Makefile    |    1 +
 drivers/dma/mediatek/mtk-cqdma.c |  952 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 965 insertions(+)
 create mode 100644 drivers/dma/mediatek/mtk-cqdma.c

diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
index 27bac0b..4a1582d 100644
--- a/drivers/dma/mediatek/Kconfig
+++ b/drivers/dma/mediatek/Kconfig
@@ -11,3 +11,15 @@ config MTK_HSDMA
 	  This controller provides the channels which is dedicated to
 	  memory-to-memory transfer to offload from CPU through ring-
 	  based descriptor management.
+
+config MTK_CQDMA
+	tristate "MediaTek Command-Queue DMA controller support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for Command-Queue DMA controller on MediaTek
+	  SoCs.
+
+	  This controller provides the channels which is dedicated to
+	  memory-to-memory transfer to offload from CPU.
diff --git a/drivers/dma/mediatek/Makefile b/drivers/dma/mediatek/Makefile
index 6e778f8..41bb381 100644
--- a/drivers/dma/mediatek/Makefile
+++ b/drivers/dma/mediatek/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MTK_HSDMA) += mtk-hsdma.o
+obj-$(CONFIG_MTK_CQDMA) += mtk-cqdma.o
diff --git a/drivers/dma/mediatek/mtk-cqdma.c b/drivers/dma/mediatek/mtk-cqdma.c
new file mode 100644
index 0000000..c74aaa3
--- /dev/null
+++ b/drivers/dma/mediatek/mtk-cqdma.c
@@ -0,0 +1,952 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018-2019 MediaTek Inc.
+
+/*
+ * Driver for MediaTek Command-Queue DMA Controller
+ *
+ * Author: Shun-Chih Yu <shun-chih.yu@mediatek.com>
+ *
+ */
+
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/refcount.h>
+#include <linux/slab.h>
+
+#include "../virt-dma.h"
+
+#define MTK_CQDMA_USEC_POLL		10
+#define MTK_CQDMA_TIMEOUT_POLL		1000
+#define MTK_CQDMA_DMA_BUSWIDTHS		BIT(DMA_SLAVE_BUSWIDTH_4_BYTES)
+#define MTK_CQDMA_ALIGN_SIZE		1
+
+/* The default number of virtual channel */
+#define MTK_CQDMA_NR_VCHANS		3
+
+/* The default number of physical channel */
+#define MTK_CQDMA_NR_PCHANS		3
+
+/* Registers for underlying dma manipulation */
+#define MTK_CQDMA_INT_FLAG		0x0
+#define MTK_CQDMA_INT_EN		0x4
+#define MTK_CQDMA_EN			0x8
+#define MTK_CQDMA_RESET			0xc
+#define MTK_CQDMA_STOP			0x10
+#define MTK_CQDMA_FLUSH			0x14
+#define MTK_CQDMA_SRC			0x1c
+#define MTK_CQDMA_DST			0x20
+#define MTK_CQDMA_LEN1			0x24
+#define MTK_CQDMA_LEN2			0x28
+#define MTK_CQDMA_SRC2			0x60
+#define MTK_CQDMA_DST2			0x64
+
+/* Registers setting */
+#define MTK_CQDMA_EN_BIT		BIT(0)
+#define MTK_CQDMA_INT_FLAG_BIT		BIT(0)
+#define MTK_CQDMA_INT_EN_BIT		BIT(0)
+#define MTK_CQDMA_FLUSH_BIT		BIT(0)
+
+#define MTK_CQDMA_WARM_RST_BIT		BIT(0)
+#define MTK_CQDMA_HARD_RST_BIT		BIT(1)
+
+#define MTK_CQDMA_MAX_LEN		(0xfffffff)
+#define MTK_CQDMA_ADDR_LIMIT		(0xffffffff)
+#define MTK_CQDMA_ADDR2_SHFIT		(32)
+
+/**
+ * struct mtk_cqdma_vdesc - The struct holding info describing physical
+ *                         descriptor (PD)
+ * @len:                   The total data size device wants to move
+ * @src:                   The source address device wants to move from
+ * @dest:                  The destination address device wants to move to
+ */
+struct mtk_cqdma_pdesc {
+	size_t len;
+	dma_addr_t src;
+	dma_addr_t dest;
+};
+
+/**
+ * struct mtk_cqdma_vdesc - The struct holding info describing virtual
+ *                         descriptor (VD)
+ * @vd:                    An instance for struct virt_dma_desc
+ * @len:                   The total data size device wants to move
+ * @residue:               The remaining data size device will move
+ * @dest:                  The destination address device wants to move to
+ * @src:                   The source address device wants to move from
+ * @ch:                    The pointer to the corresponding dma channel
+ * @pd_list		   The array for PDs
+ * @pd_list_len		   The size of PD list
+ * @pd_list_ptr            The index of the PD being processed
+ * @node                   The lise_head struct to build link-list for VDs
+ */
+struct mtk_cqdma_vdesc {
+	struct virt_dma_desc vd;
+	size_t len;
+	size_t residue;
+	dma_addr_t dest;
+	dma_addr_t src;
+	struct dma_chan *ch;
+
+	size_t pd_list_len;
+	size_t pd_list_ptr;
+	struct mtk_cqdma_pdesc **pd_list;
+
+	struct list_head node;
+};
+
+/**
+ * struct mtk_cqdma_pchan - The struct holding info describing physical
+ *                         channel (PC)
+ * @queue:                 Queue for the PDs issued to this PC
+ * @base:                  The mapped register I/O base of this PC
+ * @irq:                   The IRQ that this PC are using
+ * @refcnt:                Track how many VCs are using this PC
+ * @lock:                  Lock protect agaisting multiple VCs access PC
+ */
+struct mtk_cqdma_pchan {
+	struct list_head queue;
+	void __iomem *base;
+	u32 irq;
+
+	refcount_t refcnt;
+
+	/* lock to protect PC */
+	spinlock_t lock;
+};
+
+/**
+ * struct mtk_cqdma_vchan - The struct holding info describing virtual
+ *                         channel (VC)
+ * @vc:                    An instance for struct virt_dma_chan
+ * @pc:                    The pointer to the underlying PC
+ * @issue_completion:	   The wait for all issued descriptors completited
+ * @issue_synchronize:	   Bool indicating channel synchronization starts
+ */
+struct mtk_cqdma_vchan {
+	struct virt_dma_chan vc;
+	struct mtk_cqdma_pchan *pc;
+	struct completion issue_completion;
+	bool issue_synchronize;
+};
+
+/**
+ * struct mtk_cqdma_device - The struct holding info describing CQDMA
+ *                          device
+ * @ddev:                   An instance for struct dma_device
+ * @clk:                    The clock that device internal is using
+ * @dma_requests:           The number of VCs the device supports to
+ * @dma_channels:           The number of PCs the device supports to
+ * @vc:                     The pointer to all available VCs
+ * @pc:                     The pointer to all the underlying PCs
+ */
+struct mtk_cqdma_device {
+	struct dma_device ddev;
+	struct clk *clk;
+
+	u32 dma_requests;
+	u32 dma_channels;
+	struct mtk_cqdma_vchan *vc;
+	struct mtk_cqdma_pchan **pc;
+};
+
+static struct mtk_cqdma_device *to_cqdma_dev(struct dma_chan *chan)
+{
+	return container_of(chan->device, struct mtk_cqdma_device, ddev);
+}
+
+static struct mtk_cqdma_vchan *to_cqdma_vchan(struct dma_chan *chan)
+{
+	return container_of(chan, struct mtk_cqdma_vchan, vc.chan);
+}
+
+static struct mtk_cqdma_vdesc *to_cqdma_vdesc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct mtk_cqdma_vdesc, vd);
+}
+
+static struct device *cqdma2dev(struct mtk_cqdma_device *cqdma)
+{
+	return cqdma->ddev.dev;
+}
+
+static u32 mtk_dma_read(struct mtk_cqdma_pchan *pc, u32 reg)
+{
+	return readl(pc->base + reg);
+}
+
+static void mtk_dma_write(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
+{
+	writel_relaxed(val, pc->base + reg);
+}
+
+static void mtk_dma_rmw(struct mtk_cqdma_pchan *pc, u32 reg,
+			u32 mask, u32 set)
+{
+	u32 val;
+
+	val = mtk_dma_read(pc, reg);
+	val &= ~mask;
+	val |= set;
+	mtk_dma_write(pc, reg, val);
+}
+
+static void mtk_dma_set(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
+{
+	mtk_dma_rmw(pc, reg, 0, val);
+}
+
+static void mtk_dma_clr(struct mtk_cqdma_pchan *pc, u32 reg, u32 val)
+{
+	mtk_dma_rmw(pc, reg, val, 0);
+}
+
+static void mtk_cqdma_vdesc_free(struct virt_dma_desc *vd)
+{
+	struct mtk_cqdma_vdesc *cvd = to_cqdma_vdesc(vd);
+	size_t i;
+
+	/* free PD list */
+	for (i = 0; i < cvd->pd_list_len; ++i)
+		kfree(cvd->pd_list[i]);
+	kfree(cvd->pd_list);
+
+	/* free VD */
+	kfree(cvd);
+}
+
+static int mtk_cqdma_poll_engine_done(struct mtk_cqdma_pchan *pc)
+{
+	u32 status = 0;
+
+	return readl_poll_timeout(pc->base + MTK_CQDMA_EN, status,
+				  !(status & MTK_CQDMA_EN_BIT),
+				  MTK_CQDMA_USEC_POLL,
+				  MTK_CQDMA_TIMEOUT_POLL);
+}
+
+static int mtk_cqdma_warm_reset(struct mtk_cqdma_pchan *pc)
+{
+	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_WARM_RST_BIT);
+
+	return mtk_cqdma_poll_engine_done(pc);
+}
+
+static int mtk_cqdma_hard_reset(struct mtk_cqdma_pchan *pc)
+{
+	mtk_dma_set(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
+	mtk_dma_clr(pc, MTK_CQDMA_RESET, MTK_CQDMA_HARD_RST_BIT);
+
+	return mtk_cqdma_poll_engine_done(pc);
+}
+
+static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc)
+{
+	mtk_dma_set(pc, MTK_CQDMA_EN, MTK_CQDMA_EN_BIT);
+}
+
+static int mtk_cqdma_stop(struct mtk_cqdma_pchan *pc)
+{
+	int err;
+
+	mtk_dma_set(pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
+
+	err = mtk_cqdma_poll_engine_done(pc);
+
+	mtk_dma_clr(pc, MTK_CQDMA_FLUSH, MTK_CQDMA_FLUSH_BIT);
+	mtk_dma_clr(pc, MTK_CQDMA_INT_FLAG, MTK_CQDMA_INT_FLAG_BIT);
+
+	return err;
+}
+
+static void mtk_cqdma_set_tran(struct mtk_cqdma_pchan *pc, dma_addr_t src,
+			       dma_addr_t dest, size_t len)
+{
+	/* setup source */
+	mtk_dma_set(pc, MTK_CQDMA_SRC, src & MTK_CQDMA_ADDR_LIMIT);
+	mtk_dma_set(pc, MTK_CQDMA_SRC2, src >> MTK_CQDMA_ADDR2_SHFIT);
+
+	/* setup destination */
+	mtk_dma_set(pc, MTK_CQDMA_DST, dest & MTK_CQDMA_ADDR_LIMIT);
+	mtk_dma_set(pc, MTK_CQDMA_DST2, dest >> MTK_CQDMA_ADDR2_SHFIT);
+
+	/* setup length */
+	mtk_dma_set(pc, MTK_CQDMA_LEN1, len);
+}
+
+static void mtk_cqdma_alloc_pchan(struct mtk_cqdma_pchan *pc)
+{
+	/* hard reset the dma engine */
+	mtk_cqdma_hard_reset(pc);
+
+	/* enable interrupt for this PC */
+	mtk_dma_set(pc, MTK_CQDMA_INT_EN, MTK_CQDMA_INT_EN_BIT);
+}
+
+static void mtk_cqdma_free_pchan(struct mtk_cqdma_pchan *pc)
+{
+	/* stop the engine and wait for engine stop */
+	if (mtk_cqdma_stop(pc) < 0)
+		pr_warn("cqdma stop timeout\n");
+
+	/* disable interrupt for this PC */
+	mtk_dma_clr(pc, MTK_CQDMA_INT_EN, MTK_CQDMA_INT_EN_BIT);
+}
+
+static void mtk_cqdma_start_tran(struct mtk_cqdma_pchan *pc,
+				 struct mtk_cqdma_pdesc *cpd)
+{
+	/* reset the dma engine for the transaction */
+	if (mtk_cqdma_warm_reset(pc) < 0)
+		pr_warn("cqdma warm reset timeout\n");
+
+	/* setup dma engine for this PD */
+	mtk_cqdma_set_tran(pc, cpd->src, cpd->dest, cpd->len);
+
+	/* start dma engine */
+	mtk_cqdma_start(pc);
+}
+
+static int mtk_cqdma_issue_pending_vdesc(struct mtk_cqdma_device *cqdma,
+					 struct mtk_cqdma_pchan *pc,
+					 struct mtk_cqdma_vdesc *cvd)
+{
+	bool trigger_engine = false;
+
+	if (!cvd->pd_list)
+		return 0;
+
+	lockdep_assert_held(&pc->lock);
+
+	/* need to trigger dma engine if PC's queue is empty */
+	if (list_empty(&pc->queue))
+		trigger_engine = true;
+
+	/* add VD into PC's queue */
+	list_add_tail(&cvd->node, &pc->queue);
+
+	/* start transaction for this VD */
+	if (trigger_engine)
+		mtk_cqdma_start_tran(pc, cvd->pd_list[cvd->pd_list_ptr]);
+
+	return 0;
+}
+
+static void mtk_cqdma_issue_vchan_pending(struct mtk_cqdma_device *cqdma,
+					  struct mtk_cqdma_vchan *cvc)
+{
+	struct virt_dma_desc *vd, *vd2;
+	int err;
+
+	lockdep_assert_held(&cvc->vc.lock);
+
+	list_for_each_entry_safe(vd, vd2, &cvc->vc.desc_issued, node) {
+		struct mtk_cqdma_vdesc *cvd;
+
+		cvd = to_cqdma_vdesc(vd);
+
+		/* issue VD to PC's queue */
+		err = mtk_cqdma_issue_pending_vdesc(cqdma, cvc->pc, cvd);
+
+		if (err == -ENOSPC)
+			break;
+
+		/* remove VD from list desc_issued */
+		list_del(&vd->node);
+	}
+}
+
+/*
+ * return true if this VC is active,
+ * meaning that there are VDs under processing by the PC
+ */
+static bool mtk_cqdma_is_vchan_active(struct mtk_cqdma_vchan *cvc)
+{
+	struct mtk_cqdma_vdesc *cvd;
+
+	list_for_each_entry(cvd, &cvc->pc->queue, node)
+		if (cvc == to_cqdma_vchan(cvd->ch))
+			return true;
+
+	return false;
+}
+
+static void mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
+{
+	struct mtk_cqdma_vchan *cvc;
+	struct mtk_cqdma_vdesc *cvd;
+
+	/* consume a VD from queue */
+	cvd = list_first_entry_or_null(&pc->queue,
+				       struct mtk_cqdma_vdesc, node);
+	if (unlikely(!cvd))
+		return;
+
+	/* update residue of VD */
+	cvd->residue -= cvd->pd_list[cvd->pd_list_ptr]->len;
+
+	cvc = to_cqdma_vchan(cvd->ch);
+
+	if (cvd->pd_list_ptr == cvd->pd_list_len - 1) {
+		/* delete VD from queue if its PD list completed */
+		list_del(&cvd->node);
+
+		spin_lock(&cvc->vc.lock);
+
+		/* add VD into list desc_completed */
+		vchan_cookie_complete(&cvd->vd);
+
+		/* setup completion if this VC is under synchronization */
+		if (cvc->issue_synchronize && !mtk_cqdma_is_vchan_active(cvc)) {
+			complete(&cvc->issue_completion);
+			cvc->issue_synchronize = false;
+		}
+
+		spin_unlock(&cvc->vc.lock);
+	} else {
+		/* there are physical descs queueing to be served */
+		cvd->pd_list_ptr++;
+	}
+
+	/* start transaction for next PD if queue is not empty */
+	cvd = list_first_entry_or_null(&pc->queue,
+				       struct mtk_cqdma_vdesc, node);
+	if (cvd)
+		mtk_cqdma_start_tran(pc, cvd->pd_list[cvd->pd_list_ptr]);
+}
+
+static irqreturn_t mtk_cqdma_irq(int irq, void *devid)
+{
+	struct mtk_cqdma_device *cqdma = devid;
+	irqreturn_t ret = IRQ_NONE;
+	u32 i;
+
+	/* clear interrupt flags for each PC */
+	for (i = 0; i < cqdma->dma_channels; ++i) {
+		spin_lock(&cqdma->pc[i]->lock);
+		if (mtk_dma_read(cqdma->pc[i],
+				 MTK_CQDMA_INT_FLAG) & MTK_CQDMA_INT_FLAG_BIT) {
+			/* clear interrupt */
+			mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_FLAG,
+				    MTK_CQDMA_INT_FLAG_BIT);
+
+			/* consume the queue */
+			mtk_cqdma_consume_work_queue(cqdma->pc[i]);
+			ret = IRQ_HANDLED;
+		}
+		spin_unlock(&cqdma->pc[i]->lock);
+	}
+
+	return ret;
+}
+
+static struct virt_dma_desc *mtk_cqdma_find_active_desc(struct dma_chan *c,
+							dma_cookie_t cookie)
+{
+	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
+	struct virt_dma_desc *vd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cvc->pc->lock, flags);
+	list_for_each_entry(vd, &cvc->pc->queue, node)
+		if (vd->tx.cookie == cookie) {
+			spin_unlock_irqrestore(&cvc->pc->lock, flags);
+			return vd;
+		}
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
+
+	list_for_each_entry(vd, &cvc->vc.desc_issued, node)
+		if (vd->tx.cookie == cookie)
+			return vd;
+
+	return NULL;
+}
+
+static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
+					   dma_cookie_t cookie,
+					   struct dma_tx_state *txstate)
+{
+	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
+	struct mtk_cqdma_vdesc *cvd;
+	struct virt_dma_desc *vd;
+	enum dma_status ret;
+	unsigned long flags;
+	size_t bytes = 0;
+
+	ret = dma_cookie_status(c, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&cvc->vc.lock, flags);
+	vd = mtk_cqdma_find_active_desc(c, cookie);
+	spin_unlock_irqrestore(&cvc->vc.lock, flags);
+
+	if (vd) {
+		cvd = to_cqdma_vdesc(vd);
+		bytes = cvd->residue;
+	}
+
+	dma_set_residue(txstate, bytes);
+
+	return ret;
+}
+
+static void mtk_cqdma_issue_pending(struct dma_chan *c)
+{
+	struct mtk_cqdma_device *cqdma = to_cqdma_dev(c);
+	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
+	unsigned long pc_flags;
+	unsigned long vc_flags;
+
+	/* acquire PC's lock first due to lock dependency in ISR */
+	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
+	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
+
+	if (vchan_issue_pending(&cvc->vc))
+		mtk_cqdma_issue_vchan_pending(cqdma, cvc);
+
+	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
+}
+
+static struct dma_async_tx_descriptor *
+mtk_cqdma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dest,
+			  dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct mtk_cqdma_vdesc *cvd;
+	size_t pd_list_len, tlen, i;
+
+	cvd = kzalloc(sizeof(*cvd), GFP_NOWAIT);
+	if (!cvd)
+		return NULL;
+
+	/* setup dma channel */
+	cvd->ch = c;
+
+	/* setup sourece, destination, and length */
+	cvd->len = len;
+	cvd->residue = len;
+	cvd->src = src;
+	cvd->dest = dest;
+
+	/* setup PD list */
+	pd_list_len = DIV_ROUND_UP(len, MTK_CQDMA_MAX_LEN);
+	cvd->pd_list_len = pd_list_len;
+	cvd->pd_list_ptr = 0;
+
+	cvd->pd_list = kcalloc(pd_list_len, sizeof(struct mtk_cqdma_pdesc **),
+			       GFP_NOWAIT);
+	if (!cvd->pd_list) {
+		kfree(cvd);
+		return NULL;
+	}
+
+	for (i = 0; i < pd_list_len; ++i) {
+		cvd->pd_list[i] = kzalloc(sizeof(struct mtk_cqdma_pdesc *),
+					  GFP_NOWAIT);
+		if (!cvd->pd_list[i]) {
+			for (; i > 0; --i)
+				kfree(cvd->pd_list[i - 1]);
+			kfree(cvd->pd_list);
+			kfree(cvd);
+			return NULL;
+		}
+
+		tlen = (len > MTK_CQDMA_MAX_LEN) ? MTK_CQDMA_MAX_LEN : len;
+
+		cvd->pd_list[i]->src = cvd->src + cvd->len - tlen;
+		cvd->pd_list[i]->dest = cvd->dest + cvd->len - tlen;
+		cvd->pd_list[i]->len = tlen;
+		len -= tlen;
+	}
+
+	return vchan_tx_prep(to_virt_chan(c), &cvd->vd, flags);
+}
+
+static void mtk_cqdma_free_inactive_desc(struct dma_chan *c)
+{
+	struct virt_dma_chan *vc = to_virt_chan(c);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	/*
+	 * set desc_allocated, desc_submitted,
+	 * and desc_issued as the candicates to be freed
+	 */
+	spin_lock_irqsave(&vc->lock, flags);
+	list_splice_tail_init(&vc->desc_allocated, &head);
+	list_splice_tail_init(&vc->desc_submitted, &head);
+	list_splice_tail_init(&vc->desc_issued, &head);
+	spin_unlock_irqrestore(&vc->lock, flags);
+
+	/* free descriptor lists */
+	vchan_dma_desc_free_list(vc, &head);
+}
+
+static void mtk_cqdma_free_active_desc(struct dma_chan *c)
+{
+	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
+	bool sync_needed = false;
+	unsigned long pc_flags;
+	unsigned long vc_flags;
+
+	/* acquire PC's lock first due to lock dependency in dma ISR */
+	spin_lock_irqsave(&cvc->pc->lock, pc_flags);
+	spin_lock_irqsave(&cvc->vc.lock, vc_flags);
+
+	/* synchronization is required if this VC is active */
+	if (mtk_cqdma_is_vchan_active(cvc)) {
+		cvc->issue_synchronize = true;
+		sync_needed = true;
+	}
+
+	spin_unlock_irqrestore(&cvc->vc.lock, vc_flags);
+	spin_unlock_irqrestore(&cvc->pc->lock, pc_flags);
+
+	/* waiting for the completion of this VC */
+	if (sync_needed)
+		wait_for_completion(&cvc->issue_completion);
+
+	/* free all descriptors in list desc_completed */
+	vchan_synchronize(&cvc->vc);
+
+	WARN_ONCE(!list_empty(&cvc->vc.desc_completed),
+		  "Desc pending still in list desc_completed\n");
+}
+
+static int mtk_cqdma_terminate_all(struct dma_chan *c)
+{
+	/* free descriptors not processed yet by hardware */
+	mtk_cqdma_free_inactive_desc(c);
+
+	/* free descriptors being processed by hardware */
+	mtk_cqdma_free_active_desc(c);
+
+	return 0;
+}
+
+static int mtk_cqdma_alloc_chan_resources(struct dma_chan *c)
+{
+	struct mtk_cqdma_device *cqdma = to_cqdma_dev(c);
+	struct mtk_cqdma_vchan *vc = to_cqdma_vchan(c);
+	struct mtk_cqdma_pchan *pc = NULL;
+	u32 i, min_refcnt = U32_MAX, refcnt;
+	unsigned long flags;
+
+	/* allocate PC with the minimun refcount */
+	for (i = 0; i < cqdma->dma_channels; ++i) {
+		refcnt = refcount_read(&cqdma->pc[i]->refcnt);
+		if (refcnt < min_refcnt) {
+			pc = cqdma->pc[i];
+			min_refcnt = refcnt;
+		}
+	}
+
+	if (!pc)
+		return -ENOSPC;
+
+	spin_lock_irqsave(&pc->lock, flags);
+
+	if (!refcount_read(&pc->refcnt)) {
+		/* allocate PC when the refcount is zero */
+		mtk_cqdma_alloc_pchan(pc);
+		/*
+		 * refcount_inc would complain increment on 0; use-after-free.
+		 * Thus, we need to explicitly set it as 1 initially.
+		 */
+		refcount_set(&pc->refcnt, 1);
+	} else {
+		refcount_inc(&pc->refcnt);
+	}
+
+	spin_unlock_irqrestore(&pc->lock, flags);
+
+	vc->pc = pc;
+
+	return 0;
+}
+
+static void mtk_cqdma_free_chan_resources(struct dma_chan *c)
+{
+	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
+	unsigned long flags;
+
+	/* free all descriptors in all lists on the VC */
+	mtk_cqdma_terminate_all(c);
+
+	spin_lock_irqsave(&cvc->pc->lock, flags);
+
+	/* PC is not freed until there is no VC mapped to it */
+	if (refcount_dec_and_test(&cvc->pc->refcnt))
+		mtk_cqdma_free_pchan(cvc->pc);
+
+	spin_unlock_irqrestore(&cvc->pc->lock, flags);
+}
+
+static int mtk_cqdma_hw_init(struct mtk_cqdma_device *cqdma)
+{
+	unsigned long flags;
+	int err;
+	u32 i;
+
+	pm_runtime_enable(cqdma2dev(cqdma));
+	pm_runtime_get_sync(cqdma2dev(cqdma));
+
+	err = clk_prepare_enable(cqdma->clk);
+
+	if (err) {
+		pm_runtime_put_sync(cqdma2dev(cqdma));
+		pm_runtime_disable(cqdma2dev(cqdma));
+		return err;
+	}
+
+	/* reset all PCs */
+	for (i = 0; i < cqdma->dma_channels; ++i) {
+		spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
+		if (mtk_cqdma_hard_reset(cqdma->pc[i]) < 0) {
+			pr_warn("cqdma hard reset timeout\n");
+			spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
+
+			clk_disable_unprepare(cqdma->clk);
+			pm_runtime_put_sync(cqdma2dev(cqdma));
+			pm_runtime_disable(cqdma2dev(cqdma));
+			return -EINVAL;
+		}
+		spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
+	}
+
+	return 0;
+}
+
+static void mtk_cqdma_hw_deinit(struct mtk_cqdma_device *cqdma)
+{
+	unsigned long flags;
+	u32 i;
+
+	/* reset all PCs */
+	for (i = 0; i < cqdma->dma_channels; ++i) {
+		spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
+		if (mtk_cqdma_hard_reset(cqdma->pc[i]) < 0)
+			pr_warn("cqdma hard reset timeout\n");
+		spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
+	}
+
+	clk_disable_unprepare(cqdma->clk);
+
+	pm_runtime_put_sync(cqdma2dev(cqdma));
+	pm_runtime_disable(cqdma2dev(cqdma));
+}
+
+static const struct of_device_id mtk_cqdma_match[] = {
+	{ .compatible = "mediatek,mt6765-cqdma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_cqdma_match);
+
+static int mtk_cqdma_probe(struct platform_device *pdev)
+{
+	struct mtk_cqdma_device *cqdma;
+	struct mtk_cqdma_vchan *vc;
+	struct dma_device *dd;
+	struct resource *res;
+	int err;
+	u32 i;
+
+	cqdma = devm_kzalloc(&pdev->dev, sizeof(*cqdma), GFP_KERNEL);
+	if (!cqdma)
+		return -ENOMEM;
+
+	dd = &cqdma->ddev;
+
+	cqdma->clk = devm_clk_get(&pdev->dev, "cqdma");
+	if (IS_ERR(cqdma->clk)) {
+		dev_err(&pdev->dev, "No clock for %s\n",
+			dev_name(&pdev->dev));
+		return PTR_ERR(cqdma->clk);
+	}
+
+	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
+
+	dd->copy_align = MTK_CQDMA_ALIGN_SIZE;
+	dd->device_alloc_chan_resources = mtk_cqdma_alloc_chan_resources;
+	dd->device_free_chan_resources = mtk_cqdma_free_chan_resources;
+	dd->device_tx_status = mtk_cqdma_tx_status;
+	dd->device_issue_pending = mtk_cqdma_issue_pending;
+	dd->device_prep_dma_memcpy = mtk_cqdma_prep_dma_memcpy;
+	dd->device_terminate_all = mtk_cqdma_terminate_all;
+	dd->src_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
+	dd->dst_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
+	dd->directions = BIT(DMA_MEM_TO_MEM);
+	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	dd->dev = &pdev->dev;
+	INIT_LIST_HEAD(&dd->channels);
+
+	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
+						      "dma-requests",
+						      &cqdma->dma_requests)) {
+		dev_info(&pdev->dev,
+			 "Using %u as missing dma-requests property\n",
+			 MTK_CQDMA_NR_VCHANS);
+
+		cqdma->dma_requests = MTK_CQDMA_NR_VCHANS;
+	}
+
+	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
+						      "dma-channels",
+						      &cqdma->dma_channels)) {
+		dev_info(&pdev->dev,
+			 "Using %u as missing dma-channels property\n",
+			 MTK_CQDMA_NR_PCHANS);
+
+		cqdma->dma_channels = MTK_CQDMA_NR_PCHANS;
+	}
+
+	cqdma->pc = devm_kcalloc(&pdev->dev, cqdma->dma_channels,
+				 sizeof(*cqdma->pc), GFP_KERNEL);
+	if (!cqdma->pc)
+		return -ENOMEM;
+
+	/* initialization for PCs */
+	for (i = 0; i < cqdma->dma_channels; ++i) {
+		cqdma->pc[i] = devm_kcalloc(&pdev->dev, 1,
+					    sizeof(**cqdma->pc), GFP_KERNEL);
+		if (!cqdma->pc[i])
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&cqdma->pc[i]->queue);
+		spin_lock_init(&cqdma->pc[i]->lock);
+		refcount_set(&cqdma->pc[i]->refcnt, 0);
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res) {
+			dev_err(&pdev->dev, "No mem resource for %s\n",
+				dev_name(&pdev->dev));
+			return -EINVAL;
+		}
+
+		cqdma->pc[i]->base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(cqdma->pc[i]->base))
+			return PTR_ERR(cqdma->pc[i]->base);
+
+		/* allocate IRQ resource */
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
+		if (!res) {
+			dev_err(&pdev->dev, "No irq resource for %s\n",
+				dev_name(&pdev->dev));
+			return -EINVAL;
+		}
+		cqdma->pc[i]->irq = res->start;
+
+		err = devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
+				       mtk_cqdma_irq, 0, dev_name(&pdev->dev),
+				       cqdma);
+		if (err) {
+			dev_err(&pdev->dev,
+				"request_irq failed with err %d\n", err);
+			return -EINVAL;
+		}
+	}
+
+	/* allocate resource for VCs */
+	cqdma->vc = devm_kcalloc(&pdev->dev, cqdma->dma_requests,
+				 sizeof(*cqdma->vc), GFP_KERNEL);
+	if (!cqdma->vc)
+		return -ENOMEM;
+
+	for (i = 0; i < cqdma->dma_requests; i++) {
+		vc = &cqdma->vc[i];
+		vc->vc.desc_free = mtk_cqdma_vdesc_free;
+		vchan_init(&vc->vc, dd);
+		init_completion(&vc->issue_completion);
+	}
+
+	err = dma_async_device_register(dd);
+	if (err)
+		return err;
+
+	err = of_dma_controller_register(pdev->dev.of_node,
+					 of_dma_xlate_by_chan_id, cqdma);
+	if (err) {
+		dev_err(&pdev->dev,
+			"MediaTek CQDMA OF registration failed %d\n", err);
+		goto err_unregister;
+	}
+
+	err = mtk_cqdma_hw_init(cqdma);
+	if (err) {
+		dev_err(&pdev->dev,
+			"MediaTek CQDMA HW initialization failed %d\n", err);
+		goto err_unregister;
+	}
+
+	platform_set_drvdata(pdev, cqdma);
+
+	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");
+
+	return 0;
+
+err_unregister:
+	dma_async_device_unregister(dd);
+
+	return err;
+}
+
+static int mtk_cqdma_remove(struct platform_device *pdev)
+{
+	struct mtk_cqdma_device *cqdma = platform_get_drvdata(pdev);
+	struct mtk_cqdma_vchan *vc;
+	unsigned long flags;
+	int i;
+
+	/* kill VC task */
+	for (i = 0; i < cqdma->dma_requests; i++) {
+		vc = &cqdma->vc[i];
+
+		list_del(&vc->vc.chan.device_node);
+		tasklet_kill(&vc->vc.task);
+	}
+
+	/* disable interrupt */
+	for (i = 0; i < cqdma->dma_channels; i++) {
+		spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
+		mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_EN,
+			    MTK_CQDMA_INT_EN_BIT);
+		spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
+
+		/* Waits for any pending IRQ handlers to complete */
+		synchronize_irq(cqdma->pc[i]->irq);
+	}
+
+	/* disable hardware */
+	mtk_cqdma_hw_deinit(cqdma);
+
+	dma_async_device_unregister(&cqdma->ddev);
+	of_dma_controller_free(pdev->dev.of_node);
+
+	return 0;
+}
+
+static struct platform_driver mtk_cqdma_driver = {
+	.probe = mtk_cqdma_probe,
+	.remove = mtk_cqdma_remove,
+	.driver = {
+		.name           = KBUILD_MODNAME,
+		.of_match_table = mtk_cqdma_match,
+	},
+};
+module_platform_driver(mtk_cqdma_driver);
+
+MODULE_DESCRIPTION("MediaTek CQDMA Controller Driver");
+MODULE_AUTHOR("Shun-Chih Yu <shun-chih.yu@mediatek.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

