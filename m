Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C48DC282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39121855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899935;
	bh=TjdZGDSFRA/ujpx3vtaNoIfPDhJo+TFeGBbevVgNp9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K2uOCi8qtuTWMlQf2fkcQjwjqNcKaoMedqvEf0wZwgoGgKM/7QNaNcv7PKSFLRD7O
	 mSQu07BMJG3fD0kbLloC0qvB0bEmMH5hF/w5N+2UKmWpdrLe12CS9aCFxWLKWSV8EL
	 lcomWnJJGVIArN0qPFGTAxlW64O4zaNfhC2Kcad8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbfBKOnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:43:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732599AbfBKOnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:43:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D1220700;
        Mon, 11 Feb 2019 14:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896199;
        bh=TjdZGDSFRA/ujpx3vtaNoIfPDhJo+TFeGBbevVgNp9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kr2JPEXVncRGmMXwZTC+JOE3uUUgwWvU+x56r+3/TfEjPGmH6Wq+dZezjG9eEQon+
         9prUG7Bu2bepR4uzlf/+As5vJnudV0ddLs5pHlDCBbpKSDTuJIElSoJQVC+n+76mGS
         +wLUWc6+ubKb1kn1jd8rrM6qk5Rmw/swCuQB5rSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 106/313] IB/hfi1: Unreserve a reserved request when it is completed
Date:   Mon, 11 Feb 2019 15:16:26 +0100
Message-Id: <20190211141900.939285097@linuxfoundation.org>
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
index 9bd63abb2dfe..6f013a565353 100644
--- a/drivers/infiniband/hw/hfi1/rc.c
+++ b/drivers/infiniband/hw/hfi1/rc.c
@@ -1157,6 +1157,7 @@ void hfi1_rc_send_complete(struct rvt_qp *qp, struct hfi1_opa_header *opah)
 		if (cmp_psn(wqe->lpsn, qp->s_sending_psn) >= 0 &&
 		    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0)
 			break;
+		rvt_qp_wqe_unreserve(qp, wqe);
 		s_last = qp->s_last;
 		trace_hfi1_qp_send_completion(qp, wqe, s_last);
 		if (++s_last >= qp->s_size)
@@ -1209,6 +1210,7 @@ static struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
 		u32 s_last;
 
 		rvt_put_swqe(wqe);
+		rvt_qp_wqe_unreserve(qp, wqe);
 		s_last = qp->s_last;
 		trace_hfi1_qp_send_completion(qp, wqe, s_last);
 		if (++s_last >= qp->s_size)
-- 
2.19.1



