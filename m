Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71D7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3BA21473
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcPVL3Cj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3BA21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbeKZV4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:39998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeKZV4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93E5B20817;
        Mon, 26 Nov 2018 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230171;
        bh=IWHe9pvVuEm9cpYdygrCQHSWaM/neAWGg8MQbfVL49Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VcPVL3Cj9pw/iG481zz/x6Bim/wIz5UG/BBjEcs9dmkFz4X7K3uu9IIDNZ4eXVC59
         vrFu4OLLznm4lNi5zQdZWWQIGxYByl57oCR997x8o9Kmlei00KTpmZjjJdRwAjB/jd
         I1iTVNBB1PUnICyTgbe3v/miDCyOIbENcY+YufMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 033/118] netfilter: ipv6: fix oops when defragmenting locally generated fragments
Date:   Mon, 26 Nov 2018 11:50:27 +0100
Message-Id: <20181126105101.307993614@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
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



