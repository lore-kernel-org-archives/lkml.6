Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4EEECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D9320844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8biAwE8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D9320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732087AbeKIHoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:44:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731106AbeKIHoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:44:16 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9A4E2146E;
        Thu,  8 Nov 2018 22:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714805;
        bh=SCcCInYSlO395+EZwzRU7MbX45x/tYVqdOGWowWixDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s8biAwE8zwR1pm9pqPqYdf7i8uQOCbKPW3Etq/k1eMuR+BckzrIHpABVhivt02E4Z
         TwTGLwDOCJmBWbxX9P76OLCV/CE0Ksmc3Xl6FNQDojhelQDLNk3IJXko+nKoM80eSN
         A/WH2dmqqR2KolVVMZNFv5s7+E3E/VCw3gIR07MM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 132/171] Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"
Date:   Thu,  8 Nov 2018 13:51:42 -0800
Message-Id: <20181108215136.723736221@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit ad8b1ffc3efae2f65080bdb11145c87d299b8f9a.

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
index b9147558a8f2..e46185377981 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -597,8 +597,6 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	    fq->q.meat == fq->q.len &&
 	    nf_ct_frag6_reasm(fq, skb, dev))
 		ret = 0;
-	else
-		skb_dst_drop(skb);
 
 out_unlock:
 	spin_unlock_bh(&fq->q.lock);
-- 
2.17.1



