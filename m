Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74288ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D5421523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D5421523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbeITMXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:23:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16838 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731159AbeITMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:23:46 -0400
X-UUID: 642dc0d674a74581920830a53687b2a8-20180920
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 785937173; Thu, 20 Sep 2018 14:41:39 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 20 Sep 2018 14:41:37 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 20 Sep 2018 14:41:36 +0800
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ed Blake <ed.blake@sondrel.com>,
        Long Cheng <long.cheng@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>
Subject: [PATCH 2/4] dmaengine: mtk_uart_dma: add Mediatek uart DMA support
Date:   Thu, 20 Sep 2018 14:41:11 +0800
Message-ID: <1537425673-18807-3-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
References: <1537425673-18807-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DMA engine framework, add 8250 mtk dma to support it.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 drivers/dma/8250_mtk_dma.c | 1049 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/Kconfig        |   11 +
 drivers/dma/Makefile       |    1 +
 3 files changed, 1061 insertions(+)
 create mode 100644 drivers/dma/8250_mtk_dma.c

diff --git a/drivers/dma/8250_mtk_dma.c b/drivers/dma/8250_mtk_dma.c
new file mode 100644
index 0000000..a07844e
--- /dev/null
+++ b/drivers/dma/8250_mtk_dma.c
@@ -0,0 +1,1049 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Mediatek 8250 DMA driver.
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Long Cheng <long.cheng@mediatek.com>
+ */
+
+#define pr_fmt(fmt) "8250-mtk-dma: " fmt
+#define DRV_NAME    "8250-mtk-dma"
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of_dma.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
+
+#include "virt-dma.h"
+
+#define MTK_SDMA_REQUESTS	127
+#define MTK_SDMA_CHANNELS	(CONFIG_SERIAL_8250_NR_UARTS * 2)
+
+#define VFF_RX_INT_FLAG_CLR_B	(BIT(0U) | BIT(1U))
+#define VFF_TX_INT_FLAG_CLR_B	0
+#define VFF_RX_INT_EN0_B	BIT(0U)	/*rx valid size >=  vff thre */
+#define VFF_RX_INT_EN1_B	BIT(1U)
+#define VFF_TX_INT_EN_B		BIT(0U)	/*tx left size >= vff thre */
+#define VFF_INT_EN_CLR_B	0
+#define VFF_WARM_RST_B		BIT(0U)
+#define VFF_EN_B		BIT(0U)
+#define VFF_STOP_B		BIT(0U)
+#define VFF_STOP_CLR_B		0
+#define VFF_FLUSH_B		BIT(0U)
+#define VFF_FLUSH_CLR_B		0
+#define VFF_4G_SUPPORT_B	BIT(0U)
+#define VFF_4G_SUPPORT_CLR_B	0
+
+/* interrupt trigger level for tx */
+#define VFF_TX_THRE(n)		((n) * 7 / 8)
+/* interrupt trigger level for rx */
+#define VFF_RX_THRE(n)		((n) * 3 / 4)
+
+#define MTK_DMA_RING_SIZE	0xffffU
+/* invert this bit when wrap ring head again*/
+#define MTK_DMA_RING_WRAP	0x10000U
+
+struct mtk_dmadev {
+	struct dma_device ddev;
+	void __iomem *mem_base[MTK_SDMA_CHANNELS];
+	spinlock_t lock; /* dma dev lock */
+	struct tasklet_struct task;
+	struct list_head pending;
+	struct clk *clk;
+	unsigned int dma_requests;
+	bool support_33bits;
+	unsigned int dma_irq[MTK_SDMA_CHANNELS];
+	struct mtk_chan *lch_map[MTK_SDMA_CHANNELS];
+};
+
+struct mtk_chan {
+	struct virt_dma_chan vc;
+	struct list_head node;
+	struct dma_slave_config	cfg;
+	void __iomem *channel_base;
+	struct mtk_dma_desc *desc;
+
+	bool paused;
+	bool requested;
+
+	unsigned int dma_sig;
+	unsigned int dma_ch;
+	unsigned int sgidx;
+	unsigned int remain_size;
+	unsigned int rx_ptr;
+
+	/*sync*/
+	struct completion done;	/* dma transfer done */
+	spinlock_t lock; /* channel lock */
+	atomic_t loopcnt;
+	atomic_t entry;		/* entry count */
+};
+
+struct mtk_dma_sg {
+	dma_addr_t addr;
+	unsigned int en;		/* number of elements (24-bit) */
+	unsigned int fn;		/* number of frames (16-bit) */
+};
+
+struct mtk_dma_desc {
+	struct virt_dma_desc vd;
+	enum dma_transfer_direction dir;
+	dma_addr_t dev_addr;
+
+	unsigned int sglen;
+	struct mtk_dma_sg sg[0];
+};
+
+enum {
+	VFF_INT_FLAG		= 0x00,
+	VFF_INT_EN		= 0x04,
+	VFF_EN			= 0x08,
+	VFF_RST			= 0x0c,
+	VFF_STOP		= 0x10,
+	VFF_FLUSH		= 0x14,
+	VFF_ADDR		= 0x1c,
+	VFF_LEN			= 0x24,
+	VFF_THRE		= 0x28,
+	VFF_WPT			= 0x2c,
+	VFF_RPT			= 0x30,
+	/*TX: the buffer size HW can read. RX: the buffer size SW can read.*/
+	VFF_VALID_SIZE		= 0x3c,
+	/*TX: the buffer size SW can write. RX: the buffer size HW can write.*/
+	VFF_LEFT_SIZE		= 0x40,
+	VFF_DEBUG_STATUS	= 0x50,
+	VFF_4G_SUPPORT		= 0x54,
+};
+
+static bool mtk_dma_filter_fn(struct dma_chan *chan, void *param);
+static struct of_dma_filter_info mtk_dma_info = {
+	.filter_fn = mtk_dma_filter_fn,
+};
+
+static inline struct mtk_dmadev *to_mtk_dma_dev(struct dma_device *d)
+{
+	return container_of(d, struct mtk_dmadev, ddev);
+}
+
+static inline struct mtk_chan *to_mtk_dma_chan(struct dma_chan *c)
+{
+	return container_of(c, struct mtk_chan, vc.chan);
+}
+
+static inline struct mtk_dma_desc *to_mtk_dma_desc
+	(struct dma_async_tx_descriptor *t)
+{
+	return container_of(t, struct mtk_dma_desc, vd.tx);
+}
+
+static void mtk_dma_chan_write(struct mtk_chan *c,
+			       unsigned int reg, unsigned int val)
+{
+	writel(val, c->channel_base + reg);
+}
+
+static unsigned int mtk_dma_chan_read(struct mtk_chan *c, unsigned int reg)
+{
+	return readl(c->channel_base + reg);
+}
+
+static void mtk_dma_desc_free(struct virt_dma_desc *vd)
+{
+	struct dma_chan *chan = vd->tx.chan;
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (c->desc && c->cfg.direction == DMA_DEV_TO_MEM)
+		atomic_dec(&c->entry);
+
+	kfree(c->desc);
+	c->desc = NULL;
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+}
+
+static int mtk_dma_clk_enable(struct mtk_dmadev *mtkd)
+{
+	int ret;
+
+	ret = clk_prepare_enable(mtkd->clk);
+	if (ret) {
+		dev_err(mtkd->ddev.dev, "Couldn't enable the clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void mtk_dma_clk_disable(struct mtk_dmadev *mtkd)
+{
+	clk_disable_unprepare(mtkd->clk);
+}
+
+static void mtk_dma_remove_virt_list(dma_cookie_t cookie,
+				     struct virt_dma_chan *vc)
+{
+	struct virt_dma_desc *vd;
+
+	if (list_empty(&vc->desc_issued) == 0) {
+		list_for_each_entry(vd, &vc->desc_issued, node) {
+			if (cookie == vd->tx.cookie) {
+				INIT_LIST_HEAD(&vc->desc_issued);
+				break;
+			}
+		}
+	}
+}
+
+static void mtk_dma_tx_flush(struct dma_chan *chan)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+
+	if (mtk_dma_chan_read(c, VFF_FLUSH) == 0U) {
+		mtk_dma_chan_write(c, VFF_FLUSH, VFF_FLUSH_B);
+		if (atomic_dec_and_test(&c->loopcnt))
+			complete(&c->done);
+	}
+}
+
+/*
+ * check whether the dma flush operation is finished or not.
+ * return 0 for flush success.
+ * return others for flush timeout.
+ */
+static int mtk_dma_check_flush_result(struct dma_chan *chan)
+{
+	struct timespec start, end;
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+
+	start = ktime_to_timespec(ktime_get());
+
+	while ((mtk_dma_chan_read(c, VFF_FLUSH) & VFF_FLUSH_B) == VFF_FLUSH_B) {
+		end = ktime_to_timespec(ktime_get());
+		if ((end.tv_sec - start.tv_sec) > 1 ||
+		    ((end.tv_sec - start.tv_sec) == 1 &&
+		      end.tv_nsec > start.tv_nsec)) {
+			dev_err(chan->device->dev,
+				"[DMA] Polling flush timeout\n");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+static void mtk_dma_tx_write(struct dma_chan *chan)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	unsigned int txcount = c->remain_size;
+	unsigned int len, send, left, wpt, wrap;
+
+	if (atomic_inc_return(&c->entry) > 1) {
+		if (vchan_issue_pending(&c->vc) && !c->desc) {
+			spin_lock(&mtkd->lock);
+			list_add_tail(&c->node, &mtkd->pending);
+			spin_unlock(&mtkd->lock);
+			tasklet_schedule(&mtkd->task);
+		}
+	} else {
+		len = mtk_dma_chan_read(c, VFF_LEN);
+		if (mtk_dma_check_flush_result(chan) != 0)
+			return;
+
+		while ((left = mtk_dma_chan_read(c, VFF_LEFT_SIZE)) > 0U) {
+			send = min(left, c->remain_size);
+			wpt = mtk_dma_chan_read(c, VFF_WPT);
+			wrap = wpt & MTK_DMA_RING_WRAP ? 0U : MTK_DMA_RING_WRAP;
+
+			if ((wpt & (len - 1U)) + send < len)
+				mtk_dma_chan_write(c, VFF_WPT, wpt + send);
+			else
+				mtk_dma_chan_write(c, VFF_WPT,
+						   ((wpt + send) & (len - 1U))
+						   | wrap);
+
+			c->remain_size -= send;
+			if (c->remain_size == 0U)
+				break;
+		}
+
+		if (txcount != c->remain_size) {
+			mtk_dma_chan_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
+			mtk_dma_tx_flush(chan);
+		}
+	}
+	atomic_dec(&c->entry);
+}
+
+static void mtk_dma_start_tx(struct mtk_chan *c)
+{
+	if (mtk_dma_chan_read(c, VFF_LEFT_SIZE) == 0U) {
+		pr_info("%s maybe need fix? @L %d\n", __func__, __LINE__);
+		mtk_dma_chan_write(c, VFF_INT_EN, VFF_TX_INT_EN_B);
+	} else {
+		reinit_completion(&c->done);
+
+		/* inc twice, once for tx_flush, another for tx_interrupt */
+		atomic_inc(&c->loopcnt);
+		atomic_inc(&c->loopcnt);
+		mtk_dma_tx_write(&c->vc.chan);
+	}
+	c->paused = false;
+}
+
+static void mtk_dma_get_rx_size(struct mtk_chan *c)
+{
+	unsigned int count;
+	unsigned int rdptr, wrptr, wrreg, rdreg;
+	unsigned int rx_size = mtk_dma_chan_read(c, VFF_LEN);
+
+	rdreg = mtk_dma_chan_read(c, VFF_RPT);
+	wrreg = mtk_dma_chan_read(c, VFF_WPT);
+	rdptr = rdreg & MTK_DMA_RING_SIZE;
+	wrptr = wrreg & MTK_DMA_RING_SIZE;
+	count = ((rdreg ^ wrreg) & MTK_DMA_RING_WRAP) ?
+			(wrptr + rx_size - rdptr) : (wrptr - rdptr);
+
+	c->remain_size = count;
+	c->rx_ptr = rdptr;
+
+	mtk_dma_chan_write(c, VFF_RPT, wrreg);
+}
+
+static void mtk_dma_start_rx(struct mtk_chan *c)
+{
+	struct dma_chan *chan = &c->vc.chan;
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	struct mtk_dma_desc *d = c->desc;
+
+	if (mtk_dma_chan_read(c, VFF_VALID_SIZE) != 0U &&
+	    d && d->vd.tx.cookie != 0) {
+		mtk_dma_get_rx_size(c);
+		mtk_dma_remove_virt_list(d->vd.tx.cookie, &c->vc);
+		vchan_cookie_complete(&d->vd);
+	} else {
+		if (mtk_dma_chan_read(c, VFF_VALID_SIZE) != 0U) {
+			spin_lock(&mtkd->lock);
+			if (list_empty(&mtkd->pending))
+				list_add_tail(&c->node, &mtkd->pending);
+			spin_unlock(&mtkd->lock);
+			tasklet_schedule(&mtkd->task);
+		} else {
+			if (atomic_read(&c->entry) > 0)
+				atomic_set(&c->entry, 0);
+		}
+	}
+}
+
+static void mtk_dma_reset(struct mtk_chan *c)
+{
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
+
+	mtk_dma_chan_write(c, VFF_ADDR, 0);
+	mtk_dma_chan_write(c, VFF_THRE, 0);
+	mtk_dma_chan_write(c, VFF_LEN, 0);
+	mtk_dma_chan_write(c, VFF_RST, VFF_WARM_RST_B);
+
+	while
+		(mtk_dma_chan_read(c, VFF_EN));
+
+	if (c->cfg.direction == DMA_DEV_TO_MEM)
+		mtk_dma_chan_write(c, VFF_RPT, 0);
+	else if (c->cfg.direction == DMA_MEM_TO_DEV)
+		mtk_dma_chan_write(c, VFF_WPT, 0);
+	else
+		dev_info(c->vc.chan.device->dev, "Unknown direction.\n");
+
+	if (mtkd->support_33bits)
+		mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_CLR_B);
+}
+
+static void mtk_dma_stop(struct mtk_chan *c)
+{
+	int polling_cnt;
+
+	mtk_dma_chan_write(c, VFF_FLUSH, VFF_FLUSH_CLR_B);
+
+	polling_cnt = 0;
+	while ((mtk_dma_chan_read(c, VFF_FLUSH) & VFF_FLUSH_B) ==
+		VFF_FLUSH_B)	{
+		polling_cnt++;
+		if (polling_cnt > 10000) {
+			dev_err(c->vc.chan.device->dev,
+				"dma stop: polling FLUSH fail, DEBUG=0x%x\n",
+				mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
+			break;
+		}
+	}
+
+	polling_cnt = 0;
+	/*set stop as 1 -> wait until en is 0 -> set stop as 0*/
+	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_B);
+	while (mtk_dma_chan_read(c, VFF_EN)) {
+		polling_cnt++;
+		if (polling_cnt > 10000) {
+			dev_err(c->vc.chan.device->dev,
+				"dma stop: polling VFF_EN fail, DEBUG=0x%x\n",
+				mtk_dma_chan_read(c, VFF_DEBUG_STATUS));
+			break;
+		}
+	}
+	mtk_dma_chan_write(c, VFF_STOP, VFF_STOP_CLR_B);
+	mtk_dma_chan_write(c, VFF_INT_EN, VFF_INT_EN_CLR_B);
+
+	if (c->cfg.direction == DMA_DEV_TO_MEM)
+		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
+	else
+		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
+
+	c->paused = true;
+}
+
+/*
+ * We need to deal with 'all channels in-use'
+ */
+static void mtk_dma_rx_sched(struct mtk_chan *c)
+{
+	struct dma_chan *chan = &c->vc.chan;
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+
+	if (atomic_read(&c->entry) < 1) {
+		mtk_dma_start_rx(c);
+	} else {
+		spin_lock(&mtkd->lock);
+		if (list_empty(&mtkd->pending))
+			list_add_tail(&c->node, &mtkd->pending);
+		spin_unlock(&mtkd->lock);
+		tasklet_schedule(&mtkd->task);
+	}
+}
+
+/*
+ * This callback schedules all pending channels. We could be more
+ * clever here by postponing allocation of the real DMA channels to
+ * this point, and freeing them when our virtual channel becomes idle.
+ *
+ * We would then need to deal with 'all channels in-use'
+ */
+static void mtk_dma_sched(unsigned long data)
+{
+	struct mtk_dmadev *mtkd = (struct mtk_dmadev *)data;
+	struct mtk_chan *c;
+	struct virt_dma_desc *vd;
+	dma_cookie_t cookie;
+	LIST_HEAD(head);
+	unsigned long flags;
+
+	spin_lock_irq(&mtkd->lock);
+	list_splice_tail_init(&mtkd->pending, &head);
+	spin_unlock_irq(&mtkd->lock);
+
+	if (list_empty(&head) == 0) {
+		c = list_first_entry(&head, struct mtk_chan, node);
+		cookie = c->vc.chan.cookie;
+
+		spin_lock_irqsave(&c->vc.lock, flags);
+		if (c->cfg.direction == DMA_DEV_TO_MEM) {
+			list_del_init(&c->node);
+			mtk_dma_rx_sched(c);
+		} else if (c->cfg.direction == DMA_MEM_TO_DEV) {
+			vd = vchan_find_desc(&c->vc, cookie);
+
+			c->desc = to_mtk_dma_desc(&vd->tx);
+			list_del_init(&c->node);
+			mtk_dma_start_tx(c);
+		}
+		spin_unlock_irqrestore(&c->vc.lock, flags);
+	}
+}
+
+static int mtk_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	int ret = -EBUSY;
+
+	pm_runtime_get_sync(mtkd->ddev.dev);
+
+	if (!mtkd->lch_map[c->dma_ch]) {
+		c->channel_base = mtkd->mem_base[c->dma_ch];
+		mtkd->lch_map[c->dma_ch] = c;
+		ret = 1;
+	}
+	c->requested = false;
+	mtk_dma_reset(c);
+
+	return ret;
+}
+
+static void mtk_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+
+	if (c->requested) {
+		c->requested = false;
+		free_irq(mtkd->dma_irq[c->dma_ch], chan);
+	}
+
+	tasklet_kill(&mtkd->task);
+
+	c->channel_base = NULL;
+	mtkd->lch_map[c->dma_ch] = NULL;
+	vchan_free_chan_resources(&c->vc);
+
+	dev_dbg(mtkd->ddev.dev, "freeing channel for %u\n", c->dma_sig);
+	c->dma_sig = 0;
+
+	pm_runtime_put_sync(mtkd->ddev.dev);
+}
+
+static enum dma_status mtk_dma_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	enum dma_status ret;
+	unsigned long flags;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (ret == DMA_IN_PROGRESS) {
+		c->rx_ptr = mtk_dma_chan_read(c, VFF_RPT) & MTK_DMA_RING_SIZE;
+		txstate->residue = c->rx_ptr;
+	} else if (ret == DMA_COMPLETE && c->cfg.direction == DMA_DEV_TO_MEM) {
+		txstate->residue = c->remain_size;
+	} else {
+		txstate->residue = 0;
+	}
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+
+	return ret;
+}
+
+static unsigned int mtk_dma_desc_size(struct mtk_dma_desc *d)
+{
+	struct mtk_dma_sg *sg;
+	unsigned int i;
+	unsigned int size;
+
+	for (size = i = 0; i < d->sglen; i++) {
+		sg = &d->sg[i];
+		size += sg->en * sg->fn;
+	}
+	return size;
+}
+
+static struct dma_async_tx_descriptor *mtk_dma_prep_slave_sg
+	(struct dma_chan *chan, struct scatterlist *sgl,
+	unsigned int sglen,	enum dma_transfer_direction dir,
+	unsigned long tx_flags, void *context)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct scatterlist *sgent;
+	struct mtk_dma_desc *d;
+	dma_addr_t dev_addr;
+	unsigned int i, j, en, frame_bytes;
+
+	en = 1;
+	frame_bytes = 1;
+
+	if (dir == DMA_DEV_TO_MEM) {
+		dev_addr = c->cfg.src_addr;
+	} else if (dir == DMA_MEM_TO_DEV) {
+		dev_addr = c->cfg.dst_addr;
+	} else {
+		dev_err(chan->device->dev, "bad direction\n");
+		return NULL;
+	}
+
+	/* Now allocate and setup the descriptor. */
+	d = kzalloc(sizeof(*d) + sglen * sizeof(d->sg[0]), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->dir = dir;
+	d->dev_addr = dev_addr;
+
+	j = 0;
+	for_each_sg(sgl, sgent, sglen, i) {
+		d->sg[j].addr = sg_dma_address(sgent);
+		d->sg[j].en = en;
+		d->sg[j].fn = sg_dma_len(sgent) / frame_bytes;
+		j++;
+	}
+
+	d->sglen = j;
+
+	if (dir == DMA_MEM_TO_DEV)
+		c->remain_size = mtk_dma_desc_size(d);
+
+	return vchan_tx_prep(&c->vc, &d->vd, tx_flags);
+}
+
+static void mtk_dma_issue_pending(struct dma_chan *chan)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct mtk_dmadev *mtkd;
+	struct virt_dma_desc *vd;
+	dma_cookie_t cookie;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (c->cfg.direction == DMA_DEV_TO_MEM) {
+		cookie = c->vc.chan.cookie;
+		mtkd = to_mtk_dma_dev(chan->device);
+		if (vchan_issue_pending(&c->vc) && !c->desc) {
+			vd = vchan_find_desc(&c->vc, cookie);
+			c->desc = to_mtk_dma_desc(&vd->tx);
+			if (atomic_read(&c->entry) > 0)
+				atomic_set(&c->entry, 0);
+		}
+	} else if (c->cfg.direction == DMA_MEM_TO_DEV) {
+		cookie = c->vc.chan.cookie;
+		if (vchan_issue_pending(&c->vc) && !c->desc) {
+			vd = vchan_find_desc(&c->vc, cookie);
+			c->desc = to_mtk_dma_desc(&vd->tx);
+			mtk_dma_start_tx(c);
+		}
+	}
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+}
+
+static irqreturn_t mtk_dma_rx_interrupt(int irq, void *dev_id)
+{
+	struct dma_chan *chan = (struct dma_chan *)dev_id;
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
+
+	if (atomic_inc_return(&c->entry) > 1) {
+		if (list_empty(&mtkd->pending))
+			list_add_tail(&c->node, &mtkd->pending);
+		tasklet_schedule(&mtkd->task);
+	} else {
+		mtk_dma_start_rx(c);
+	}
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mtk_dma_tx_interrupt(int irq, void *dev_id)
+{
+	struct dma_chan *chan = (struct dma_chan *)dev_id;
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+	struct mtk_dma_desc *d = c->desc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (c->remain_size != 0U) {
+		list_add_tail(&c->node, &mtkd->pending);
+		tasklet_schedule(&mtkd->task);
+	} else {
+		mtk_dma_remove_virt_list(d->vd.tx.cookie, &c->vc);
+		vchan_cookie_complete(&d->vd);
+	}
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+
+	mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
+	if (atomic_dec_and_test(&c->loopcnt))
+		complete(&c->done);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_dma_slave_config(struct dma_chan *chan,
+				struct dma_slave_config *cfg)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	struct mtk_dmadev *mtkd = to_mtk_dma_dev(c->vc.chan.device);
+	int ret;
+
+	c->cfg = *cfg;
+
+	if (cfg->direction == DMA_DEV_TO_MEM) {
+		unsigned int rx_len = cfg->src_addr_width * 1024;
+
+		mtk_dma_chan_write(c, VFF_ADDR, cfg->src_addr);
+		mtk_dma_chan_write(c, VFF_LEN, rx_len);
+		mtk_dma_chan_write(c, VFF_THRE, VFF_RX_THRE(rx_len));
+		mtk_dma_chan_write(c,
+				   VFF_INT_EN, VFF_RX_INT_EN0_B
+				   | VFF_RX_INT_EN1_B);
+		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_RX_INT_FLAG_CLR_B);
+		mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
+
+		if (!c->requested) {
+			atomic_set(&c->entry, 0);
+			c->requested = true;
+			ret = request_irq(mtkd->dma_irq[c->dma_ch],
+					  mtk_dma_rx_interrupt,
+					  IRQF_TRIGGER_NONE,
+					  DRV_NAME, chan);
+			if (ret < 0) {
+				dev_err(chan->device->dev, "Can't request rx dma IRQ\n");
+				return -EINVAL;
+			}
+		}
+	} else if (cfg->direction == DMA_MEM_TO_DEV)	{
+		unsigned int tx_len = cfg->dst_addr_width * 1024;
+
+		mtk_dma_chan_write(c, VFF_ADDR, cfg->dst_addr);
+		mtk_dma_chan_write(c, VFF_LEN, tx_len);
+		mtk_dma_chan_write(c, VFF_THRE, VFF_TX_THRE(tx_len));
+		mtk_dma_chan_write(c, VFF_INT_FLAG, VFF_TX_INT_FLAG_CLR_B);
+		mtk_dma_chan_write(c, VFF_EN, VFF_EN_B);
+
+		if (!c->requested) {
+			c->requested = true;
+			ret = request_irq(mtkd->dma_irq[c->dma_ch],
+					  mtk_dma_tx_interrupt,
+					  IRQF_TRIGGER_NONE,
+					  DRV_NAME, chan);
+			if (ret < 0) {
+				dev_err(chan->device->dev, "Can't request tx dma IRQ\n");
+				return -EINVAL;
+			}
+		}
+	} else {
+		dev_info(chan->device->dev, "Unknown direction!\n");
+	}
+
+	if (mtkd->support_33bits)
+		mtk_dma_chan_write(c, VFF_4G_SUPPORT, VFF_4G_SUPPORT_B);
+
+	if (mtk_dma_chan_read(c, VFF_EN) != VFF_EN_B) {
+		dev_err(chan->device->dev,
+			"config dma dir[%d] fail\n", cfg->direction);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mtk_dma_terminate_all(struct dma_chan *chan)
+{
+	struct mtk_chan *c = to_mtk_dma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	if (atomic_read(&c->loopcnt) != 0)
+		wait_for_completion(&c->done);
+
+	spin_lock_irqsave(&c->vc.lock, flags);
+	if (c->desc) {
+		mtk_dma_remove_virt_list(c->desc->vd.tx.cookie, &c->vc);
+		spin_unlock_irqrestore(&c->vc.lock, flags);
+
+		mtk_dma_desc_free(&c->desc->vd);
+
+		spin_lock_irqsave(&c->vc.lock, flags);
+		if (!c->paused)	{
+			list_del_init(&c->node);
+			mtk_dma_stop(c);
+		}
+	}
+	vchan_get_all_descriptors(&c->vc, &head);
+	spin_unlock_irqrestore(&c->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&c->vc, &head);
+
+	return 0;
+}
+
+static int mtk_dma_device_pause(struct dma_chan *chan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	return -EINVAL;
+}
+
+static int mtk_dma_device_resume(struct dma_chan *chan)
+{
+	/* Pause/Resume only allowed with cyclic mode */
+	return -EINVAL;
+}
+
+static int mtk_dma_chan_init(struct mtk_dmadev *mtkd)
+{
+	struct mtk_chan *c;
+
+	c = devm_kzalloc(mtkd->ddev.dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	c->vc.desc_free = mtk_dma_desc_free;
+	vchan_init(&c->vc, &mtkd->ddev);
+	spin_lock_init(&c->lock);
+	INIT_LIST_HEAD(&c->node);
+
+	init_completion(&c->done);
+	atomic_set(&c->loopcnt, 0);
+	atomic_set(&c->entry, 0);
+
+	return 0;
+}
+
+static void mtk_dma_free(struct mtk_dmadev *mtkd)
+{
+	tasklet_kill(&mtkd->task);
+	while (list_empty(&mtkd->ddev.channels) == 0) {
+		struct mtk_chan *c = list_first_entry(&mtkd->ddev.channels,
+			struct mtk_chan, vc.chan.device_node);
+
+		list_del(&c->vc.chan.device_node);
+		tasklet_kill(&c->vc.task);
+		devm_kfree(mtkd->ddev.dev, c);
+	}
+}
+
+static const struct of_device_id mtk_uart_dma_match[] = {
+	{ .compatible = "mediatek,mt6577-uart-dma", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_uart_dma_match);
+
+static int mtk_dma_probe(struct platform_device *pdev)
+{
+	struct mtk_dmadev *mtkd;
+	struct resource *res;
+	unsigned int i;
+	int rc;
+
+	mtkd = devm_kzalloc(&pdev->dev, sizeof(*mtkd), GFP_KERNEL);
+	if (!mtkd)
+		return -ENOMEM;
+
+	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			return -ENODEV;
+		mtkd->mem_base[i] = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mtkd->mem_base[i]))
+			return PTR_ERR(mtkd->mem_base[i]);
+	}
+
+	/* request irq */
+	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
+		mtkd->dma_irq[i] = platform_get_irq(pdev, i);
+		if ((int)mtkd->dma_irq[i] < 0) {
+			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
+			return -EINVAL;
+		}
+	}
+
+	mtkd->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mtkd->clk)) {
+		dev_err(&pdev->dev, "No clock specified\n");
+		return PTR_ERR(mtkd->clk);
+	}
+
+	if (of_property_read_bool(pdev->dev.of_node, "dma-33bits")) {
+		dev_info(&pdev->dev, "Support dma 33bits\n");
+		mtkd->support_33bits = true;
+	}
+
+	if (mtkd->support_33bits)
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(33));
+	else
+		rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rc)
+		return rc;
+
+	dma_cap_set(DMA_SLAVE, mtkd->ddev.cap_mask);
+	mtkd->ddev.device_alloc_chan_resources = mtk_dma_alloc_chan_resources;
+	mtkd->ddev.device_free_chan_resources = mtk_dma_free_chan_resources;
+	mtkd->ddev.device_tx_status = mtk_dma_tx_status;
+	mtkd->ddev.device_issue_pending = mtk_dma_issue_pending;
+	mtkd->ddev.device_prep_slave_sg = mtk_dma_prep_slave_sg;
+	mtkd->ddev.device_config = mtk_dma_slave_config;
+	mtkd->ddev.device_pause = mtk_dma_device_pause;
+	mtkd->ddev.device_resume = mtk_dma_device_resume;
+	mtkd->ddev.device_terminate_all = mtk_dma_terminate_all;
+	mtkd->ddev.src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
+	mtkd->ddev.dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
+	mtkd->ddev.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	mtkd->ddev.residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	mtkd->ddev.dev = &pdev->dev;
+	INIT_LIST_HEAD(&mtkd->ddev.channels);
+	INIT_LIST_HEAD(&mtkd->pending);
+
+	spin_lock_init(&mtkd->lock);
+	tasklet_init(&mtkd->task, mtk_dma_sched, (unsigned long)mtkd);
+
+	mtkd->dma_requests = MTK_SDMA_REQUESTS;
+	if (of_property_read_u32(pdev->dev.of_node,
+				 "dma-requests", &mtkd->dma_requests) != 0) {
+		dev_info(&pdev->dev,
+			 "Missing dma-requests property, using %u.\n",
+			 MTK_SDMA_REQUESTS);
+	}
+
+	for (i = 0; i < MTK_SDMA_CHANNELS; i++) {
+		rc = mtk_dma_chan_init(mtkd);
+		if (rc)
+			goto err_no_dma;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+
+	rc = dma_async_device_register(&mtkd->ddev);
+	if (rc) {
+		dev_warn(&pdev->dev, "fail to register DMA device: %d\n", rc);
+		mtk_dma_clk_disable(mtkd);
+		goto err_no_dma;
+	}
+
+	platform_set_drvdata(pdev, mtkd);
+
+	if (pdev->dev.of_node) {
+		mtk_dma_info.dma_cap = mtkd->ddev.cap_mask;
+
+		/* Device-tree DMA controller registration */
+		rc = of_dma_controller_register(pdev->dev.of_node,
+						of_dma_simple_xlate,
+						&mtk_dma_info);
+		if (rc) {
+			dev_warn(&pdev->dev, "fail to register DMA controller\n");
+			dma_async_device_unregister(&mtkd->ddev);
+			mtk_dma_clk_disable(mtkd);
+			goto err_no_dma;
+		}
+	}
+
+	return rc;
+
+err_no_dma:
+	mtk_dma_free(mtkd);
+	return rc;
+}
+
+static int mtk_dma_remove(struct platform_device *pdev)
+{
+	struct mtk_dmadev *mtkd = platform_get_drvdata(pdev);
+
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
+
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	dma_async_device_unregister(&mtkd->ddev);
+
+	mtk_dma_free(mtkd);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mtk_dma_suspend(struct device *dev)
+{
+	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
+
+	if (!pm_runtime_suspended(dev))
+		mtk_dma_clk_disable(mtkd);
+
+	return 0;
+}
+
+static int mtk_dma_resume(struct device *dev)
+{
+	int ret;
+	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = mtk_dma_clk_enable(mtkd);
+		if (ret) {
+			dev_info(dev, "fail to enable clk: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_dma_runtime_suspend(struct device *dev)
+{
+	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
+
+	mtk_dma_clk_disable(mtkd);
+
+	return 0;
+}
+
+static int mtk_dma_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct mtk_dmadev *mtkd = dev_get_drvdata(dev);
+
+	ret = mtk_dma_clk_enable(mtkd);
+	if (ret) {
+		dev_warn(dev, "fail to enable clk: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+#endif /* CONFIG_PM_SLEEP */
+
+static const struct dev_pm_ops mtk_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(mtk_dma_suspend, mtk_dma_resume)
+	SET_RUNTIME_PM_OPS(mtk_dma_runtime_suspend,
+			   mtk_dma_runtime_resume, NULL)
+};
+
+static struct platform_driver mtk_dma_driver = {
+	.probe	= mtk_dma_probe,
+	.remove	= mtk_dma_remove,
+	.driver = {
+		.name		= "8250-mtk-dma",
+		.pm		= &mtk_dma_pm_ops,
+		.of_match_table = of_match_ptr(mtk_uart_dma_match),
+	},
+};
+
+static bool mtk_dma_filter_fn(struct dma_chan *chan, void *param)
+{
+	if (chan->device->dev->driver == &mtk_dma_driver.driver) {
+		struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
+		struct mtk_chan *c = to_mtk_dma_chan(chan);
+		unsigned int req = *(unsigned int *)param;
+
+		if (req <= mtkd->dma_requests) {
+			c->dma_sig = req;
+			c->dma_ch = req;
+			return true;
+		}
+	}
+	return false;
+}
+
+static int mtk_dma_init(void)
+{
+	return platform_driver_register(&mtk_dma_driver);
+}
+subsys_initcall(mtk_dma_init);
+
+static void __exit mtk_dma_exit(void)
+{
+	platform_driver_unregister(&mtk_dma_driver);
+}
+module_exit(mtk_dma_exit);
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index dacf3f4..cfa1699 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -151,6 +151,17 @@ config DMA_JZ4780
 	  If you have a board based on such a SoC and wish to use DMA for
 	  devices which can use the DMA controller, say Y or M here.
 
+config DMA_MTK_UART
+	tristate "MediaTek SoCs APDMA support for UART"
+	depends on OF
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support for the UART DMA engine found on MediaTek MTK SoCs.
+	  when 8250 mtk uart is enabled, and if you want to using DMA,
+	  you can enable the config. the DMA engine just only be used
+	  with MediaTek Socs.
+
 config DMA_SA11X0
 	tristate "SA-11x0 DMA support"
 	depends on ARCH_SA1100 || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index c91702d..42690d8 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
 obj-$(CONFIG_DMA_BCM2835) += bcm2835-dma.o
 obj-$(CONFIG_DMA_JZ4740) += dma-jz4740.o
 obj-$(CONFIG_DMA_JZ4780) += dma-jz4780.o
+obj-$(CONFIG_DMA_MTK_UART) += 8250_mtk_dma.o
 obj-$(CONFIG_DMA_SA11X0) += sa11x0-dma.o
 obj-$(CONFIG_DMA_SUN4I) += sun4i-dma.o
 obj-$(CONFIG_DMA_SUN6I) += sun6i-dma.o
-- 
1.7.9.5

