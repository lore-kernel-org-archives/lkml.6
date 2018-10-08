Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2F0C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41AF4214C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQnsgRLE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AF4214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732125AbeJICDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbeJICDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:42 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83995214DA;
        Mon,  8 Oct 2018 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024635;
        bh=upLm+mo08S7ILHAjdRv8ODefobKvsA20ykdFH5SKyG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQnsgRLEbV4B0lPDOdOnf7V3lS9lfY4OlAYaUxaOkFuzl4cEgcYTO0gaoQwqtzy/4
         4j5w9xgNnhpjEcos5EI5+p2CDeO+Am6CMeqkQ1XL32L9qYVzcQNEBTA5tO87/GXczf
         LbGOyRqYGTZJ5b0uQkJ4zu2+WEbsReL04Jxinsn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Somnath Kotur <somnath.kotur@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 104/168] bnxt_re: Fix couple of memory leaks that could lead to IOMMU call traces
Date:   Mon,  8 Oct 2018 20:31:24 +0200
Message-Id: <20181008175624.009943231@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Somnath Kotur <somnath.kotur@broadcom.com>

[ Upstream commit f40f299bbe806a2e2c8b0d7cdda822fa3bdd171b ]

1. DMA-able memory allocated for Shadow QP was not being freed.
2. bnxt_qplib_alloc_qp_hdr_buf() had a bug wherein the SQ pointer was
   erroneously pointing to the RQ. But since the corresponding
   free_qp_hdr_buf() was correct, memory being free was less than what was
   allocated.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |    2 ++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -844,6 +844,8 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_
 				"Failed to destroy Shadow QP");
 			return rc;
 		}
+		bnxt_qplib_free_qp_res(&rdev->qplib_res,
+				       &rdev->qp1_sqp->qplib_qp);
 		mutex_lock(&rdev->qp_lock);
 		list_del(&rdev->qp1_sqp->list);
 		atomic_dec(&rdev->qp_count);
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -196,7 +196,7 @@ static int bnxt_qplib_alloc_qp_hdr_buf(s
 				       struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_q *rq = &qp->rq;
-	struct bnxt_qplib_q *sq = &qp->rq;
+	struct bnxt_qplib_q *sq = &qp->sq;
 	int rc = 0;
 
 	if (qp->sq_hdr_buf_size && sq->hwq.max_elements) {


