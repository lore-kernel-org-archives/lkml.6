Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48AEC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8D72173B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 11:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbeLYLKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 06:10:07 -0500
Received: from inva020.nxp.com ([92.121.34.13]:58672 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbeLYLKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 06:10:06 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B3921A0077;
        Tue, 25 Dec 2018 12:09:50 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28A501A003A;
        Tue, 25 Dec 2018 12:09:46 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 59C89402A5;
        Tue, 25 Dec 2018 19:09:41 +0800 (SGT)
From:   Peng Ma <peng.ma@nxp.com>
To:     vkoul@kernel.org
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com, jerry.huang@nxp.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>
Subject: [PATCH] dmaengine: fsl-dpaa2-qdma: Add qDMA controller driver for Layerscape SoCs
Date:   Tue, 25 Dec 2018 11:04:47 +0000
Message-Id: <20181225110447.31628-1-peng.ma@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NXP Data Path Acceleration Architecture 2 (dpaa2) queue direct
memory(qDMA) controller driver support.
This module can be found on NXP LS2 SoCs.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
---
 drivers/dma/Kconfig                         |    2 +
 drivers/dma/Makefile                        |    1 +
 drivers/dma/fsl-dpaa2-qdma/Kconfig          |    8 +
 drivers/dma/fsl-dpaa2-qdma/Makefile         |    8 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c     |  781 +++++++++++++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h     |  152 ++++++
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c         |  483 +++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h     |  524 ++++++++++++++++++
 drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h |  197 +++++++
 9 files changed, 2156 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/Kconfig
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/Makefile
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpdmai.c
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h
 create mode 100644 drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de511db..f0d8125 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -646,6 +646,8 @@ source "drivers/dma/sh/Kconfig"
 
 source "drivers/dma/ti/Kconfig"
 
+source drivers/dma/fsl-dpaa2-qdma/Kconfig
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 7fcc4d8..f542823 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_TIMB_DMA) += timb_dma.o
 obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
 obj-$(CONFIG_ZX_DMA) += zx_dma.o
 obj-$(CONFIG_ST_FDMA) += st_fdma.o
+obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
 
 obj-y += mediatek/
 obj-y += qcom/
