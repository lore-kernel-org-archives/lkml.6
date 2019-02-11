Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFEC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C910A222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899710;
	bh=O79/nziKHT+4jgZn0NrKMraHOr8/nypyTjJ866ZxegE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c913nPctGpr7tZCJD+uQcFivnjQF0z2qRS45z16QZUQf/Q7TAHAiEjfVDxKSFp3Gj
	 VS6u+Wlfpdn4aIPKmGEJRMnKT3ynxjH0mg44wB0armfXCBQ2bUUbNOXTwJojZ2mz67
	 Ag9f2LyGLJnvLq1xPwLYQC0dAUVdkFQlt3t2z2kw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387861AbfBKPlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:41:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387496AbfBKOrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:47:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D70D6206BA;
        Mon, 11 Feb 2019 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896445;
        bh=O79/nziKHT+4jgZn0NrKMraHOr8/nypyTjJ866ZxegE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIJVhccnsR9ldgN9auXna+e+KBUYhKwh0RbyZLB6/qPnHi4hTFNxQ+g8pPHr6G2lj
         /l5Z4+CPklpoCMyGlFFFXZJQ9XNU5bA+/hwyJCXNot8gEJcm5grw8TS/Tk152vq40f
         HB1ARRJRSr6VfvLtCtK1zqfmyhUQjaaanQrj/ExQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 185/313] net: hns3: add max vector number check for pf
Date:   Mon, 11 Feb 2019 15:17:45 +0100
Message-Id: <20190211141905.651294737@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



