Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC7C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44EE213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddg6YjOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44EE213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbeKTDQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbeKTDQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD22208E3;
        Mon, 19 Nov 2018 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646347;
        bh=GNsD2NePsOXSIsSVy7e8jGq17bJzFPBverSk9/KVHWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddg6YjOm1+yr1XU3o1GAChcDbYCdBVWWSRvsvrCKyQ2pohPB3/jdh42sFGKvwjArk
         3cWpparaZwDpotLN+Z3bSyDxhxGVlR78nmbebYN56kwGvcmpBzTFLw9zk0lLLvzm7E
         Q7hT9R/DG+ClFBy1Pz0D65kUqtdT4hgvJOuP/9Q0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 123/124] nvme-loop: fix kernel oops in case of unhandled command
Date:   Mon, 19 Nov 2018 17:29:37 +0100
Message-Id: <20181119162634.214715057@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

commit 11d9ea6f2ca69237d35d6c55755beba3e006b106 upstream.

When nvmet_req_init() fails, __nvmet_req_complete() is called
to handle the target request via .queue_response(), so
nvme_loop_queue_response() shouldn't be called again for
handling the failure.

This patch fixes this case by the following way:

- move blk_mq_start_request() before nvmet_req_init(), so
nvme_loop_queue_response() may work well to complete this
host request

- don't call nvme_cleanup_cmd() which is done in nvme_loop_complete_rq()

- don't call nvme_loop_queue_response() which is done via
.queue_response()

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[trimmed changelog]
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/target/loop.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -183,15 +183,12 @@ static blk_status_t nvme_loop_queue_rq(s
 	if (ret)
 		return ret;
 
+	blk_mq_start_request(req);
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = nvmet_loop_port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
-			&queue->nvme_sq, &nvme_loop_ops)) {
-		nvme_cleanup_cmd(req);
-		blk_mq_start_request(req);
-		nvme_loop_queue_response(&iod->req);
+			&queue->nvme_sq, &nvme_loop_ops))
 		return BLK_STS_OK;
-	}
 
 	if (blk_rq_bytes(req)) {
 		iod->sg_table.sgl = iod->first_sgl;
@@ -204,8 +201,6 @@ static blk_status_t nvme_loop_queue_rq(s
 		iod->req.sg_cnt = blk_rq_map_sg(req->q, req, iod->sg_table.sgl);
 	}
 
-	blk_mq_start_request(req);
-
 	schedule_work(&iod->work);
 	return BLK_STS_OK;
 }


