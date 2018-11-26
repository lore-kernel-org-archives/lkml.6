Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D30C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFC9421104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xta9UXk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFC9421104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730751AbeKZV5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:57:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeKZV5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:57:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8594120645;
        Mon, 26 Nov 2018 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230208;
        bh=sbkR9fgHVrfghcj9JyFi9ZZi1G/hVt7KWGCCmMaSGRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xta9UXk0BcbYjZYuYA/YUXdAp7lDAT2zQfBpWT391jEW6Pn14+ALbZYiyXrpUZxie
         HhLluClJ90KQP6UGF8LUsYac5zp6a1qVM2sUzHznGU+FueM/MUVcIBWIIXMKv7enau
         WMp1ryBFd9vFSf6J8nrytl4F8wuGAssWlmlZI95s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/118] netfilter: ipset: Fix calling ip_set() macro at dumping
Date:   Mon, 26 Nov 2018 11:50:43 +0100
Message-Id: <20181126105102.786142173@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8a02bdd50b2ecb6d62121d2958d3ea186cc88ce7 ]

The ip_set() macro is called when either ip_set_ref_lock held only
or no lock/nfnl mutex is held at dumping. Take this into account
properly. Also, use Pablo's suggestion to use rcu_dereference_raw(),
the ref_netlink protects the set.

Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index 68db946df151..1577f2f76060 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -55,11 +55,15 @@ MODULE_AUTHOR("Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>");
 MODULE_DESCRIPTION("core IP set support");
 MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_IPSET);
 
-/* When the nfnl mutex is held: */
+/* When the nfnl mutex or ip_set_ref_lock is held: */
 #define ip_set_dereference(p)		\
-	rcu_dereference_protected(p, lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET))
+	rcu_dereference_protected(p,	\
+		lockdep_nfnl_is_held(NFNL_SUBSYS_IPSET) || \
+		lockdep_is_held(&ip_set_ref_lock))
 #define ip_set(inst, id)		\
 	ip_set_dereference((inst)->ip_set_list)[id]
+#define ip_set_ref_netlink(inst,id)	\
+	rcu_dereference_raw((inst)->ip_set_list)[id]
 
 /* The set types are implemented in modules and registered set types
  * can be found in ip_set_type_list. Adding/deleting types is
@@ -1251,7 +1255,7 @@ ip_set_dump_done(struct netlink_callback *cb)
 		struct ip_set_net *inst =
 			(struct ip_set_net *)cb->args[IPSET_CB_NET];
 		ip_set_id_t index = (ip_set_id_t)cb->args[IPSET_CB_INDEX];
-		struct ip_set *set = ip_set(inst, index);
+		struct ip_set *set = ip_set_ref_netlink(inst, index);
 
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
@@ -1440,7 +1444,7 @@ next_set:
 release_refcount:
 	/* If there was an error or set is done, release set */
 	if (ret || !cb->args[IPSET_CB_ARG0]) {
-		set = ip_set(inst, index);
+		set = ip_set_ref_netlink(inst, index);
 		if (set->variant->uref)
 			set->variant->uref(set, cb, false);
 		pr_debug("release set %s\n", set->name);
-- 
2.17.1



