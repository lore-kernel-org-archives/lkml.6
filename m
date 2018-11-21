Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53972C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1859D206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNiaYzST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1859D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387752AbeKVFmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:37304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387645AbeKVFmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1388A214F1;
        Wed, 21 Nov 2018 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827232;
        bh=eTj/DTGjHwi21WwFDwNq62jGp3DKal+Jt2ZQVCJWwqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hNiaYzST3y9fkjGXjWEeA9kaWgkkXC6AoqqjtDgQ17u1wfZtAo3EKaf9C7ZjohysP
         7UiJ94l4XKGVqFm1oelG+yLCKcYRc1q4KVQzSn7iE1itjf5mEjFMLOA2Vqp0GzRHWb
         CtT4/1xz6oNeFglM13lY4p7ZdKyc1GZZmuyXnqI0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valentine Fatiev <valentinef@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 24/42] net/mlx5e: Fix selftest for small MTUs
Date:   Wed, 21 Nov 2018 20:06:00 +0100
Message-Id: <20181121183149.053952933@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Valentine Fatiev <valentinef@mellanox.com>

[ Upstream commit 228c4cd04dfd0667eda182c91504b83c17d97584 ]

Loopback test had fixed packet size, which can be bigger than configured
MTU. Shorten the loopback packet size to be bigger than minimal MTU
allowed by the device. Text field removed from struct 'mlx5ehdr'
as redundant to allow send small packets as minimal allowed MTU.

Fixes: d605d66 ("net/mlx5e: Add support for ethtool self diagnostics test")
Signed-off-by: Valentine Fatiev <valentinef@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c |   26 ++++++------------
 1 file changed, 10 insertions(+), 16 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_selftest.c
@@ -98,18 +98,17 @@ static int mlx5e_test_link_speed(struct
 	return 1;
 }
 
-#ifdef CONFIG_INET
-/* loopback test */
-#define MLX5E_TEST_PKT_SIZE (MLX5E_RX_MAX_HEAD - NET_IP_ALIGN)
-static const char mlx5e_test_text[ETH_GSTRING_LEN] = "MLX5E SELF TEST";
-#define MLX5E_TEST_MAGIC 0x5AEED15C001ULL
-
 struct mlx5ehdr {
 	__be32 version;
 	__be64 magic;
-	char   text[ETH_GSTRING_LEN];
 };
 
+#ifdef CONFIG_INET
+/* loopback test */
+#define MLX5E_TEST_PKT_SIZE (sizeof(struct ethhdr) + sizeof(struct iphdr) +\
+			     sizeof(struct udphdr) + sizeof(struct mlx5ehdr))
+#define MLX5E_TEST_MAGIC 0x5AEED15C001ULL
+
 static struct sk_buff *mlx5e_test_get_udp_skb(struct mlx5e_priv *priv)
 {
 	struct sk_buff *skb = NULL;
@@ -117,10 +116,7 @@ static struct sk_buff *mlx5e_test_get_ud
 	struct ethhdr *ethh;
 	struct udphdr *udph;
 	struct iphdr *iph;
-	int datalen, iplen;
-
-	datalen = MLX5E_TEST_PKT_SIZE -
-		  (sizeof(*ethh) + sizeof(*iph) + sizeof(*udph));
+	int    iplen;
 
 	skb = netdev_alloc_skb(priv->netdev, MLX5E_TEST_PKT_SIZE);
 	if (!skb) {
@@ -149,7 +145,7 @@ static struct sk_buff *mlx5e_test_get_ud
 	/* Fill UDP header */
 	udph->source = htons(9);
 	udph->dest = htons(9); /* Discard Protocol */
-	udph->len = htons(datalen + sizeof(struct udphdr));
+	udph->len = htons(sizeof(struct mlx5ehdr) + sizeof(struct udphdr));
 	udph->check = 0;
 
 	/* Fill IP header */
@@ -157,7 +153,8 @@ static struct sk_buff *mlx5e_test_get_ud
 	iph->ttl = 32;
 	iph->version = 4;
 	iph->protocol = IPPROTO_UDP;
-	iplen = sizeof(struct iphdr) + sizeof(struct udphdr) + datalen;
+	iplen = sizeof(struct iphdr) + sizeof(struct udphdr) +
+		sizeof(struct mlx5ehdr);
 	iph->tot_len = htons(iplen);
 	iph->frag_off = 0;
 	iph->saddr = 0;
@@ -170,9 +167,6 @@ static struct sk_buff *mlx5e_test_get_ud
 	mlxh = skb_put(skb, sizeof(*mlxh));
 	mlxh->version = 0;
 	mlxh->magic = cpu_to_be64(MLX5E_TEST_MAGIC);
-	strlcpy(mlxh->text, mlx5e_test_text, sizeof(mlxh->text));
-	datalen -= sizeof(*mlxh);
-	skb_put_zero(skb, datalen);
 
 	skb->csum = 0;
 	skb->ip_summed = CHECKSUM_PARTIAL;


