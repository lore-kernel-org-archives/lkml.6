Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23962082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23962082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbeH3W66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:58:58 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40048 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeH3W5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:57:41 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fvS4t-0006Om-Nd; Thu, 30 Aug 2018 12:54:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1fvS4o-0000tZ-RG; Thu, 30 Aug 2018 12:53:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 30 Aug 2018 12:53:46 -0600
Message-Id: <20180830185352.3369-8-logang@deltatee.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, linux-block@vger.kernel.org, sbates@raithlin.com, hch@lst.de, sagi@grimberg.me, bhelgaas@google.com, jgg@mellanox.com, maxg@mellanox.com, keith.busch@intel.com, dan.j.williams@intel.com, benh@kernel.crashing.org, jglisse@redhat.com, alex.williamson@redhat.com, christian.koenig@amd.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v5 07/13] block: Add PCI P2P flag for request queue and check support for requests
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
supports targeting P2P memory.

When a request is submitted we check if PCI P2PDMA memory is assigned
to the first page in the bio. If it is, we ensure the queue it's
submitted to supports it, and enforce REQ_NOMERGE.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-core.c       | 14 ++++++++++++++
 include/linux/blkdev.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c282efb..cc0289c7b983 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2264,6 +2264,20 @@ generic_make_request_checks(struct bio *bio)
 	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_rq_based(q))
 		goto not_supported;
 
+	/*
+	 * Ensure PCI P2PDMA memory is not used in requests to queues that
+	 * have no support. This should never happen if the higher layers using
+	 * P2PDMA do the right thing and use the proper P2PDMA client
+	 * infrastructure. Also, ensure such requests use REQ_NOMERGE
+	 * seeing requests can not mix P2PDMA and non-P2PDMA memory at
+	 * this time.
+	 */
+	if (bio->bi_vcnt && is_pci_p2pdma_page(bio->bi_io_vec->bv_page)) {
+		if (WARN_ON_ONCE(!blk_queue_pci_p2pdma(q)))
+			goto not_supported;
+		bio->bi_opf |= REQ_NOMERGE;
+	}
+
 	if (should_fail_bio(bio))
 		goto end_io;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0e2b64..7bf80ca802e1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,6 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PCI_P2PDMA  30	/* device supports pci p2p requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -731,6 +732,8 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
+#define blk_queue_pci_p2pdma(q)	\
+	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.11.0

