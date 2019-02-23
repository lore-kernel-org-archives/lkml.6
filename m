Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35034C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AF120675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 18:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBWSvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 13:51:13 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.21]:16250 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfBWSvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 13:51:12 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C17E016D27D
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 12:51:11 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xcOFgvpiVYTGMxcOFgDRD7; Sat, 23 Feb 2019 12:51:11 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=60464 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gxcOE-000w09-0t; Sat, 23 Feb 2019 12:51:10 -0600
Date:   Sat, 23 Feb 2019 12:51:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] nvmet-fc: use zero-sized array and struct_size() in kzalloc()
Message-ID: <20190223185108.GA6706@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gxcOE-000w09-0t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:60464
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the code to use a zero-sized array instead of a pointer in
structure nvmet_fc_tgt_queue and use struct_size() in kzalloc().

Notice that one of the more common cases of allocation size calculations
is finding the size of a structure that has a zero-sized array at the end,
along with memory for some number of elements for that array. For example:

struct foo {
	int stuff;
	struct boo entry[];
};

instance = kzalloc(sizeof(struct foo) + sizeof(struct boo) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can now
use the new struct_size() helper:

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/nvme/target/fc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1e9654f04c60..23baec38f97e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -128,12 +128,12 @@ struct nvmet_fc_tgt_queue {
 	struct nvmet_cq			nvme_cq;
 	struct nvmet_sq			nvme_sq;
 	struct nvmet_fc_tgt_assoc	*assoc;
-	struct nvmet_fc_fcp_iod		*fod;		/* array of fcp_iods */
 	struct list_head		fod_list;
 	struct list_head		pending_cmd_list;
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
+	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
 } __aligned(sizeof(unsigned long long));
 
 struct nvmet_fc_tgt_assoc {
@@ -588,9 +588,7 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (qid > NVMET_NR_QUEUES)
 		return NULL;
 
-	queue = kzalloc((sizeof(*queue) +
-				(sizeof(struct nvmet_fc_fcp_iod) * sqsize)),
-				GFP_KERNEL);
+	queue = kzalloc(struct_size(queue, fod, sqsize), GFP_KERNEL);
 	if (!queue)
 		return NULL;
 
@@ -603,7 +601,6 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue->work_q)
 		goto out_a_put;
 
-	queue->fod = (struct nvmet_fc_fcp_iod *)&queue[1];
 	queue->qid = qid;
 	queue->sqsize = sqsize;
 	queue->assoc = assoc;
-- 
2.20.1

