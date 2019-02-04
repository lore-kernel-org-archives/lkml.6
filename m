Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD72AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765E82087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277040;
	bh=4+ZoBI9/jOUwj4Q5FMVPwVunhddtOljf0bYhka44YD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xaQAiq4g6MVZsOY31Q2V7rJW3iXoAMKqVI/fHMNZh2TMrXQIi3tA448DDp4Y8SViA
	 auO7iGWSkaxkbnsJNjv6E8RFblgodSjECsnrcZSiQXXonVhZbtb1AbymYmB3TXQRO0
	 hYkbfzk+ddpKK7oomqDF8wpFXZ2bKkX2h4V4EyZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730867AbfBDKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:43:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730848AbfBDKnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:43:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3627C2070C;
        Mon,  4 Feb 2019 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277034;
        bh=4+ZoBI9/jOUwj4Q5FMVPwVunhddtOljf0bYhka44YD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNBfQmLir734R+MyRuJcDU/qYa7bxcDsxhKRP+JGq4diCN1hQjEHci8okG5AjSbT2
         DeAXf/7jr/7ygIMwA/XqaLUjiJ4acCvzb9tnOVQB/mx2VVkorgx6ShBVLVUEacxpP5
         K0+xSTQljjJcdbaTHPpZbrIQUzWEpk13ERXpJEGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ivan Babrou <ivan@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH 4.9 01/30] Fix "net: ipv4: do not handle duplicate fragments as overlapping"
Date:   Mon,  4 Feb 2019 11:36:39 +0100
Message-Id: <20190204103605.523790581@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103605.271746870@linuxfoundation.org>
References: <20190204103605.271746870@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

ade446403bfb ("net: ipv4: do not handle duplicate fragments as
overlapping") was backported to many stable trees, but it had a problem
that was "accidentally" fixed by the upstream commit 0ff89efb5246 ("ip:
fail fast on IP defrag errors")

This is the fixup for that problem as we do not want the larger patch in
the older stable trees.

Fixes: ade446403bfb ("net: ipv4: do not handle duplicate fragments as overlapping")
Reported-by: Ivan Babrou <ivan@cloudflare.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/ip_fragment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -423,6 +423,7 @@ static int ip_frag_queue(struct ipq *qp,
 	 * fragment.
 	 */
 
+	err = -EINVAL;
 	/* Find out where to put this fragment.  */
 	prev_tail = qp->q.fragments_tail;
 	if (!prev_tail)
@@ -499,7 +500,6 @@ static int ip_frag_queue(struct ipq *qp,
 
 discard_qp:
 	inet_frag_kill(&qp->q);
-	err = -EINVAL;
 	__IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
 err:
 	kfree_skb(skb);


