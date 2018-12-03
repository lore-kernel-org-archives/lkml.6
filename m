Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53673C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1E820672
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1E820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbeLCGdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:33:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbeLCGdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:33:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E2033800B9254;
        Mon,  3 Dec 2018 14:33:12 +0800 (CST)
Received: from HSH1000038028.huawei.com (10.177.161.152) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Mon, 3 Dec 2018 14:33:07 +0800
From:   Kevin Wangtao <kevin.wangtao@hisilicon.com>
To:     <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <leo.yan@linaro.org>,
        <gengyanping@hisilicon.com>, <suzhuangluan@hisilicon.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>
Subject: [PATCH v2] mailbox: Hi3660: Fixup mailbox state machine malfunction issue
Date:   Mon, 3 Dec 2018 14:13:08 +0800
Message-ID: <1543817588-82411-1-git-send-email-kevin.wangtao@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1543809309-61169-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <1543809309-61169-1-git-send-email-kevin.wangtao@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.161.152]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current mailbox driver of Hi3660 release the mailbox directly
before sending a new message which may cause last message lost
and next message sending doesn't take effect actually.

This patch fixes this issue by following the right process below,
each time before sending a message, mailbox driver will check
whether the mailbox is in ready state, if last message has been
acknowledged, mailbox driver will clear the ack state to turn
the mailbox to ready state again.

Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
---
Changes v1 -> v2:
 - update commit message

 drivers/mailbox/hi3660-mailbox.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 3eea6b6..035b71a 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -38,6 +38,7 @@
 #define MBOX_AUTOMATIC_ACK		1
 
 #define MBOX_STATE_IDLE			BIT(4)
+#define MBOX_STATE_READY		BIT(5)
 #define MBOX_STATE_ACK			BIT(7)
 
 #define MBOX_MSG_LEN			8
@@ -91,8 +92,8 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
 	unsigned long val;
 	unsigned int ret;
 
-	/* Mailbox is idle so directly bail out */
-	if (readl(base + MBOX_MODE_REG) & MBOX_STATE_IDLE)
+	/* Mailbox is ready to use */
+	if (readl(base + MBOX_MODE_REG) & MBOX_STATE_READY)
 		return 0;
 
 	/* Wait for acknowledge from remote */
@@ -103,9 +104,9 @@ static int hi3660_mbox_check_state(struct mbox_chan *chan)
 		return ret;
 	}
 
-	/* Ensure channel is released */
-	writel(0xffffffff, base + MBOX_IMASK_REG);
-	writel(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
+	/* clear ack state, mailbox will get back to ready state */
+	writel(BIT(mchan->ack_irq), base + MBOX_ICLR_REG);
+
 	return 0;
 }
 
@@ -160,10 +161,6 @@ static int hi3660_mbox_startup(struct mbox_chan *chan)
 {
 	int ret;
 
-	ret = hi3660_mbox_check_state(chan);
-	if (ret)
-		return ret;
-
 	ret = hi3660_mbox_unlock(chan);
 	if (ret)
 		return ret;
@@ -183,10 +180,11 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
 	void __iomem *base = MBOX_BASE(mbox, ch);
 	u32 *buf = msg;
 	unsigned int i;
+	int ret;
 
-	/* Ensure channel is released */
-	writel_relaxed(0xffffffff, base + MBOX_IMASK_REG);
-	writel_relaxed(BIT(mchan->ack_irq), base + MBOX_SRC_REG);
+	ret = hi3660_mbox_check_state(chan);
+	if (ret)
+		return ret;
 
 	/* Clear mask for destination interrupt */
 	writel_relaxed(~BIT(mchan->dst_irq), base + MBOX_IMASK_REG);
-- 
2.8.1

