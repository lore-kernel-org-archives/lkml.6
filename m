Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16164C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3B20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B3B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967078AbeFSRXP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:23:15 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:60858 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966551AbeFSRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:23:13 -0400
Received: from [148.252.241.226] (helo=xylophone.i.decadent.org.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fVKLT-0007JZ-SQ; Tue, 19 Jun 2018 18:23:08 +0100
Date:   Tue, 19 Jun 2018 18:23:06 +0100
From:   Ben Hutchings <ben.hutchings@codethink.co.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.4] nvme-pci: initialize queue memory before interrupts
Message-ID: <20180619172306.atcqdzb2tdk3ivvt@xylophone.i.decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180613171320.GB28828@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
[bwh: Backported to 4.4: adjust context]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e86fcc9e9852..01f47b68b6e7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1589,11 +1589,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	if (result < 0)
 		goto release_cq;
 
+	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
 	if (result < 0)
 		goto release_sq;
 
-	nvme_init_queue(nvmeq, qid);
 	return result;
 
  release_sq:
@@ -1797,6 +1797,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		goto free_nvmeq;
 
 	nvmeq->cq_vector = 0;
+	nvme_init_queue(nvmeq, 0);
 	result = queue_request_irq(dev, nvmeq, nvmeq->irqname);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -3165,7 +3166,6 @@ static void nvme_probe_work(struct work_struct *work)
 		goto disable;
 	}
 
-	nvme_init_queue(dev->queues[0], 0);
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
 		goto disable;
-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

