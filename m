Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A36DC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505C320866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iYSj5OBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505C320866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeKKXVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:21:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbeKKXVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9xSQjtstEtzxm1uf6+OoapYv+bUHEexWRQgpZv4NLbA=; b=iYSj5OBkNi/1b8KjqemwsVAzTs
        CtEFa1+u7qlJNQ2mSkuYP8Cs3zS8KdA1CoFFu/STtlYL2qKWlBo1iJHxrDbKzzof+BaPTZD4lLRJy
        xnWz/niPZnWYthQRpHNWUYPr9zTsXWmCFcZtzQWoP1lNMBcKlueQQx4Nrqsr/uwSl55QdIIkSmZJX
        MQAlZuRR6iS34BTu69oSoTpiQ344JWm0JlfW+06VDWHuz587aO7BVp8ucKn74VfLcRG9WsdqV0u5+
        AgD0kerE7kvGv9T2B0arHkCAL0UqtnGAKFTXPM2lyf97C4+BKmbn0LKVuj7NAgWvJPAl4+zmmZCDx
        FJqJR43A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLpqk-0007YU-Ih; Sun, 11 Nov 2018 13:32:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] scsi: stop setting up request->special
Date:   Sun, 11 Nov 2018 14:32:07 +0100
Message-Id: <20181111133211.13926-5-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111133211.13926-1-hch@lst.de>
References: <20181111133211.13926-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No more need in a blk-mq world where the scsi command and request
are allocated together.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/qedf/qedf_io.c | 6 ------
 drivers/scsi/qedi/qedi_fw.c | 7 -------
 drivers/scsi/scsi_lib.c     | 3 ---
 drivers/scsi/sd.c           | 1 -
 drivers/scsi/sr.c           | 1 -
 5 files changed, 18 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 6bbc38b1b465..6ca583bdde23 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1128,12 +1128,6 @@ void qedf_scsi_completion(struct qedf_ctx *qedf, struct fcoe_cqe *cqe,
 		return;
 	}
 
-	if (!sc_cmd->request->special) {
-		QEDF_WARN(&(qedf->dbg_ctx), "request->special is NULL so "
-		    "request not valid, sc_cmd=%p.\n", sc_cmd);
-		return;
-	}
-
 	if (!sc_cmd->request->q) {
 		QEDF_WARN(&(qedf->dbg_ctx), "request->q is NULL so request "
 		   "is not valid, sc_cmd=%p.\n", sc_cmd);
diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 25d763ae5d5a..e2a995a6e8e7 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -616,13 +616,6 @@ static void qedi_scsi_completion(struct qedi_ctx *qedi,
 		goto error;
 	}
 
-	if (!sc_cmd->request->special) {
-		QEDI_WARN(&qedi->dbg_ctx,
-			  "request->special is NULL so request not valid, sc_cmd=%p.\n",
-			  sc_cmd);
-		goto error;
-	}
-
 	if (!sc_cmd->request->q) {
 		QEDI_WARN(&qedi->dbg_ctx,
 			  "request->q is NULL so request is not valid, sc_cmd=%p.\n",
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 369c15a701f1..d65f838af6eb 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1561,10 +1561,7 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
 
 	scsi_init_command(sdev, cmd);
 
-	req->special = cmd;
-
 	cmd->request = req;
-
 	cmd->tag = req->tag;
 	cmd->prot_op = SCSI_PROT_NORMAL;
 
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 4a6ed2fc8c71..96e906e438d2 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1026,7 +1026,6 @@ static blk_status_t sd_setup_read_write_cmnd(struct scsi_cmnd *SCpnt)
 	ret = scsi_init_io(SCpnt);
 	if (ret != BLK_STS_OK)
 		return ret;
-	WARN_ON_ONCE(SCpnt != rq->special);
 
 	SCSI_LOG_HLQUEUE(1,
 		scmd_printk(KERN_INFO, SCpnt,
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 38ddbbfe5f3c..039c27c2d7b3 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -394,7 +394,6 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	ret = scsi_init_io(SCpnt);
 	if (ret != BLK_STS_OK)
 		goto out;
-	WARN_ON_ONCE(SCpnt != rq->special);
 	cd = scsi_cd(rq->rq_disk);
 
 	/* from here on until we're complete, any goto out
-- 
2.19.1

