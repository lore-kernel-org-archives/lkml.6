Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id euA9CBVGHluVewAAmS7hNA
	; Mon, 11 Jun 2018 09:51:17 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 024EA607A4; Mon, 11 Jun 2018 09:51:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4171D60385;
	Mon, 11 Jun 2018 09:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4171D60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932816AbeFKJvP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:51:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37227 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932641AbeFKJvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:51:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5B9nZ3t008471;
        Mon, 11 Jun 2018 11:50:42 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jg4bwga7e-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 11:50:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B174543;
        Mon, 11 Jun 2018 09:50:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8BBA724DF;
        Mon, 11 Jun 2018 09:50:41 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 11:50:41 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 11:50:40
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
Subject: [PATCH 4/4] media: stm32-dcmi: revisit buffer list management
Date: Mon, 11 Jun 2018 11:50:27 +0200
Message-ID: <1528710627-8566-5-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
References: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup "active" field usage and enhance list management
to avoid exceptions when releasing buffers on error or
stopping streaming.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 65 +++++++++++++++----------------
 1 file changed, 31 insertions(+), 34 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 93bb03a..581ded0 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -191,7 +191,7 @@ static inline void reg_clear(void __iomem *base, u32 reg, u32 mask)
 	reg_write(base, reg, reg_read(base, reg) & ~mask);
 }
 
