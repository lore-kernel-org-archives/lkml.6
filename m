Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F6A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F6A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbeIMTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:08:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34626 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbeIMTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:08:14 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C62D6D0E;
        Thu, 13 Sep 2018 13:58:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, shaochun chen <cscnull@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 075/197] netfilter: fix memory leaks on netlink_dump_start error
Date:   Thu, 13 Sep 2018 15:30:24 +0200
Message-Id: <20180913131844.524514107@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
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

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 3e673b23b541b8e7f773b2d378d6eb99831741cd ]

Shaochun Chen points out we leak dumper filter state allocations
stored in dump_control->data in case there is an error before netlink sets
cb_running (after which ->done will be called at some point).

In order to fix this, add .start functions and move allocations there.

Same pattern as used in commit 90fd131afc565159c9e0ea742f082b337e10f8c6
("netfilter: nf_tables: move dumper state allocation into ->start").

Reported-by: shaochun chen <cscnull@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_conntrack_netlink.c |   26 +++++++++++++++++---------
 net/netfilter/nfnetlink_acct.c       |   29 +++++++++++++----------------
 2 files changed, 30 insertions(+), 25 deletions(-)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -821,6 +821,21 @@ ctnetlink_alloc_filter(const struct nlat
 #endif
 }
 
+static int ctnetlink_start(struct netlink_callback *cb)
+{
+	const struct nlattr * const *cda = cb->data;
+	struct ctnetlink_filter *filter = NULL;
+
+	if (cda[CTA_MARK] && cda[CTA_MARK_MASK]) {
+		filter = ctnetlink_alloc_filter(cda);
+		if (IS_ERR(filter))
+			return PTR_ERR(filter);
+	}
+
+	cb->data = filter;
+	return 0;
+}
+
 static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 {
 	struct ctnetlink_filter *filter = data;
@@ -1240,19 +1255,12 @@ static int ctnetlink_get_conntrack(struc
 
 	if (nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
+			.start = ctnetlink_start,
 			.dump = ctnetlink_dump_table,
 			.done = ctnetlink_done,
+			.data = (void *)cda,
 		};
 
-		if (cda[CTA_MARK] && cda[CTA_MARK_MASK]) {
-			struct ctnetlink_filter *filter;
-
-			filter = ctnetlink_alloc_filter(cda);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
-
-			c.data = filter;
-		}
 		return netlink_dump_start(ctnl, skb, nlh, &c);
 	}
 
--- a/net/netfilter/nfnetlink_acct.c
+++ b/net/netfilter/nfnetlink_acct.c
@@ -238,29 +238,33 @@ static const struct nla_policy filter_po
 	[NFACCT_FILTER_VALUE]	= { .type = NLA_U32 },
 };
 
-static struct nfacct_filter *
-nfacct_filter_alloc(const struct nlattr * const attr)
+static int nfnl_acct_start(struct netlink_callback *cb)
 {
-	struct nfacct_filter *filter;
+	const struct nlattr *const attr = cb->data;
 	struct nlattr *tb[NFACCT_FILTER_MAX + 1];
+	struct nfacct_filter *filter;
 	int err;
 
+	if (!attr)
+		return 0;
+
 	err = nla_parse_nested(tb, NFACCT_FILTER_MAX, attr, filter_policy,
 			       NULL);
 	if (err < 0)
-		return ERR_PTR(err);
+		return err;
 
 	if (!tb[NFACCT_FILTER_MASK] || !tb[NFACCT_FILTER_VALUE])
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
 	filter = kzalloc(sizeof(struct nfacct_filter), GFP_KERNEL);
 	if (!filter)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	filter->mask = ntohl(nla_get_be32(tb[NFACCT_FILTER_MASK]));
 	filter->value = ntohl(nla_get_be32(tb[NFACCT_FILTER_VALUE]));
+	cb->data = filter;
 
-	return filter;
+	return 0;
 }
 
 static int nfnl_acct_get(struct net *net, struct sock *nfnl,
@@ -275,18 +279,11 @@ static int nfnl_acct_get(struct net *net
 	if (nlh->nlmsg_flags & NLM_F_DUMP) {
 		struct netlink_dump_control c = {
 			.dump = nfnl_acct_dump,
+			.start = nfnl_acct_start,
 			.done = nfnl_acct_done,
+			.data = (void *)tb[NFACCT_FILTER],
 		};
 
-		if (tb[NFACCT_FILTER]) {
-			struct nfacct_filter *filter;
-
-			filter = nfacct_filter_alloc(tb[NFACCT_FILTER]);
-			if (IS_ERR(filter))
-				return PTR_ERR(filter);
-
-			c.data = filter;
-		}
 		return netlink_dump_start(nfnl, skb, nlh, &c);
 	}
 


