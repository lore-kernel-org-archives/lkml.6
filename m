Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B880C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9FF208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9FF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbeHATpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405928AbeHATIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:08:39 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D81E91360;
        Wed,  1 Aug 2018 17:13:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florent Fourcot <florent.fourcot@wifirst.fr>,
        Victorien Molle <victorien.molle@wifirst.fr>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 037/246] netfilter: ipset: forbid family for hash:mac sets
Date:   Wed,  1 Aug 2018 18:49:07 +0200
Message-Id: <20180801165013.456059346@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florent Fourcot <florent.fourcot@wifirst.fr>

[ Upstream commit cbdebe481a14b42c45aa9f4ceb5ff19b55de2c57 ]

Userspace `ipset` command forbids family option for hash:mac type:

ipset create test hash:mac family inet4
ipset v6.30: Unknown argument: `family'

However, this check is not done in kernel itself. When someone use
external netlink applications (pyroute2 python library for example), one
can create hash:mac with invalid family and inconsistant results from
userspace (`ipset` command cannot read set content anymore).

This patch enforce the logic in kernel, and forbids insertion of
hash:mac with a family set.

Since IP_SET_PROTO_UNDEF is defined only for hash:mac, this patch has no
impact on other hash:* sets

Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Signed-off-by: Victorien Molle <victorien.molle@wifirst.fr>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/ipset/ip_set_hash_gen.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -1241,7 +1241,10 @@ IPSET_TOKEN(HTYPE, _create)(struct net *
 	pr_debug("Create set %s with family %s\n",
 		 set->name, set->family == NFPROTO_IPV4 ? "inet" : "inet6");
 
-#ifndef IP_SET_PROTO_UNDEF
+#ifdef IP_SET_PROTO_UNDEF
+	if (set->family != NFPROTO_UNSPEC)
+		return -IPSET_ERR_INVALID_FAMILY;
+#else
 	if (!(set->family == NFPROTO_IPV4 || set->family == NFPROTO_IPV6))
 		return -IPSET_ERR_INVALID_FAMILY;
 #endif


