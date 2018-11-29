Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F3AEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149AA21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2nikKPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149AA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbeK2RDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbeK2RDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:03:55 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037EC21019;
        Thu, 29 Nov 2018 05:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471184;
        bh=TNYCcXOUKa2S7N2ZD9BSLRILUTL9/i9sgAMFi2Q5YWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R2nikKPImyJ/YMClHrx1s6eD9KPTKKEide82s1RBqYJrNHngNRMOhBu6jqQWshN6h
         ydxfVKNfT+3bf7qIT8cqnm1i4kAFvveWeDxgUUJZVTpL0RL5YfM+WVtznLyqymDkXB
         JcGWi3oN0UUy5I9WdbSN5QGLgr26tFGipYW38Pzg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 47/68] qed: Fix bitmap_weight() check
Date:   Thu, 29 Nov 2018 00:55:38 -0500
Message-Id: <20181129055559.159228-47-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <denis.bolotin@cavium.com>

[ Upstream commit 276d43f0ae963312c0cd0e2b9a85fd11ac65dfcc ]

Fix the condition which verifies that only one flag is set. The API
bitmap_weight() should receive size in bits instead of bytes.

Fixes: b5a9ee7cf3be ("qed: Revise QM cofiguration")
Signed-off-by: Denis Bolotin <denis.bolotin@cavium.com>
Signed-off-by: Michal Kalderon <michal.kalderon@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 9d2d18c32162..d2ead4eb1b9a 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -478,8 +478,11 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
 	struct qed_qm_info *qm_info = &p_hwfn->qm_info;
 
 	/* Can't have multiple flags set here */
-	if (bitmap_weight((unsigned long *)&pq_flags, sizeof(pq_flags)) > 1)
+	if (bitmap_weight((unsigned long *)&pq_flags,
+			  sizeof(pq_flags) * BITS_PER_BYTE) > 1) {
+		DP_ERR(p_hwfn, "requested multiple pq flags 0x%x\n", pq_flags);
 		goto err;
+	}
 
 	switch (pq_flags) {
 	case PQ_FLAGS_RLS:
-- 
2.17.1

