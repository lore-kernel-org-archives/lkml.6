Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ECDECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC0F2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqjdwytD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC0F2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731722AbeGQMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbeGQMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:39:06 -0400
Received: from kenny.it.cumulusnetworks.com. (fw.cumulusnetworks.com [216.129.126.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A4DA2145D;
        Tue, 17 Jul 2018 12:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531829205;
        bh=l0XadBySdZEszOh3O0s3O72VhezJaGmZX7d9gRWWLFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqjdwytD4h5kuWzXrVkehOCykoAFkafqa9pzuhtDReinks3NOTL274FVILZKT+Ru1
         /sMvO+2wsWybc14iwAdS0dtGCgAiwKs3xFbjlhrYP7U8TOs64+e2l2k5d0ZiIejptj
         VqnEas24NBL0rkkT//2yjb+iFpfGTGX6IjLjiwzc=
From:   dsahern@kernel.org
To:     netdev@vger.kernel.org
Cc:     nikita.leshchenko@oracle.com, roopa@cumulusnetworks.com,
        stephen@networkplumber.org, idosch@mellanox.com, jiri@mellanox.com,
        saeedm@mellanox.com, alex.aring@gmail.com,
        linux-wpan@vger.kernel.org, netfilter-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: [PATCH RFC/RFT net-next 01/17] net/ipv4: rename ipv4_neigh_lookup to ipv4_dst_neigh_lookup
Date:   Tue, 17 Jul 2018 05:06:35 -0700
Message-Id: <20180717120651.15748-2-dsahern@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180717120651.15748-1-dsahern@kernel.org>
References: <20180717120651.15748-1-dsahern@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

Consistency with ipv6 name for similar function and allows
ipv4_neigh_lookup to be reused for the wrapper to the arp table.
---
 net/ipv4/route.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 1df6e97106d7..74e1df60ab7f 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -153,7 +153,7 @@ static u32 *ipv4_cow_metrics(struct dst_entry *dst, unsigned long old)
 	return NULL;
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
 					   struct sk_buff *skb,
 					   const void *daddr);
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr);
@@ -170,7 +170,7 @@ static struct dst_ops ipv4_dst_ops = {
 	.update_pmtu =		ip_rt_update_pmtu,
 	.redirect =		ip_do_redirect,
 	.local_out =		__ip_local_out,
-	.neigh_lookup =		ipv4_neigh_lookup,
+	.neigh_lookup =		ipv4_dst_neigh_lookup,
 	.confirm_neigh =	ipv4_confirm_neigh,
 };
 
@@ -430,7 +430,7 @@ void rt_cache_flush(struct net *net)
 	rt_genid_bump_ipv4(net);
 }
 
-static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
+static struct neighbour *ipv4_dst_neigh_lookup(const struct dst_entry *dst,
 					   struct sk_buff *skb,
 					   const void *daddr)
 {
@@ -2537,7 +2537,7 @@ static struct dst_ops ipv4_dst_blackhole_ops = {
 	.update_pmtu		=	ipv4_rt_blackhole_update_pmtu,
 	.redirect		=	ipv4_rt_blackhole_redirect,
 	.cow_metrics		=	ipv4_rt_blackhole_cow_metrics,
-	.neigh_lookup		=	ipv4_neigh_lookup,
+	.neigh_lookup		=	ipv4_dst_neigh_lookup,
 };
 
 struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_orig)
-- 
2.11.0

