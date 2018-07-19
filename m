Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0800C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A069B2084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A069B2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbeGSON7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:13:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:54256 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731831AbeGSON5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:13:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2E57FAF4D;
        Thu, 19 Jul 2018 13:30:45 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, Ewan Milne <emilne@redhat.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 3/4] nvmet: loop: abort commands before resetting controller
Date:   Thu, 19 Jul 2018 15:28:37 +0200
Message-Id: <20180719132838.15556-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180719132838.15556-1-jthumshirn@suse.de>
References: <20180719132838.15556-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently if a timeout on loop happens we just go ahead and reset the
underlying transport.

Instead try to abort the timeout out command and if this fails as well
continue the error path escalation and tear down the transport.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/target/loop.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index af7fbf4132b0..b6c355125cb0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -141,9 +141,24 @@ static enum blk_eh_timer_return
 nvme_loop_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(rq);
+	struct nvme_ctrl *ctrl = &iod->queue->ctrl->ctrl;
+	int qid = nvme_loop_queue_idx(iod->queue);
+	int ret;
+
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d timeout, aborting\n",
+		 rq->tag, qid);
+
+	ret = nvme_abort_cmd(ctrl, rq, cpu_to_le16(qid));
+	if (!ret)
+		return BLK_EH_RESET_TIMER;
+
+	dev_warn(ctrl->device,
+		 "I/O %d QID %d abort failed %d, reset controller\n",
+		 rq->tag, qid, ret);
 
 	/* queue error recovery */
-	nvme_reset_ctrl(&iod->queue->ctrl->ctrl);
+	nvme_reset_ctrl(ctrl);
 
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
-- 
2.16.4

