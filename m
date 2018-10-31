Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D6FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B371F2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCnXnL10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B371F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbeKAIeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730399AbeKAIJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACB020840;
        Wed, 31 Oct 2018 23:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027353;
        bh=2h5AOeZchGzgjP0uM8Do63qTlbDMuIEEewO/zMK3tEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCnXnL108bAWVX4JK34xt1cebF/AK3NtCj2fTaCwqqBD1uzvZyPDd6o4437it8mgv
         XXT0Y42Ha1Hp/2+Pw1iKLC1I4VXqY+FuEmjuylQjNa8MQcGD1OpL3+gdtG/2UEVqPe
         9fnUb+1q3ZLO38TsKCBOZVdB0Kk6D/Ab3oR2EJ+0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 086/126] RDMA/bnxt_re: Avoid accessing nq->bar_reg_iomem in failure case
Date:   Wed, 31 Oct 2018 19:07:14 -0400
Message-Id: <20181031230754.29029-86-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit ed51efd2ce44091a858ad829f666727e7c95695e ]

In the failure path, nq->bar_reg_iomem gets accessed without
initializing. Avoid this by calling the bnxt_qplib_nq_stop_irq only if the
initialization is complete.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
Fixes: 6e04b1035689 ("RDMA/bnxt_re: Fix broken RoCE driver due to recent L2 driver changes")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 6ad0d46ab879..249efa0a6aba 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -360,7 +360,8 @@ void bnxt_qplib_disable_nq(struct bnxt_qplib_nq *nq)
 	}
 
 	/* Make sure the HW is stopped! */
-	bnxt_qplib_nq_stop_irq(nq, true);
+	if (nq->requested)
+		bnxt_qplib_nq_stop_irq(nq, true);
 
 	if (nq->bar_reg_iomem)
 		iounmap(nq->bar_reg_iomem);
-- 
2.17.1

