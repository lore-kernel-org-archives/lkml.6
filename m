Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49377ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC9420856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uwn6Q9HX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC9420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeJYXOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728511AbeJYWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:20 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040FC2085B;
        Thu, 25 Oct 2018 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476924;
        bh=670edZCOoXdjUYuKpw/9yOZFCp06xEAp9ZaUUBLMTaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uwn6Q9HXS6+K+1Z2i++mMbgX9UEMmAI/wI1QO6Zt7fQCU6dBc96oWHhTQVSq8LBTV
         VRkP1lmePlbhr/vAHKxON4oxpYLFe5aTJ7QPXGgmyQlVCG2IJCp/INVUr/m3EGRctZ
         ById+Sv908gZO6QtJn3jak3UMBDxPowsRc3iIOu8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 40/98] net: stmmac: ensure jumbo_frm error return is correctly checked for -ve value
Date:   Thu, 25 Oct 2018 10:13:25 -0400
Message-Id: <20181025141423.213774-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 594238158bf748c285f0a73222cd9b7ccf3c525d ]

The current comparison of entry < 0 will never be true since entry is an
unsigned integer. Make entry an int to ensure -ve error return values
from the call to jumbo_frm are correctly being caught.

Detected by CoverityScan, CID#1238760 ("Macro compares unsigned to 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 0df71865fab1..65ed02bc3ea3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2199,7 +2199,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int nopaged_len = skb_headlen(skb);
 	int i, csum_insertion = 0, is_jumbo = 0;
 	int nfrags = skb_shinfo(skb)->nr_frags;
-	unsigned int entry, first_entry;
+	int entry;
+	unsigned int first_entry;
 	struct dma_desc *desc, *first;
 	unsigned int enh_desc;
 	unsigned int des;
-- 
2.17.1

