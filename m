Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B39C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436202147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697027;
	bh=w6rl0+yIbb0gfVaM+A6naT5nTbl+4ZHBrNUsPndjiy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J+y3xnIlO2K8MHiPi/jKdhluGumkPXj6CjBKrFn94Jsc0KOPuOARSh+jS3+Ysa6YB
	 p5NwTak3adOPHUW4RSt/Mz0+HESvUiN+WvrDPhvTdXx7HnqbXHhCUVloMfENAVxlkG
	 QpPdYeneHLSewfT6aomn2ZuO11kdzNcldTe/tNIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfA1RhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:37:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfA1PzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:55:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D8620855;
        Mon, 28 Jan 2019 15:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690903;
        bh=w6rl0+yIbb0gfVaM+A6naT5nTbl+4ZHBrNUsPndjiy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eNcyaHM+AcRc0KNY4z8ISolyhgon4jgY1lnhFBHraDJr7DIYYT/aVm0rvmhP7TejH
         L2E3Is/Z9JZ5SyHP1ZPOKtazW/DU8eC94q1CUBi4OGQo7XlcihtJ0U+ucuOh8RinyS
         CKCK4uFJDkntbKdpc9MtHa3ywyJ5VYOu4Hv8ZYhQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 230/304] net: hns3: add max vector number check for pf
Date:   Mon, 28 Jan 2019 10:42:27 -0500
Message-Id: <20190128154341.47195-230-sashal@kernel.org>
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

[ Upstream commit 75edb610860fda65ceedb017fc69afabd2806b8b ]

Each pf supports max 64 vectors and 128 tqps. For 2p/4p core scenario,
there may be more than 64 cpus online. So the result of min_t(u16,
num_Online_cpus(), tqp_num) may be more than 64. This patch adds check
for the vector number.

Fixes: dd38c72604dc ("net: hns3: fix for coalesce configuration lost during reset")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 85d534a24f2c..beb5dbd5e98d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2902,6 +2902,8 @@ map_ring_fail:
 
 static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 {
+#define HNS3_VECTOR_PF_MAX_NUM		64
+
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
 	struct hnae3_vector_info *vector;
@@ -2914,6 +2916,8 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 	/* RSS size, cpu online and vector_num should be the same */
 	/* Should consider 2p/4p later */
 	vector_num = min_t(u16, num_online_cpus(), tqp_num);
+	vector_num = min_t(u16, vector_num, HNS3_VECTOR_PF_MAX_NUM);
+
 	vector = devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
 			      GFP_KERNEL);
 	if (!vector)
-- 
2.19.1

