Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C288EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A01E214C5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eECjGeDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A01E214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732116AbeJICDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF8CD21479;
        Mon,  8 Oct 2018 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024632;
        bh=eKBGKW6JqlfhSyRUGuhsEl/8Dc5H8/44s5cvxOGfdj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eECjGeDOfNfw+vdGW7f0VW+bTKwGpVuUPOTS7VTjemDVNOSj5D/IIdBVDCjdmX1QK
         g1wsVu87TlRm2dljWQwnMjmsE5jpHQsAYfvt0cXOrOOR9AZUIWxUFWIaR2qDE/9QP9
         h/dOK80vhl9RSC+Fok2VPssnFvEHOCDxElWRcfD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 103/168] nvmet-rdma: fix possible bogus dereference under heavy load
Date:   Mon,  8 Oct 2018 20:31:23 +0200
Message-Id: <20181008175623.975423964@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 8407879c4e0d7731f6e7e905893cecf61a7762c7 ]

Currently we always repost the recv buffer before we send a response
capsule back to the host. Since ordering is not guaranteed for send
and recv completions, it is posible that we will receive a new request
from the host before we got a send completion for the response capsule.

Today, we pre-allocate 2x rsps the length of the queue, but in reality,
under heavy load there is nothing that is really preventing the gap to
expand until we exhaust all our rsps.

To fix this, if we don't have any pre-allocated rsps left, we dynamically
allocate a rsp and make sure to free it when we are done. If under memory
pressure we fail to allocate a rsp, we silently drop the command and
wait for the host to retry.

Reported-by: Steve Wise <swise@opengridcomputing.com>
Tested-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
[hch: dropped a superflous assignment]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/target/rdma.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -65,6 +65,7 @@ struct nvmet_rdma_rsp {
 
 	struct nvmet_req	req;
 
+	bool			allocated;
 	u8			n_rdma;
 	u32			flags;
 	u32			invalidate_rkey;
@@ -166,11 +167,19 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_que
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->rsps_lock, flags);
-	rsp = list_first_entry(&queue->free_rsps,
+	rsp = list_first_entry_or_null(&queue->free_rsps,
 				struct nvmet_rdma_rsp, free_list);
-	list_del(&rsp->free_list);
+	if (likely(rsp))
+		list_del(&rsp->free_list);
 	spin_unlock_irqrestore(&queue->rsps_lock, flags);
 
+	if (unlikely(!rsp)) {
+		rsp = kmalloc(sizeof(*rsp), GFP_KERNEL);
+		if (unlikely(!rsp))
+			return NULL;
+		rsp->allocated = true;
+	}
+
 	return rsp;
 }
 
@@ -179,6 +188,11 @@ nvmet_rdma_put_rsp(struct nvmet_rdma_rsp
 {
 	unsigned long flags;
 
+	if (rsp->allocated) {
+		kfree(rsp);
+		return;
+	}
+
 	spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
 	list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
 	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
@@ -702,6 +716,15 @@ static void nvmet_rdma_recv_done(struct
 
 	cmd->queue = queue;
 	rsp = nvmet_rdma_get_rsp(queue);
+	if (unlikely(!rsp)) {
+		/*
+		 * we get here only under memory pressure,
+		 * silently drop and have the host retry
+		 * as we can't even fail it.
+		 */
+		nvmet_rdma_post_recv(queue->dev, cmd);
+		return;
+	}
 	rsp->queue = queue;
 	rsp->cmd = cmd;
 	rsp->flags = 0;


