Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED20C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858842172E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:53:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 858842172E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404207AbeHGVJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:09:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404151AbeHGVJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:09:38 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F16B7D0E;
        Tue,  7 Aug 2018 18:53:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 4.14 15/21] nvme-pci: Fix queue double allocations
Date:   Tue,  7 Aug 2018 20:51:29 +0200
Message-Id: <20180807172331.653550469@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172330.953888701@linuxfoundation.org>
References: <20180807172330.953888701@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 62314e405fa101dbb82563394f9dfc225e3f1167 upstream.

The queue count says the highest queue that's been allocated, so don't
reallocate a queue lower than that.

Fixes: 147b27e4bd0 ("nvme-pci: allocate device queues storage space at probe")
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1246,6 +1246,9 @@ static int nvme_alloc_queue(struct nvme_
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
+	if (dev->ctrl.queue_count > qid)
+		return 0;
+
 	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(depth),
 					  &nvmeq->cq_dma_addr, GFP_KERNEL);
 	if (!nvmeq->cqes)


