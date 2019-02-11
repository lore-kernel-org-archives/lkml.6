Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850D1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5593B2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549896823;
	bh=GlQIYNAE6jRqKANaJ4A8vSe+jJI1X49qao2L/Msl244=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hHxO71De1lA67p0If7z+hsxxMxdWVQ1SAQnPsqNy53PMmAg7qM3WKq63474KRaDz7
	 ZFzk21zKbC09aw5Na/MgxJRii45dky6YU7Oc9VrBNpWxSLaEAe67ShhOuylfT611vM
	 eLZqfTSqn1m1dmjd7f1wSKf+lnOAs4plOYoEvxPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbfBKOxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:53:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbfBKOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:53:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2F920855;
        Mon, 11 Feb 2019 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896819;
        bh=GlQIYNAE6jRqKANaJ4A8vSe+jJI1X49qao2L/Msl244=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rMiwHvZ5A4xoKB6TkJn4ZBm2VAqaDzwWrH1XFxYmsmZWClLeMV5mR4SFym1qBRJLd
         a1Iv7/ID8HXO9I4oXpLWURKXYAehUMnt8ck6Z5gLvBfnusC7kQKXOhoBfg5mTJLo4Z
         lYfN6ArzyVWRo7yIuWXpVzoDImvM0FL4EC/X0gtw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.19 312/313] IB/hfi1: Add limit test for RC/UC send via loopback
Date:   Mon, 11 Feb 2019 15:19:52 +0100
Message-Id: <20190211141913.632141883@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Marciniszyn <mike.marciniszyn@intel.com>

commit 09ce351dff8e7636af0beb72cd4a86c3904a0500 upstream.

Fix potential memory corruption and panic in loopback for IB_WR_SEND
variants.

The code blindly assumes the posted length will fit in the fetched rwqe,
which is not a valid assumption.

Fix by adding a limit test, and triggering the appropriate send completion
and putting the QP in an error state.  This mimics the handling for
non-loopback QPs.

Fixes: 15703461533a ("IB/{hfi1, qib, rdmavt}: Move ruc_loopback to rdmavt")
Cc: <stable@vger.kernel.org> #v4.20+
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mike Marciniszyn <mike.marciniszyn@intel.com>

---
 drivers/infiniband/hw/hfi1/ruc.c    |    7 ++++++-
 drivers/infiniband/hw/qib/qib_ruc.c |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/hfi1/ruc.c
+++ b/drivers/infiniband/hw/hfi1/ruc.c
@@ -278,6 +278,8 @@ send:
 			goto op_err;
 		if (!ret)
 			goto rnr_nak;
+		if (wqe->length > qp->r_len)
+			goto inv_err;
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -445,7 +447,10 @@ op_err:
 	goto err;
 
 inv_err:
-	send_status = IB_WC_REM_INV_REQ_ERR;
+	send_status =
+		sqp->ibqp.qp_type == IB_QPT_RC ?
+			IB_WC_REM_INV_REQ_ERR :
+			IB_WC_SUCCESS;
 	wc.status = IB_WC_LOC_QP_OP_ERR;
 	goto err;
 
--- a/drivers/infiniband/hw/qib/qib_ruc.c
+++ b/drivers/infiniband/hw/qib/qib_ruc.c
@@ -274,6 +274,8 @@ again:
 			goto op_err;
 		if (!ret)
 			goto rnr_nak;
+		if (wqe->length > qp->r_len)
+			goto inv_err;
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -434,7 +436,10 @@ op_err:
 	goto err;
 
 inv_err:
-	send_status = IB_WC_REM_INV_REQ_ERR;
+	send_status =
+		sqp->ibqp.qp_type == IB_QPT_RC ?
+			IB_WC_REM_INV_REQ_ERR :
+			IB_WC_SUCCESS;
 	wc.status = IB_WC_LOC_QP_OP_ERR;
 	goto err;
 


