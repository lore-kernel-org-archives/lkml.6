Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCF4C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28A2612A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E28A2612A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934129AbeF0LRL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:17:11 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64746 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933275AbeF0LRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:17:08 -0400
X-UUID: f48e771594224055ba083e48292185ec-20180627
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2141440393; Wed, 27 Jun 2018 19:17:04 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 27 Jun 2018 19:17:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 19:17:02 +0800
From:   Houlong Wei <houlong.wei@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Subject: [PATCH v22 4/4] soc: mediatek: Add Mediatek CMDQ helper
Date:   Wed, 27 Jun 2018 19:16:12 +0800
Message-ID: <1530098172-31385-5-git-send-email-houlong.wei@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.

Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 drivers/soc/mediatek/Kconfig           |   12 ++
 drivers/soc/mediatek/Makefile          |    1 +
 drivers/soc/mediatek/mtk-cmdq-helper.c |  258 ++++++++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-cmdq.h  |  132 ++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
 create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index a7d0667..17bd759 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -4,6 +4,18 @@
 menu "MediaTek SoC drivers"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
+config MTK_CMDQ
+	tristate "MediaTek CMDQ Support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select MAILBOX
+	select MTK_CMDQ_MBOX
+	select MTK_INFRACFG
+	help
+	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
+	  driver. The CMDQ is used to help read/write registers with critical
+	  time limitation, such as updating display configuration during the
+	  vblank.
+
 config MTK_INFRACFG
 	bool "MediaTek INFRACFG Support"
 	select REGMAP
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 12998b0..64ce5ee 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,3 +1,4 @@
+obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
 obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
 obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
