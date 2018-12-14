Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF90C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E837D2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789234;
	bh=ouMRBUYnSbpn4SyYKMrIYHr+Zz+f0iNrKgoHuL2LJ9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0Hb7JFS4+MO+JmR49dJfK0xNK9Izfp8F4RTdY+fn2RUdoTS5n0EojXECHv1asXSZ
	 mGf2wwFFRl7zDWqBXVndjH1/vAWDhql2eNMO8BBkBVPOfA9yzhLwWqS/OpxewrZWuH
	 KpbkHWyeAiaLVKzOzPxmQg3+IqMqkBJuNAgEnei4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E837D2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeLNMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:07:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbeLNMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:07:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443E42147D;
        Fri, 14 Dec 2018 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789229;
        bh=ouMRBUYnSbpn4SyYKMrIYHr+Zz+f0iNrKgoHuL2LJ9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EaoYtQywcwzCO5Tjy/PIQ6/cfbax/x6MMY/5Gxr0LHQIrFugGV/qjBgwsKJQVcslO
         jDrm0wOO2xm4htAL8JIFQgzzbrZh+JNyywRS3sgq5z0Bhs8v23zFpEo2m4EGEoeaCC
         avcfJZzD4AnFKLimhSltJCffZyC4RZ1Ghh+X3yHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prabhath Sajeepa <psajeepa@purestorage.com>,
        Roland Dreier <roland@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 122/142] nvme-rdma: fix double freeing of async event data
Date:   Fri, 14 Dec 2018 13:00:07 +0100
Message-Id: <20181214115751.910696070@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 6344d02dc8f886b6bbcd922ae1a17e4a41500f2d ]

Some error paths in configuration of admin queue free data buffer
associated with async request SQE without resetting the data buffer
pointer to NULL, This buffer is also freed up again if the controller
is shutdown or reset.

Signed-off-by: Prabhath Sajeepa <psajeepa@purestorage.com>
Reviewed-by: Roland Dreier <roland@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index dc042017c293..b6a28de682e8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -184,6 +184,7 @@ static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
 	qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
 	if (ib_dma_mapping_error(ibdev, qe->dma)) {
 		kfree(qe->data);
+		qe->data = NULL;
 		return -ENOMEM;
 	}
 
@@ -816,6 +817,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 out_free_async_qe:
 	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
+	ctrl->async_event_sqe.data = NULL;
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
-- 
2.19.1



