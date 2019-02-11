Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C8FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FC8222A8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897036;
	bh=gxrcmFMq+iKSRNTZwlLiBNJF/2XMBk2dfAQN7VoVJQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pEyXdJVZ9fy9wSS8k69wGtMcpcUtMoewkxVjvN8/Qc/W8w3qIbmoDk6b/yvEAmRJk
	 08Fr4wn/V+SiSFCTZ0uRLZgCyaJ3gKbeR0o9EBhT1+xkjv58bQnMISkJ0frsb0AN2A
	 XVpVys0YGoEnQ8qdq4TfPMTw5DZsjjg2nUjyfXpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388740AbfBKO5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:57:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:44572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388679AbfBKO5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:57:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4EB0222A8;
        Mon, 11 Feb 2019 14:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897032;
        bh=gxrcmFMq+iKSRNTZwlLiBNJF/2XMBk2dfAQN7VoVJQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=huW7K/ZFVYJbA5eyaqftwOeZyqNxUJW3eGT/BdPjpPM+OWlOfMFm7kD33SiQ4nu0V
         bkkXRmn3EcG0Cx7pw4EkhnFRtOw52w94oj8jS2J/uRjtdGtTThvt1DSQNvJfPVTPsv
         FJOSq+BPkGeN4Dh+0OTVmyIKTf7RTT/+cFJRHvtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 069/205] IB/hfi1: Unreserve a reserved request when it is completed
Date:   Mon, 11 Feb 2019 15:17:47 +0100
Message-Id: <20190211141833.257445558@linuxfoundation.org>
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

[ Upstream commit ca95f802ef5139722acc8d30aeaab6fe5bbe939e ]

Currently, When a reserved operation is completed, its entry in the send
queue will not be unreserved, which leads to the miscalculation of
qp->s_avail and thus the triggering of a WARN_ON call trace. This patch
fixes the problem by unreserving the reserved operation when it is
completed.

Fixes: 856cc4c237ad ("IB/hfi1: Add the capability for reserved operations")
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hfi1/rc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hfi1/rc.c b/drivers/infiniband/hw/hfi1/rc.c
index 818bac1a4056..d3b8cb92fd6d 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1162,6 +1162,7 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 		if (cmp_psn(wqe->lpsn, qp->s_sending_psn) >= 0 &&
 		    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0)
 			break;
+		rvt_qp_wqe_unreserve(qp, wqe);
 		s_last = qp->s_last;
 		trace_hfi1_qp_send_completion(qp, wqe, s_last);
 		if (++s_last >= qp->s_size)
@@ -1214,6 +1215,7 @@ static struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 		u32 s_last;
 
 		rvt_put_swqe(wqe);
+		rvt_qp_wqe_unreserve(qp, wqe);
 		s_last = qp->s_last;
 		trace_hfi1_qp_send_completion(qp, wqe, s_last);
 		if (++s_last >= qp->s_size)
-- 
2.19.1