new file mode 100644
index 0000000..6c66091
--- /dev/null
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ *
+ */
+
+#include <linux/completion.h>
+#include <linux/errno.h>
+#include <linux/dma-mapping.h>
+#include <linux/mailbox_controller.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#define CMDQ_ARG_A_WRITE_MASK	0xffff
+#define CMDQ_WRITE_ENABLE_MASK	BIT(0)
+#define CMDQ_EOC_IRQ_EN		BIT(0)
+#define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
+				<< 32 | CMDQ_EOC_IRQ_EN)
+
+int cmdq_pkt_realloc_cmd_buffer(struct cmdq_pkt *pkt, size_t size)
+{
+	void *new_buf;
+
+	new_buf = krealloc(pkt->va_base, size, GFP_KERNEL | __GFP_ZERO);
+	if (!new_buf)
+		return -ENOMEM;
+	pkt->va_base = new_buf;
+	pkt->buf_size = size;
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_realloc_cmd_buffer);
+
+struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
+{
+	struct cmdq_client *client;
+	long err = 0;
+
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return (struct cmdq_client *)-ENOMEM;
+
+	client->client.dev = dev;
+	client->client.tx_block = false;
+	client->chan = mbox_request_channel(&client->client, index);
+
+	if (IS_ERR(client->chan)) {
+		dev_err(dev, "failed to request channel\n");
+		err = PTR_ERR(client->chan);
+		kfree(client);
+
+		return (struct cmdq_client *)err;
+	}
+
+	return client;
+}
+EXPORT_SYMBOL(cmdq_mbox_create);
+
+void cmdq_mbox_destroy(struct cmdq_client *client)
+{
+	mbox_free_channel(client->chan);
+	kfree(client);
+}
+EXPORT_SYMBOL(cmdq_mbox_destroy);
+
+int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr)
+{
+	struct cmdq_pkt *pkt;
+	int err;
+
+	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
+	if (!pkt)
+		return -ENOMEM;
+	err = cmdq_pkt_realloc_cmd_buffer(pkt, PAGE_SIZE);
+	if (err < 0) {
+		kfree(pkt);
+		return err;
+	}
+	*pkt_ptr = pkt;
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_create);
+
+void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
+{
+	kfree(pkt->va_base);
+	kfree(pkt);
+}
+EXPORT_SYMBOL(cmdq_pkt_destroy);
+
+static bool cmdq_pkt_is_finalized(struct cmdq_pkt *pkt)
+{
+	u64 *expect_eoc;
+
+	if (pkt->cmd_buf_size < CMDQ_INST_SIZE << 1)
+		return false;
+
+	expect_eoc = pkt->va_base + pkt->cmd_buf_size - (CMDQ_INST_SIZE << 1);
+	if (*expect_eoc == CMDQ_EOC_CMD)
+		return true;
+
+	return false;
+}
+
+static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
+				   u32 arg_a, u32 arg_b)
+{
+	u64 *cmd_ptr;
+	int err;
+
+	if (WARN_ON(cmdq_pkt_is_finalized(pkt)))
+		return -EBUSY;
+	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
+		err = cmdq_pkt_realloc_cmd_buffer(pkt, pkt->buf_size << 1);
+		if (err < 0)
+			return err;
+	}
+	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
+	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
+	pkt->cmd_buf_size += CMDQ_INST_SIZE;
+
+	return 0;
+}
+
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
+{
+	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
+		    (subsys << CMDQ_SUBSYS_SHIFT);
+
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
+}
+EXPORT_SYMBOL(cmdq_pkt_write);
+
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
+			u32 subsys, u32 offset, u32 mask)
+{
+	u32 offset_mask = offset;
+	int err;
+
+	if (mask != 0xffffffff) {
+		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
+		if (err < 0)
+			return err;
+		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
+	}
+
+	return cmdq_pkt_write(pkt, value, subsys, offset_mask);
+}
+EXPORT_SYMBOL(cmdq_pkt_write_mask);
+
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
+{
+	u32 arg_b;
+
+	if (event >= CMDQ_MAX_EVENT || event < 0)
+		return -EINVAL;
+
+	/*
+	 * WFE arg_b
+	 * bit 0-11: wait value
+	 * bit 15: 1 - wait, 0 - no wait
+	 * bit 16-27: update value
+	 * bit 31: 1 - update, 0 - no update
+	 */
+	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
+
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
+}
+EXPORT_SYMBOL(cmdq_pkt_wfe);
+
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
+{
+	if (event >= CMDQ_MAX_EVENT || event < 0)
+		return -EINVAL;
+
+	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
+				       CMDQ_WFE_UPDATE);
+}
+EXPORT_SYMBOL(cmdq_pkt_clear_event);
+
+static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
+{
+	int err;
+
+	if (cmdq_pkt_is_finalized(pkt))
+		return 0;
+
+	/* insert EOC and generate IRQ for each command iteration */
+	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
+	if (err < 0)
+		return err;
+
+	/* JUMP to end */
+	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
+			 cmdq_async_flush_cb cb, void *data)
+{
+	int err;
+	struct device *dev;
+	dma_addr_t dma_addr;
+
+	err = cmdq_pkt_finalize(pkt);
+	if (err < 0)
+		return err;
+
+	dev = client->chan->mbox->dev;
+	dma_addr = dma_map_single(dev, pkt->va_base, pkt->cmd_buf_size,
+		DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, dma_addr)) {
+		dev_err(client->chan->mbox->dev, "dma map failed\n");
+		return -ENOMEM;
+	}
+
+	pkt->pa_base = dma_addr;
+	pkt->cb.cb = cb;
+	pkt->cb.data = data;
+
+	mbox_send_message(client->chan, pkt);
+	/* We can send next packet immediately, so just call txdone. */
+	mbox_client_txdone(client->chan, 0);
+
+	return 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_flush_async);
+
+struct cmdq_flush_completion {
+	struct completion cmplt;
+	bool err;
+};
+
+static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
+{
+	struct cmdq_flush_completion *cmplt = data.data;
+
+	cmplt->err = data.err;
+	complete(&cmplt->cmplt);
+}
+
+int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
+{
+	struct cmdq_flush_completion cmplt;
+	int err;
+
+	init_completion(&cmplt.cmplt);
+	err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
+	if (err < 0)
+		return err;
+	wait_for_completion(&cmplt.cmplt);
+
+	return cmplt.err ? -EFAULT : 0;
+}
+EXPORT_SYMBOL(cmdq_pkt_flush);
diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
new file mode 100644
index 0000000..d7c8ef2
--- /dev/null
+++ b/include/linux/soc/mediatek/mtk-cmdq.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ *
+ */
+
+#ifndef __MTK_CMDQ_H__
+#define __MTK_CMDQ_H__
+
+#include <linux/mailbox_client.h>
+#include <linux/mailbox/mtk-cmdq-mailbox.h>
+
+/** cmdq event maximum */
+#define CMDQ_MAX_EVENT				0x3ff
+
+struct cmdq_pkt;
+
+struct cmdq_client {
+	struct mbox_client client;
+	struct mbox_chan *chan;
+};
+
+/**
+ * cmdq_mbox_create() - create CMDQ mailbox client and channel
+ * @dev:	device of CMDQ mailbox client
+ * @index:	index of CMDQ mailbox channel
+ *
+ * Return: CMDQ mailbox client pointer
+ */
+struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
+
+/**
+ * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
+ * @client:	the CMDQ mailbox client
+ */
+void cmdq_mbox_destroy(struct cmdq_client *client);
+
+/**
+ * cmdq_pkt_create() - create a CMDQ packet
+ * @pkt_ptr:	CMDQ packet pointer to retrieve cmdq_pkt
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr);
+
+/**
+ * cmdq_pkt_destroy() - destroy the CMDQ packet
+ * @pkt:	the CMDQ packet
+ */
+void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_pkt_realloc_cmd_buffer() - reallocate command buffer for CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @size:	the request size
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_realloc_cmd_buffer(struct cmdq_pkt *pkt, size_t size);
+
+/**
+ * cmdq_pkt_write() - append write command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @value:	the specified target register value
+ * @subsys:	the CMDQ sub system code
+ * @offset:	register offset from CMDQ sub system
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
+
+/**
+ * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @value:	the specified target register value
+ * @subsys:	the CMDQ sub system code
+ * @offset:	register offset from CMDQ sub system
+ * @mask:	the specified target register mask
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
+			u32 subsys, u32 offset, u32 mask);
+
+/**
+ * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event type to "wait and CLEAR"
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
+
+/**
+ * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
+ * @pkt:	the CMDQ packet
+ * @event:	the desired event to be cleared
+ *
+ * Return: 0 for success; else the error code is returned
+ */
+int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
+
+/**
+ * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
+ * @client:	the CMDQ mailbox client
+ * @pkt:	the CMDQ packet
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ * Trigger CMDQ to execute the CMDQ packet. Note that this is a
+ * synchronous flush function. When the function returned, the recorded
+ * commands have been done.
+ */
+int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt);
+
+/**
+ * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
+ *                          packet and call back at the end of done packet
+ * @client:	the CMDQ mailbox client
+ * @pkt:	the CMDQ packet
+ * @cb:		called at the end of done packet
+ * @data:	this data will pass back to cb
+ *
+ * Return: 0 for success; else the error code is returned
+ *
+ * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
+ * at the end of done packet. Note that this is an ASYNC function. When the
+ * function returned, it may or may not be finished.
+ */
+int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
+			 cmdq_async_flush_cb cb, void *data);
+
+#endif	/* __MTK_CMDQ_H__ */
-- 
1.7.9.5

