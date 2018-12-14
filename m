Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CAC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE41620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791360;
	bh=gGspOn1/vegOuqDB8u5K8d1A2vchGhmqt9WQXLxJTUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZ5k/jH7esP8HBbsvMgAnXEbVbCOGSAHp9a+dv4hQTDflyIw2ykJh/qWs8Scxu2mx
	 m+EcBgPj1o/069LtPBLVH07sTBM6Bdu3PRY5QlV0OBK10kkzgUQDWIZZKBW5XbXW7e
	 C1pH9ybB3HkRv1GlK9pYXXejjhmqChbEzEBBOfMM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE41620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbeLNMmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:42:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbeLNMCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA4E2146F;
        Fri, 14 Dec 2018 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788968;
        bh=gGspOn1/vegOuqDB8u5K8d1A2vchGhmqt9WQXLxJTUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByVntFfbroHMK32Gw0TpCqz5kYS3QtH4vN91h/LxD6utqyuCnhg1g9J8GfJC6kwLe
         kMym5juL5wKlK9yDBWtJ/qsku5rtB1CqBd0LyarxPPMBSl50py4XfubnOSILtRLiX5
         qHoooLC8FJRz0GhB7uL6fTOj1WG3cDP0YPW1Lg3I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 020/142] net: restore call to netdev_queue_numa_node_write when resetting XPS
Date:   Fri, 14 Dec 2018 12:58:25 +0100
Message-Id: <20181214115747.856719566@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit f28c020fb488e1a8b87469812017044bef88aa2b ]

Before commit 80d19669ecd3 ("net: Refactor XPS for CPUs and Rx queues"),
netif_reset_xps_queues() did netdev_queue_numa_node_write() for all the
queues being reset. Now, this is only done when the "active" variable in
clean_xps_maps() is false, ie when on all the CPUs, there's no active
XPS mapping left.

Fixes: 80d19669ecd3 ("net: Refactor XPS for CPUs and Rx queues")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2173,17 +2173,19 @@ static void clean_xps_maps(struct net_de
 		active |= remove_xps_queue_cpu(dev, dev_maps, j, offset,
 					       count);
 	if (!active) {
-		if (is_rxqs_map) {
+		if (is_rxqs_map)
 			RCU_INIT_POINTER(dev->xps_rxqs_map, NULL);
-		} else {
+		else
 			RCU_INIT_POINTER(dev->xps_cpus_map, NULL);
+		kfree_rcu(dev_maps, rcu);
+	}
 
-			for (i = offset + (count - 1); count--; i--)
-				netdev_queue_numa_node_write(
-					netdev_get_tx_queue(dev, i),
-							NUMA_NO_NODE);
+	if (!is_rxqs_map) {
+		for (i = offset + (count - 1); count--; i--) {
+			netdev_queue_numa_node_write(
+				netdev_get_tx_queue(dev, i),
+				NUMA_NO_NODE);
 		}
-		kfree_rcu(dev_maps, rcu);
 	}
 }
 


