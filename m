Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62ECC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5484122529
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zn8GEw4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5484122529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbeKOI3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbeKOI3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:19 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2A4422523;
        Wed, 14 Nov 2018 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234254;
        bh=kQCgP0AYUd405RnUtdKHwz/PU0R3nnv3byVRwVDOuqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zn8GEw4NGGWB+jCjAdjv0UcQ7ZP56eVo5Z+oN4hR+5CtUo19T1wVOUyDHjkXVYIrM
         q8n7zs6qTQmMf7NP+DG1mx8+4Nu430+Lc7TaScxoG9xx9dqMDuNDBeFim6IHNwRoz2
         7VsTPo+FBhzy/alaiUC0/FhG/iopKK9BYanBu1SM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 17/59] netfilter: ipset: Fix calling ip_set() macro at dumping
Date:   Wed, 14 Nov 2018 17:22:49 -0500
Message-Id: <20181114222335.99339-17-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>

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
@@ -1440,7 +1444,7 @@ ip_set_dump_start(struct sk_buff *skb, struct netlink_callback *cb)
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