-static int dcmi_start_capture(struct stm32_dcmi *dcmi);
+static int dcmi_start_capture(struct stm32_dcmi *dcmi, struct dcmi_buf *buf);
 
 static void dcmi_buffer_done(struct stm32_dcmi *dcmi,
 			     struct dcmi_buf *buf,
@@ -203,6 +203,8 @@ static void dcmi_buffer_done(struct stm32_dcmi *dcmi,
 	if (!buf)
 		return;
 
+	list_del_init(&buf->list);
+
 	vbuf = &buf->vb;
 
 	vbuf->sequence = dcmi->sequence++;
@@ -220,6 +222,8 @@ static void dcmi_buffer_done(struct stm32_dcmi *dcmi,
 
 static int dcmi_restart_capture(struct stm32_dcmi *dcmi)
 {
+	struct dcmi_buf *buf;
+
 	spin_lock_irq(&dcmi->irqlock);
 
 	if (dcmi->state != RUNNING) {
@@ -230,19 +234,16 @@ static int dcmi_restart_capture(struct stm32_dcmi *dcmi)
 	/* Restart a new DMA transfer with next buffer */
 	if (list_empty(&dcmi->buffers)) {
 		dev_dbg(dcmi->dev, "Capture restart is deferred to next buffer queueing\n");
-		dcmi->active = NULL;
 		dcmi->state = WAIT_FOR_BUFFER;
 		spin_unlock_irq(&dcmi->irqlock);
 		return 0;
 	}
-
-	dcmi->active = list_entry(dcmi->buffers.next,
-				  struct dcmi_buf, list);
-	list_del_init(&dcmi->active->list);
+	buf = list_entry(dcmi->buffers.next, struct dcmi_buf, list);
+	dcmi->active = buf;
 
 	spin_unlock_irq(&dcmi->irqlock);
 
-	return dcmi_start_capture(dcmi);
+	return dcmi_start_capture(dcmi, buf);
 }
 
 static void dcmi_dma_callback(void *param)
@@ -252,6 +253,8 @@ static void dcmi_dma_callback(void *param)
 	enum dma_status status;
 	struct dcmi_buf *buf = dcmi->active;
 
+	spin_lock_irq(&dcmi->irqlock);
+
 	/* Check DMA status */
 	status = dmaengine_tx_status(dcmi->dma_chan, dcmi->dma_cookie, &state);
 
@@ -274,15 +277,19 @@ static void dcmi_dma_callback(void *param)
 		/* Return buffer to V4L2 */
 		dcmi_buffer_done(dcmi, buf, buf->size, 0);
 
+		spin_unlock_irq(&dcmi->irqlock);
+
 		/* Restart capture */
 		if (dcmi_restart_capture(dcmi))
 			dev_err(dcmi->dev, "%s: Cannot restart capture on DMA complete\n",
 				__func__);
-		break;
+		return;
 	default:
 		dev_err(dcmi->dev, "%s: Received unknown status\n", __func__);
 		break;
 	}
+
+	spin_unlock_irq(&dcmi->irqlock);
 }
 
 static int dcmi_start_dma(struct stm32_dcmi *dcmi,
@@ -334,10 +341,9 @@ static int dcmi_start_dma(struct stm32_dcmi *dcmi,
 	return 0;
 }
 
-static int dcmi_start_capture(struct stm32_dcmi *dcmi)
+static int dcmi_start_capture(struct stm32_dcmi *dcmi, struct dcmi_buf *buf)
 {
 	int ret;
-	struct dcmi_buf *buf = dcmi->active;
 
 	if (!buf)
 		return -EINVAL;
@@ -491,8 +497,6 @@ static int dcmi_queue_setup(struct vb2_queue *vq,
 	*nplanes = 1;
 	sizes[0] = size;
 
-	dcmi->active = NULL;
-
 	dev_dbg(dcmi->dev, "Setup queue, count=%d, size=%d\n",
 		*nbuffers, size);
 
@@ -550,23 +554,24 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-		dcmi->active = buf;
+	/* Enqueue to video buffers list */
+	list_add_tail(&buf->list, &dcmi->buffers);
 
 	if (dcmi->state == WAIT_FOR_BUFFER) {
 		dcmi->state = RUNNING;
+		dcmi->active = buf;
 
 		dev_dbg(dcmi->dev, "Starting capture on buffer[%d] queued\n",
 			buf->vb.vb2_buf.index);
 
 		spin_unlock_irq(&dcmi->irqlock);
-		if (dcmi_start_capture(dcmi))
+		if (dcmi_start_capture(dcmi, buf))
 			dev_err(dcmi->dev, "%s: Cannot restart capture on overflow or error\n",
 				__func__);
-	} else {
-		/* Enqueue to video buffers list */
-		list_add_tail(&buf->list, &dcmi->buffers);
-		spin_unlock_irq(&dcmi->irqlock);
+		return;
 	}
+
+	spin_unlock_irq(&dcmi->irqlock);
 }
 
 static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -638,7 +643,6 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	dcmi->errors_count = 0;
 	dcmi->overrun_count = 0;
 	dcmi->buffers_count = 0;
-	dcmi->active = NULL;
 
 	/*
 	 * Start transfer if at least one buffer has been queued,
@@ -651,15 +655,15 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 		return 0;
 	}
 
-	dcmi->active = list_entry(dcmi->buffers.next, struct dcmi_buf, list);
-	list_del_init(&dcmi->active->list);
-
-	dev_dbg(dcmi->dev, "Start streaming, starting capture\n");
+	buf = list_entry(dcmi->buffers.next, struct dcmi_buf, list);
+	dcmi->active = buf;
 
 	dcmi->state = RUNNING;
 
+	dev_dbg(dcmi->dev, "Start streaming, starting capture\n");
+
 	spin_unlock_irq(&dcmi->irqlock);
-	ret = dcmi_start_capture(dcmi);
+	ret = dcmi_start_capture(dcmi, buf);
 	if (ret) {
 		dev_err(dcmi->dev, "%s: Start streaming failed, cannot start capture\n",
 			__func__);
@@ -683,15 +687,11 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 * Return all buffers to vb2 in QUEUED state.
 	 * This will give ownership back to userspace
 	 */
-	if (dcmi->active) {
-		buf = dcmi->active;
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
-		dcmi->active = NULL;
-	}
 	list_for_each_entry_safe(buf, node, &dcmi->buffers, list) {
 		list_del_init(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
 	}
+	dcmi->active = NULL;
 	spin_unlock_irq(&dcmi->irqlock);
 
 	return ret;
@@ -733,16 +733,13 @@ static void dcmi_stop_streaming(struct vb2_queue *vq)
 	}
 
 	/* Return all queued buffers to vb2 in ERROR state */
-	if (dcmi->active) {
-		buf = dcmi->active;
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
-		dcmi->active = NULL;
-	}
 	list_for_each_entry_safe(buf, node, &dcmi->buffers, list) {
 		list_del_init(&buf->list);
 		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 	}
 
+	dcmi->active = NULL;
+
 	spin_unlock_irq(&dcmi->irqlock);
 
 	/* Stop all pending DMA operations */
-- 
1.9.1
