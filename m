Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89858C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F292075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F292075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeIHB5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:57:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42058 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727683AbeIHB5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:57:06 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 59CD5F07;
        Fri,  7 Sep 2018 21:14:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Wise <swise@opengridcomputing.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.18 044/145] IB/srpt: Support HCAs with more than two ports
Date:   Fri,  7 Sep 2018 23:08:30 +0200
Message-Id: <20180907210908.132000718@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Reviewed-by: Steve Wise <swise@opengridcomputing.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    5 ++---
 drivers/infiniband/ulp/srpt/ib_srpt.h |    4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2983,7 +2983,8 @@ static void srpt_add_one(struct ib_devic
 
 	pr_debug("device = %p\n", device);
 
-	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
+	sdev = kzalloc(struct_size(sdev, port, device->phys_port_cnt),
+		       GFP_KERNEL);
 	if (!sdev)
 		goto err;
 
@@ -3037,8 +3038,6 @@ static void srpt_add_one(struct ib_devic
 			      srpt_event_handler);
 	ib_register_event_handler(&sdev->event_handler);
 
-	WARN_ON(sdev->device->phys_port_cnt > ARRAY_SIZE(sdev->port));
-
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		INIT_LIST_HEAD(&sport->nexus_list);
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -396,9 +396,9 @@ struct srpt_port {
  * @sdev_mutex:	   Serializes use_srq changes.
  * @use_srq:       Whether or not to use SRQ.
  * @ioctx_ring:    Per-HCA SRQ.
- * @port:          Information about the ports owned by this HCA.
  * @event_handler: Per-HCA asynchronous IB event handler.
  * @list:          Node in srpt_dev_list.
+ * @port:          Information about the ports owned by this HCA.
  */
 struct srpt_device {
 	struct ib_device	*device;
@@ -410,9 +410,9 @@ struct srpt_device {
 	struct mutex		sdev_mutex;
 	bool			use_srq;
 	struct srpt_recv_ioctx	**ioctx_ring;
-	struct srpt_port	port[2];
 	struct ib_event_handler	event_handler;
 	struct list_head	list;
+	struct srpt_port        port[];
 };
 
 #endif				/* IB_SRPT_H */


