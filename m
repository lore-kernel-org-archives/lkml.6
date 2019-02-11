Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E2AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC554218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900925;
	bh=Bo/Ka2ucu4QoXjV4LqqcgqyzgA7UTGGPgmtiOF9ZTTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klNQsCGYQm90yR1nAd8HKzZiq55MhO0vTIbgz99qfxsAI9aDcoEQQ1UPl39oyHJAN
	 QkfhbawOk3I6SZmUbH7i4LyB6ImT256IQXOKfGFGAVcsPH5lSmTgkWY9nNuOlbqOWN
	 IYEdEN6WIBtn3TCkobvq+BhlDoJmnDIbYX7GOkxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbfBKOam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:30:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:37166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfBKOak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:30:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E490820844;
        Mon, 11 Feb 2019 14:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895439;
        bh=Bo/Ka2ucu4QoXjV4LqqcgqyzgA7UTGGPgmtiOF9ZTTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qF/XCtbU8O0ZuoUkoz4Kjmr/FftQM8TI/UO17amn8WHhjOMt5QIkMMr+wq8vjJp6j
         E62nV0DwyErvsvFy4bo3MjXL5dbq18i5qtOPn29019MXVBZvd7fKxrtEHlOOn30dFT
         hyCv6can5yacnFcnEhAX3bs4+dIMSMR5sRWrvLhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 205/352] net: hns3: fix incomplete uninitialization of IRQ in the hns3_nic_uninit_vector_data()
Date:   Mon, 11 Feb 2019 15:17:12 +0100
Message-Id: <20190211141900.198909864@linuxfoundation.org>
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



