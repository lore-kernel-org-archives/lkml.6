Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EC8ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4343E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4343E206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbeGTNOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34850 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:35 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C04EEBBD;
        Fri, 20 Jul 2018 12:26:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 3.18 08/29] netfilter: x_tables: initialise match/target check parameter struct
Date:   Fri, 20 Jul 2018 14:11:03 +0200
Message-Id: <20180720115159.271963099@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit c568503ef02030f169c9e19204def610a3510918 upstream.

syzbot reports following splat:

BUG: KMSAN: uninit-value in ebt_stp_mt_check+0x24b/0x450
 net/bridge/netfilter/ebt_stp.c:162
 ebt_stp_mt_check+0x24b/0x450 net/bridge/netfilter/ebt_stp.c:162
 xt_check_match+0x1438/0x1650 net/netfilter/x_tables.c:506
 ebt_check_match net/bridge/netfilter/ebtables.c:372 [inline]
 ebt_check_entry net/bridge/netfilter/ebtables.c:702 [inline]

The uninitialised access is
   xt_mtchk_param->nft_compat

... which should be set to 0.
Fix it by zeroing the struct beforehand, same for tgchk.

ip(6)tables targetinfo uses c99-style initialiser, so no change
needed there.

Reported-by: syzbot+da4494182233c23a5fcf@syzkaller.appspotmail.com
Fixes: 55917a21d0cc0 ("netfilter: x_tables: add context to know if extension runs from nft_compat")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bridge/netfilter/ebtables.c |    2 ++
 net/ipv4/netfilter/ip_tables.c  |    1 +
 net/ipv6/netfilter/ip6_tables.c |    1 +
 3 files changed, 4 insertions(+)

--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -699,6 +699,8 @@ ebt_check_entry(struct ebt_entry *e, str
 	}
 	i = 0;
 
+	memset(&mtpar, 0, sizeof(mtpar));
+	memset(&tgpar, 0, sizeof(tgpar));
 	mtpar.net	= tgpar.net       = net;
 	mtpar.table     = tgpar.table     = name;
 	mtpar.entryinfo = tgpar.entryinfo = e;
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -651,6 +651,7 @@ find_check_entry(struct ipt_entry *e, st
 	struct xt_entry_match *ematch;
 
 	j = 0;
+	memset(&mtpar, 0, sizeof(mtpar));
 	mtpar.net	= net;
 	mtpar.table     = name;
 	mtpar.entryinfo = &e->ip;
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -662,6 +662,7 @@ find_check_entry(struct ip6t_entry *e, s
 	struct xt_entry_match *ematch;
 
 	j = 0;
+	memset(&mtpar, 0, sizeof(mtpar));
 	mtpar.net	= net;
 	mtpar.table     = name;
 	mtpar.entryinfo = &e->ipv6;


