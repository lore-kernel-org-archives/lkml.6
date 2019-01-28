Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0654CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7472147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697008;
	bh=BK2v3EalhyqBpa0iRFrwi0ZwAhThugfBz1iFsjy1seg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jMdkm9mEgKICFn8sz4ztPHGFRKlQ/+BDQhIXAb3/goFa1EEp7Qjlm0479a6GRnD4g
	 c5RkF/3jd0Ady0EtkyuVnvQakIxGCI1TXbCEeUqlQFWqc7CdqLEU2Qs4UsdMr75q0W
	 t8JGWChoD+0UvF3bk/pP7mw4oF3Rv24cuhCYVaLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfA1Rgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728624AbfA1PzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F5620855;
        Mon, 28 Jan 2019 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690910;
        bh=BK2v3EalhyqBpa0iRFrwi0ZwAhThugfBz1iFsjy1seg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qHUgq6uxLKH4FytGtlqvYCg0Nx9NqV3fdIfJwE33QxsaMQMRfWJP0gRIde8BFxtsU
         +Vwl01e0OUIrR15dxGBWPPwAkDtbgWBGamH245lmVDVCpCEa4pn/K8g+Gls6cT4XJ8
         bEdIXU32Pnw1hNaMyXpsdYqNym8jaOvnVYZrxUj8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 232/304] net: hns3: don't restore rules when flow director is disabled
Date:   Mon, 28 Jan 2019 10:42:29 -0500
Message-Id: <20190128154341.47195-232-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Shen <shenjian15@huawei.com>

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

