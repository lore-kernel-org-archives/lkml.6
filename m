Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8565D2146D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YaD4BKzh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8565D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbeLCSkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:40:40 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42865 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeLCSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:40:39 -0500
Received: by mail-lf1-f65.google.com with SMTP id l10so9935942lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 10:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AqR+/tdvN+T03MfMl2BZakLvSSDhyowAZhzj7me3ZY0=;
        b=YaD4BKzhs0h80iAS6DLry0wrLCOm+kNnEJBcvZO8qowRaipNimLGISvXZTTISIAQBd
         4wgK7t6/ElreUMZowwv6K6eqM/v2dATuPJg9MaTdBYCC6fG68dEbhz7Vy/by4wgPjz28
         Ayx7AiZ6U+wjM60HgTE8O7y6xOs9aXl/b76jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AqR+/tdvN+T03MfMl2BZakLvSSDhyowAZhzj7me3ZY0=;
        b=Ggd7ffGJnNuMWNNvK4P1fXe19m35Qa7eI8x4CK9WlsEpE/dYZ9tlq2u0xJ2ZHXTugh
         bGFZHWf1pnBmuUe1jUm2vnPubWDqSiLUFllzxBI4GTqFzkItSSzh7rbF8P8nfiCDRzd+
         a5mr3npTnUQvnqrEAOWJSs38Jx47PK+5CoikEWfgKoogjTq/LA7lZEnFzazXHW70H6PE
         5l04K15qRb461gXPoDR34ke8rLo2bh0ocdLSTHYw7zdXEAzWkm4mcbOAnNsxar2IBLBr
         Fe/r+CvqUkTb9gfSdcMkS/cIqNaMrjL1NzZc1487kXGQ20Dya3POsKRylp9/yKEiQNMo
         IqZg==
X-Gm-Message-State: AA+aEWbZKhSiAnUUzgQd3N5yn31iVG24RwT4hllJDrcOnxuOyxdtBcmF
        N7ZVw4GAMcINtT7XO1olDMQDL1yadXyH0A==
X-Google-Smtp-Source: AFSGD/WuA0Ki0SJfIvQBbk9ywQ8RcQEjitFRR+Gh0ivVr+aKQhOB0EyqkBXV6ldkFLi9yGuAWY8JZQ==
X-Received: by 2002:a19:920a:: with SMTP id u10mr9678312lfd.122.1543862433315;
        Mon, 03 Dec 2018 10:40:33 -0800 (PST)
Received: from localhost.localdomain (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id d23sm2518513lfc.11.2018.12.03.10.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 10:40:32 -0800 (PST)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     davem@davemloft.net, grygorii.strashko@ti.com
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 4/5] net: ethernet: add default vid len for all ehternet kind devices
Date:   Mon,  3 Dec 2018 20:40:22 +0200
Message-Id: <20181203184023.3430-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default every ethernet netdev needs vid len = 2 bytes to be able to
hold up to 4096 vids. So set it for every eth device to be correct,
except vlan devs.

In order to shrink all addresses of devices above vlan, the vid_len
for vlan dev = 0, as result all suckers sync their addresses to common
base not taking in to account vid part (vid_len of "to" devices is
important only). And only vlan device is the source of addresses with
actual its vid set, propagating it to parent devices while rx_mode().

Also, don't bother those devices that at this moment not moved to vlan
addressing scheme, so while end ethernet device is created - set
vid_len to 0, thus, while syncing, its address space is concatenated
to one dimensional like usual, and who needs vlan addresses to be
separate - set it to VLAN_VID_TYPE_SIZE. When number of devices
supporting new vlan addressing scheme becomes more than simple ones,
it can be reversed, disabling it for those who don't need.

This vid_len should be placed under smth like CONFIG_8021Q_ADDR_FLT.

There is another decision - is to inherit vid_len or some feature flag
from end root device in order to all upper devices have vlan extended
address space only if exact end real device have such capability. But
I didn't, because it requires more changes and probably I'm not
familiar with all places where it should be inherited, I would
appreciate if someone can guid where it's applicable, then it could
become a little bit more limited.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 net/8021q/vlan_dev.c |  1 +
 net/ethernet/eth.c   | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index f6bcd847509e..c2d934251e77 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -896,6 +896,7 @@ void vlan_setup(struct net_device *dev)
 
 	dev->min_mtu		= 0;
 	dev->max_mtu		= ETH_MAX_MTU;
+	dev->vid_len		= 0;
 
 	eth_zero_addr(dev->broadcast);
 }
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 58933fa50bb5..52f90cefb6de 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -363,6 +363,7 @@ void ether_setup(struct net_device *dev)
 	dev->min_mtu		= ETH_MIN_MTU;
 	dev->max_mtu		= ETH_DATA_LEN;
 	dev->addr_len		= ETH_ALEN;
+	dev->vid_len		= NET_802Q_VID_TSIZE;
 	dev->tx_queue_len	= DEFAULT_TX_QUEUE_LEN;
 	dev->flags		= IFF_BROADCAST|IFF_MULTICAST;
 	dev->priv_flags		|= IFF_TX_SKB_SHARING;
@@ -390,8 +391,18 @@ EXPORT_SYMBOL(ether_setup);
 struct net_device *alloc_etherdev_mqs(int sizeof_priv, unsigned int txqs,
 				      unsigned int rxqs)
 {
-	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
-				ether_setup, txqs, rxqs);
+	struct net_device *dev;
+
+	dev = alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_UNKNOWN,
+			       ether_setup, txqs, rxqs);
+
+	/* TODO: When number of real ehternet devices supporting vlan
+	 * addressing scheme becomes more than simple ones, it should
+	 * be removed, disabling it (by dev->vid_len = 0) for those
+	 * who doesn't support it
+	 */
+	dev->vid_len = 0;
+	return dev;
 }
 EXPORT_SYMBOL(alloc_etherdev_mqs);
 
-- 
2.17.1

