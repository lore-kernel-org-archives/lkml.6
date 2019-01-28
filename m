Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70FC282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759A120989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690871;
	bh=N1OGd1iFgOS/dGvaZK+iTZcUY2B2M3f49dSNBdIAIXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QdR2Yf1IxT1pDprbFuBykLKxVGp8RSTUbrCtrwWTwtJD8KPjvPXYG9mOKZzqnADvO
	 MyxGR04wXE1/aS0ZJM78vrbY1SYDePjt8shaLSYYl8bYnlTUOouzB7CWcIrjL0oAJD
	 Oj6vApfA9O/ZoUWYcdFXIOJDsUrzw30/r29rYKcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbfA1Py3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbfA1PyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:54:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C1E20989;
        Mon, 28 Jan 2019 15:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690864;
        bh=N1OGd1iFgOS/dGvaZK+iTZcUY2B2M3f49dSNBdIAIXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ulsfJAuPsLDdKm94zHb7kHnvG3zqU69vfV4x9RLwGiCcM6asZVRzFvIq6vwrk0R2U
         199Zyx7VaHTuj4FxS9lBJtZNov//Yy+UQTfqmbTtml1rUWLTQm5CZE+0D60byu9NyC
         1A84/72G5hRoKT87xsh43O0hVk2lKKr0ONtdEzVQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 217/304] net: hns3: fix incomplete uninitialization of IRQ in the hns3_nic_uninit_vector_data()
Date:   Mon, 28 Jan 2019 10:42:14 -0500
Message-Id: <20190128154341.47195-217-sashal@kernel.org>
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

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit ae6017a71115ebc4e5c1a3f0f451319ab3f5c447 ]

In the hns3_nic_uninit_vector_data(), the procedure of uninitializing
the tqp_vector's IRQ has not set affinity_notify to NULL and changes
its init flag. This patch fixes it. And for simplificaton, local
variable tqp_vector is used instead of priv->tqp_vector[i].

Fixes: 424eb834a9be ("net: hns3: Unified HNS3 {VF|PF} Ethernet Driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 4aea3f57586e..85d534a24f2c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2971,12 +2971,12 @@ static int hns3_nic_uninit_vector_data(struct hns3_nic_priv *priv)
 
 		hns3_free_vector_ring_chain(tqp_vector, &vector_ring_chain);
 
-		if (priv->tqp_vector[i].irq_init_flag == HNS3_VECTOR_INITED) {
-			(void)irq_set_affinity_hint(
-				priv->tqp_vector[i].vector_irq,
-						    NULL);
-			free_irq(priv->tqp_vector[i].vector_irq,
-				 &priv->tqp_vector[i]);
+		if (tqp_vector->irq_init_flag == HNS3_VECTOR_INITED) {
+			irq_set_affinity_notifier(tqp_vector->vector_irq,
+						  NULL);
+			irq_set_affinity_hint(tqp_vector->vector_irq, NULL);
+			free_irq(tqp_vector->vector_irq, tqp_vector);
+			tqp_vector->irq_init_flag = HNS3_VECTOR_NOT_INITED;
 		}
 
 		priv->ring_data[i].ring->irq_init_flag = HNS3_VECTOR_NOT_INITED;
-- 
2.19.1

