Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A898C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8F92084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYFmjcjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8F92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbeKLJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:22:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388519AbeKLIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:17 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA27A21780;
        Sun, 11 Nov 2018 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975421;
        bh=nyUwdrc3OSG7gSiAh4iNiEVjsaO2e4HeYoUvFPVZMdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYFmjcjpO1/5RVfgdcGAf5v80Yl2tCxGUTqJEl0o6Jju1D0OcUybmCdfzR0PM0sWA
         AY0PbiH75Nc+WDJQXtz/CF7/j2lG8xa9f9Bw2oXQ0ql7GRIfd6ax/5rqed28mwVpb5
         hEa6R/b9ssKDH5Mm+NAUq962BojGurA5yOThN7c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 147/350] RDMA/bnxt_re: Avoid accessing nq->bar_reg_iomem in failure case
Date:   Sun, 11 Nov 2018 14:20:11 -0800
Message-Id: <20181111221714.211565988@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -360,7 +360,8 @@ void bnxt_qplib_disable_nq(struct bnxt_q
 	}
 
 	/* Make sure the HW is stopped! */
-	bnxt_qplib_nq_stop_irq(nq, true);
+	if (nq->requested)
+		bnxt_qplib_nq_stop_irq(nq, true);
 
 	if (nq->bar_reg_iomem)
 		iounmap(nq->bar_reg_iomem);


