Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58885C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F65C20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Np2dOVEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F65C20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeKIH7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbeKIHnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4FB21486;
        Thu,  8 Nov 2018 22:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714735;
        bh=2LXqvFmSSn6Z59FYDKX3dxJbaMFBhvXkajughPQxPZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Np2dOVEU5LXMMjZUre4WgDMZP7ze1HjVLjLUYfmLM9J9XFbO45Gno45X3ogCinwpP
         /I+U3j8FlIyBv05OZ4J9Sr5mFCXFN63u6maieiuBiKieDpSzj+EoU73QAEolWfNRms
         5VPVC69/OFxh7+g5dcQYOtmB2yOCtX1Xspczju4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 096/171] nbd: only set MSG_MORE when we have more to send
Date:   Thu,  8 Nov 2018 13:51:06 -0800
Message-Id: <20181108215134.445993898@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



