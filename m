Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98A4C4161B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F4C2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:33:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F4C2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeK3Ijw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:39:52 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:17103 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbeK3Ijw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:39:52 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wATLTaD1001701;
        Thu, 29 Nov 2018 22:32:59 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2nxvnb6guq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 29 Nov 2018 22:32:59 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 609F8490;
        Thu, 29 Nov 2018 22:32:29 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9C0BD59A4;
        Thu, 29 Nov 2018 21:32:58 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov
 2018 22:32:58 +0100
Received: from localhost (10.129.6.191) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 29 Nov 2018 22:32:57
 +0100
From:   Loic Pallardy <loic.pallardy@st.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@linaro.org>,
        <s-anna@ti.com>, Loic Pallardy <loic.pallardy@st.com>
Subject: [PATCH 3/3] rpmsg: virtio: allocate buffer from parent
Date:   Thu, 29 Nov 2018 22:32:38 +0100
Message-ID: <1543527158-56163-4-git-send-email-loic.pallardy@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543527158-56163-1-git-send-email-loic.pallardy@st.com>
References: <1543527158-56163-1-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.6.191]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-29_13:,,
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
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Anup Patel <anup@brainfault.org>

---
 drivers/rpmsg/virtio_rpmsg_bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957012cd..5c892019ce89 100644
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
2.7.4

