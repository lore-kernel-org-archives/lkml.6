Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1412C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758B52147A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758B52147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731878AbeHWMHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbeHWMHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:51 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 861C4941;
        Thu, 23 Aug 2018 08:39:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 005/324] IB/rxe: avoid double kfree skb
Date:   Thu, 23 Aug 2018 09:51:11 +0200
Message-Id: <20180823074956.187536669@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhu Yanjun <yanjun.zhu@oracle.com>

[ Upstream commit 828d810550abc1fffff9b20545fec4bc150d5e82 ]

In rxe_send, when network_type is not RDMA_NETWORK_IPV4 or
RDMA_NETWORK_IPV6, skb is freed and -EINVAL is returned.
Then rxe_xmit_packet will return -EINVAL, too. In rxe_requester,
this skb is double freed.
In rxe_requester, kfree_skb is needed only after fill_packet fails.
So kfree_skb is moved from label err to test fill_packet.

Fixes: 5793b4652155 ("IB/rxe: remove unnecessary skb_clone in xmit")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_req.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -709,6 +709,7 @@ next_wqe:
 
 	if (fill_packet(qp, wqe, &pkt, skb, payload)) {
 		pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
+		kfree_skb(skb);
 		goto err;
 	}
 
@@ -740,7 +741,6 @@ next_wqe:
 	goto next_wqe;
 
 err:
-	kfree_skb(skb);
 	wqe->status = IB_WC_LOC_PROT_ERR;
 	wqe->state = wqe_state_error;
 	__rxe_do_task(&qp->comp.task);


