Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFF0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AEBD218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900916;
	bh=AVjOb0BPEAYeblgLmfRnxNpAq9oHPcIX5BzpRyHYHvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NjrN5LrL0h9z8O7aiFes32fs3e1F++iEIOIqUGfoLjIAc3dfd9byWlO9fxHg+yox4
	 XQJZxi17F5Be0exR7JpWXwwtNVAfwLAXifwsI4Wv76UEzge/VyXaOX/PXh4zTn+Ctv
	 tYlHSAu06Twc4j6FDCRxKhWZp+77KBDvqUI7roOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfBKOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:37096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729012AbfBKOah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5396420675;
        Mon, 11 Feb 2019 14:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895436;
        bh=AVjOb0BPEAYeblgLmfRnxNpAq9oHPcIX5BzpRyHYHvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y89LOjLGiIyyvv725c6GYvalAtAjA9dzln4+BVK6gYgQ8/bi6BSDDrAu7SUVhBCJl
         I6emkJuVSmYfcUDiG8UhbQMDDvK1hq2sOgw9GeDfKnrPlNEAKEfy1R8O4jz0UxDjQY
         Y1Zm0CUq7EzGb86eFDZLMeQkp8TPHQPf3VXMhQpM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 204/352] net: hns3: fix error handling int the hns3_get_vector_ring_chain
Date:   Mon, 11 Feb 2019 15:17:11 +0100
Message-Id: <20190211141900.125445339@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

[ Upstream commit cda69d244585bc4497d3bb878c22fe2b6ad647c1 ]

When hns3_get_vector_ring_chain() failed in the
hns3_nic_init_vector_data(), it should do the error handling instead
of return directly.

Also, cur_chain should be freed instead of chain and head->next should
be set to NULL in error handling of hns3_get_vector_ring_chain.

This patch fixes them.

Fixes: 73b907a083b8 ("net: hns3: bugfix for buffer not free problem during resetting")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 20fcf0d1c2ce..4aea3f57586e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2783,9 +2783,10 @@ err_free_chain:
 	cur_chain = head->next;
 	while (cur_chain) {
 		chain = cur_chain->next;
-		devm_kfree(&pdev->dev, chain);
+		devm_kfree(&pdev->dev, cur_chain);
 		cur_chain = chain;
 	}
+	head->next = NULL;
 
 	return -ENOMEM;
 }
@@ -2876,7 +2877,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 		ret = hns3_get_vector_ring_chain(tqp_vector,
 						 &vector_ring_chain);
 		if (ret)
-			return ret;
+			goto map_ring_fail;
 
 		ret = h->ae_algo->ops->map_ring_to_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-- 
2.19.1



