Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iuA9CBVGHluVewAAmS7hNA
	; Mon, 11 Jun 2018 09:51:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E51A0607A4; Mon, 11 Jun 2018 09:51:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6A47A60791;
	Mon, 11 Jun 2018 09:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A47A60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932851AbeFKJvt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 05:51:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44685 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932745AbeFKJuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 05:50:55 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5B9ii4n013576;
        Mon, 11 Jun 2018 11:50:42 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2jg415reey-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 11:50:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 56C8A41;
        Mon, 11 Jun 2018 09:50:40 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas24.st.com [10.75.90.94])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2472224E1;
        Mon, 11 Jun 2018 09:50:40 +0000 (GMT)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.47) by Safex1hubcas24.st.com
 (10.75.90.94) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 11:50:39 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 11:50:39
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
Subject: [PATCH 3/4] media: stm32-dcmi: clarify state logic on buffer starvation
Date: Mon, 11 Jun 2018 11:50:26 +0200
Message-ID: <1528710627-8566-4-git-send-email-hugues.fruchet@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
References: <1528710627-8566-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce WAIT_FOR_BUFFER state instead of "active" field checking
to manage buffer starvation case.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/stm32/stm32-dcmi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index 6ccf195..93bb03a 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -85,6 +85,7 @@
 
 enum state {
 	STOPPED = 0,
+	WAIT_FOR_BUFFER,
 	RUNNING,
 	STOPPING,
 };
@@ -230,6 +231,7 @@ static int dcmi_restart_capture(struct stm32_dcmi *dcmi)
 	if (list_empty(&dcmi->buffers)) {
 		dev_dbg(dcmi->dev, "Capture restart is deferred to next buffer queueing\n");
 		dcmi->active = NULL;
+		dcmi->state = WAIT_FOR_BUFFER;
 		spin_unlock_irq(&dcmi->irqlock);
 		return 0;
 	}
@@ -548,9 +550,11 @@ static void dcmi_buf_queue(struct vb2_buffer *vb)
 
 	spin_lock_irq(&dcmi->irqlock);
 
-	if (dcmi->state == RUNNING && !dcmi->active) {
 		dcmi->active = buf;
 
+	if (dcmi->state == WAIT_FOR_BUFFER) {
+		dcmi->state = RUNNING;
+
 		dev_dbg(dcmi->dev, "Starting capture on buffer[%d] queued\n",
 			buf->vb.vb2_buf.index);
 
@@ -630,8 +634,6 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	/* Enable dcmi */
 	reg_set(dcmi->regs, DCMI_CR, CR_ENABLE);
 
-	dcmi->state = RUNNING;
-
 	dcmi->sequence = 0;
 	dcmi->errors_count = 0;
 	dcmi->overrun_count = 0;
@@ -644,6 +646,7 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 	 */
 	if (list_empty(&dcmi->buffers)) {
 		dev_dbg(dcmi->dev, "Start streaming is deferred to next buffer queueing\n");
+		dcmi->state = WAIT_FOR_BUFFER;
 		spin_unlock_irq(&dcmi->irqlock);
 		return 0;
 	}
@@ -653,6 +656,8 @@ static int dcmi_start_streaming(struct vb2_queue *vq, unsigned int count)
 
 	dev_dbg(dcmi->dev, "Start streaming, starting capture\n");
 
+	dcmi->state = RUNNING;
+
 	spin_unlock_irq(&dcmi->irqlock);
 	ret = dcmi_start_capture(dcmi);
 	if (ret) {
-- 
1.9.1
