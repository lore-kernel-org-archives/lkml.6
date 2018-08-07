Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9276AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518972172F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518972172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404295AbeHGVKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:10:49 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33620 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbeHGVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:10:48 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B0E71D07;
        Tue,  7 Aug 2018 18:55:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kamenee Arumugam <kamenee.arumugam@intel.com>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.9 16/17] IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values
Date:   Tue,  7 Aug 2018 20:51:52 +0200
Message-Id: <20180807172342.950165138@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172342.071526922@linuxfoundation.org>
References: <20180807172342.071526922@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit b697d7d8c741f27b728a878fc55852b06d0f6f5e upstream.

The __get_txreq() function can return a pointer, ERR_PTR(-EBUSY), or NULL.
All of the relevant call sites look for IS_ERR, so the NULL return would
lead to a NULL pointer exception.

Do not use the ERR_PTR mechanism for this function.

Update all call sites to handle the return value correctly.

Clean up error paths to reflect return value.

Fixes: 45842abbb292 ("staging/rdma/hfi1: move txreq header code")
Cc: <stable@vger.kernel.org> # 4.9.x+
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/hfi1/rc.c          |    2 +-
 drivers/infiniband/hw/hfi1/uc.c          |    4 ++--
 drivers/infiniband/hw/hfi1/ud.c          |    4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.c |    4 ++--
 drivers/infiniband/hw/hfi1/verbs_txreq.h |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -397,7 +397,7 @@ int hfi1_make_rc_req(struct rvt_qp *qp,
 
 	lockdep_assert_held(&qp->s_lock);
 	ps->s_txreq = get_txreq(ps->dev, qp);
-	if (IS_ERR(ps->s_txreq))
+	if (!ps->s_txreq)
 		goto bail_no_tx;
 
 	ohdr = &ps->s_txreq->phdr.hdr.u.oth;
--- a/drivers/infiniband/hw/hfi1/uc.c
+++ b/drivers/infiniband/hw/hfi1/uc.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -72,7 +72,7 @@ int hfi1_make_uc_req(struct rvt_qp *qp,
 	int middle = 0;
 
 	ps->s_txreq = get_txreq(ps->dev, qp);
-	if (IS_ERR(ps->s_txreq))
+	if (!ps->s_txreq)
 		goto bail_no_tx;
 
 	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_SEND_OK)) {
--- a/drivers/infiniband/hw/hfi1/ud.c
+++ b/drivers/infiniband/hw/hfi1/ud.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -285,7 +285,7 @@ int hfi1_make_ud_req(struct rvt_qp *qp,
 	u8 sc5;
 
 	ps->s_txreq = get_txreq(ps->dev, qp);
-	if (IS_ERR(ps->s_txreq))
+	if (!ps->s_txreq)
 		goto bail_no_tx;
 
 	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_NEXT_SEND_OK)) {
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.c
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2016 Intel Corporation.
+ * Copyright(c) 2016 - 2018 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -94,7 +94,7 @@ struct verbs_txreq *__get_txreq(struct h
 				struct rvt_qp *qp)
 	__must_hold(&qp->s_lock)
 {
-	struct verbs_txreq *tx = ERR_PTR(-EBUSY);
+	struct verbs_txreq *tx = NULL;
 
 	write_seqlock(&dev->iowait_lock);
 	if (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) {
--- a/drivers/infiniband/hw/hfi1/verbs_txreq.h
+++ b/drivers/infiniband/hw/hfi1/verbs_txreq.h
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2016 Intel Corporation.
+ * Copyright(c) 2016 - 2018 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -82,7 +82,7 @@ static inline struct verbs_txreq *get_tx
 	if (unlikely(!tx)) {
 		/* call slow path to get the lock */
 		tx = __get_txreq(dev, qp);
-		if (IS_ERR(tx))
+		if (!tx)
 			return tx;
 	}
 	tx->qp = qp;


