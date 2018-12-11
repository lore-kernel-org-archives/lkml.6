Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D14020855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543509;
	bh=4qeVp4sIXqhOGj+85q90pPI6RcxE5Y3yqVO6I685nFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bmrUiSWgzdsbnkiAKys+pv5yLmyA6vEN41tNZxDGWVo6X8dxhjgZbtZ2XzqU7ntmc
	 Td2uAVIkpGnBcIRznOf5BCQZ22Jqn37p8AOPx1gGQSN4m5h1VV09fzL0M9XaYNfja7
	 ucHCwh945iQc9RukQ9+cW7OozbWPa0TwiQqXg+gg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D14020855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbeLKPvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:51:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbeLKPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09D9720855;
        Tue, 11 Dec 2018 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543504;
        bh=4qeVp4sIXqhOGj+85q90pPI6RcxE5Y3yqVO6I685nFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7NndUdQ1+bRcp5dDG62fw4U0ghrunxzVMybuxT58ouZomwuUFAvWDb7Ng3kDKBPt
         dABAGCtdnTVLrqIAc9lFQV9VzdF7cFXK7N+s7eIVi51hRIQfQgv6dIOGG1fvDuD19Z
         KfzmXF3+9MyCqGpORREwBfXBgOIL40PujEdvHQEs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/67] qed: Fix QM getters to always return a valid pq
Date:   Tue, 11 Dec 2018 16:41:23 +0100
Message-Id: <20181211151631.577036716@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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
index a51cd1028ecb..16953c4ebd71 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -446,6 +446,11 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
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
@@ -468,8 +473,7 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
 	}
 
 err:
-	DP_ERR(p_hwfn, "BAD pq flags %d\n", pq_flags);
-	return NULL;
+	return &qm_info->start_pq;
 }
 
 /* save pq index in qm info */
@@ -493,20 +497,32 @@ u16 qed_get_cm_pq_idx_mcos(struct qed_hwfn *p_hwfn, u8 tc)
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
 
 u16 qed_get_cm_pq_idx_rl(struct qed_hwfn *p_hwfn, u8 rl)
-- 
2.19.1



