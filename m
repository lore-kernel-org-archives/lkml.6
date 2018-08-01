Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A5A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A5A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407870AbeHAT0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:26:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52930 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436518AbeHATSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 625A8EFE;
        Wed,  1 Aug 2018 16:55:13 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florent Fourcot <florent.fourcot@wifirst.fr>,
        Victorien Molle <victorien.molle@wifirst.fr>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 040/336] netfilter: ipset: forbid family for hash:mac sets
Date:   Wed,  1 Aug 2018 18:46:15 +0200
Message-Id: <20180801165030.615496815@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1234,7 +1234,10 @@ IPSET_TOKEN(HTYPE, _create)(struct net *
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


