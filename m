Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6399FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28AE52083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131435;
	bh=bWmGc9XDbz8dLdxHUIWeJylLSDLmRsYykZ4ddvbepjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kOOhihxYRVC11r/BWRxCKawqrI8qv9ItyWbndDHQBYUznEsXMQ5bR/9v7Olr0cXyB
	 jiaVGVJxT4w2NtNkAHVSHKjWiFqxiOfgI8eHu6OitErzps2AMyVrZQW4gx8NhQJLs5
	 C9PYodbXf6R398X56LeoTBypJaiulOkegPREAxgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfBYVue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:50:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730566AbfBYVY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:24:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B5320C01;
        Mon, 25 Feb 2019 21:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129866;
        bh=bWmGc9XDbz8dLdxHUIWeJylLSDLmRsYykZ4ddvbepjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWT4AIZYSRszNqXE6LG9Qtazj+7ZR9PDLYoSNCnBR9BaCkWhpP4AFIy67fXluKUp6
         hEbtgTvD4qM1W0Nty9rYxcgXCyph/H1ohLklAh6Gyn5rmBw2at16ZTW4ku5cvvckbX
         fUQl0lSYv5MEauHk6JT+gvD9tTYuZyb950szr2bU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 091/152] dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start
Date:   Mon, 25 Feb 2019 22:11:23 +0100
Message-Id: <20190225195049.285169523@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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
index 65a22cd9aef26..029730bbe7db1 100644
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



