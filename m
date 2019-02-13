Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F64C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1BE222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550025575;
	bh=4AiQB7el7iZGdfdCGcMw9eu4ndrOIxh5lFb/h1tPzGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hTjhsOML8MAH6c7+mk0xS6QGKwXu8h0SnrjgW8Jg/Ge54231muyzpbYqpYMmQoDMT
	 x3v0PVTXJmtTmbQ5YqyjCpCP/cIVJGBSK+hek7jMuWYr5CPxRaWYZlHGpF+wUeNhJO
	 Mdm+lYI/AL2NLCv0nQhttE8GoNutfh7j4+2NfYuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbfBMCjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:43132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388763AbfBMCjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:39:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25102222CD;
        Wed, 13 Feb 2019 02:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025571;
        bh=4AiQB7el7iZGdfdCGcMw9eu4ndrOIxh5lFb/h1tPzGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMPUmkGTghtS8OGZ/LsfVcd8gPWcpU0wZyIJHZiXxqIs5Y9T/lMOGioyhU52oSI0/
         IRw5fFLetbrw8XtYgWnz9BScbrr30Mum9daY3v/B7TASG77GVlCwmIUS9jtCKioK8A
         T8r8tXk+xcIrWhnShmaWQWz9O6atfxlo4kfOV1pc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 77/83] dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start
Date:   Tue, 12 Feb 2019 21:36:55 -0500
Message-Id: <20190213023701.20286-77-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023701.20286-1-sashal@kernel.org>
References: <20190213023701.20286-1-sashal@kernel.org>
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
index 65a22cd9aef2..029730bbe7db 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2052,6 +2052,7 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
 	bool nonlinear = skb_is_nonlinear(skb);
 	struct rtnl_link_stats64 *percpu_stats;
 	struct dpaa_percpu_priv *percpu_priv;
+	struct netdev_queue *txq;
 	struct dpaa_priv *priv;
 	struct qm_fd fd;
 	int offset = 0;
@@ -2101,6 +2102,11 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct net_device *net_dev)
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

