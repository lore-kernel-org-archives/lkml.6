Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF264C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D15213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Anep66RZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D15213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbeK3Bda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:33:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbeK3Bd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:33:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEEA2133F;
        Thu, 29 Nov 2018 14:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501676;
        bh=9hS67AwPFo1hlyBFM7o2Vzf1fLz7+BzL7kOvJfITrOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Anep66RZHZhlVw8vMOM578wpRvVtK/ZJU6ZGqIBsgX3NsZN3xCIaDIfBNKYrnIe1+
         o8PBi1EA07HMjioS2e7PThtBSWFVjlnfBrBA/lS4Q/nSwQM17nUsSUAjZgt9vByFhM
         KTJbLnXPjCjKuoxrtmRmiHsmoSMU/9HT3JCjRlZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@osg.samsung.com>
Subject: [PATCH 4.14 096/100] net: ieee802154: 6lowpan: fix frag reassembly
Date:   Thu, 29 Nov 2018 15:13:06 +0100
Message-Id: <20181129140107.059805029@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140058.768942700@linuxfoundation.org>
References: <20181129140058.768942700@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Aring <aring@mojatatu.com>

commit f18fa5de5ba7f1d6650951502bb96a6e4715a948 upstream.

This patch initialize stack variables which are used in
frag_lowpan_compare_key to zero. In my case there are padding bytes in the
structures ieee802154_addr as well in frag_lowpan_compare_key. Otherwise
the key variable contains random bytes. The result is that a compare of
two keys by memcmp works incorrect.

Fixes: 648700f76b03 ("inet: frags: use rhashtables for reassembly units")
Signed-off-by: Alexander Aring <aring@mojatatu.com>
Reported-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ieee802154/6lowpan/6lowpan_i.h  |    4 ++--
 net/ieee802154/6lowpan/reassembly.c |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -20,8 +20,8 @@ typedef unsigned __bitwise lowpan_rx_res
 struct frag_lowpan_compare_key {
 	u16 tag;
 	u16 d_size;
-	const struct ieee802154_addr src;
-	const struct ieee802154_addr dst;
+	struct ieee802154_addr src;
+	struct ieee802154_addr dst;
 };
 
 /* Equivalent of ipv4 struct ipq
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -75,14 +75,14 @@ fq_find(struct net *net, const struct lo
 {
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
-	struct frag_lowpan_compare_key key = {
-		.tag = cb->d_tag,
-		.d_size = cb->d_size,
-		.src = *src,
-		.dst = *dst,
-	};
+	struct frag_lowpan_compare_key key = {};
 	struct inet_frag_queue *q;
 
+	key.tag = cb->d_tag;
+	key.d_size = cb->d_size;
+	key.src = *src;
+	key.dst = *dst;
+
 	q = inet_frag_find(&ieee802154_lowpan->frags, &key);
 	if (!q)
 		return NULL;
@@ -372,7 +372,7 @@ int lowpan_frag_rcv(struct sk_buff *skb,
 	struct lowpan_frag_queue *fq;
 	struct net *net = dev_net(skb->dev);
 	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = {};
 	int err;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)


