Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3824ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C6D20847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="x1zz37fF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C6D20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeKAIJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbeKAIJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C0020664;
        Wed, 31 Oct 2018 23:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027379;
        bh=X6D8vaT3ay7sZOblU3lLC0B1EcIlf4i1ApAQwr5H4Xw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1zz37fFEjX1b6WOpvQvSkXMyJwsEEXyfSunB5hrT6S61Wekdk+88x6ZNw7+vOgaf
         Q+we0qtuMJ32ihOTF0elOtqLotUYYK5sDMJcnmiyGtqS2xdB8wnt/p7VtHzLh0WKnl
         nD3vQSTaJ3+dkwQuJqchBy4wxwuDUibn/MGaem6Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 116/126] IB/mlx5: Allow transition of DCI QP to reset
Date:   Wed, 31 Oct 2018 19:07:44 -0400
Message-Id: <20181031230754.29029-116-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

[ Upstream commit 99ed748e878a99c6c7b87bbec063eefd9e47cb42 ]

The transition is allowed from any state and the atrribute mask must be
IB_QP_STATE.

Fixes: c32a4f296e1d ("IB/mlx5: Add support for DC Initiator QP")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 01eae67d5a6e..e260f6a156ed 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3264,7 +3264,9 @@ static bool modify_dci_qp_is_ok(enum ib_qp_state cur_state, enum ib_qp_state new
 	int req = IB_QP_STATE;
 	int opt = 0;
 
-	if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
+	if (new_state == IB_QPS_RESET) {
+		return is_valid_mask(attr_mask, req, opt);
+	} else if (cur_state == IB_QPS_RESET && new_state == IB_QPS_INIT) {
 		req |= IB_QP_PKEY_INDEX | IB_QP_PORT;
 		return is_valid_mask(attr_mask, req, opt);
 	} else if (cur_state == IB_QPS_INIT && new_state == IB_QPS_INIT) {
-- 
2.17.1

