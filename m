Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35948C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B282251B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny5J+sH1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0B282251B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbeKOI1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeKOI1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:12 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC88022510;
        Wed, 14 Nov 2018 22:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234128;
        bh=Mk2xhl4cODY/WVIJcuWQm+21kgdh0wtRNFPh2/XR1nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ny5J+sH1V4z2Vvo1Z0WQxQ8/aH6+jdbkWsekaQ4RdYH7i1zSbo0I9zMtUdfsdPsbn
         hb2ElukEQiAmfnS0Iy2xe8M8Wkjf1G23ZkqOnVlcMfAQDDxk6A78PBSeSSsGb1LvlD
         Nh4AXvBg7uJBCw2yUJu+52SbUpxtZYtirkwvNtHQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 02/73] netfilter: ipv6: fix oops when defragmenting locally generated fragments
Date:   Wed, 14 Nov 2018 17:20:56 -0500
Message-Id: <20181114222207.98701-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 61792b677415b77c8db04991c22966bb8de7603e ]

Unlike ipv4 and normal ipv6 defrag, netfilter ipv6 defragmentation did
not save/restore skb->dst.

This causes oops when handling locally generated ipv6 fragments, as
output path needs a valid dst.

Reported-by: Maciej Żenczykowski <zenczykowski@gmail.com>
Fixes: 84379c9afe01 ("netfilter: ipv6: nf_defrag: drop skb dst before queueing")
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 8f68a518d9db..f76bd4d15704 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -587,11 +587,16 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	 */
 	ret = -EINPROGRESS;
 	if (fq->q.flags == (INET_FRAG_FIRST_IN | INET_FRAG_LAST_IN) &&
-	    fq->q.meat == fq->q.len &&
-	    nf_ct_frag6_reasm(fq, skb, dev))
-		ret = 0;
-	else
+	    fq->q.meat == fq->q.len) {
+		unsigned long orefdst = skb->_skb_refdst;
+
+		skb->_skb_refdst = 0UL;
+		if (nf_ct_frag6_reasm(fq, skb, dev))
+			ret = 0;
+		skb->_skb_refdst = orefdst;
+	} else {
 		skb_dst_drop(skb);
+	}
 
 out_unlock:
 	spin_unlock_bh(&fq->q.lock);
-- 
2.17.1

