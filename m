Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5223C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF102075E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF102075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbeICVgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:36:45 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbeICVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:36:44 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 79D9AD02;
        Mon,  3 Sep 2018 17:15:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 014/165] nbd: dont requeue the same request twice.
Date:   Mon,  3 Sep 2018 18:55:00 +0200
Message-Id: <20180903165655.718803447@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit d7d94d48a272fd7583dc3c83acb8f5ed4ef456a4 ]

We can race with the snd timeout and the per-request timeout and end up
requeuing the same request twice.  We can't use the send_complete
completion to tell if everything is ok because we hold the tx_lock
during send, so the timeout stuff will block waiting to mark the socket
dead, and we could be marked complete and still requeue.  Instead add a
flag to the socket so we know whether we've been requeued yet.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/nbd.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -112,12 +112,15 @@ struct nbd_device {
 	struct task_struct *task_setup;
 };
 
+#define NBD_CMD_REQUEUED	1
+
 struct nbd_cmd {
 	struct nbd_device *nbd;
 	int index;
 	int cookie;
 	struct completion send_complete;
 	blk_status_t status;
+	unsigned long flags;
 };
 
 #if IS_ENABLED(CONFIG_DEBUG_FS)
@@ -146,6 +149,14 @@ static inline struct device *nbd_to_dev(
 	return disk_to_dev(nbd->disk);
 }
 
+static void nbd_requeue_cmd(struct nbd_cmd *cmd)
+{
+	struct request *req = blk_mq_rq_from_pdu(cmd);
+
+	if (!test_and_set_bit(NBD_CMD_REQUEUED, &cmd->flags))
+		blk_mq_requeue_request(req, true);
+}
+
 static const char *nbdcmd_to_ascii(int cmd)
 {
 	switch (cmd) {
@@ -328,7 +339,7 @@ static enum blk_eh_timer_return nbd_xmit
 					nbd_mark_nsock_dead(nbd, nsock, 1);
 				mutex_unlock(&nsock->tx_lock);
 			}
-			blk_mq_requeue_request(req, true);
+			nbd_requeue_cmd(cmd);
 			nbd_config_put(nbd);
 			return BLK_EH_NOT_HANDLED;
 		}
@@ -484,6 +495,7 @@ static int nbd_send_cmd(struct nbd_devic
 				nsock->pending = req;
 				nsock->sent = sent;
 			}
+			set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 			return BLK_STS_RESOURCE;
 		}
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -525,6 +537,7 @@ send_pages:
 					 */
 					nsock->pending = req;
 					nsock->sent = sent;
+					set_bit(NBD_CMD_REQUEUED, &cmd->flags);
 					return BLK_STS_RESOURCE;
 				}
 				dev_err(disk_to_dev(nbd->disk),
@@ -793,7 +806,7 @@ again:
 	 */
 	blk_mq_start_request(req);
 	if (unlikely(nsock->pending && nsock->pending != req)) {
-		blk_mq_requeue_request(req, true);
+		nbd_requeue_cmd(cmd);
 		ret = 0;
 		goto out;
 	}
@@ -806,7 +819,7 @@ again:
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
 				    "Request send failed, requeueing\n");
 		nbd_mark_nsock_dead(nbd, nsock, 1);
-		blk_mq_requeue_request(req, true);
+		nbd_requeue_cmd(cmd);
 		ret = 0;
 	}
 out:
@@ -831,6 +844,7 @@ static blk_status_t nbd_queue_rq(struct
 	 * done sending everything over the wire.
 	 */
 	init_completion(&cmd->send_complete);
+	clear_bit(NBD_CMD_REQUEUED, &cmd->flags);
 
 	/* We can be called directly from the user space process, which means we
 	 * could possibly have signals pending so our sendmsg will fail.  In
@@ -1446,6 +1460,7 @@ static int nbd_init_request(struct blk_m
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	cmd->nbd = set->driver_data;
+	cmd->flags = 0;
 	return 0;
 }
 


