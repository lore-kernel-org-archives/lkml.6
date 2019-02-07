Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB55C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B738421908
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549539796;
	bh=RMvcEMq1vmc8Sj9yR7Dd8qNRZp5x7nYml1Rf8VdZA3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NMJHvsWbbuNE3RsnojZlYq7JLVdKcZfWAtIybKkjk9NfuSrwQZXF8XK5GT6k8wrS9
	 sr/1KFsbfiZPzG6o62R6nBhbZYfh/Glnex0CRvoyUeK+z38+PMZej8gWAbt7A6PNmj
	 wk4d7KGtivCJinv56+TGWbjB3mzWmTE8I1883AKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfBGLnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:43:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727325AbfBGLnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:43:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3B08218FE;
        Thu,  7 Feb 2019 11:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549539793;
        bh=RMvcEMq1vmc8Sj9yR7Dd8qNRZp5x7nYml1Rf8VdZA3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lztnsru2MsihyFV9Pn+RLiWHVzBhTqhlS3ICZIH87bt7lKh8R/0b9Eh29OrhAO3WK
         uA6rFqaNcxqg7RKbkC4mRGgiWyueAk3kA8OHaIk9DZaI6QYdaNIXSRqCTSFVU0gVCl
         mFLiKHQNR8PB7wzhllPtBalprNqULknoLJ5q1gz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Aring <aring@mojatatu.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 10/34] net: ieee802154: 6lowpan: fix frag reassembly
Date:   Thu,  7 Feb 2019 12:41:52 +0100
Message-Id: <20190207113025.986174348@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207113025.552605181@linuxfoundation.org>
References: <20190207113025.552605181@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ieee802154/6lowpan/6lowpan_i.h  |    4 ++--
 net/ieee802154/6lowpan/reassembly.c |   14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/net/ieee802154/6lowpan/6lowpan_i.h
+++ b/net/ieee802154/6lowpan/6lowpan_i.h
@@ -19,8 +19,8 @@ typedef unsigned __bitwise__ lowpan_rx_r
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
@@ -74,14 +74,14 @@ fq_find(struct net *net, const struct lo
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
 	if (IS_ERR_OR_NULL(q)) {
 		inet_frag_maybe_warn_overflow(q, pr_fmt());
@@ -372,7 +372,7 @@ int lowpan_frag_rcv(struct sk_buff *skb,
 	struct lowpan_frag_queue *fq;
 	struct net *net = dev_net(skb->dev);
 	struct lowpan_802154_cb *cb = lowpan_802154_cb(skb);
-	struct ieee802154_hdr hdr;
+	struct ieee802154_hdr hdr = {};
 	int err;
 
 	if (ieee802154_hdr_peek_addrs(skb, &hdr) < 0)


