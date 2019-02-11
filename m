Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59BAC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6003222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897448;
	bh=vsvl/RBmdO8DV9rUsOFFPy6XQC91IeUG4Qp4oOsBQzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yfl0rLTQHnWxxSGIVImMaoAqurhtU7bQmf1uUBP2PmExTTCX0LkKLJADd7TwZS85w
	 A/Z+YQK4+1XgN0JU3/7TOhENW27DWgXVqltljv9prjI7VScDs9QtvGVQ59Yw+jk+8D
	 ZLR9gjR+i3E1oBy53+mVFZ6c6x1eLE2Y8zvrhOFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfBKPEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390698AbfBKPEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:04:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB71C222B1;
        Mon, 11 Feb 2019 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897441;
        bh=vsvl/RBmdO8DV9rUsOFFPy6XQC91IeUG4Qp4oOsBQzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fwe2zK9ERrzTk9u03UbkUqV9FkF0eJ/6GVz/AnUEyujxEG7icsMAENbL7M7loRsap
         Sceqv0QS+CPXZ7jNEH6/OXfiSaY07n3k+IRVO2GrGi7GoaOc+UNawM8labmTdDMUOm
         mz+78Y96WP74QyvWeN5JKzQCUOglYvJ/Smr7/Oqg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 204/205] IB/hfi1: Add limit test for RC/UC send via loopback
Date:   Mon, 11 Feb 2019 15:20:02 +0100
Message-Id: <20190211141841.901234258@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141827.214852402@linuxfoundation.org>
References: <20190211141827.214852402@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -440,6 +440,8 @@ send:
 			goto op_err;
 		if (!ret)
 			goto rnr_nak;
+		if (wqe->length > qp->r_len)
+			goto inv_err;
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -607,7 +609,10 @@ op_err:
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
@@ -425,6 +425,8 @@ again:
 			goto op_err;
 		if (!ret)
 			goto rnr_nak;
+		if (wqe->length > qp->r_len)
+			goto inv_err;
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -585,7 +587,10 @@ op_err:
 	goto err;
 
 inv_err:
-	send_status = IB_WC_REM_INV_REQ_ERR;
+	send_status =
+		sqp->ibqp.qp_type == IB_QPT_RC ?
+			IB_WC_REM_INV_REQ_ERR :
+			IB_WC_SUCCESS;
 	wc.status = IB_WC_LOC_QP_OP_ERR;
 	goto err;
 


