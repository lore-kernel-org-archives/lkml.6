Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDB10C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8953220020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRShg7JM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8953220020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966165AbeFNOY6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966063AbeFNOMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:12:34 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46DD208DB;
        Thu, 14 Jun 2018 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985554;
        bh=OKiTcyULM6BDGycl3nfnvyKKS9gVKkOZqyoLHHp2iwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRShg7JMNaQUfUQYt/gFT9p8sUdKNKReKWSJxABF5bayyZj56EqYPTAZdnj5Bcqsx
         L2PtjNtnNxO1HeE4oRcWxPUoX/WXQ7NtuWrTN5byValaFqd6B+m83McxxLvx4clvWG
         pzxAxC+F7dt0D1SKDtc0tkPMy1upc5ZQyTqwW2L8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 05/30] nvme-pci: initialize queue memory before interrupts
Date:   Thu, 14 Jun 2018 16:04:46 +0200
Message-Id: <20180614132600.473786690@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit 161b8be2bd6abad250d4b3f674bdd5480f15beeb upstream.

A spurious interrupt before the nvme driver has initialized the completion
queue may inadvertently cause the driver to believe it has a completion
to process. This may result in a NULL dereference since the nvmeq's tags
are not set at this point.

The patch initializes the host's CQ memory so that a spurious interrupt
isn't mistaken for a real completion.

Signed-off-by: Keith Busch <keith.busch@intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1126,11 +1126,11 @@ static int nvme_create_queue(struct nvme
 	if (result < 0)
 		goto release_cq;
 
+	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
 		goto release_sq;
 
-	nvme_init_queue(nvmeq, qid);
 	return result;
 
  release_sq:
@@ -1248,6 +1248,7 @@ static int nvme_configure_admin_queue(st
 		return result;
 
 	nvmeq->cq_vector = 0;
+	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -1776,7 +1777,6 @@ static void nvme_reset_work(struct work_
 	if (result)
 		goto out;
 
-	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto out;


