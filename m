Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34822C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF66E213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxxuDS1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF66E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbeK3Bax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732932AbeK3Bax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65BD72145D;
        Thu, 29 Nov 2018 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501520;
        bh=ed96p4ykzJ/5OD8f/bb9ENZym7zHLdJ+02iJFjEXi4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxxuDS1fzgNiytgXKofPnxVdMeO7ID2NP95C5uwuEvbjpmXPFkzbbx6HThFTNU2TT
         0s+Y4gGSKOnrDgPtOs1WgsqfIJv1q4e9nAiCh459zdnfRFBsFyz2hDc4ilI49IAA47
         X5Ky7Q0vZigDb9WFe4nKvbwpk49d9dVB6lkR7yAw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 031/100] IB/core: Perform modify QP on real one
Date:   Thu, 29 Nov 2018 15:12:01 +0100
Message-Id: <20181129140101.479596721@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
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

From: Parav Pandit <parav@mellanox.com>

commit b2bedfb39541a7e14798d066b6f8685d84c8fcf5 upstream.

Currently qp->port stores the port number whenever IB_QP_PORT
QP attribute mask is set (during QP state transition to INIT state).
This port number should be stored for the real QP when XRC target QP
is used.

Follow the ib_modify_qp() implementation and hide the access to ->real_qp.

Fixes: a512c2fbef9c ("IB/core: Introduce modify QP operation with udata")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/verbs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1285,7 +1285,7 @@ EXPORT_SYMBOL(ib_resolve_eth_dmac);
 
 /**
  * ib_modify_qp_with_udata - Modifies the attributes for the specified QP.
- * @qp: The QP to modify.
+ * @ib_qp: The QP to modify.
  * @attr: On input, specifies the QP attributes to modify.  On output,
  *   the current values of selected QP attributes are returned.
  * @attr_mask: A bit-mask used to specify which attributes of the QP
@@ -1294,9 +1294,10 @@ EXPORT_SYMBOL(ib_resolve_eth_dmac);
  *   are being modified.
  * It returns 0 on success and returns appropriate error code on error.
  */
-int ib_modify_qp_with_udata(struct ib_qp *qp, struct ib_qp_attr *attr,
+int ib_modify_qp_with_udata(struct ib_qp *ib_qp, struct ib_qp_attr *attr,
 			    int attr_mask, struct ib_udata *udata)
 {
+	struct ib_qp *qp = ib_qp->real_qp;
 	int ret;
 
 	if (attr_mask & IB_QP_AV) {


