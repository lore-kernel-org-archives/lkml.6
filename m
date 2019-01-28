Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4421741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694879;
	bh=43gx7nNChdDSDexgCb8CVI7diSd0vYjHrGbi80JOPMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cXKIjXQJRvl4hMxG6TQey0nFNH4BF3vRw9SREqiyixzpRevjqTi0WYzJH4ODgQDpU
	 WLCzkEt8U+yta7jzn42hodgsZZYo5rJ1uxAvUfakWmAgfgcYnHX5+RH3+aonsNq5LE
	 HpD0v+ww3eEFhU3EShrqCpibkwSaUv/AK9TQyucw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfA1RBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:44878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387735AbfA1QPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C84322147A;
        Mon, 28 Jan 2019 16:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692110;
        bh=43gx7nNChdDSDexgCb8CVI7diSd0vYjHrGbi80JOPMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ef59VdgPqiPoLdoorj+N2CVTE35zIYe63Fw3/kn9EOtC7kr9NTIVrrZuZIByOvnKR
         w2MNiTPNJq0McqwZ+pSGJwVjFnM6JjlqY6Am8cERQIBLsyl9Kjdu6OThXE6pNYczEQ
         JEFe6Et2qEfUkIvSyHW3hjN3TsbfY2Kw4MdLAqvs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 072/170] IB/hfi1: Unreserve a reserved request when it is completed
Date:   Mon, 28 Jan 2019 11:10:22 -0500
Message-Id: <20190128161200.55107-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

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

