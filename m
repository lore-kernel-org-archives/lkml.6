Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F534C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81A72145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfIj2tZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81A72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeK2RGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:06:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbeK2RGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:06:50 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACEFB2145D;
        Thu, 29 Nov 2018 06:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471358;
        bh=T7BTphX5qI3Y9zFvbRhLXZcY1mpWKKv4urF+1PibT6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfIj2tZ8tjeqzoTurl89/i9iBWvCRfgmJ409g/73xzex8xRQpUjaukSQz//4jeh5x
         3avgXIz7s4GqpPxKEWzYHcGCNj7VI8sOwlnECsM9jhhJmHJdGxsHzr1OJwOLMfq59x
         VITeX0VTJN+OyDdKCevN/TTPAm+ubLo/huI4/3xs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Denis Bolotin <denis.bolotin@cavium.com>,
        Michal Kalderon <michal.kalderon@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/35] qed: Fix bitmap_weight() check
Date:   Thu, 29 Nov 2018 01:00:57 -0500
Message-Id: <20181129060110.159878-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
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
index ef2374699726..a51cd1028ecb 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -440,8 +440,11 @@ static u16 *qed_init_qm_get_idx_from_flags(struct qed_hwfn *p_hwfn,
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

