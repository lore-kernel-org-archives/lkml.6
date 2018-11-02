Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225D6C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95D62082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0bzS+a9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95D62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbeKCDqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbeKCDqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:39 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3A92081B;
        Fri,  2 Nov 2018 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183908;
        bh=WIqTJZlZJ1MhuQrEmxhs6s+VlNxI88Csb+at8SXRwBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bzS+a9j5fWd+pJcTG3FvFHLcJkWDLAo7P4ulbyzX8J9LyQoNW8F5g148OI+H10tq
         uYFQid7UxRYWHbPP6dnkoDCVmjmgF1a3jApXPUxKpqpcJPRYMen99Wth/cwQy6Jz5/
         muI2C/hAkcCnNrh9v7IBJwF23AErCY6rJTRU/7ls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, zhong jiang <zhongjiang@huawei.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 017/150] netfilter: conntrack: get rid of double sizeof
Date:   Fri,  2 Nov 2018 19:32:59 +0100
Message-Id: <20181102182904.063832148@linuxfoundation.org>
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

[ Upstream commit 346fa83d10934cf206e2fd0f514bf8ce186f08fe ]

sizeof(sizeof()) is quite strange and does not seem to be what
is wanted here.

The issue is detected with the help of Coccinelle.

Fixes: 39215846740a ("netfilter: conntrack: remove nlattr_size pointer from l4proto trackers")
Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Acked-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 8e67910185a0..1004fb5930de 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1239,8 +1239,8 @@ static const struct nla_policy tcp_nla_policy[CTA_PROTOINFO_TCP_MAX+1] = {
 #define TCP_NLATTR_SIZE	( \
 	NLA_ALIGN(NLA_HDRLEN + 1) + \
 	NLA_ALIGN(NLA_HDRLEN + 1) + \
-	NLA_ALIGN(NLA_HDRLEN + sizeof(sizeof(struct nf_ct_tcp_flags))) + \
-	NLA_ALIGN(NLA_HDRLEN + sizeof(sizeof(struct nf_ct_tcp_flags))))
+	NLA_ALIGN(NLA_HDRLEN + sizeof(struct nf_ct_tcp_flags)) + \
+	NLA_ALIGN(NLA_HDRLEN + sizeof(struct nf_ct_tcp_flags)))
 
 static int nlattr_to_tcp(struct nlattr *cda[], struct nf_conn *ct)
 {
-- 
2.17.1



