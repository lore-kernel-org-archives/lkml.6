Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D652C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D20520661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D20520661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeLIW11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:27:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34676 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726386AbeLIVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:12 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0002im-QP; Sun, 09 Dec 2018 21:55:06 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72Y-0003DD-6I; Sun, 09 Dec 2018 21:55:06 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Steve Wise" <swise@opengridcomputing.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "Bart Van Assche" <bart.vanassche@wdc.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.816527800@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 014/328] IB/srpt: Support HCAs with more than two ports
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit e620ebfc228dcbef7519e3d16f43c6c6f1a1d0cb upstream.

Since there are adapters that have four ports, increase the size of
the srpt_device.port[] array. This patch avoids that the following
warning is hit with quad port Chelsio adapters:

    WARN_ON(sdev->device->phys_port_cnt > ARRAY_SIZE(sdev->port));

Reported-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Steve Wise <swise@opengridcomputing.com>
Cc: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
[bwh: Backported to 3.16:
 - Use inline calculation instead of struct_size; the number of ports is not
   user-controlled so no overflow check is needed
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3147,7 +3147,9 @@ static void srpt_add_one(struct ib_devic
 	pr_debug("device = %p, device->dma_ops = %p\n", device,
 		 device->dma_ops);
 
-	sdev = kzalloc(sizeof *sdev, GFP_KERNEL);
+	sdev = kzalloc(sizeof(*sdev) +
+		       device->phys_port_cnt * sizeof(*sdev->port),
+		       GFP_KERNEL);
 	if (!sdev)
 		goto err;
 
@@ -3220,8 +3222,6 @@ static void srpt_add_one(struct ib_devic
 	for (i = 0; i < sdev->srq_size; ++i)
 		srpt_post_recv(sdev, sdev->ioctx_ring[i]);
 
-	WARN_ON(sdev->device->phys_port_cnt > ARRAY_SIZE(sdev->port));
-
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		sport->sdev = sdev;
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -387,9 +387,9 @@ struct srpt_port {
  * @rch_list:      Per-device channel list -- see also srpt_rdma_ch.list.
  * @ch_releaseQ:   Enables waiting for removal from rch_list.
  * @spinlock:      Protects rch_list and tpg.
- * @port:          Information about the ports owned by this HCA.
  * @event_handler: Per-HCA asynchronous IB event handler.
  * @list:          Node in srpt_dev_list.
+ * @port:          Information about the ports owned by this HCA.
  */
 struct srpt_device {
 	struct ib_device	*device;
@@ -403,9 +403,9 @@ struct srpt_device {
 	struct list_head	rch_list;
 	wait_queue_head_t	ch_releaseQ;
 	spinlock_t		spinlock;
-	struct srpt_port	port[2];
 	struct ib_event_handler	event_handler;
 	struct list_head	list;
+	struct srpt_port        port[];
 };
 
 /**

