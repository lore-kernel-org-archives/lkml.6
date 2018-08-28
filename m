Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E5BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B72252084A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=westbrook.io header.i=@westbrook.io header.b="KPi5BDeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72252084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=westbrook.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH2BRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:17:47 -0400
Received: from westbrook.io ([205.159.239.66]:52199 "EHLO mail.westbrook.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH2BRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:17:47 -0400
X-Greylist: delayed 576 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Aug 2018 21:17:47 EDT
Received: from [192.168.29.2] (westbrook.io [192.168.29.2])
        by mail.westbrook.io (Postfix) with ESMTPSA id 93CF0194C6D;
        Tue, 28 Aug 2018 21:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=westbrook.io; s=io;
        t=1535490882; bh=FdKcgGlFjVD9QsqkLDdXYDvKSOGF55QVL/+rdjFcYWQ=;
        h=From:Subject:To:Date;
        b=KPi5BDeAslSvg7N929JudOwM+54Q8VCMwSMfsGHm2mbqCv9DBDHSn81ifMSSeb/7f
         N3Yt9jrCq6L6wuopCJhXJxiHV3xTPkNaUWSYDd/YOXONnwZvLPZ3bgW41vJ+zNt8u2
         gMUcYrZTiwtg0GwnfExBZ/XZWUwBwXvOnygicyt0=
From:   Eric Westbrook <eric@westbrook.io>
Subject: [PATCH] netfilter: ipset: actually allow allowable CIDR 0 in
 hash:net,port,net
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Team <coreteam@netfilter.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trivial Patch Monkey <trivial@kernel.org>
Message-ID: <a3d786d6-3608-8575-9901-afcf3a52693a@westbrook.io>
Date:   Tue, 28 Aug 2018 15:14:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.18.0

