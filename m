Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B65C2F3D9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD0E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080492;
	bh=Rty9TqHV/ld7RqdsK53FxMbrbev41kPEKjS8Q2LlNd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1M5UT/3s4Zk9Ufy8yXBEq8GjeqJh4G1DutVcJG552xGbsce5X1ichH1wDdPaDkZO
	 5XxBLyGTItS69VMFbMILsS1Trrf4KAgnB3KVHzf1yba4PhXy8oXQ9LVKSAmXwzdufy
	 3GgAZgG/TmO4UIJ6Bti/997E7SgKxPjivmR7CqZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfAUNrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729380AbfAUNq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:46:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5432020861;
        Mon, 21 Jan 2019 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078417;
        bh=Rty9TqHV/ld7RqdsK53FxMbrbev41kPEKjS8Q2LlNd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2M9O9pT4VsVNtXYK9XFOsVX+CWHr4u+2L3e6yGEjy6tkhTKQU/bJwOd5NzYyfkLle
         FeVkQFQbRMX8n5jjkPWIrRAdSZSux1Aba9zOp7fynwkmmL5bWtmOmFaGc1AUm8si3e
         R36FDS3BDRqgEGJ1i13MDpBgMGqeR8VEEAgiOCe4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 007/111] netfilter: nf_conncount: dont skip eviction when age is negative
Date:   Mon, 21 Jan 2019 14:42:01 +0100
Message-Id: <20190121122456.588981223@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 4cd273bb91b3001f623f516ec726c49754571b1a upstream.

age is signed integer, so result can be negative when the timestamps
have a large delta.  In this case we want to discard the entry.

Instead of using age >= 2 || age < 0, just make it unsigned.

Fixes: b36e4523d4d56 ("netfilter: nf_conncount: fix garbage collection confirm race")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -155,7 +155,7 @@ find_or_evict(struct net *net, struct nf
 	const struct nf_conntrack_tuple_hash *found;
 	unsigned long a, b;
 	int cpu = raw_smp_processor_id();
-	__s32 age;
+	u32 age;
 
 	found = nf_conntrack_find_get(net, &conn->zone, &conn->tuple);
 	if (found)


