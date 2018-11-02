Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58781C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274D32084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGcGXyc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274D32084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbeKCDvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:51:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729437AbeKCDvF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:51:05 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DC420847;
        Fri,  2 Nov 2018 18:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184172;
        bh=0N7dQpqoLN0dFViOBTAf7xjALSJuiPXsO7syvGjSRC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGcGXyc6wIkOdn1sEkQFSCcTZSxhASgeK2pV89NEGIZCtw/YwzHLmZYfsl9DpLtwm
         JjPLoy3XsI4NCYRmRrreHkpA3du1wXzJ+2Wh9+WoyN+gLr2bffj3WF3iBgD7stEdxF
         L+PzVx+lfygfYLcoPogXOEZNUqAVuk+YTorhbe6A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 101/150] Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"
Date:   Fri,  2 Nov 2018 19:34:23 +0100
Message-Id: <20181102182910.388676447@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 84379c9afe011020e797e3f50a662b08a6355dcf.

>From Florian Westphal <fw@strlen.de>:

	It causes kernel crash for locally generated ipv6 fragments
	when netfilter ipv6 defragmentation is used.

	The faulty commit is not essential for -stable, it only
	delays netns teardown for longer than needed when that netns
	still has ipv6 frags queued.  Much better than crash :-/

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index e4d9e6976d3c..a452d99c9f52 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -585,8 +585,6 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	    fq->q.meat == fq->q.len &&
 	    nf_ct_frag6_reasm(fq, skb, dev))
 		ret = 0;
-	else
-		skb_dst_drop(skb);
 
 out_unlock:
 	spin_unlock_bh(&fq->q.lock);
-- 
2.17.1



