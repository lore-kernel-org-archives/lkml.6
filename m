Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B00C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1BB2064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:39:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZPesPBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1BB2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbeJYWsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbeJYWso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:44 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0941920869;
        Thu, 25 Oct 2018 14:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476948;
        bh=kV1vj+Q4IKHEvX910Wrx1w5TlOkueCJR6KSsJUUk4EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HZPesPBsHTscne5oReBhR2/ytmww/qu3VDBzikzbkhuu4gK0MUMLYpxT++Yljvx4x
         UdS/JS7DQkT0RVfDng4lqdLuPAUiIWXWott/BYt49F9CuKLX+kcA4IsHSxU3e3cT9S
         t0DDBidyy8rDtMvD94SKzc9NVZAErqYBG255XXME=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Mintz, Yuval" <Yuval.Mintz@cavium.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 57/98] qed: Warn PTT usage by wrong hw-function
Date:   Thu, 25 Oct 2018 10:13:42 -0400
Message-Id: <20181025141423.213774-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mintz, Yuval" <Yuval.Mintz@cavium.com>

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

