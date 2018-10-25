Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624CEECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205222086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlrfKg1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205222086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeJYWs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728175AbeJYWs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:58 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8174D20848;
        Thu, 25 Oct 2018 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476962;
        bh=QVOnltH6ZMYEEl1XaQ4h1QFniEtcO+XNrgbkl4lwbJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlrfKg1/Ct3CVYNvQGTEfHOEYu2a66rFERYjgh0URAgha8WfbTmu4MiBI0Y3Ioyxo
         MntPt2mD73bzOlh30HsscB+E2r7EC02l6wZogkHR5BPpxLqnifaqbG7bI+dH06mL1U
         hKkPAFHMzMXYF6MytUkzZBRsOtlBwEkvf0uJY2L8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josef Bacik <jbacik@fb.com>, Jens Axboe <axboe@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 67/98] nbd: only set MSG_MORE when we have more to send
Date:   Thu, 25 Oct 2018 10:13:52 -0400
Message-Id: <20181025141423.213774-67-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Bacik <jbacik@fb.com>

[ Upstream commit d61b7f972dab2a7d187c38254845546dfc8eed85 ]

A user noticed that write performance was horrible over loopback and we
traced it to an inversion of when we need to set MSG_MORE.  It should be
set when we have more bvec's to send, not when we are on the last bvec.
This patch made the test go from 20 iops to 78k iops.

Signed-off-by: Josef Bacik <jbacik@fb.com>
Fixes: 429a787be679 ("nbd: fix use-after-free of rq/bio in the xmit path")
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 4d30da269060..42a53956aefe 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -269,7 +269,7 @@ static inline int sock_send_bvec(struct nbd_device *nbd, struct bio_vec *bvec,
 static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 {
 	struct request *req = blk_mq_rq_from_pdu(cmd);
-	int result, flags;
+	int result;
 	struct nbd_request request;
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
@@ -309,7 +309,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 	if (type != NBD_CMD_WRITE)
 		return 0;
 
-	flags = 0;
 	bio = req->bio;
 	while (bio) {
 		struct bio *next = bio->bi_next;
@@ -318,9 +317,8 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd)
 
 		bio_for_each_segment(bvec, bio, iter) {
 			bool is_last = !next && bio_iter_last(bvec, iter);
+			int flags = is_last ? 0 : MSG_MORE;
 
-			if (is_last)
-				flags = MSG_MORE;
 			dev_dbg(nbd_to_dev(nbd), "request %p: sending %d bytes data\n",
 				cmd, bvec.bv_len);
 			result = sock_send_bvec(nbd, &bvec, flags);
-- 
2.17.1

