Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1DBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665CC206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 05:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfAPFHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 00:07:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:19340 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbfAPFHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 00:07:52 -0500
X-UUID: 8334bc0decde46a4b84d8e03675b0b2d-20190116
X-UUID: 8334bc0decde46a4b84d8e03675b0b2d-20190116
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 389863652; Wed, 16 Jan 2019 13:07:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 16 Jan 2019 13:07:22 +0800
Received: from mtkslt305.mediatek.inc (10.21.14.140) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 16 Jan 2019 13:07:22 +0800
From:   CK Hu <ck.hu@mediatek.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, CK Hu <ck.hu@mediatek.com>
Subject: [PATCH 2/3] mailbox: mediatek: Implement abort_data function.
Date:   Wed, 16 Jan 2019 13:04:34 +0800
Message-ID: <20190116050435.11624-3-ck.hu@mediatek.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190116050435.11624-1-ck.hu@mediatek.com>
References: <20190116050435.11624-1-ck.hu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 69A7877979E11386BBE973F251CDFD145478041FA21F307B5E29E033EBCC8AFE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For client driver which need to reorganize the command buffer, it could
use this function to abort the sent but not executed command buffer.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 22811784dc7d..f2219f263ef6 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -417,6 +417,45 @@ static int cmdq_mbox_send_data(struct mbox_chan *chan, void *data)
 	return 0;
 }
 
+static void cmdq_mbox_abort_data(struct mbox_chan *chan)
+{
+	struct cmdq_thread *thread = (struct cmdq_thread *)chan->con_priv;
+	struct cmdq *cmdq = dev_get_drvdata(chan->mbox->dev);
+	struct cmdq_task *task, *tmp;
+	unsigned long flags;
+	u32 enable;
+
+	spin_lock_irqsave(&thread->chan->lock, flags);
+	if (list_empty(&thread->task_busy_list))
+		goto out;
+
+	WARN_ON(cmdq_thread_suspend(cmdq, thread) < 0);
+	if (!cmdq_thread_is_in_wfe(thread))
+		goto wait;
+
+	list_for_each_entry_safe(task, tmp, &thread->task_busy_list,
+				 list_entry) {
+		list_del(&task->list_entry);
+		kfree(task);
+	}
+
+	cmdq_thread_resume(thread);
+	cmdq_thread_disable(cmdq, thread);
+	clk_disable(cmdq->clock);
+
+out:
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	return;
+
+wait:
+	cmdq_thread_resume(thread);
+	spin_unlock_irqrestore(&thread->chan->lock, flags);
+	if (readl_poll_timeout_atomic(thread->base + CMDQ_THR_ENABLE_TASK,
+				      enable, !enable, 1, 20))
+		dev_err(cmdq->mbox.dev, "Fail to wait GCE thread 0x%x done\n",
+			(u32)(thread->base - cmdq->base));
+}
+
 static int cmdq_mbox_startup(struct mbox_chan *chan)
 {
 	return 0;
@@ -427,6 +466,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 }
 
 static const struct mbox_chan_ops cmdq_mbox_chan_ops = {
+	.abort_data = cmdq_mbox_abort_data,
 	.send_data = cmdq_mbox_send_data,
 	.startup = cmdq_mbox_startup,
 	.shutdown = cmdq_mbox_shutdown,
-- 
2.18.1

