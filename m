Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9988DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D22150B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587D22150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeISSLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:11:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35933 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731447AbeISSLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:11:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8E485814DB568;
        Wed, 19 Sep 2018 20:33:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 20:33:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <kadlec@blackhole.kfki.hu>, <pablo@netfilter.org>, <fw@strlen.de>,
        <netfilter-devel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] netfilter: conntrack: get rid of double sizeof
Date:   Wed, 19 Sep 2018 20:21:11 +0800
Message-ID: <1537359671-53720-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sizeof(sizeof()) is quite strange and does not seem to be what
is wanted here.

The issue is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/netfilter/nf_conntrack_proto_tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index b4bdf9e..247b897 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1213,8 +1213,8 @@ static int tcp_to_nlattr(struct sk_buff *skb, struct nlattr *nla,
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
1.7.12.4

