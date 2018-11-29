Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5BCC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43234208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpNbSeSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43234208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeK2RD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbeK2RD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:58 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FB2208E7;
        Thu, 29 Nov 2018 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471187;
        bh=O5M04tYTFatKT3e5jhk+cF/lPCJnInKJZAjdT0UTuVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpNbSeSPhi3OU9ywbSNBWXw+NcUZt6WskkBllgn3iMHcaIyuro2+gXnqv2DznJW4T
         M3tDn0SwQ2ZiHCtZbtfyhdrCJEDJxyik5kqoyhPIA/1vaYPSjIiItjjCQB3yPT2tjR
         8bT7KDKkEx63Iwl0FmuoceVMrhA55MyMt2ZLB+ZQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 48/68] qed: Fix QM getters to always return a valid pq
Date:   Thu, 29 Nov 2018 00:55:39 -0500
Message-Id: <20181129055559.159228-48-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit eb62cca9bee842e5b23bd0ddfb1f271ca95e8759 ]

The getter callers doesn't know the valid Physical Queues (PQ) values.
This patch makes sure that a valid PQ will always be returned.

The patch consists of 3 fixes:

 - When qed_init_qm_get_idx_from_flags() receives a disabled flag, it
   returned PQ 0, which can potentially be another function's pq. Verify
   that flag is enabled, otherwise return default start_pq.

 - When qed_init_qm_get_idx_from_flags() receives an unknown flag, it
   returned NULL and could lead to a segmentation fault. Return default
   start_pq instead.

 - A modulo operation was added to MCOS/VFS PQ getters to make sure the
   PQ returned is in range of the required flag.

Fixes: b5a9ee7cf3be ("qed: Revise QM cofiguration")
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 24 +++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index d2ead4eb1b9a..2f69ee9221c6 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -484,6 +484,11 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
 		goto err;
 	}
 
+	if (!(qed_get_pq_flags(p_hwfn) & pq_flags)) {
+		DP_ERR(p_hwfn, "pq flag 0x%x is not set\n", pq_flags);
+		goto err;
+	}
+
 	switch (pq_flags) {
 	case PQ_FLAGS_RLS:
 		return &qm_info->first_rl_pq;
@@ -506,8 +511,7 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
 	}
 
 err:
-	DP_ERR(p_hwfn, "BAD pq flags %d\n", pq_flags);
-	return NULL;
+	return &qm_info->start_pq;
 }
 
 /* save pq index in qm info */
@@ -531,20 +535,32 @@ u16 qed_get_cm_pq_idx_mcos(struct qed_hwfn *p_hwfn, u8 tc)
 {
 	u8 max_tc = qed_init_qm_get_num_tcs(p_hwfn);
 
+	if (max_tc == 0) {
+		DP_ERR(p_hwfn, "pq with flag 0x%lx do not exist\n",
+		       PQ_FLAGS_MCOS);
+		return p_hwfn->qm_info.start_pq;
+	}
+
 	if (tc > max_tc)
 		DP_ERR(p_hwfn, "tc %d must be smaller than %d\n", tc, max_tc);
 
-	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_MCOS) + tc;
+	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_MCOS) + (tc % max_tc);
 }
 
 u16 qed_get_cm_pq_idx_vf(struct qed_hwfn *p_hwfn, u16 vf)
 {
 	u16 max_vf = qed_init_qm_get_num_vfs(p_hwfn);
 
+	if (max_vf == 0) {
+		DP_ERR(p_hwfn, "pq with flag 0x%lx do not exist\n",
+		       PQ_FLAGS_VFS);
+		return p_hwfn->qm_info.start_pq;
+	}
+
 	if (vf > max_vf)
 		DP_ERR(p_hwfn, "vf %d must be smaller than %d\n", vf, max_vf);
 
-	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_VFS) + vf;
+	return qed_get_cm_pq_idx(p_hwfn, PQ_FLAGS_VFS) + (vf % max_vf);
 }
 
 u16 qed_get_cm_pq_idx_ofld_mtc(struct qed_hwfn *p_hwfn, u8 tc)
-- 
2.17.1

