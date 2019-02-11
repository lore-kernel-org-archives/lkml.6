Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7BCC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343B7218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900876;
	bh=DMHHeTkG7GrR1RpS7kdsqd43WM2x5UA9fEa1G8kQjDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kj09JrxhTXKFl8tsnlcR657jaBxpfbCcZVFms3B2EBzc5ZKXOpoBJeb1FGweCejaA
	 dE2nr5iHXhKI8ZfNexJZ4z5czslgqhGBdwrLxqw3VGbnZnwnwxr5anbX8+0+l6YLQX
	 mCYk/2n9fhccX/V1zz+VB08JpVkPsIpy4TSQ05GM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfBKQBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:01:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbfBKObW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F84E20675;
        Mon, 11 Feb 2019 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895481;
        bh=DMHHeTkG7GrR1RpS7kdsqd43WM2x5UA9fEa1G8kQjDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLU9BVnqEppeDvYNE/UaCo/3Wl2bU1hAzMDNaAkg16pMRGxb6EOP6B2CzmUWZYvjD
         ZjWx4YekXu3Ij/pG+SD5pafQb1pZQea6jREu5Goow0bJkNiAX9IITqukZIyQd7II7t
         VTE+uV38zKnHkcJn8Oyu/pgQGbnhy7G0UBGJH/xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 220/352] net: hns3: dont restore rules when flow director is disabled
Date:   Mon, 11 Feb 2019 15:17:27 +0100
Message-Id: <20190211141901.231893264@linuxfoundation.org>
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

[ Upstream commit 8edc2285b7285c5fbffe438dc8113260d3e76656 ]

When user disables flow director, all the rules will be disabled. But
when reset happens, it will restore all the rules again. It's not
reasonable. This patch fixes it by add flow director status check before
restore fules.

Fixes: 6871af29b3ab ("net: hns3: Add reset handle for flow director")
Fixes: c17852a8932f ("net: hns3: Add support for enable/disable flow director")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index ffdd96020860..a7895aefe291 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -4339,6 +4339,10 @@ static int hclge_restore_fd_entries(struct hnae3_handle *handle)
 	if (!hnae3_dev_fd_supported(hdev))
 		return -EOPNOTSUPP;
 
+	/* if fd is disabled, should not restore it when reset */
+	if (!hdev->fd_cfg.fd_en)
+		return 0;
+
 	hlist_for_each_entry_safe(rule, node, &hdev->fd_rule_list, rule_node) {
 		ret = hclge_config_action(hdev, HCLGE_FD_STAGE_1, rule);
 		if (!ret)
-- 
2.19.1



