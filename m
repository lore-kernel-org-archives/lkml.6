Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A94BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A312064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A312064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeHWLfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:35:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44716 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeHWLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:35:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 08D23C7B;
        Thu, 23 Aug 2018 08:07:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vijay Immanuel <vijayi@attalasystems.com>,
        Yonatan Cohen <yonatanc@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 016/130] IB/rxe: Fix missing completion for mem_reg work requests
Date:   Thu, 23 Aug 2018 09:52:12 +0200
Message-Id: <20180823074928.416818178@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
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

From: Vijay Immanuel <vijayi@attalasystems.com>

[ Upstream commit 375dc53d032fc11e98036b5f228ad13f7c5933f5 ]

Run the completer task to post a work completion after processing
a memory registration or invalidate work request. This covers the
case where the memory registration or invalidate was the last work
request posted to the qp.

Signed-off-by: Vijay Immanuel <vijayi@attalasystems.com>
Reviewed-by: Yonatan Cohen <yonatanc@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_req.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -648,6 +648,9 @@ next_wqe:
 		} else {
 			goto exit;
 		}
+		if ((wqe->wr.send_flags & IB_SEND_SIGNALED) ||
+		    qp->sq_sig_type == IB_SIGNAL_ALL_WR)
+			rxe_run_task(&qp->comp.task, 1);
 		qp->req.wqe_index = next_index(qp->sq.queue,
 						qp->req.wqe_index);
 		goto next_wqe;


