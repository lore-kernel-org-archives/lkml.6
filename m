Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987F8C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684BB2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079117;
	bh=5l1D5xLFLBvso1o2iWeKQZozz0ozdxdXxxTpQo7nlz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XhVSZiNdtTfm+dRMYktOkXA/XCyi0ULL79vfVt29U3hmyPUrKkJqg4VeFqO0rsb8i
	 6bMG8WL58xt4+WDT7CEDufpEnQyeUPMatXxwp6CHkPY01uBfzGFAs9XrD8uP9qBlNG
	 R7aH1eiXeG0Ox0hkWmR4fJFaapHSmN8VZzbDc+Ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbfAUN6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731822AbfAUN6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:58:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D69F82084C;
        Mon, 21 Jan 2019 13:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079112;
        bh=5l1D5xLFLBvso1o2iWeKQZozz0ozdxdXxxTpQo7nlz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9Kg65GJuljtE/lFSdzvDpaYTP2v2Lr3XEIxR1WqAhT3Qo84gLZiQk4+pTgIPkv48
         WzCwL/ddqRpC42hZbR8C1DYZevIiqlYcAK3Sz77DYz5nTl7MI5LZMhV+b1hXQscDGq
         chTRIfx8NHZoCYibCMQ4x7B8MlkNjf9gjluZroAs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 13/99] netfilter: nf_conncount: fix argument order to find_next_bit
Date:   Mon, 21 Jan 2019 14:48:05 +0100
Message-Id: <20190121134914.421023706@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

commit a007232066f6839d6f256bab21e825d968f1a163 upstream.

Size and 'next bit' were swapped, this bug could cause worker to
reschedule itself even if system was idle.

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -488,7 +488,7 @@ next:
 	clear_bit(tree, data->pending_trees);
 
 	next_tree = (tree + 1) % CONNCOUNT_SLOTS;
-	next_tree = find_next_bit(data->pending_trees, next_tree, CONNCOUNT_SLOTS);
+	next_tree = find_next_bit(data->pending_trees, CONNCOUNT_SLOTS, next_tree);
 
 	if (next_tree < CONNCOUNT_SLOTS) {
 		data->gc_tree = next_tree;


