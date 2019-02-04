Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE80FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E312082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277771;
	bh=jdKFL+yh5JYy86+uGO0CEyr1a8pijX88zUyNYzUQoIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VErgQCpemkFaDanNDIB3imGVszCM8DlqJ4rmLTovOtasu5usF10Wm4zn+K50T4reh
	 cSMA/Q95ZXjBBvWyKGWofYpdASCxuNlEPWLeD8BPvo6/9cRnC6nLj4TmuuifSlVlSo
	 Es4xAKV7VU5sn/vY/Nc0e5HrgYuLh1VWud403Rkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732734AbfBDK4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732312AbfBDKxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42FC5217D6;
        Mon,  4 Feb 2019 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277591;
        bh=jdKFL+yh5JYy86+uGO0CEyr1a8pijX88zUyNYzUQoIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BoRAC2Gkgk5zDVr6aXCYnVF/rc/91Sq+Uab642qxLv2DXHTxsLAZMn0hePz/iWTrY
         kb3FYuE1qv45zZORJFs0EntHDYzAGLdWmr0Fd9P7TwuwGGqPiOT/G463aE1XM+1twX
         HZWNYBwjPKtqgdWNYQVGiLWcug++++7+6KLU8JOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 63/80] IB/hfi1: Add limit test for RC/UC send via loopback
Date:   Mon,  4 Feb 2019 11:37:23 +0100
Message-Id: <20190204103628.896596005@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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

---
 drivers/infiniband/sw/rdmavt/qp.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -2903,6 +2903,8 @@ send:
 			goto op_err;
 		if (!ret)
 			goto rnr_nak;
+		if (wqe->length > qp->r_len)
+			goto inv_err;
 		break;
 
 	case IB_WR_RDMA_WRITE_WITH_IMM:
@@ -3071,7 +3073,10 @@ op_err:
 	goto err;
 
 inv_err:
-	send_status = IB_WC_REM_INV_REQ_ERR;
+	send_status =
+		sqp->ibqp.qp_type == IB_QPT_RC ?
+			IB_WC_REM_INV_REQ_ERR :
+			IB_WC_SUCCESS;
 	wc.status = IB_WC_LOC_QP_OP_ERR;
 	goto err;
 


