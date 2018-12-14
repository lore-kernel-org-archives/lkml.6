Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B42BC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416B82146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788975;
	bh=9qOgkAsopNh71iTv9zN7Qqusf1/Fk3JKVeNVU2+DOhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0f+xRwUW/kCSWT3wqeAbpVoMX/9pntdqTj2AwDatWf1qbA5xawf7L6DolipP0cScF
	 n3fUiie5CX9dvEPfWjbOcvtA8csMgsHt/EXFDkrMmtkbpuyssyWtWurtoVHHCFllzF
	 0lC2u4REr2PkwO4RyGqVKqMzQ+G9P8Uf73GKLlfk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416B82146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbeLNMCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:45944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730125AbeLNMCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCB5F2146E;
        Fri, 14 Dec 2018 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788971;
        bh=9qOgkAsopNh71iTv9zN7Qqusf1/Fk3JKVeNVU2+DOhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mOJX4BS/PtCdPRHI1mdZbH1yv9/NzsBOTd10wdd17++pymn259KUy8vUoOz+Fjc4k
         19BDicXSBufmggJ/++MtPI/+jLGe98g95lA4nqT3WA0X0ySKpURB1aOD7sOnbNOyoR
         ibB0uD+L/vFGly/OvRnNhf6mB1XwZDer/hujGUT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 021/142] net: fix XPS static_key accounting
Date:   Fri, 14 Dec 2018 12:58:26 +0100
Message-Id: <20181214115747.901716879@linuxfoundation.org>
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

[ Upstream commit 867d0ad476db89a1e8af3f297af402399a54eea5 ]

Commit 04157469b7b8 ("net: Use static_key for XPS maps") introduced a
static key for XPS, but the increments/decrements don't match.

First, the static key's counter is incremented once for each queue, but
only decremented once for a whole batch of queues, leading to large
unbalances.

Second, the xps_rxqs_needed key is decremented whenever we reset a batch
of queues, whether they had any rxqs mapping or not, so that if we setup
cpu-XPS on em1 and RXQS-XPS on em2, resetting the queues on em1 would
decrement the xps_rxqs_needed key.

This reworks the accounting scheme so that the xps_needed key is
incremented only once for each type of XPS for all the queues on a
device, and the xps_rxqs_needed key is incremented only once for all
queues. This is sufficient to let us retrieve queues via
get_xps_queue().

This patch introduces a new reset_xps_maps(), which reinitializes and
frees the appropriate map (xps_rxqs_map or xps_cpus_map), and drops a
reference to the needed keys:
 - both xps_needed and xps_rxqs_needed, in case of rxqs maps,
 - only xps_needed, in case of CPU maps.

Now, we also need to call reset_xps_maps() at the end of
__netif_set_xps_queue() when there's no active map left, for example
when writing '00000000,00000000' to all queues' xps_rxqs setting.

Fixes: 04157469b7b8 ("net: Use static_key for XPS maps")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/dev.c |   45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2161,6 +2161,20 @@ static bool remove_xps_queue_cpu(struct
 	return active;
 }
 
+static void reset_xps_maps(struct net_device *dev,
+			   struct xps_dev_maps *dev_maps,
+			   bool is_rxqs_map)
+{
+	if (is_rxqs_map) {
+		static_key_slow_dec_cpuslocked(&xps_rxqs_needed);
+		RCU_INIT_POINTER(dev->xps_rxqs_map, NULL);
+	} else {
+		RCU_INIT_POINTER(dev->xps_cpus_map, NULL);
+	}
+	static_key_slow_dec_cpuslocked(&xps_needed);
+	kfree_rcu(dev_maps, rcu);
+}
+
 static void clean_xps_maps(struct net_device *dev, const unsigned long *mask,
 			   struct xps_dev_maps *dev_maps, unsigned int nr_ids,
 			   u16 offset, u16 count, bool is_rxqs_map)
@@ -2172,13 +2186,8 @@ static void clean_xps_maps(struct net_de
 	     j < nr_ids;)
 		active |= remove_xps_queue_cpu(dev, dev_maps, j, offset,
 					       count);
-	if (!active) {
-		if (is_rxqs_map)
-			RCU_INIT_POINTER(dev->xps_rxqs_map, NULL);
-		else
-			RCU_INIT_POINTER(dev->xps_cpus_map, NULL);
-		kfree_rcu(dev_maps, rcu);
-	}
+	if (!active)
+		reset_xps_maps(dev, dev_maps, is_rxqs_map);
 
 	if (!is_rxqs_map) {
 		for (i = offset + (count - 1); count--; i--) {
@@ -2222,10 +2231,6 @@ static void netif_reset_xps_queues(struc
 		       false);
 
 out_no_maps:
-	if (static_key_enabled(&xps_rxqs_needed))
-		static_key_slow_dec_cpuslocked(&xps_rxqs_needed);
-
-	static_key_slow_dec_cpuslocked(&xps_needed);
 	mutex_unlock(&xps_map_mutex);
 	cpus_read_unlock();
 }
@@ -2343,9 +2348,12 @@ int __netif_set_xps_queue(struct net_dev
 	if (!new_dev_maps)
 		goto out_no_new_maps;
 
-	static_key_slow_inc_cpuslocked(&xps_needed);
-	if (is_rxqs_map)
-		static_key_slow_inc_cpuslocked(&xps_rxqs_needed);
+	if (!dev_maps) {
+		/* Increment static keys at most once per type */
+		static_key_slow_inc_cpuslocked(&xps_needed);
+		if (is_rxqs_map)
+			static_key_slow_inc_cpuslocked(&xps_rxqs_needed);
+	}
 
 	for (j = -1; j = netif_attrmask_next(j, possible_mask, nr_ids),
 	     j < nr_ids;) {
@@ -2443,13 +2451,8 @@ out_no_new_maps:
 	}
 
 	/* free map if not active */
-	if (!active) {
-		if (is_rxqs_map)
-			RCU_INIT_POINTER(dev->xps_rxqs_map, NULL);
-		else
-			RCU_INIT_POINTER(dev->xps_cpus_map, NULL);
-		kfree_rcu(dev_maps, rcu);
-	}
+	if (!active)
+		reset_xps_maps(dev, dev_maps, is_rxqs_map);
 
 out_no_maps:
 	mutex_unlock(&xps_map_mutex);


