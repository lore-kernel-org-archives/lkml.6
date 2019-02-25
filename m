Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBCD8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D80821841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130419;
	bh=HHyYp0aY41ZK8JYqQ4kbcqWotriRSSbxTv5WBd+O2hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uXMdv26u7JtNJ7a9JXG4qEOKVZJCLdNAZ0T3fHSyYztSdNr6dQx+1fVctOFpcC65E
	 4NHaJiGtFJbnRE+jUmDbVG4wBby+0i1h8mQv1V4aOlAXY0Qw72poSbeVbmwq0aommD
	 iie+WQ4dW/S1K9K/AKVutlZUp4trsyaiC5bPa1Zo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfBYVdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:33:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbfBYVdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:33:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDAE021855;
        Mon, 25 Feb 2019 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130413;
        bh=HHyYp0aY41ZK8JYqQ4kbcqWotriRSSbxTv5WBd+O2hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fk9wu7Wga0RtbDEN+7IVP4BPfCJBQllnJWMeokVN7mPEBbHz0wbYBuQn7hGLceda1
         JDJwdcKh94M4REvBVFtQHHIoSEcjfcIEW5azW21Rbhrm0j8fufcPniny8L8CNCNwjO
         myolZkHel2jphN8cvqKjPIzr8OKfJMpRUnYMl1WA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 114/183] dpaa_eth: NETIF_F_LLTX requires to do our own update of trans_start
Date:   Mon, 25 Feb 2019 22:11:27 +0100
Message-Id: <20190225195113.845072230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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
index 6e0f47f2c8a37..3e53be0fcd7ec 100644
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



