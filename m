Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544AAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267E12083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267E12083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbeJBU6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:58:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60008 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbeJBUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:15 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95218BF0;
        Tue,  2 Oct 2018 13:26:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 031/228] RDMA/bnxt_re: Fix a bunch of off by one bugs in qplib_fp.c
Date:   Tue,  2 Oct 2018 06:22:08 -0700
Message-Id: <20181002132501.190272232@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit c1dfc0114c901b4f46c85ceff0491debf2b2a2ec ]

The srq->swq[] is allocated in bnxt_qplib_create_srq().  It has
srq->hwq.max_elements elements so these tests should be > instead of >=
or we might go beyond the end of the array.

Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -2354,7 +2354,7 @@ static int bnxt_qplib_cq_process_res_rc(
 		srq = qp->srq;
 		if (!srq)
 			return -EINVAL;
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >= srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process RC ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2369,7 +2369,7 @@ static int bnxt_qplib_cq_process_res_rc(
 		*pcqe = cqe;
 	} else {
 		rq = &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >= rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process RC ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2437,7 +2437,7 @@ static int bnxt_qplib_cq_process_res_ud(
 		if (!srq)
 			return -EINVAL;
 
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >= srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process UD ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2452,7 +2452,7 @@ static int bnxt_qplib_cq_process_res_ud(
 		*pcqe = cqe;
 	} else {
 		rq = &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >= rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process UD ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2546,7 +2546,7 @@ static int bnxt_qplib_cq_process_res_raw
 				"QPLIB: FP: SRQ used but not defined??");
 			return -EINVAL;
 		}
-		if (wr_id_idx > srq->hwq.max_elements) {
+		if (wr_id_idx >= srq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process Raw/QP1 ");
 			dev_err(&cq->hwq.pdev->dev,
@@ -2561,7 +2561,7 @@ static int bnxt_qplib_cq_process_res_raw
 		*pcqe = cqe;
 	} else {
 		rq = &qp->rq;
-		if (wr_id_idx > rq->hwq.max_elements) {
+		if (wr_id_idx >= rq->hwq.max_elements) {
 			dev_err(&cq->hwq.pdev->dev,
 				"QPLIB: FP: CQ Process Raw/QP1 RQ wr_id ");
 			dev_err(&cq->hwq.pdev->dev,