diff --git a/drivers/dma/fsl-dpaa2-qdma/Kconfig b/drivers/dma/fsl-dpaa2-qdma/Kconfig
new file mode 100644
index 0000000..ec591fc
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/Kconfig
@@ -0,0 +1,8 @@
+menuconfig FSL_DPAA2_QDMA
+	tristate "NXP DPAA2 QDMA"
+	depends on FSL_MC_BUS && FSL_MC_DPIO
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  NXP Data Path Acceleration Architecture 2 QDMA driver,
+	  using the NXP MC bus driver.
diff --git a/drivers/dma/fsl-dpaa2-qdma/Makefile b/drivers/dma/fsl-dpaa2-qdma/Makefile
new file mode 100644
index 0000000..4990282
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the NXP DPAA2 qDMA controllers
+#
+ccflags-y += -DVERSION=\"\"
+
+obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma.o
+
+fsl-dpaa2-qdma-objs    := dpaa2-qdma.o dpdmai.o
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
new file mode 100644
index 0000000..1347281
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -0,0 +1,781 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2014-2018 NXP
+
+/*
+ * Author: Changming Huang <jerry.huang@nxp.com>
+ *
+ * Driver for the NXP QDMA engine with QMan mode.
+ * Channel virtualization is supported through enqueuing of DMA jobs to,
+ * or dequeuing DMA jobs from different work queues with QMan portal.
+ * This module can be found on NXP LS2 SoCs.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dmapool.h>
+#include <linux/of_irq.h>
+#include <linux/iommu.h>
+#include <linux/sys_soc.h>
+#include <linux/fsl/mc.h>
+#include <soc/fsl/dpaa2-io.h>
+
+#include "../virt-dma.h"
+#include "fsl_dpdmai_cmd.h"
+#include "fsl_dpdmai.h"
+#include "dpaa2-qdma.h"
+
+static bool smmu_disable = true;
+
+static struct dpaa2_qdma_chan *to_dpaa2_qdma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct dpaa2_qdma_chan, vchan.chan);
+}
+
+static struct dpaa2_qdma_comp *to_fsl_qdma_comp(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct dpaa2_qdma_comp, vdesc);
+}
+
+static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
+	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
+	struct device *dev = &dpaa2_qdma->priv->dpdmai_dev->dev;
+
+	dpaa2_chan->fd_pool = dma_pool_create("fd_pool", dev,
+					      FD_POOL_SIZE, 32, 0);
+	if (!dpaa2_chan->fd_pool)
+		return -ENOMEM;
+
+	return dpaa2_qdma->desc_allocated++;
+}
+
+static void dpaa2_qdma_free_chan_resources(struct dma_chan *chan)
+{
+	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
+	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
+	unsigned long flags;
+
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&dpaa2_chan->vchan.lock, flags);
+	vchan_get_all_descriptors(&dpaa2_chan->vchan, &head);
+	spin_unlock_irqrestore(&dpaa2_chan->vchan.lock, flags);
+
+	vchan_dma_desc_free_list(&dpaa2_chan->vchan, &head);
+
+	dpaa2_dpdmai_free_comp(dpaa2_chan, &dpaa2_chan->comp_used);
+	dpaa2_dpdmai_free_comp(dpaa2_chan, &dpaa2_chan->comp_free);
+
+	dma_pool_destroy(dpaa2_chan->fd_pool);
+	dpaa2_qdma->desc_allocated--;
+}
+
+/*
+ * Request a command descriptor for enqueue.
+ */
+static struct dpaa2_qdma_comp *
+dpaa2_qdma_request_desc(struct dpaa2_qdma_chan *dpaa2_chan)
+{
+	struct dpaa2_qdma_comp *comp_temp = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dpaa2_chan->queue_lock, flags);
+	if (list_empty(&dpaa2_chan->comp_free)) {
+		spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
+		comp_temp = kzalloc(sizeof(*comp_temp), GFP_KERNEL);
+		if (!comp_temp)
+			goto err;
+		comp_temp->fd_virt_addr =
+			dma_pool_alloc(dpaa2_chan->fd_pool, GFP_NOWAIT,
+				       &comp_temp->fd_bus_addr);
+		if (!comp_temp->fd_virt_addr)
+			goto err;
+
+		comp_temp->fl_virt_addr =
+			(void *)((struct dpaa2_fd *)
+				comp_temp->fd_virt_addr + 1);
+		comp_temp->fl_bus_addr = comp_temp->fd_bus_addr +
+					sizeof(struct dpaa2_fd);
+		comp_temp->desc_virt_addr =
+			(void *)((struct dpaa2_fl_entry *)
+				comp_temp->fl_virt_addr + 3);
+		comp_temp->desc_bus_addr = comp_temp->fl_bus_addr +
+				sizeof(struct dpaa2_fl_entry) * 3;
+
+		comp_temp->qchan = dpaa2_chan;
+		return comp_temp;
+	}
+	comp_temp = list_first_entry(&dpaa2_chan->comp_free,
+				     struct dpaa2_qdma_comp, list);
+	list_del(&comp_temp->list);
+	spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
+
+	comp_temp->qchan = dpaa2_chan;
+err:
+	return comp_temp;
+}
+
+static void
+dpaa2_qdma_populate_fd(u32 format, struct dpaa2_qdma_comp *dpaa2_comp)
+{
+	struct dpaa2_fd *fd;
+
+	fd = (struct dpaa2_fd *)dpaa2_comp->fd_virt_addr;
+	memset(fd, 0, sizeof(struct dpaa2_fd));
+
+	/* fd populated */
+	dpaa2_fd_set_addr(fd, dpaa2_comp->fl_bus_addr);
+	/* Bypass memory translation, Frame list format, short length disable */
+	/* we need to disable BMT if fsl-mc use iova addr */
+	if (smmu_disable)
+		dpaa2_fd_set_bpid(fd, QMAN_FD_BMT_ENABLE);
+	dpaa2_fd_set_format(fd, QMAN_FD_FMT_ENABLE | QMAN_FD_SL_DISABLE);
+
+	dpaa2_fd_set_frc(fd, format | QDMA_SER_CTX);
+}
+
+/* first frame list for descriptor buffer */
+static void
+dpaa2_qdma_populate_first_framel(struct dpaa2_fl_entry *f_list,
+				 struct dpaa2_qdma_comp *dpaa2_comp,
+				 bool wrt_changed)
+{
+	struct dpaa2_qdma_sd_d *sdd;
+
+	sdd = (struct dpaa2_qdma_sd_d *)dpaa2_comp->desc_virt_addr;
+	memset(sdd, 0, 2 * (sizeof(*sdd)));
+
+	/* source descriptor CMD */
+	sdd->cmd = cpu_to_le32(QDMA_SD_CMD_RDTTYPE_COHERENT);
+	sdd++;
+
+	/* dest descriptor CMD */
+	if (wrt_changed)
+		sdd->cmd = cpu_to_le32(LX2160_QDMA_DD_CMD_WRTTYPE_COHERENT);
+	else
+		sdd->cmd = cpu_to_le32(QDMA_DD_CMD_WRTTYPE_COHERENT);
+
+	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
+
+	/* first frame list to source descriptor */
+	dpaa2_fl_set_addr(f_list, dpaa2_comp->desc_bus_addr);
+	dpaa2_fl_set_len(f_list, 0x20);
+	dpaa2_fl_set_format(f_list, QDMA_FL_FMT_SBF | QDMA_FL_SL_LONG);
+
+	/* bypass memory translation */
+	if (smmu_disable)
+		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
+}
+
+/* source and destination frame list */
+static void
+dpaa2_qdma_populate_frames(struct dpaa2_fl_entry *f_list,
+			   dma_addr_t dst, dma_addr_t src,
+			   size_t len, uint8_t fmt)
+{
+	/* source frame list to source buffer */
+	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
+
+	dpaa2_fl_set_addr(f_list, src);
+	dpaa2_fl_set_len(f_list, len);
+
+	/* single buffer frame or scatter gather frame */
+	dpaa2_fl_set_format(f_list, (fmt | QDMA_FL_SL_LONG));
+
+	/* bypass memory translation */
+	if (smmu_disable)
+		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
+
+	f_list++;
+
+	/* destination frame list to destination buffer */
+	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
+
+	dpaa2_fl_set_addr(f_list, dst);
+	dpaa2_fl_set_len(f_list, len);
+	dpaa2_fl_set_format(f_list, (fmt | QDMA_FL_SL_LONG));
+	/* single buffer frame or scatter gather frame */
+	dpaa2_fl_set_final(f_list, QDMA_FL_F);
+	/* bypass memory translation */
+	if (smmu_disable)
+		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
+}
+
+static struct dma_async_tx_descriptor
+*dpaa2_qdma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst,
+			dma_addr_t src, size_t len, ulong flags)
+{
+	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
+	struct dpaa2_qdma_engine *dpaa2_qdma;
+	struct dpaa2_qdma_comp *dpaa2_comp;
+	struct dpaa2_fl_entry *f_list;
+	bool wrt_changed;
+	u32 format;
+
+	dpaa2_qdma = dpaa2_chan->qdma;
+	dpaa2_comp = dpaa2_qdma_request_desc(dpaa2_chan);
+	wrt_changed = (bool)dpaa2_qdma->qdma_wrtype_fixup;
+
+#ifdef LONG_FORMAT
+	format = QDMA_FD_LONG_FORMAT;
+#else
+	format = QDMA_FD_SHORT_FORMAT;
+#endif
+	/* populate Frame descriptor */
+	dpaa2_qdma_populate_fd(format, dpaa2_comp);
+
+	f_list = (struct dpaa2_fl_entry *)dpaa2_comp->fl_virt_addr;
+
+#ifdef LONG_FORMAT
+	/* first frame list for descriptor buffer (logn format) */
+	dpaa2_qdma_populate_first_framel(f_list, dpaa2_comp, wrt_changed);
+
+	f_list++;
+#endif
+
+	dpaa2_qdma_populate_frames(f_list, dst, src, len, QDMA_FL_FMT_SBF);
+
+	return vchan_tx_prep(&dpaa2_chan->vchan, &dpaa2_comp->vdesc, flags);
+}
+
+static enum
+dma_status dpaa2_qdma_tx_status(struct dma_chan *chan,
+				dma_cookie_t cookie,
+				struct dma_tx_state *txstate)
+{
+	return dma_cookie_status(chan, cookie, txstate);
+}
+
+static void dpaa2_qdma_issue_pending(struct dma_chan *chan)
+{
+	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
+	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
+	struct dpaa2_qdma_priv *priv = dpaa2_qdma->priv;
+	struct dpaa2_qdma_comp *dpaa2_comp;
+	struct virt_dma_desc *vdesc;
+	struct dpaa2_fd *fd;
+	unsigned long flags;
+	int err;
+
+	spin_lock_irqsave(&dpaa2_chan->queue_lock, flags);
+	spin_lock(&dpaa2_chan->vchan.lock);
+	if (vchan_issue_pending(&dpaa2_chan->vchan)) {
+		vdesc = vchan_next_desc(&dpaa2_chan->vchan);
+		if (!vdesc)
+			goto err_enqueue;
+		dpaa2_comp = to_fsl_qdma_comp(vdesc);
+
+		fd = (struct dpaa2_fd *)dpaa2_comp->fd_virt_addr;
+
+		list_del(&vdesc->node);
+		list_add_tail(&dpaa2_comp->list, &dpaa2_chan->comp_used);
+
+		/* TOBO: priority hard-coded to zero */
+		err = dpaa2_io_service_enqueue_fq(NULL,
+				priv->tx_queue_attr[0].fqid, fd);
+		if (err) {
+			list_del(&dpaa2_comp->list);
+			list_add_tail(&dpaa2_comp->list,
+				      &dpaa2_chan->comp_free);
+		}
+	}
+err_enqueue:
+	spin_unlock(&dpaa2_chan->vchan.lock);
+	spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
+}
+
+static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
+{
+	struct dpaa2_qdma_priv_per_prio *ppriv;
+	struct device *dev = &ls_dev->dev;
+	struct dpaa2_qdma_priv *priv;
+	u8 prio_def = DPDMAI_PRIO_NUM;
+	int err;
+	int i;
+
+	priv = dev_get_drvdata(dev);
+
+	priv->dev = dev;
+	priv->dpqdma_id = ls_dev->obj_desc.id;
+
+	/*Get the handle for the DPDMAI this interface is associate with */
+	err = dpdmai_open(priv->mc_io, 0, priv->dpqdma_id, &ls_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpdmai_open() failed\n");
+		return err;
+	}
+	dev_info(dev, "Opened dpdmai object successfully\n");
+
+	err = dpdmai_get_attributes(priv->mc_io, 0, ls_dev->mc_handle,
+				    &priv->dpdmai_attr);
+	if (err) {
+		dev_err(dev, "dpdmai_get_attributes() failed\n");
+		return err;
+	}
+
+	if (priv->dpdmai_attr.version.major > DPDMAI_VER_MAJOR) {
+		dev_err(dev, "DPDMAI major version mismatch\n"
+			     "Found %u.%u, supported version is %u.%u\n",
+				priv->dpdmai_attr.version.major,
+				priv->dpdmai_attr.version.minor,
+				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);
+	}
+
+	if (priv->dpdmai_attr.version.minor > DPDMAI_VER_MINOR) {
+		dev_err(dev, "DPDMAI minor version mismatch\n"
+			     "Found %u.%u, supported version is %u.%u\n",
+				priv->dpdmai_attr.version.major,
+				priv->dpdmai_attr.version.minor,
+				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);
+	}
+
+	priv->num_pairs = min(priv->dpdmai_attr.num_of_priorities, prio_def);
+	ppriv = kcalloc(priv->num_pairs, sizeof(*ppriv), GFP_KERNEL);
+	if (!ppriv) {
+		dev_err(dev, "kzalloc for ppriv failed\n");
+		return -1;
+	}
+	priv->ppriv = ppriv;
+
+	for (i = 0; i < priv->num_pairs; i++) {
+		err = dpdmai_get_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
+					  i, &priv->rx_queue_attr[i]);
+		if (err) {
+			dev_err(dev, "dpdmai_get_rx_queue() failed\n");
+			return err;
+		}
+		ppriv->rsp_fqid = priv->rx_queue_attr[i].fqid;
+
+		err = dpdmai_get_tx_queue(priv->mc_io, 0, ls_dev->mc_handle,
+					  i, &priv->tx_queue_attr[i]);
+		if (err) {
+			dev_err(dev, "dpdmai_get_tx_queue() failed\n");
+			return err;
+		}
+		ppriv->req_fqid = priv->tx_queue_attr[i].fqid;
+		ppriv->prio = i;
+		ppriv->priv = priv;
+		ppriv++;
+	}
+
+	return 0;
+}
+
+static void dpaa2_qdma_fqdan_cb(struct dpaa2_io_notification_ctx *ctx)
+{
+	struct dpaa2_qdma_priv_per_prio *ppriv = container_of(ctx,
+			struct dpaa2_qdma_priv_per_prio, nctx);
+	struct dpaa2_qdma_comp *dpaa2_comp, *_comp_tmp;
+	struct dpaa2_qdma_priv *priv = ppriv->priv;
+	u32 n_chans = priv->dpaa2_qdma->n_chans;
+	struct dpaa2_qdma_chan *qchan;
+	const struct dpaa2_fd *fd_eq;
+	const struct dpaa2_fd *fd;
+	struct dpaa2_dq *dq;
+	int is_last = 0;
+	int found;
+	u8 status;
+	int err;
+	int i;
+
+	do {
+		err = dpaa2_io_service_pull_fq(NULL, ppriv->rsp_fqid,
+					       ppriv->store);
+	} while (err);
+
+	while (!is_last) {
+		do {
+			dq = dpaa2_io_store_next(ppriv->store, &is_last);
+		} while (!is_last && !dq);
+		if (!dq) {
+			dev_err(priv->dev, "FQID returned no valid frames!\n");
+			continue;
+		}
+
+		/* obtain FD and process the error */
+		fd = dpaa2_dq_fd(dq);
+
+		status = dpaa2_fd_get_ctrl(fd) & 0xff;
+		if (status)
+			dev_err(priv->dev, "FD error occurred\n");
+		found = 0;
+		for (i = 0; i < n_chans; i++) {
+			qchan = &priv->dpaa2_qdma->chans[i];
+			spin_lock(&qchan->queue_lock);
+			if (list_empty(&qchan->comp_used)) {
+				spin_unlock(&qchan->queue_lock);
+				continue;
+			}
+			list_for_each_entry_safe(dpaa2_comp, _comp_tmp,
+						 &qchan->comp_used, list) {
+				fd_eq = (struct dpaa2_fd *)
+					dpaa2_comp->fd_virt_addr;
+
+				if (le64_to_cpu(fd_eq->simple.addr) ==
+				    le64_to_cpu(fd->simple.addr)) {
+					spin_lock(&qchan->vchan.lock);
+					vchan_cookie_complete(&
+							dpaa2_comp->vdesc);
+					spin_unlock(&qchan->vchan.lock);
+					found = 1;
+					break;
+				}
+			}
+			spin_unlock(&qchan->queue_lock);
+			if (found)
+				break;
+		}
+	}
+
+	dpaa2_io_service_rearm(NULL, ctx);
+}
+
+static int __cold dpaa2_qdma_dpio_setup(struct dpaa2_qdma_priv *priv)
+{
+	struct dpaa2_qdma_priv_per_prio *ppriv;
+	struct device *dev = priv->dev;
+	int err, i, num;
+
+	num = priv->num_pairs;
+	ppriv = priv->ppriv;
+	for (i = 0; i < num; i++) {
+		ppriv->nctx.is_cdan = 0;
+		ppriv->nctx.desired_cpu = 1;
+		ppriv->nctx.id = ppriv->rsp_fqid;
+		ppriv->nctx.cb = dpaa2_qdma_fqdan_cb;
+		err = dpaa2_io_service_register(NULL, &ppriv->nctx);
+		if (err) {
+			dev_err(dev, "Notification register failed\n");
+			goto err_service;
+		}
+
+		ppriv->store =
+			dpaa2_io_store_create(DPAA2_QDMA_STORE_SIZE, dev);
+		if (!ppriv->store) {
+			dev_err(dev, "dpaa2_io_store_create() failed\n");
+			goto err_store;
+		}
+
+		ppriv++;
+	}
+	return 0;
+
+err_store:
+	dpaa2_io_service_deregister(NULL, &ppriv->nctx);
+err_service:
+	ppriv--;
+	while (ppriv >= priv->ppriv) {
+		dpaa2_io_service_deregister(NULL, &ppriv->nctx);
+		dpaa2_io_store_destroy(ppriv->store);
+		ppriv--;
+	}
+	return -1;
+}
+
+static void dpaa2_dpmai_store_free(struct dpaa2_qdma_priv *priv)
+{
+	struct dpaa2_qdma_priv_per_prio *ppriv = priv->ppriv;
+	int i;
+
+	for (i = 0; i < priv->num_pairs; i++) {
+		dpaa2_io_store_destroy(ppriv->store);
+		ppriv++;
+	}
+}
+
+static void dpaa2_dpdmai_dpio_free(struct dpaa2_qdma_priv *priv)
+{
+	struct dpaa2_qdma_priv_per_prio *ppriv = priv->ppriv;
+	int i;
+
+	for (i = 0; i < priv->num_pairs; i++) {
+		dpaa2_io_service_deregister(NULL, &ppriv->nctx);
+		ppriv++;
+	}
+}
+
+static int __cold dpaa2_dpdmai_bind(struct dpaa2_qdma_priv *priv)
+{
+	int err;
+	int i, num;
+	struct device *dev = priv->dev;
+	struct dpaa2_qdma_priv_per_prio *ppriv;
+	struct dpdmai_rx_queue_cfg rx_queue_cfg;
+	struct fsl_mc_device *ls_dev = to_fsl_mc_device(dev);
+
+	num = priv->num_pairs;
+	ppriv = priv->ppriv;
+	for (i = 0; i < num; i++) {
+		rx_queue_cfg.options = DPDMAI_QUEUE_OPT_USER_CTX |
+					DPDMAI_QUEUE_OPT_DEST;
+		rx_queue_cfg.user_ctx = ppriv->nctx.qman64;
+		rx_queue_cfg.dest_cfg.dest_type = DPDMAI_DEST_DPIO;
+		rx_queue_cfg.dest_cfg.dest_id = ppriv->nctx.dpio_id;
+		rx_queue_cfg.dest_cfg.priority = ppriv->prio;
+		err = dpdmai_set_rx_queue(priv->mc_io, 0, ls_dev->mc_handle,
+					  rx_queue_cfg.dest_cfg.priority,
+					  &rx_queue_cfg);
+		if (err) {
+			dev_err(dev, "dpdmai_set_rx_queue() failed\n");
+			return err;
+		}
+
+		ppriv++;
+	}
+
+	return 0;
+}
+
+static int __cold dpaa2_dpdmai_dpio_unbind(struct dpaa2_qdma_priv *priv)
+{
+	int i;
+	int err = 0;
+	struct device *dev = priv->dev;
+	struct fsl_mc_device *ls_dev = to_fsl_mc_device(dev);
+	struct dpaa2_qdma_priv_per_prio *ppriv = priv->ppriv;
+
+	for (i = 0; i < priv->num_pairs; i++) {
+		ppriv->nctx.qman64 = 0;
+		ppriv->nctx.dpio_id = 0;
+		ppriv++;
+	}
+
+	err = dpdmai_reset(priv->mc_io, 0, ls_dev->mc_handle);
+	if (err)
+		dev_err(dev, "dpdmai_reset() failed\n");
+
+	return err;
+}
+
+static void dpaa2_dpdmai_free_comp(struct dpaa2_qdma_chan *qchan,
+				   struct list_head *head)
+{
+	struct dpaa2_qdma_comp *comp_tmp, *_comp_tmp;
+
+	list_for_each_entry_safe(comp_tmp, _comp_tmp,
+				 head, list) {
+		dma_pool_free(qchan->fd_pool,
+			      comp_tmp->fd_virt_addr,
+			      comp_tmp->fd_bus_addr);
+		list_del(&comp_tmp->list);
+		kfree(comp_tmp);
+	}
+}
+
+static void dpaa2_dpdmai_free_channels(struct dpaa2_qdma_engine *dpaa2_qdma)
+{
+	struct dpaa2_qdma_chan *qchan;
+	int num, i;
+
+	num = dpaa2_qdma->n_chans;
+	for (i = 0; i < num; i++) {
+		qchan = &dpaa2_qdma->chans[i];
+		dpaa2_dpdmai_free_comp(qchan, &qchan->comp_used);
+		dpaa2_dpdmai_free_comp(qchan, &qchan->comp_free);
+		dma_pool_destroy(qchan->fd_pool);
+	}
+}
+
+static void dpaa2_qdma_free_desc(struct virt_dma_desc *vdesc)
+{
+	struct dpaa2_qdma_comp *dpaa2_comp;
+	struct dpaa2_qdma_chan *qchan;
+
+	dpaa2_comp = to_fsl_qdma_comp(vdesc);
+	qchan = dpaa2_comp->qchan;
+	list_del(&dpaa2_comp->list);
+	list_add_tail(&dpaa2_comp->list, &qchan->comp_free);
+}
+
+static int dpaa2_dpdmai_init_channels(struct dpaa2_qdma_engine *dpaa2_qdma)
+{
+	struct dpaa2_qdma_chan *dpaa2_chan;
+	int i;
+
+	INIT_LIST_HEAD(&dpaa2_qdma->dma_dev.channels);
+	for (i = 0; i < dpaa2_qdma->n_chans; i++) {
+		dpaa2_chan = &dpaa2_qdma->chans[i];
+		dpaa2_chan->qdma = dpaa2_qdma;
+		dpaa2_chan->vchan.desc_free = dpaa2_qdma_free_desc;
+		vchan_init(&dpaa2_chan->vchan, &dpaa2_qdma->dma_dev);
+		spin_lock_init(&dpaa2_chan->queue_lock);
+		INIT_LIST_HEAD(&dpaa2_chan->comp_used);
+		INIT_LIST_HEAD(&dpaa2_chan->comp_free);
+	}
+	return 0;
+}
+
+static int dpaa2_qdma_probe(struct fsl_mc_device *dpdmai_dev)
+{
+	struct dpaa2_qdma_priv *priv;
+	struct device *dev = &dpdmai_dev->dev;
+	struct dpaa2_qdma_engine *dpaa2_qdma;
+	int err;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	dev_set_drvdata(dev, priv);
+	priv->dpdmai_dev = dpdmai_dev;
+
+	priv->iommu_domain = iommu_get_domain_for_dev(dev);
+	if (priv->iommu_domain)
+		smmu_disable = false;
+
+	/* obtain a MC portal */
+	err = fsl_mc_portal_allocate(dpdmai_dev, 0, &priv->mc_io);
+	if (err) {
+		if (err == -ENXIO)
+			err = -EPROBE_DEFER;
+		else
+			dev_err(dev, "MC portal allocation failed\n");
+		goto err_mcportal;
+	}
+
+	/* DPDMAI initialization */
+	err = dpaa2_qdma_setup(dpdmai_dev);
+	if (err) {
+		dev_err(dev, "dpaa2_dpdmai_setup() failed\n");
+		goto err_dpdmai_setup;
+	}
+
+	/* DPIO */
+	err = dpaa2_qdma_dpio_setup(priv);
+	if (err) {
+		dev_err(dev, "dpaa2_dpdmai_dpio_setup() failed\n");
+		goto err_dpio_setup;
+	}
+
+	/* DPDMAI binding to DPIO */
+	err = dpaa2_dpdmai_bind(priv);
+	if (err) {
+		dev_err(dev, "dpaa2_dpdmai_bind() failed\n");
+		goto err_bind;
+	}
+
+	/* DPDMAI enable */
+	err = dpdmai_enable(priv->mc_io, 0, dpdmai_dev->mc_handle);
+	if (err) {
+		dev_err(dev, "dpdmai_enable() faile\n");
+		goto err_enable;
+	}
+
+	dpaa2_qdma = kzalloc(sizeof(*dpaa2_qdma), GFP_KERNEL);
+	if (!dpaa2_qdma) {
+		err = -ENOMEM;
+		goto err_eng;
+	}
+
+	priv->dpaa2_qdma = dpaa2_qdma;
+	dpaa2_qdma->priv = priv;
+
+	dpaa2_qdma->desc_allocated = 0;
+	dpaa2_qdma->n_chans = NUM_CH;
+
+	dpaa2_dpdmai_init_channels(dpaa2_qdma);
+
+	if (soc_device_match(soc_fixup_tuning))
+		dpaa2_qdma->qdma_wrtype_fixup = true;
+	else
+		dpaa2_qdma->qdma_wrtype_fixup = false;
+
+	dma_cap_set(DMA_PRIVATE, dpaa2_qdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_SLAVE, dpaa2_qdma->dma_dev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, dpaa2_qdma->dma_dev.cap_mask);
+
+	dpaa2_qdma->dma_dev.dev = dev;
+	dpaa2_qdma->dma_dev.device_alloc_chan_resources =
+		dpaa2_qdma_alloc_chan_resources;
+	dpaa2_qdma->dma_dev.device_free_chan_resources =
+		dpaa2_qdma_free_chan_resources;
+	dpaa2_qdma->dma_dev.device_tx_status = dpaa2_qdma_tx_status;
+	dpaa2_qdma->dma_dev.device_prep_dma_memcpy = dpaa2_qdma_prep_memcpy;
+	dpaa2_qdma->dma_dev.device_issue_pending = dpaa2_qdma_issue_pending;
+
+	err = dma_async_device_register(&dpaa2_qdma->dma_dev);
+	if (err) {
+		dev_err(dev, "Can't register NXP QDMA engine.\n");
+		goto err_eng;
+	}
+
+	return 0;
+
+err_eng:
+	dpdmai_disable(priv->mc_io, 0, dpdmai_dev->mc_handle);
+err_enable:
+	dpaa2_dpdmai_dpio_unbind(priv);
+err_bind:
+	dpaa2_dpmai_store_free(priv);
+	dpaa2_dpdmai_dpio_free(priv);
+err_dpio_setup:
+	dpdmai_close(priv->mc_io, 0, dpdmai_dev->mc_handle);
+err_dpdmai_setup:
+	fsl_mc_portal_free(priv->mc_io);
+err_mcportal:
+	kfree(priv->ppriv);
+	kfree(priv);
+	dev_set_drvdata(dev, NULL);
+	return err;
+}
+
+static int dpaa2_qdma_remove(struct fsl_mc_device *ls_dev)
+{
+	struct device *dev;
+	struct dpaa2_qdma_priv *priv;
+	struct dpaa2_qdma_engine *dpaa2_qdma;
+
+	dev = &ls_dev->dev;
+	priv = dev_get_drvdata(dev);
+	dpaa2_qdma = priv->dpaa2_qdma;
+
+	dpdmai_disable(priv->mc_io, 0, ls_dev->mc_handle);
+	dpaa2_dpdmai_dpio_unbind(priv);
+	dpaa2_dpmai_store_free(priv);
+	dpaa2_dpdmai_dpio_free(priv);
+	dpdmai_close(priv->mc_io, 0, ls_dev->mc_handle);
+	fsl_mc_portal_free(priv->mc_io);
+	dev_set_drvdata(dev, NULL);
+	dpaa2_dpdmai_free_channels(dpaa2_qdma);
+
+	dma_async_device_unregister(&dpaa2_qdma->dma_dev);
+	kfree(priv);
+	kfree(dpaa2_qdma);
+
+	return 0;
+}
+
+static const struct fsl_mc_device_id dpaa2_qdma_id_table[] = {
+	{
+		.vendor = FSL_MC_VENDOR_FREESCALE,
+		.obj_type = "dpdmai",
+	},
+	{ .vendor = 0x0 }
+};
+
+static struct fsl_mc_driver dpaa2_qdma_driver = {
+	.driver		= {
+		.name	= "dpaa2-qdma",
+		.owner  = THIS_MODULE,
+	},
+	.probe          = dpaa2_qdma_probe,
+	.remove		= dpaa2_qdma_remove,
+	.match_id_table	= dpaa2_qdma_id_table
+};
+
+static int __init dpaa2_qdma_driver_init(void)
+{
+	return fsl_mc_driver_register(&(dpaa2_qdma_driver));
+}
+late_initcall(dpaa2_qdma_driver_init);
+
+static void __exit fsl_qdma_exit(void)
+{
+	fsl_mc_driver_unregister(&(dpaa2_qdma_driver));
+}
+module_exit(fsl_qdma_exit);
+
+MODULE_ALIAS("platform:fsl-dpaa2-qdma");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("NXP Layerscape DPAA2 qDMA engine driver");
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
new file mode 100644
index 0000000..3fcade8
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2014-2018 NXP */
+
+#ifndef __DPAA2_QDMA_H
+#define __DPAA2_QDMA_H
+
+#define LONG_FORMAT 1
+
+#define DPAA2_QDMA_STORE_SIZE 16
+#define NUM_CH 8
+
+struct dpaa2_qdma_sd_d {
+	u32 rsv:32;
+	union {
+		struct {
+			u32 ssd:12; /* souce stride distance */
+			u32 sss:12; /* souce stride size */
+			u32 rsv1:8;
+		} sdf;
+		struct {
+			u32 dsd:12; /* Destination stride distance */
+			u32 dss:12; /* Destination stride size */
+			u32 rsv2:8;
+		} ddf;
+	} df;
+	u32 rbpcmd;	/* Route-by-port command */
+	u32 cmd;
+} __attribute__((__packed__));
+
+/* Source descriptor command read transaction type for RBP=0: */
+/* coherent copy of cacheable memory */
+#define QDMA_SD_CMD_RDTTYPE_COHERENT (0xb << 28)
+/* Destination descriptor command write transaction type for RBP=0: */
+/* coherent copy of cacheable memory */
+#define QDMA_DD_CMD_WRTTYPE_COHERENT (0x6 << 28)
+#define LX2160_QDMA_DD_CMD_WRTTYPE_COHERENT (0xb << 28)
+
+#define QMAN_FD_FMT_ENABLE	BIT(0) /* frame list table enable */
+#define QMAN_FD_BMT_ENABLE	BIT(15) /* bypass memory translation */
+#define QMAN_FD_BMT_DISABLE	(0) /* bypass memory translation */
+#define QMAN_FD_SL_DISABLE	(0) /* short lengthe disabled */
+#define QMAN_FD_SL_ENABLE	BIT(14) /* short lengthe enabled */
+
+#define QDMA_FINAL_BIT_DISABLE	(0) /* final bit disable */
+#define QDMA_FINAL_BIT_ENABLE	BIT(31) /* final bit enable */
+
+#define QDMA_FD_SHORT_FORMAT	BIT(11) /* short format */
+#define QDMA_FD_LONG_FORMAT	(0) /* long format */
+#define QDMA_SER_DISABLE	(8) /* no notification */
+#define QDMA_SER_CTX		BIT(8) /* notification by FQD_CTX[fqid] */
+#define QDMA_SER_DEST		(2 << 8) /* notification by destination desc */
+#define QDMA_SER_BOTH		(3 << 8) /* soruce and dest notification */
+#define QDMA_FD_SPF_ENALBE	BIT(30) /* source prefetch enable */
+
+#define QMAN_FD_VA_ENABLE	BIT(14) /* Address used is virtual address */
+#define QMAN_FD_VA_DISABLE	(0)/* Address used is a real address */
+/* Flow Context: 49bit physical address */
+#define QMAN_FD_CBMT_ENABLE	BIT(15)
+#define QMAN_FD_CBMT_DISABLE	(0) /* Flow Context: 64bit virtual address */
+#define QMAN_FD_SC_DISABLE	(0) /* stashing control */
+
+#define QDMA_FL_FMT_SBF		(0x0) /* Single buffer frame */
+#define QDMA_FL_FMT_SGE		(0x2) /* Scatter gather frame */
+#define QDMA_FL_BMT_ENABLE	BIT(15) /* enable bypass memory translation */
+#define QDMA_FL_BMT_DISABLE	(0x0) /* enable bypass memory translation */
+#define QDMA_FL_SL_LONG		(0x0)/* long length */
+#define QDMA_FL_SL_SHORT	(0x1) /* short length */
+#define QDMA_FL_F		(0x1)/* last frame list bit */
+
+/*Description of Frame list table structure*/
+struct dpaa2_qdma_chan {
+	struct virt_dma_chan		vchan;
+	struct virt_dma_desc		vdesc;
+	enum dma_status			status;
+	struct dpaa2_qdma_engine	*qdma;
+
+	struct mutex			dpaa2_queue_mutex;
+	spinlock_t			queue_lock;
+	struct dma_pool			*fd_pool;
+
+	struct list_head		comp_used;
+	struct list_head		comp_free;
+
+};
+
+struct dpaa2_qdma_comp {
+	dma_addr_t		fd_bus_addr;
+	dma_addr_t		fl_bus_addr;
+	dma_addr_t		desc_bus_addr;
+	void			*fd_virt_addr;
+	void			*fl_virt_addr;
+	void			*desc_virt_addr;
+	struct dpaa2_qdma_chan	*qchan;
+	struct virt_dma_desc	vdesc;
+	struct list_head	list;
+};
+
+struct dpaa2_qdma_engine {
+	struct dma_device	dma_dev;
+	u32			n_chans;
+	struct dpaa2_qdma_chan	chans[NUM_CH];
+	int			qdma_wrtype_fixup;
+	int			desc_allocated;
+
+	struct dpaa2_qdma_priv *priv;
+};
+
+/*
+ * dpaa2_qdma_priv - driver private data
+ */
+struct dpaa2_qdma_priv {
+	int dpqdma_id;
+
+	struct iommu_domain	*iommu_domain;
+	struct dpdmai_attr	dpdmai_attr;
+	struct device		*dev;
+	struct fsl_mc_io	*mc_io;
+	struct fsl_mc_device	*dpdmai_dev;
+	u8			num_pairs;
+
+	struct dpaa2_qdma_engine	*dpaa2_qdma;
+	struct dpaa2_qdma_priv_per_prio	*ppriv;
+
+	struct dpdmai_rx_queue_attr rx_queue_attr[DPDMAI_PRIO_NUM];
+	struct dpdmai_tx_queue_attr tx_queue_attr[DPDMAI_PRIO_NUM];
+};
+
+struct dpaa2_qdma_priv_per_prio {
+	int req_fqid;
+	int rsp_fqid;
+	int prio;
+
+	struct dpaa2_io_store *store;
+	struct dpaa2_io_notification_ctx nctx;
+
+	struct dpaa2_qdma_priv *priv;
+};
+
+static struct soc_device_attribute soc_fixup_tuning[] = {
+	{ .family = "QorIQ LX2160A"},
+	{ },
+};
+
+/* FD pool size: one FD + 3 Frame list + 2 source/destination descriptor */
+#define FD_POOL_SIZE (sizeof(struct dpaa2_fd) + \
+		sizeof(struct dpaa2_fl_entry) * 3 + \
+		sizeof(struct dpaa2_qdma_sd_d) * 2)
+
+static void dpaa2_dpdmai_free_channels(struct dpaa2_qdma_engine *dpaa2_qdma);
+static void dpaa2_dpdmai_free_comp(struct dpaa2_qdma_chan *qchan,
+				   struct list_head *head);
+#endif /* __DPAA2_QDMA_H */
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
new file mode 100644
index 0000000..175f4f4
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -0,0 +1,483 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright 2014-2018 NXP
+
+#include <linux/types.h>
+#include <linux/io.h>
+#include "fsl_dpdmai.h"
+#include "fsl_dpdmai_cmd.h"
+#include <linux/fsl/mc.h>
+
+struct dpdmai_cmd_open {
+	__le32 dpdmai_id;
+};
+
+struct dpdmai_rsp_get_attributes {
+	__le32 id;
+	u8 num_of_priorities;
+	u8 pad0[3];
+	__le16 major;
+	__le16 minor;
+};
+
+struct dpdmai_cmd_queue {
+	__le32 dest_id;
+	u8 priority;
+	u8 queue;
+	u8 dest_type;
+	u8 pad;
+	__le64 user_ctx;
+	union {
+		__le32 options;
+		__le32 fqid;
+	};
+};
+
+struct dpdmai_rsp_get_tx_queue {
+	__le64 pad;
+	__le32 fqid;
+};
+
+int dpdmai_open(struct fsl_mc_io *mc_io,
+		u32 cmd_flags,
+		int dpdmai_id,
+		u16 *token)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_open *cmd_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_OPEN,
+					  cmd_flags,
+					  0);
+
+	cmd_params = (struct dpdmai_cmd_open *)cmd.params;
+	cmd_params->dpdmai_id = cpu_to_le32(dpdmai_id);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = mc_cmd_hdr_read_token(&cmd);
+	return 0;
+}
+
+int dpdmai_close(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CLOSE,
+					  cmd_flags, token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_create(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  const struct dpdmai_cfg *cfg,
+		  u16 *token)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CREATE,
+					  cmd_flags,
+					  0);
+	DPDMAI_CMD_CREATE(cmd, cfg);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	*token = MC_CMD_HDR_READ_TOKEN(cmd.header);
+
+	return 0;
+}
+
+int dpdmai_destroy(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_enable(struct fsl_mc_io *mc_io,
+		  u32 cmd_flags,
+		  u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_ENABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_disable(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DISABLE,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_is_enabled(struct fsl_mc_io *mc_io,
+		      u32 cmd_flags,
+		      u16 token,
+		      int *en)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_IS_ENABLED,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_IS_ENABLED(cmd, *en);
+
+	return 0;
+}
+
+int dpdmai_reset(struct fsl_mc_io *mc_io,
+		 u32 cmd_flags,
+		 u16 token)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_RESET,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u8 irq_index,
+		   int *type,
+		   struct dpdmai_irq_cfg	*irq_cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ(cmd, *type, irq_cfg);
+
+	return 0;
+}
+
+int dpdmai_set_irq(struct fsl_mc_io *mc_io,
+		   u32 cmd_flags,
+		   u16 token,
+		   u8 irq_index,
+		   struct dpdmai_irq_cfg *irq_cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ(cmd, irq_index, irq_cfg);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_enable(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u8 *en)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_ENABLE,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_ENABLE(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_ENABLE(cmd, *en);
+
+	return 0;
+}
+
+int dpdmai_set_irq_enable(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u8 en)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ_ENABLE,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ_ENABLE(cmd, irq_index, en);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_mask(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 *mask)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_MASK,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_MASK(cmd, irq_index);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_MASK(cmd, *mask);
+
+	return 0;
+}
+
+int dpdmai_set_irq_mask(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 irq_index,
+			u32 mask)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_IRQ_MASK,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_SET_IRQ_MASK(cmd, irq_index, mask);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_irq_status(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  u8 irq_index,
+			  u32 *status)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_GET_IRQ_STATUS(cmd, irq_index, *status);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	DPDMAI_RSP_GET_IRQ_STATUS(cmd, *status);
+
+	return 0;
+}
+
+int dpdmai_clear_irq_status(struct fsl_mc_io *mc_io,
+			    u32 cmd_flags,
+			    u16 token,
+			    u8 irq_index,
+			    u32 status)
+{
+	struct fsl_mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CLEAR_IRQ_STATUS,
+					  cmd_flags,
+					  token);
+	DPDMAI_CMD_CLEAR_IRQ_STATUS(cmd, irq_index, status);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
+			  u32 cmd_flags,
+			  u16 token,
+			  struct dpdmai_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	int err;
+	struct dpdmai_rsp_get_attributes *rsp_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_ATTR,
+					  cmd_flags,
+					  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpdmai_rsp_get_attributes *)cmd.params;
+	attr->id = le32_to_cpu(rsp_params->id);
+	attr->version.major = le16_to_cpu(rsp_params->major);
+	attr->version.minor = le16_to_cpu(rsp_params->minor);
+	attr->num_of_priorities = rsp_params->num_of_priorities;
+
+	return 0;
+}
+
+int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority,
+			const struct dpdmai_rx_queue_cfg *cfg)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_RX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->dest_id = cpu_to_le32(cfg->dest_cfg.dest_id);
+	cmd_params->priority = cfg->dest_cfg.priority;
+	cmd_params->queue = priority;
+	cmd_params->dest_type = cfg->dest_cfg.dest_type;
+	cmd_params->user_ctx = cpu_to_le64(cfg->user_ctx);
+	cmd_params->options = cpu_to_le32(cfg->options);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority, struct dpdmai_rx_queue_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_RX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->queue = priority;
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	attr->dest_cfg.dest_id = le32_to_cpu(cmd_params->dest_id);
+	attr->dest_cfg.priority = cmd_params->priority;
+	attr->dest_cfg.dest_type = cmd_params->dest_type;
+	attr->user_ctx = le64_to_cpu(cmd_params->user_ctx);
+	attr->fqid = le32_to_cpu(cmd_params->fqid);
+
+	return 0;
+}
+
+int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io,
+			u32 cmd_flags,
+			u16 token,
+			u8 priority,
+			struct dpdmai_tx_queue_attr *attr)
+{
+	struct fsl_mc_command cmd = { 0 };
+	struct dpdmai_cmd_queue *cmd_params;
+	struct dpdmai_rsp_get_tx_queue *rsp_params;
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_GET_TX_QUEUE,
+					  cmd_flags,
+					  token);
+
+	cmd_params = (struct dpdmai_cmd_queue *)cmd.params;
+	cmd_params->queue = priority;
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+
+	rsp_params = (struct dpdmai_rsp_get_tx_queue *)cmd.params;
+	attr->fqid = le32_to_cpu(rsp_params->fqid);
+
+	return 0;
+}
diff --git a/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h b/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h
new file mode 100644
index 0000000..c8a7b7f
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai.h
@@ -0,0 +1,524 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2014-2018 NXP */
+
+/*
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ * * Neither the name of the above-listed copyright holders nor the
+ * names of any contributors may be used to endorse or promote products
+ * derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+#ifndef __FSL_DPDMAI_H
+#define __FSL_DPDMAI_H
+
+struct fsl_mc_io;
+
+/* Data Path DMA Interface API
+ * Contains initialization APIs and runtime control APIs for DPDMAI
+ */
+
+/* General DPDMAI macros */
+
+/**
+ * Maximum number of Tx/Rx priorities per DPDMAI object
+ */
+#define DPDMAI_PRIO_NUM		2
+
+/**
+ * All queues considered; see dpdmai_set_rx_queue()
+ */
+#define DPDMAI_ALL_QUEUES	(u8)(-1)
+
+/**
+ * dpdmai_open() - Open a control session for the specified object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @dpdmai_id:	DPDMAI unique ID
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * This function can be used to open a control session for an
+ * already created object; an object may have been declared in
+ * the DPL or by calling the dpdmai_create() function.
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent commands for
+ * this specific object.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_open(struct fsl_mc_io	*mc_io,
+		u32		cmd_flags,
+		int			dpdmai_id,
+		u16		*token);
+
+/**
+ * dpdmai_close() - Close the control session of the object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * After this function is called, no further operations are
+ * allowed on the object without opening a new control session.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_close(struct fsl_mc_io	*mc_io,
+		 u32		cmd_flags,
+		 u16		token);
+
+/**
+ * struct dpdmai_cfg - Structure representing DPDMAI configuration
+ * @priorities: Priorities for the DMA hardware processing; valid priorities are
+ *	configured with values 1-8; the entry following last valid entry
+ *	should be configured with 0
+ */
+struct dpdmai_cfg {
+	u8 priorities[DPDMAI_PRIO_NUM];
+};
+
+/**
+ * dpdmai_create() - Create the DPDMAI object
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @cfg:	Configuration structure
+ * @token:	Returned token; use in subsequent API calls
+ *
+ * Create the DPDMAI object, allocate required resources and
+ * perform required initialization.
+ *
+ * The object can be created either by declaring it in the
+ * DPL file, or by calling this function.
+ *
+ * This function returns a unique authentication token,
+ * associated with the specific object ID and the specific MC
+ * portal; this token must be used in all subsequent calls to
+ * this specific object. For objects that are created using the
+ * DPL file, call dpdmai_open() function to get an authentication
+ * token first.
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_create(struct fsl_mc_io		*mc_io,
+		  u32			cmd_flags,
+		  const struct dpdmai_cfg	*cfg,
+		  u16			*token);
+
+/**
+ * dpdmai_destroy() - Destroy the DPDMAI object and release all its resources.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; error code otherwise.
+ */
+int dpdmai_destroy(struct fsl_mc_io	*mc_io,
+		   u32		cmd_flags,
+		   u16		token);
+
+/**
+ * dpdmai_enable() - Enable the DPDMAI, allow sending and receiving frames.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_enable(struct fsl_mc_io	*mc_io,
+		  u32		cmd_flags,
+		  u16		token);
+
+/**
+ * dpdmai_disable() - Disable the DPDMAI, stop sending and receiving frames.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_disable(struct fsl_mc_io	*mc_io,
+		   u32		cmd_flags,
+		   u16		token);
+
+/**
+ * dpdmai_is_enabled() - Check if the DPDMAI is enabled.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @en:		Returns '1' if object is enabled; '0' otherwise
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_is_enabled(struct fsl_mc_io	*mc_io,
+		      u32		cmd_flags,
+		      u16		token,
+		      int		*en);
+
+/**
+ * dpdmai_reset() - Reset the DPDMAI, returns the object to initial state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_reset(struct fsl_mc_io	*mc_io,
+		 u32		cmd_flags,
+		 u16		token);
+
+/**
+ * struct dpdmai_irq_cfg - IRQ configuration
+ * @addr:	Address that must be written to signal a message-based interrupt
+ * @val:	Value to write into irq_addr address
+ * @irq_num: A user defined number associated with this IRQ
+ */
+struct dpdmai_irq_cfg {
+	u64	addr;
+	u32	val;
+	int		irq_num;
+};
+
+/**
+ * dpdmai_set_irq() - Set IRQ information for the DPDMAI to trigger
+ * an interrupt.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	Identifies the interrupt index to configure
+ * @irq_cfg:	IRQ configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq(struct fsl_mc_io		*mc_io,
+		   u32			cmd_flags,
+		   u16			token,
+		   u8			irq_index,
+		   struct dpdmai_irq_cfg	*irq_cfg);
+
+/**
+ * dpdmai_get_irq() - Get IRQ information from the DPDMAI
+ *
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @type:	Interrupt type: 0 represents message interrupt
+ *		type (both irq_addr and irq_val are valid)
+ * @irq_cfg:	IRQ attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq(struct fsl_mc_io		*mc_io,
+		   u32			cmd_flags,
+		   u16			token,
+		   u8			irq_index,
+		   int				*type,
+		   struct dpdmai_irq_cfg	*irq_cfg);
+
+/**
+ * dpdmai_set_irq_enable() - Set overall interrupt state.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @en:			Interrupt state - enable = 1, disable = 0
+ *
+ * Allows GPP software to control when interrupts are generated.
+ * Each interrupt can have up to 32 causes.  The enable/disable control's the
+ * overall interrupt state. if the interrupt is disabled no causes will cause
+ * an interrupt
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq_enable(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u8		en);
+
+/**
+ * dpdmai_get_irq_enable() - Get overall interrupt state
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @en:			Returned Interrupt state - enable = 1, disable = 0
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_enable(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u8		*en);
+
+/**
+ * dpdmai_set_irq_mask() - Set interrupt mask.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @mask:		event mask to trigger interrupt;
+ *				each bit:
+ *					0 = ignore event
+ *					1 = consider event for asserting IRQ
+ *
+ * Every interrupt can have up to 32 causes and the interrupt model supports
+ * masking/unmasking each cause independently
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_irq_mask(struct fsl_mc_io	*mc_io,
+			u32		cmd_flags,
+			u16		token,
+			u8		irq_index,
+			u32		mask);
+
+/**
+ * dpdmai_get_irq_mask() - Get interrupt mask.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @mask:		Returned event mask to trigger interrupt
+ *
+ * Every interrupt can have up to 32 causes and the interrupt model supports
+ * masking/unmasking each cause independently
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_mask(struct fsl_mc_io	*mc_io,
+			u32		cmd_flags,
+			u16		token,
+			u8		irq_index,
+			u32		*mask);
+
+/**
+ * dpdmai_get_irq_status() - Get the current status of any pending interrupts
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:		Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @status:		Returned interrupts status - one bit per cause:
+ *					0 = no interrupt pending
+ *					1 = interrupt pending
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_irq_status(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  u8		irq_index,
+			  u32		*status);
+
+/**
+ * dpdmai_clear_irq_status() - Clear a pending interrupt's status
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @irq_index:	The interrupt index to configure
+ * @status:	bits to clear (W1C) - one bit per cause:
+ *			0 = don't change
+ *			1 = clear status bit
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_clear_irq_status(struct fsl_mc_io	*mc_io,
+			    u32		cmd_flags,
+			    u16		token,
+			    u8		irq_index,
+			    u32		status);
+
+/**
+ * struct dpdmai_attr - Structure representing DPDMAI attributes
+ * @id: DPDMAI object ID
+ * @version: DPDMAI version
+ * @num_of_priorities: number of priorities
+ */
+struct dpdmai_attr {
+	int	id;
+	/**
+	 * struct version - DPDMAI version
+	 * @major: DPDMAI major version
+	 * @minor: DPDMAI minor version
+	 */
+	struct {
+		u16 major;
+		u16 minor;
+	} version;
+	u8 num_of_priorities;
+};
+
+/**
+ * dpdmai_get_attributes() - Retrieve DPDMAI attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @attr:	Returned object's attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_attributes(struct fsl_mc_io	*mc_io,
+			  u32		cmd_flags,
+			  u16		token,
+			  struct dpdmai_attr	*attr);
+
+/**
+ * enum dpdmai_dest - DPDMAI destination types
+ * @DPDMAI_DEST_NONE: Unassigned destination; The queue is set in parked mode
+ *	and does not generate FQDAN notifications; user is expected to dequeue
+ *	from the queue based on polling or other user-defined method
+ * @DPDMAI_DEST_DPIO: The queue is set in schedule mode and generates FQDAN
+ *	notifications to the specified DPIO; user is expected to dequeue
+ *	from the queue only after notification is received
+ * @DPDMAI_DEST_DPCON: The queue is set in schedule mode and does not generate
+ *	FQDAN notifications, but is connected to the specified DPCON object;
+ *	user is expected to dequeue from the DPCON channel
+ */
+enum dpdmai_dest {
+	DPDMAI_DEST_NONE = 0,
+	DPDMAI_DEST_DPIO = 1,
+	DPDMAI_DEST_DPCON = 2
+};
+
+/**
+ * struct dpdmai_dest_cfg - Structure representing DPDMAI destination parameters
+ * @dest_type: Destination type
+ * @dest_id: Either DPIO ID or DPCON ID, depending on the destination type
+ * @priority: Priority selection within the DPIO or DPCON channel; valid values
+ *	are 0-1 or 0-7, depending on the number of priorities in that
+ *	channel; not relevant for 'DPDMAI_DEST_NONE' option
+ */
+struct dpdmai_dest_cfg {
+	enum dpdmai_dest	dest_type;
+	int			dest_id;
+	u8		priority;
+};
+
+/* DPDMAI queue modification options */
+
+/**
+ * Select to modify the user's context associated with the queue
+ */
+#define DPDMAI_QUEUE_OPT_USER_CTX	0x00000001
+
+/**
+ * Select to modify the queue's destination
+ */
+#define DPDMAI_QUEUE_OPT_DEST		0x00000002
+
+/**
+ * struct dpdmai_rx_queue_cfg - DPDMAI RX queue configuration
+ * @options: Flags representing the suggested modifications to the queue;
+ *	Use any combination of 'DPDMAI_QUEUE_OPT_<X>' flags
+ * @user_ctx: User context value provided in the frame descriptor of each
+ *	dequeued frame;
+ *	valid only if 'DPDMAI_QUEUE_OPT_USER_CTX' is contained in 'options'
+ * @dest_cfg: Queue destination parameters;
+ *	valid only if 'DPDMAI_QUEUE_OPT_DEST' is contained in 'options'
+ */
+struct dpdmai_rx_queue_cfg {
+	u32		options;
+	u64		user_ctx;
+	struct dpdmai_dest_cfg	dest_cfg;
+
+};
+
+/**
+ * dpdmai_set_rx_queue() - Set Rx queue configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *			priorities configured at DPDMAI creation; use
+ *			DPDMAI_ALL_QUEUES to configure all Rx queues
+ *			identically.
+ * @cfg:	Rx queue configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_set_rx_queue(struct fsl_mc_io			*mc_io,
+			u32				cmd_flags,
+			u16				token,
+			u8					priority,
+			const struct dpdmai_rx_queue_cfg	*cfg);
+
+/**
+ * struct dpdmai_rx_queue_attr - Structure representing attributes of Rx queues
+ * @user_ctx:  User context value provided in the frame descriptor of each
+ *	 dequeued frame
+ * @dest_cfg: Queue destination configuration
+ * @fqid: Virtual FQID value to be used for dequeue operations
+ */
+struct dpdmai_rx_queue_attr {
+	u64		user_ctx;
+	struct dpdmai_dest_cfg	dest_cfg;
+	u32		fqid;
+};
+
+/**
+ * dpdmai_get_rx_queue() - Retrieve Rx queue attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *				priorities configured at DPDMAI creation
+ * @attr:	Returned Rx queue attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_rx_queue(struct fsl_mc_io		*mc_io,
+			u32			cmd_flags,
+			u16			token,
+			u8				priority,
+			struct dpdmai_rx_queue_attr	*attr);
+
+/**
+ * struct dpdmai_tx_queue_attr - Structure representing attributes of Tx queues
+ * @fqid: Virtual FQID to be used for sending frames to DMA hardware
+ */
+
+struct dpdmai_tx_queue_attr {
+	u32 fqid;
+};
+
+/**
+ * dpdmai_get_tx_queue() - Retrieve Tx queue attributes.
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPDMAI object
+ * @priority:	Select the queue relative to number of
+ *			priorities configured at DPDMAI creation
+ * @attr:	Returned Tx queue attributes
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+int dpdmai_get_tx_queue(struct fsl_mc_io		*mc_io,
+			u32			cmd_flags,
+			u16			token,
+			u8				priority,
+			struct dpdmai_tx_queue_attr	*attr);
+
+#endif /* __FSL_DPDMAI_H */
diff --git a/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h b/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h
new file mode 100644
index 0000000..071a1a7
--- /dev/null
+++ b/drivers/dma/fsl-dpaa2-qdma/fsl_dpdmai_cmd.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2014-2018 NXP */
+
+#ifndef _FSL_DPDMAI_CMD_H
+#define _FSL_DPDMAI_CMD_H
+
+/* DPDMAI Version */
+#define DPDMAI_VER_MAJOR		2
+#define DPDMAI_VER_MINOR		2
+
+#define DPDMAI_CMD_BASE_VERSION		0
+#define DPDMAI_CMD_ID_OFFSET		4
+
+#define DPDMAI_CMDID_FORMAT(x)		(((x) << DPDMAI_CMD_ID_OFFSET) | \
+					DPDMAI_CMD_BASE_VERSION)
+
+/* Command IDs */
+#define DPDMAI_CMDID_CLOSE		DPDMAI_CMDID_FORMAT(0x800)
+#define DPDMAI_CMDID_OPEN               DPDMAI_CMDID_FORMAT(0x80E)
+#define DPDMAI_CMDID_CREATE             DPDMAI_CMDID_FORMAT(0x90E)
+#define DPDMAI_CMDID_DESTROY            DPDMAI_CMDID_FORMAT(0x900)
+
+#define DPDMAI_CMDID_ENABLE             DPDMAI_CMDID_FORMAT(0x002)
+#define DPDMAI_CMDID_DISABLE            DPDMAI_CMDID_FORMAT(0x003)
+#define DPDMAI_CMDID_GET_ATTR           DPDMAI_CMDID_FORMAT(0x004)
+#define DPDMAI_CMDID_RESET              DPDMAI_CMDID_FORMAT(0x005)
+#define DPDMAI_CMDID_IS_ENABLED         DPDMAI_CMDID_FORMAT(0x006)
+
+#define DPDMAI_CMDID_SET_IRQ            DPDMAI_CMDID_FORMAT(0x010)
+#define DPDMAI_CMDID_GET_IRQ            DPDMAI_CMDID_FORMAT(0x011)
+#define DPDMAI_CMDID_SET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x012)
+#define DPDMAI_CMDID_GET_IRQ_ENABLE     DPDMAI_CMDID_FORMAT(0x013)
+#define DPDMAI_CMDID_SET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x014)
+#define DPDMAI_CMDID_GET_IRQ_MASK       DPDMAI_CMDID_FORMAT(0x015)
+#define DPDMAI_CMDID_GET_IRQ_STATUS     DPDMAI_CMDID_FORMAT(0x016)
+#define DPDMAI_CMDID_CLEAR_IRQ_STATUS	DPDMAI_CMDID_FORMAT(0x017)
+
+#define DPDMAI_CMDID_SET_RX_QUEUE	DPDMAI_CMDID_FORMAT(0x1A0)
+#define DPDMAI_CMDID_GET_RX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A1)
+#define DPDMAI_CMDID_GET_TX_QUEUE       DPDMAI_CMDID_FORMAT(0x1A2)
+
+#define MC_CMD_HDR_TOKEN_O 32  /* Token field offset */
+#define MC_CMD_HDR_TOKEN_S 16  /* Token field size */
+
+#define MAKE_UMASK64(_width) \
+	((u64)((_width) < 64 ? ((u64)1 << (_width)) - 1 : \
+	(u64)-1)) \
+
+static inline u64 mc_enc(int lsoffset, int width, u64 val)
+{
+	return (u64)(((u64)val & MAKE_UMASK64(width)) << lsoffset);
+}
+
+static inline u64 mc_dec(u64 val, int lsoffset, int width)
+{
+	return (u64)((val >> lsoffset) & MAKE_UMASK64(width));
+}
+
+#define MC_CMD_OP(_cmd, _param, _offset, _width, _type, _arg) \
+	((_cmd).params[_param] |= mc_enc((_offset), (_width), _arg))
+
+#define MC_RSP_OP(_cmd, _param, _offset, _width, _type, _arg) \
+	(_arg = (_type)mc_dec(_cmd.params[_param], (_offset), (_width)))
+
+#define MC_CMD_HDR_READ_TOKEN(_hdr) \
+	((u16)mc_dec((_hdr), MC_CMD_HDR_TOKEN_O, MC_CMD_HDR_TOKEN_S))
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_OPEN(cmd, dpdmai_id) \
+	MC_CMD_OP(cmd, 0, 0,  32, int,      dpdmai_id)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_CREATE(cmd, cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 8,  8,  u8,  (cfg)->priorities[0]);\
+	MC_CMD_OP(cmd, 0, 16, 8,  u8,  (cfg)->priorities[1]);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_IS_ENABLED(cmd, en) \
+	MC_RSP_OP(cmd, 0, 0,  1,  int,	    en)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ(cmd, irq_index, irq_cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  8,  u8,  irq_index);\
+	MC_CMD_OP(cmd, 0, 32, 32, u32, irq_cfg->val);\
+	MC_CMD_OP(cmd, 1, 0,  64, u64, irq_cfg->addr);\
+	MC_CMD_OP(cmd, 2, 0,  32, int,	    irq_cfg->irq_num); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ(cmd, type, irq_cfg) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, u32, irq_cfg->val); \
+	MC_RSP_OP(cmd, 1, 0,  64, u64, irq_cfg->addr);\
+	MC_RSP_OP(cmd, 2, 0,  32, int,	    irq_cfg->irq_num); \
+	MC_RSP_OP(cmd, 2, 32, 32, int,	    type); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ_ENABLE(cmd, irq_index, enable_state) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  8,  u8,  enable_state); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_ENABLE(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_ENABLE(cmd, enable_state) \
+	MC_RSP_OP(cmd, 0, 0,  8,  u8,  enable_state)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_IRQ_MASK(cmd, irq_index, mask) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, mask); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_MASK(cmd, irq_index) \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_MASK(cmd, mask) \
+	MC_RSP_OP(cmd, 0, 0,  32, u32, mask)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_IRQ_STATUS(cmd, irq_index, status) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, status);\
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_IRQ_STATUS(cmd, status) \
+	MC_RSP_OP(cmd, 0, 0,  32, u32,  status)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_CLEAR_IRQ_STATUS(cmd, irq_index, status) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, u32, status); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,  irq_index); \
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_ATTR(cmd, attr) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, int,	(attr)->id); \
+	MC_RSP_OP(cmd, 0, 32,  8,  u8,	(attr)->num_of_priorities); \
+	MC_RSP_OP(cmd, 1, 0,  16, u16,	(attr)->version.major);\
+	MC_RSP_OP(cmd, 1, 16, 16, u16,	(attr)->version.minor);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_SET_RX_QUEUE(cmd, priority, cfg) \
+do { \
+	MC_CMD_OP(cmd, 0, 0,  32, int,	(cfg)->dest_cfg.dest_id); \
+	MC_CMD_OP(cmd, 0, 32, 8,  u8,	(cfg)->dest_cfg.priority); \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,	priority); \
+	MC_CMD_OP(cmd, 0, 48, 4,  enum dpdmai_dest, \
+			(cfg)->dest_cfg.dest_type); \
+	MC_CMD_OP(cmd, 1, 0,  64, u64,	(cfg)->user_ctx); \
+	MC_CMD_OP(cmd, 2, 0,  32, u32,	(cfg)->options);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_RX_QUEUE(cmd, priority) \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,  priority)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_RX_QUEUE(cmd, attr) \
+do { \
+	MC_RSP_OP(cmd, 0, 0,  32, int,	(attr)->dest_cfg.dest_id);\
+	MC_RSP_OP(cmd, 0, 32, 8,  u8,	(attr)->dest_cfg.priority);\
+	MC_RSP_OP(cmd, 0, 48, 4,  enum dpdmai_dest, \
+			(attr)->dest_cfg.dest_type);\
+	MC_RSP_OP(cmd, 1, 0,  64, u64,  (attr)->user_ctx);\
+	MC_RSP_OP(cmd, 2, 0,  32, u32,  (attr)->fqid);\
+} while (0)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_CMD_GET_TX_QUEUE(cmd, priority) \
+	MC_CMD_OP(cmd, 0, 40, 8,  u8,  priority)
+
+/*                cmd, param, offset, width, type, arg_name */
+#define DPDMAI_RSP_GET_TX_QUEUE(cmd, attr) \
+	MC_RSP_OP(cmd, 1, 0,  32, u32,  (attr)->fqid)
+
+#endif /* _FSL_DPDMAI_CMD_H */
-- 
1.7.1

