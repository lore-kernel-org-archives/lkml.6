Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76CD22084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbI7StAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD22084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbeKCEEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeKCEE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:04:29 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9124C20848;
        Fri,  2 Nov 2018 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184973;
        bh=Y41XsFTE8Z92ihYBxDLyGEaPFUWgC15XGPICFuQWpBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbI7StAM72cGe8IhTJ6DRs7yiptskz8SGUelbXgjXVYIg4Tc5qhem+TjxLNWVq8xf
         t0oMt83h1bIIoug62mgsYskVEmKZNlrpSExTfVBRuxXsRxmp7Kx2nmt+qDao/vapqI
         gQumbQ5FVunVLA+8b+P+Ak7Q5rDzPf2sA7JjA6fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 112/143] Revert "netfilter: ipv6: nf_defrag: drop skb dst before queueing"
Date:   Fri,  2 Nov 2018 19:34:57 +0100
Message-Id: <20181102182906.790839045@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
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

This reverts commit 28c74ff85efd192aeca9005499ca50c24d795f61.

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
index 2ed8536e10b6..611d406c4656 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -598,8 +598,6 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	    fq->q.meat == fq->q.len &&
 	    nf_ct_frag6_reasm(fq, skb, dev))
 		ret = 0;
-	else
-		skb_dst_drop(skb);
 
 out_unlock:
 	spin_unlock_bh(&fq->q.lock);
-- 
2.17.1



