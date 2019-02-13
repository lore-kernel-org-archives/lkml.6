Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94632C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5763121934
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026141;
	bh=dqnW6HJM498CLD0WQCw6U3xN4zsh4/bNOLvmgBVfKs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YchFy57AO3/nwZOYytQZlMkuECXJHr8SCAOlDRD/ZsNnVAPHjFYgzyn6jFL3A4TNF
	 izVbtNOCXtPbcCqDV+2JL8DPT3C7GRBPr+jOBLU8DCd3ahHKXeMtrehLztEyeTx0+B
	 YwodEaMQYT6Es2aI3nZnNHeLg383YS0K5GdD3z34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbfBMCtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:49:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388910AbfBMCkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:40:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FB43222C7;
        Wed, 13 Feb 2019 02:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025608;
        bh=dqnW6HJM498CLD0WQCw6U3xN4zsh4/bNOLvmgBVfKs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1W0ndiTa0FMA9EkrdMenSzV8jg6v2JlHmGyukW8XqFTfmYFxNbSI9/hk1AtxhSMIA
         HY1MVlOWMGyeCGe1X34DF6YaBYfJVEEp9Tl6hhPyfR7c5fou7GmZG9YPpnzAq35X/d
         ivwx7i4q1JI1Dp9QdZao317ih63f4BfC6F85jvj0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Bolotin <dbolotin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/34] qed: Fix qed_ll2_post_rx_buffer_notify_fw() by adding a write memory barrier
Date:   Tue, 12 Feb 2019 21:39:32 -0500
Message-Id: <20190213023952.21311-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023952.21311-1-sashal@kernel.org>
References: <20190213023952.21311-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <dbolotin@marvell.com>

[ Upstream commit 46721c3d9e273aea880e9ff835b0e1271e1cd2fb ]

Make sure chain element is updated before ringing the doorbell.

Signed-off-by: Denis Bolotin <dbolotin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_ll2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ll2.c b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
index b73bcbeb5f27..cef619f0ce10 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ll2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ll2.c
@@ -1487,6 +1487,10 @@ static void qed_ll2_post_rx_buffer_notify_fw(struct qed_hwfn *p_hwfn,
 	cq_prod = qed_chain_get_prod_idx(&p_rx->rcq_chain);
 	rx_prod.bd_prod = cpu_to_le16(bd_prod);
 	rx_prod.cqe_prod = cpu_to_le16(cq_prod);
+
+	/* Make sure chain element is updated before ringing the doorbell */
+	dma_wmb();
+
 	DIRECT_REG_WR(p_rx->set_prod_addr, *((u32 *)&rx_prod));
 }
 
-- 
2.19.1

