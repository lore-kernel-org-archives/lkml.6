Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB6C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0875320835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550026717;
	bh=Gd0NWGrB8XbPit8PEcqzaJDHvFWP3xj182ausYKXIOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s2ZYKtquF3Et9Xcta/ZJ41WfWzIg/niF9pNq0Yb/uk+wxy0jrJGDKpk+lTNWBTFh9
	 2/rvy3t0GzFM2NsRKIpK4x5Sq+Bq463oL2ekAlyahDTiNWUVyavWueTO9F6eQMKBtC
	 heCRxcXJrQn5+VJNNNet/vGy8fiC/dkxWaOQRhYE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390197AbfBMC6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388144AbfBMCg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:36:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B73222C9;
        Wed, 13 Feb 2019 02:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025389;
        bh=Gd0NWGrB8XbPit8PEcqzaJDHvFWP3xj182ausYKXIOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bzPJkCdsPmBBS6JPZe2/6xW4wumOVBT4uzMAMzx1Poj7i8be5yRhac6bGQDWzZXA3
         jDgaPjYxlZQf5W2bJM8fnBRHhGGPfqfB9BnCYE+I+5Uhu/Z70wc+WZKqYUVAQYqk6d
         Z8+Q6O7YX6yEXIUmAKb/CivIMTtYqfna9p+T12gk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 097/105] dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start
Date:   Tue, 12 Feb 2019 21:33:28 -0500
Message-Id: <20190213023336.19019-97-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>

[ Upstream commit c6ddfb9a963f0cac0f7365acfc87f3f3b33a3b69 ]

As txq_trans_update() only updates trans_start when the lock is held,
trans_start does not get updated if NETIF_F_LLTX is declared.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 6e0f47f2c8a3..3e53be0fcd7e 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2051,6 +2051,7 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
+	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
 	int offset = 0;
@@ -2100,6 +2101,11 @@ dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	if (unlikely(err < 0))
 		goto skb_to_fd_failed;
 
+	txq = netdev_get_tx_queue(net_dev, queue_mapping);
+
+	/* LLTX requires to do our own update of trans_start */
+	txq->trans_start = jiffies;
+
 	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
 		fd.cmd |= cpu_to_be32(FM_FD_CMD_UPD);
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
-- 
2.19.1

