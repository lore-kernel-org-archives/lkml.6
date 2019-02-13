Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E5FC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA0B20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026550;
	bh=TnEGSoTVVCn7tMIT4f4oBmz+dWl2DI0Q7yJ0fJTxL3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wsKcYEb2BuzbBtVW1rX5A366+OhEeZ19ppQslrTDqNzttT4MbF60Waf810E03vzFI
	 vBWxj2Oalx4r5iQB4fTNAfc+0sbn4TVH4K33Lrcd4hfxe1b6PfUvH+ClmT7PKrBDou
	 d/hjMhvtU3LyFF/qbAT9WKmpBMaImKaTucswI7/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbfBMCzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:55:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388296AbfBMCh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:37:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD65222C9;
        Wed, 13 Feb 2019 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025446;
        bh=TnEGSoTVVCn7tMIT4f4oBmz+dWl2DI0Q7yJ0fJTxL3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n81kV09zTi60T3k1EAlgjNALJfI8C1Y5SVana1t3CgMZAdlMjhbdgFgP3JA/Ry6JR
         4BkYhtZ2o4Ip/fhTa5M81CNunoxe2mZvsE+nOc3buLKnjZLure/4z2LuGKdVlfRVVh
         FrhRDzuLFXhvpdS7BGo9FDw4XicQmRyk959YqD+U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Denis Bolotin <dbolotin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 21/83] qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page count
Date:   Tue, 12 Feb 2019 21:35:59 -0500
Message-Id: <20190213023701.20286-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Bolotin <dbolotin@marvell.com>

[ Upstream commit 2d533a9287f2011632977e87ce2783f4c689c984 ]

In PBL chains with non power of 2 page count, the producer is not at the
beginning of the chain when index is 0 after a wrap. Therefore, after the
producer index wrap around, page index should be calculated more carefully.

Signed-off-by: Denis Bolotin <dbolotin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/qed/qed_chain.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/qed/qed_chain.h b/include/linux/qed/qed_chain.h
index 59ddf9af909e..2dd0a9ed5b36 100644
--- a/include/linux/qed/qed_chain.h
+++ b/include/linux/qed/qed_chain.h
@@ -663,6 +663,37 @@ static inline void *qed_chain_get_last_elem(struct qed_chain *p_chain)
 static inline void qed_chain_set_prod(struct qed_chain *p_chain,
 				      u32 prod_idx, void *p_prod_elem)
 {
+	if (p_chain->mode == QED_CHAIN_MODE_PBL) {
+		u32 cur_prod, page_mask, page_cnt, page_diff;
+
+		cur_prod = is_chain_u16(p_chain) ? p_chain->u.chain16.prod_idx :
+			   p_chain->u.chain32.prod_idx;
+
+		/* Assume that number of elements in a page is power of 2 */
+		page_mask = ~p_chain->elem_per_page_mask;
+
+		/* Use "cur_prod - 1" and "prod_idx - 1" since producer index
+		 * reaches the first element of next page before the page index
+		 * is incremented. See qed_chain_produce().
+		 * Index wrap around is not a problem because the difference
+		 * between current and given producer indices is always
+		 * positive and lower than the chain's capacity.
+		 */
+		page_diff = (((cur_prod - 1) & page_mask) -
+			     ((prod_idx - 1) & page_mask)) /
+			    p_chain->elem_per_page;
+
+		page_cnt = qed_chain_get_page_cnt(p_chain);
+		if (is_chain_u16(p_chain))
+			p_chain->pbl.c.u16.prod_page_idx =
+				(p_chain->pbl.c.u16.prod_page_idx -
+				 page_diff + page_cnt) % page_cnt;
+		else
+			p_chain->pbl.c.u32.prod_page_idx =
+				(p_chain->pbl.c.u32.prod_page_idx -
+				 page_diff + page_cnt) % page_cnt;
+	}
+
 	if (is_chain_u16(p_chain))
 		p_chain->u.chain16.prod_idx = (u16) prod_idx;
 	else
-- 
2.19.1

