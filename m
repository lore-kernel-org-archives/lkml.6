Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71CAB2251D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG1OOnNo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71CAB2251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbeKOI3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:35868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387950AbeKOI27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:28:59 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC45D22513;
        Wed, 14 Nov 2018 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234235;
        bh=DSlerBsIa2hOZCsBa38Ey/15idcm1DMM4+k5OQbdh54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dG1OOnNoVsiHGTo9WDnWDz+0B/+mUGQRxlp4bG/3IhXSiUaDTjX5BOhrGtdILUbbC
         5L/VHyudK6aG3tJ+ebZMBKT1FXY/E/PFOR7uaDJBivZ9KXYPCqb/UdvkZL8sjZ3kuv
         yg2XD12UNV6ERmdhveaHiS09tmQkfQhqwW5X7A0Q=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Westbrook <eric@westbrook.io>,
        Eric Westbrook <linux@westbrook.io>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 06/59] netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net
Date:   Wed, 14 Nov 2018 17:22:38 -0500
Message-Id: <20181114222335.99339-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Westbrook <eric@westbrook.io>

[ Upstream commit 886503f34d63e681662057448819edb5b1057a97 ]

Allow /0 as advertised for hash:net,port,net sets.

For "hash:net,port,net", ipset(8) says that "either subnet
is permitted to be a /0 should you wish to match port
between all destinations."

Make that statement true.

Before:

    # ipset create cidrzero hash:net,port,net
    # ipset add cidrzero 0.0.0.0/0,12345,0.0.0.0/0
    ipset v6.34: The value of the CIDR parameter of the IP address is invalid

    # ipset create cidrzero6 hash:net,port,net family inet6
    # ipset add cidrzero6 ::/0,12345,::/0
    ipset v6.34: The value of the CIDR parameter of the IP address is invalid

After:

    # ipset create cidrzero hash:net,port,net
    # ipset add cidrzero 0.0.0.0/0,12345,0.0.0.0/0
    # ipset test cidrzero 192.168.205.129,12345,172.16.205.129
    192.168.205.129,tcp:12345,172.16.205.129 is in set cidrzero.

    # ipset create cidrzero6 hash:net,port,net family inet6
    # ipset add cidrzero6 ::/0,12345,::/0
    # ipset test cidrzero6 fe80::1,12345,ff00::1
    fe80::1,tcp:12345,ff00::1 is in set cidrzero6.

See also:

  https://bugzilla.kernel.org/show_bug.cgi?id=200897
  https://github.com/ewestbrook/linux/commit/df7ff6efb0934ab6acc11f003ff1a7580d6c1d9c

Signed-off-by: Eric Westbrook <linux@westbrook.io>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_hash_netportnet.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_hash_netportnet.c b/net/netfilter/ipset/ip_set_hash_netportnet.c
index d391485a6acd..613e18e720a4 100644
--- a/net/netfilter/ipset/ip_set_hash_netportnet.c
+++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
@@ -213,13 +213,13 @@ hash_netportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
 
 	if (tb[IPSET_ATTR_CIDR]) {
 		e.cidr[0] = nla_get_u8(tb[IPSET_ATTR_CIDR]);
-		if (!e.cidr[0] || e.cidr[0] > HOST_MASK)
+		if (e.cidr[0] > HOST_MASK)
 			return -IPSET_ERR_INVALID_CIDR;
 	}
 
 	if (tb[IPSET_ATTR_CIDR2]) {
 		e.cidr[1] = nla_get_u8(tb[IPSET_ATTR_CIDR2]);
-		if (!e.cidr[1] || e.cidr[1] > HOST_MASK)
+		if (e.cidr[1] > HOST_MASK)
 			return -IPSET_ERR_INVALID_CIDR;
 	}
 
@@ -493,13 +493,13 @@ hash_netportnet6_uadt(struct ip_set *set, struct nlattr *tb[],
 
 	if (tb[IPSET_ATTR_CIDR]) {
 		e.cidr[0] = nla_get_u8(tb[IPSET_ATTR_CIDR]);
-		if (!e.cidr[0] || e.cidr[0] > HOST_MASK)
+		if (e.cidr[0] > HOST_MASK)
 			return -IPSET_ERR_INVALID_CIDR;
 	}
 
 	if (tb[IPSET_ATTR_CIDR2]) {
 		e.cidr[1] = nla_get_u8(tb[IPSET_ATTR_CIDR2]);
-		if (!e.cidr[1] || e.cidr[1] > HOST_MASK)
+		if (e.cidr[1] > HOST_MASK)
 			return -IPSET_ERR_INVALID_CIDR;
 	}
 
-- 
2.17.1

