Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wECQDQBGHlszeQAAmS7hNA
	; Mon, 11 Jun 2018 09:52:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D78DB607A4; Mon, 11 Jun 2018 09:52:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58D69606FA;
	Mon, 11 Jun 2018 09:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58D69606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932863AbeFKJws (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:52:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:7985 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932702AbeFKJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:52:46 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5B9ikQB013583;
        Mon, 11 Jun 2018 11:52:25 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jg415reqj-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 11:52:25 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CAB244A;
        Mon, 11 Jun 2018 09:52:23 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9662C241E;
        Mon, 11 Jun 2018 09:52:23 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 11:52:22 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 11:52:22
 +0200
From: Hugues Fruchet <hugues.fruchet@st.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil@xs4all.nl>
CC: <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Hugues Fruchet <hugues.fruchet@st.com>
Subject: [PATCH] media: stm32-dcmi: revisit stop streaming ops
Date: Mon, 11 Jun 2018 11:52:17 +0200
Message-ID: <1528710737-8946-1-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not wait for interrupt completion when stopping streaming,
stopping sensor and disabling interruptions are enough.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 29 +----------------------------
 1 file changed, 1 insertion(+), 28 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 581ded0..f0134a6 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -87,7 +87,6 @@ enum state {
 	STOPPED = 0,
 	WAIT_FOR_BUFFER,
 	RUNNING,
-	STOPPING,
 };
 
 #define MIN_WIDTH	16U
@@ -432,18 +431,6 @@ static irqreturn_t dcmi_irq_thread(int irq, void *arg)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-	/* Stop capture is required */
-	if (dcmi->state == STOPPING) {
-		reg_clear(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
-
-		dcmi->state = STOPPED;
-
-		complete(&dcmi->complete);
-
-		spin_unlock_irq(&dcmi->irqlock);
-		return IRQ_HANDLED;
-	}
-
 	if ((dcmi->misr & IT_OVR) || (dcmi->misr & IT_ERR)) {
 		dcmi->errors_count++;
 		if (dcmi->misr & IT_OVR)
@@ -701,8 +688,6 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 {
 	struct stm32_dcmi *dcmi = vb2_get_drv_priv(vq);
 	struct dcmi_buf *buf, *node;
-	unsigned long time_ms = msecs_to_jiffies(TIMEOUT_MS);
-	long timeout;
 	int ret;
 
 	/* Disable stream on the sub device */
@@ -712,13 +697,6 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 			__func__, ret);
 
 	spin_lock_irq(&dcmi->irqlock);
-	dcmi->state = STOPPING;
-	spin_unlock_irq(&dcmi->irqlock);
-
-	timeout = wait_for_completion_interruptible_timeout(&dcmi->complete,
-							    time_ms);
-
-	spin_lock_irq(&dcmi->irqlock);
 
 	/* Disable interruptions */
 	reg_clear(dcmi->regs, DCMI_IER, IT_FRAME | IT_OVR | IT_ERR);
@@ -726,12 +704,6 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	/* Disable DCMI */
 	reg_clear(dcmi->regs, DCMI_CR, CR_ENABLE);
 
-	if (!timeout) {
-		dev_err(dcmi->dev, "%s: Timeout during stop streaming\n",
-			__func__);
-		dcmi->state = STOPPED;
-	}
-
 	/* Return all queued buffers to vb2 in ERROR state */
 	list_for_each_entry_safe(buf, node, &dcmi->buffers, list) {
 		list_del_init(&buf->list);
@@ -739,6 +711,7 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	}
 
 	dcmi->active = NULL;
+	dcmi->state = STOPPED;
 
 	spin_unlock_irq(&dcmi->irqlock);
 
-- 
1.9.1
