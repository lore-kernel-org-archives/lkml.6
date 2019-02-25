Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AD020842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131101;
	bh=YCiSRDfk22KwGQz8nDX2tz8mGs4EWsw2XDBP+CIm+UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WgeU8TIqpSkiDsMC6Z6PksN3BQbgHa6VhkEIDfTE14Y9qeu3RVh5lhh1Gt2lUARnv
	 WkrZzdZBSr9WdtAu+Id7+vDb/V3dRJhrjgCr3nXuPgCpM0pVML6Xyo8KzUV5Tsvww/
	 z0QhpOch2yunZKp5VAVhzjW4balpyFbHhQLBblTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfBYVpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:45:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732046AbfBYV3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E8B217F5;
        Mon, 25 Feb 2019 21:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130186;
        bh=YCiSRDfk22KwGQz8nDX2tz8mGs4EWsw2XDBP+CIm+UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yt4NBEGmNwfyYZYWqJJBZ4EI2yjsM+PctxH0MskzvBO5xxyE4ZHfgkiJ3TdhmoKUi
         0i4L5BDVquGamgKSnJM9qvXWRf03MhrjRMvXhAXFlppgPU05+ncj+YrCZGaQjylX8J
         50sRGWQThB2rbrINHCXa1X0+nTPBitpaUzxDts1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Bolotin <dbolotin@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 041/183] qed: Fix qed_chain_set_prod() for PBL chains with non power of 2 page count
Date:   Mon, 25 Feb 2019 22:10:14 +0100
Message-Id: <20190225195101.558437663@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 59ddf9af909e4..2dd0a9ed5b361 100644
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



