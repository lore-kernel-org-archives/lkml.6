Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C544C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E34208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107192;
	bh=6CusEYzlI2vLH/tmi7CarMbssxIkNqmfJhGXh0cDArI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GDfdygp1cMC4ofpGQwwaXv107H1VwHh79+vXwtNP3JkWhiBEs4wFlUt+Iy8jrs4Rl
	 pGQP/iaq64oBNV2XVpujI2tZ+ERQ4IONLmO7GC4odOcU8fHgssOkEBnuipf1L7ZnLe
	 6Rz9zxsn3AmS098epBanw+ac0VVmRb8fJ4NvG5Rk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E34208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeLFOjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbeLFOju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:39:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB0520672;
        Thu,  6 Dec 2018 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107189;
        bh=6CusEYzlI2vLH/tmi7CarMbssxIkNqmfJhGXh0cDArI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PIzSGGGnstwpdr3HTk6o9TWk+xmwgqW5P+ipq1Hnv0qlsorW1QNym6O81oi4iQYqB
         tQLgcoT71bTZc41AIncws0UE0AbcJ411xzBVNnYW8/GSPqaR2WuM4ta+iIoAMnIRm5
         x/gNWXfS/D6zn2uQqvfj2AnN9g4V77bAYNfaIe+o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 01/41] blk-mq: fix corruption with direct issue
Date:   Thu,  6 Dec 2018 15:38:41 +0100
Message-Id: <20181206142949.916980889@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206142949.757402551@linuxfoundation.org>
References: <20181206142949.757402551@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit ffe81d45322cc3cb140f0db080a4727ea284661e upstream.

If we attempt a direct issue to a SCSI device, and it returns BUSY, then
we queue the request up normally. However, the SCSI layer may have
already setup SG tables etc for this particular command. If we later
merge with this request, then the old tables are no longer valid. Once
we issue the IO, we only read/write the original part of the request,
not the new state of it.

This causes data corruption, and is most often noticed with the file
system complaining about the just read data being invalid:

[  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)

because most of it is garbage...

This doesn't happen from the normal issue path, as we will simply defer
the request to the hardware queue dispatch list if we fail. Once it's on
the dispatch list, we never merge with it.

Fix this from the direct issue path by flagging the request as
REQ_NOMERGE so we don't change the size of it before issue.

See also:
  https://bugzilla.kernel.org/show_bug.cgi?id=201685

Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-mq.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1698,6 +1698,15 @@ static blk_status_t __blk_mq_issue_direc
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
+		/*
+		 * If direct dispatch fails, we cannot allow any merging on
+		 * this IO. Drivers (like SCSI) may have set up permanent state
+		 * for this request, like SG tables and mappings, and if we
+		 * merge to it later on then we'll still only do IO to the
+		 * original part.
+		 */
+		rq->cmd_flags |= REQ_NOMERGE;
+
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;
@@ -1710,6 +1719,18 @@ static blk_status_t __blk_mq_issue_direc
 	return ret;
 }
 
+/*
+ * Don't allow direct dispatch of anything but regular reads/writes,
+ * as some of the other commands can potentially share request space
+ * with data we need for the IO scheduler. If we attempt a direct dispatch
+ * on those and fail, we can't safely add it to the scheduler afterwards
+ * without potentially overwriting data that the driver has already written.
+ */
+static bool blk_rq_can_direct_dispatch(struct request *rq)
+{
+	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
+}
+
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
@@ -1731,7 +1752,7 @@ static blk_status_t __blk_mq_try_issue_d
 		goto insert;
 	}
 
-	if (q->elevator && !bypass_insert)
+	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
 		goto insert;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
@@ -1793,6 +1814,9 @@ void blk_mq_try_issue_list_directly(stru
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
+		if (!blk_rq_can_direct_dispatch(rq))
+			break;
+
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
 		if (ret != BLK_STS_OK) {


