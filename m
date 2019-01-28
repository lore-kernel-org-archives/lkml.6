Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E805C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D212175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691719;
	bh=gJ+FAV6UJQyeu8zI+YPZADRrBEfEI+ucPMXy2Dc45+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dyW5dziKFCb43HN1xqxBZaKrCNeu9n9aIHsBepBkr5MpLOy52RxuiBRf49jOdfGid
	 XkTgJZz9qVh0bzFZcNy0mGvbXMRbTiLok+iCX32dd7kBFMH8Ssu92RIH0T4nl+7r9j
	 ju5+OLNnFBM9LwA6qO+rdnvHaEQ+yTJiMoB1/J44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfA1QIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732398AbfA1QIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D0A20989;
        Mon, 28 Jan 2019 16:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691710;
        bh=gJ+FAV6UJQyeu8zI+YPZADRrBEfEI+ucPMXy2Dc45+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4SpTjsUDLqP/W0UzB69Usfwrhj1e/ZIN0nccrd8Ba/xb9t83ZilDB8ldJqHQojnh
         fMQYMG9ivFeQZM72sqtvL0PGkkUq9T6SVIXa4JpHGrLrdHEpDrk7sOZLScQEvvhQH4
         cKI0PJG6K9CACthm46Jqb4yN3jHUcj2EhEzHAbsE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jian Shen <shenjian15@huawei.com>, Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 194/258] net: hns3: add max vector number check for pf
Date:   Mon, 28 Jan 2019 10:58:20 -0500
Message-Id: <20190128155924.51521-194-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index d5f15d8d18a9..0ccfa6a84535 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2691,6 +2691,8 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 
 static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 {
+#define HNS3_VECTOR_PF_MAX_NUM		64
+
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
 	struct hnae3_vector_info *vector;
@@ -2703,6 +2705,8 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
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

