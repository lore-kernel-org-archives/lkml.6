Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C552EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EC520936
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EC520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733030AbeGJS1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:27:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44730 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732516AbeGJS1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:27:14 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F22AEB8;
        Tue, 10 Jul 2018 18:27:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 12/47] nvme-pci: initialize queue memory before interrupts
Date:   Tue, 10 Jul 2018 20:24:36 +0200
Message-Id: <20180710182337.649747627@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710182337.047502999@linuxfoundation.org>
References: <20180710182337.047502999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 4.4: adjust context]
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1589,11 +1589,11 @@ static int nvme_create_queue(struct nvme
 	if (result < 0)
 		goto release_cq;
 
+	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
 	if (result < 0)
 		goto release_sq;
 
-	nvme_init_queue(nvmeq, qid);
 	return result;
 
  release_sq:
@@ -1797,6 +1797,7 @@ static int nvme_configure_admin_queue(st
 		goto free_nvmeq;
 
 	nvmeq->cq_vector = 0;
+	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -3165,7 +3166,6 @@ static void nvme_probe_work(struct work_
 		goto disable;
 	}
 
-	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto disable;


