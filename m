Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCC5C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC8208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:15:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AC8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeG0Ohd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:37:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:18766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732124AbeG0Ohc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:37:32 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w6RDEJ13016198;
        Fri, 27 Jul 2018 15:15:36 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2kg26xrjws-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 27 Jul 2018 15:15:36 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 52F6F3D;
        Fri, 27 Jul 2018 13:15:35 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag7node2.st.com [10.75.127.20])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 180B75782;
        Fri, 27 Jul 2018 13:15:35 +0000 (GMT)
Received: from localhost (10.75.127.48) by SFHDAG7NODE2.st.com (10.75.127.20)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 27 Jul 2018 15:15:34
 +0200
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH v4 17/17] rpmsg: virtio: allocate buffer from parent
Date:   Fri, 27 Jul 2018 15:14:52 +0200
Message-ID: <1532697292-14272-18-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
References: <1532697292-14272-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG7NODE2.st.com
 (10.75.127.20)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remoteproc is now capable to create one specific sub-device per
virtio link to associate a dedicated memory pool.
This implies to change device used by virtio_rpmsg for
buffer allocation from grand-parent to parent.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957..5c89201 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -912,7 +912,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	total_buf_space = vrp->num_bufs * vrp->buf_size;
 
 	/* allocate coherent memory for the buffers */
-	bufs_va = dma_alloc_coherent(vdev->dev.parent->parent,
+	bufs_va = dma_alloc_coherent(vdev->dev.parent,
 				     total_buf_space, &vrp->bufs_dma,
 				     GFP_KERNEL);
 	if (!bufs_va) {
@@ -980,7 +980,7 @@ static int rpmsg_probe(struct virtio_device *vdev)
 	return 0;
 
 free_coherent:
-	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
+	dma_free_coherent(vdev->dev.parent, total_buf_space,
 			  bufs_va, vrp->bufs_dma);
 vqs_del:
 	vdev->config->del_vqs(vrp->vdev);
@@ -1015,7 +1015,7 @@ static void rpmsg_remove(struct virtio_device *vdev)
 
 	vdev->config->del_vqs(vrp->vdev);
 
-	dma_free_coherent(vdev->dev.parent->parent, total_buf_space,
+	dma_free_coherent(vdev->dev.parent, total_buf_space,
 			  vrp->rbufs, vrp->bufs_dma);
 
 	kfree(vrp);
-- 
1.9.1

