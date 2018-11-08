Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80835C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4390E20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWy3nhd4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4390E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbeKIHm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbeKIHmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B1B820892;
        Thu,  8 Nov 2018 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714724;
        bh=3Eo3Q0ne5gCsr26SjDQigPkP25pXnhEYAtfE3nQZpcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWy3nhd48MFlmj2spJwpAeQjntLmWkSXPqdrkZu4REB96QJGn0w/OgNYwKSEwxsHf
         sENp2wHhiV05na9+Z9GUGTV4/h6YoatRZcc3k6Vuc6uQrQS+hQ9j0g2GL6QZM2USul
         gucntsZOSRJamYl1J73+Qqpd2xZhKj81SXPTbOJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuval Mintz <Yuval.Mintz@cavium.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 087/171] qed: Warn PTT usage by wrong hw-function
Date:   Thu,  8 Nov 2018 13:50:57 -0800
Message-Id: <20181108215133.744908435@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 3a50d3518dcba44f8a0f9356b7140fe1499984ea ]

PTT entries are per-hwfn; If some errneous flow is trying
to use a PTT belonging to a differnet hwfn warn user, as this
can break every register accessing flow later and is very hard
to root-cause.

Signed-off-by: Yuval Mintz <Yuval.Mintz@cavium.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_hw.c b/drivers/net/ethernet/qlogic/qed/qed_hw.c
index 6e4fae9b1430..944749cfe092 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hw.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_hw.c
@@ -34,6 +34,7 @@ struct qed_ptt {
 	struct list_head	list_entry;
 	unsigned int		idx;
 	struct pxp_ptt_entry	pxp;
+	u8			hwfn_id;
 };
 
 struct qed_ptt_pool {
@@ -55,6 +56,7 @@ int qed_ptt_pool_alloc(struct qed_hwfn *p_hwfn)
 		p_pool->ptts[i].idx = i;
 		p_pool->ptts[i].pxp.offset = QED_BAR_INVALID_OFFSET;
 		p_pool->ptts[i].pxp.pretend.control = 0;
+		p_pool->ptts[i].hwfn_id = p_hwfn->my_id;
 		if (i >= RESERVED_PTT_MAX)
 			list_add(&p_pool->ptts[i].list_entry,
 				 &p_pool->free_list);
@@ -169,6 +171,11 @@ static u32 qed_set_ptt(struct qed_hwfn *p_hwfn,
 
 	offset = hw_addr - win_hw_addr;
 
+	if (p_ptt->hwfn_id != p_hwfn->my_id)
+		DP_NOTICE(p_hwfn,
+			  "ptt[%d] of hwfn[%02x] is used by hwfn[%02x]!\n",
+			  p_ptt->idx, p_ptt->hwfn_id, p_hwfn->my_id);
+
 	/* Verify the address is within the window */
 	if (hw_addr < win_hw_addr ||
 	    offset >= PXP_EXTERNAL_BAR_PF_WINDOW_SINGLE_SIZE) {
-- 
2.17.1



