Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DACFC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E4A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079629;
	bh=I1Wn7MxKNmvkodZTr1XLq3G0DQ2JfO0w1QH4KNGb4+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N2oOBju2abBI9zvS+bYx8Yy2TuRQi01z+odaiVleytSPC+ZYVsdOQ1m/Hs2MJIZ5r
	 ZxCWF7Ncpbd8SgEk3HDz/YkRxnM1yMEUwSiMituS4tzn0Wqld3HuhD+B88cALCRxR3
	 YP6ZsdGnDaldJK41H05jXpTNYSJW5K1BElVQmSLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAUOHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:07:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfAUN75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17C9220879;
        Mon, 21 Jan 2019 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079196;
        bh=I1Wn7MxKNmvkodZTr1XLq3G0DQ2JfO0w1QH4KNGb4+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXitIIj7q/QBVQHUdp9qtl7ectLHcUC4a/KBWZr+CRkj172xDDJrrv7qjsyPl8a5o
         OM7zONrGA6J7BP334AwBWzUeLghPigpIOO2ZUmWrLgqarSucs7ZOBOmrQrUHmqf9Ym
         Pc5iSXCLxZj5MvIrQkL8SVGSwwJsBvB3+8L4+EX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 07/99] netfilter: nf_conncount: dont skip eviction when age is negative
Date:   Mon, 21 Jan 2019 14:47:59 +0100
Message-Id: <20190121134914.197421271@linuxfoundation.org>
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


