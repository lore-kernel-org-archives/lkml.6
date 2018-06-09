Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ilnhNzXwG1sSQQAAmS7hNA
	; Sat, 09 Jun 2018 15:31:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 88F2E608CD; Sat,  9 Jun 2018 15:31:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/gDOw0i"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0F81602FC;
	Sat,  9 Jun 2018 15:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0F81602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753505AbeFIPbJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeFIPbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:06 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C649204EC;
        Sat,  9 Jun 2018 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558265;
        bh=cgWhPug0amFhOEQhuKVyxyeHtISMR0du9qfqllb04rI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C/gDOw0isqeG+b/8yIT4xPNKL6/RXnNrnAox4CORJ+jBrWmjbhTZRGPCeoc/2axVi
         7SamxtH53qI/AO7OHFWv/YFUcOYlFbAY79gkne3gVqLvs7N7lr8LdWHDVmGPjHbY8+
         XHAcY4vCPne9Lwqey4pubvDeyY4rKe3+NBDo6POI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 04/15] ipv6: omit traffic class when calculating flow hash
Date: Sat,  9 Jun 2018 17:29:39 +0200
Message-Id: <20180609150000.966362763@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
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

From: Michal Kubecek <mkubecek@suse.cz>

[ Upstream commit fa1be7e01ea863e911349e30456706749518eeab ]

Some of the code paths calculating flow hash for IPv6 use flowlabel member
of struct flowi6 which, despite its name, encodes both flow label and
traffic class. If traffic class changes within a TCP connection (as e.g.
ssh does), ECMP route can switch between path. It's also inconsistent with
other code paths where ip6_flowlabel() (returning only flow label) is used
to feed the key.

Use only flow label everywhere, including one place where hash key is set
using ip6_flowinfo().

Fixes: 51ebd3181572 ("ipv6: add support of equal cost multipath (ECMP)")
Fixes: f70ea018da06 ("net: Add functions to get skb->hash based on flow structures")
Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ipv6.h        |    5 +++++
 net/core/flow_dissector.c |    2 +-
 net/ipv6/route.c          |    4 ++--
 3 files changed, 8 insertions(+), 3 deletions(-)

--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -906,6 +906,11 @@ static inline __be32 ip6_make_flowinfo(u
 	return htonl(tclass << IPV6_TCLASS_SHIFT) | flowlabel;
 }
 
+static inline __be32 flowi6_get_flowlabel(const struct flowi6 *fl6)
+{
+	return fl6->flowlabel & IPV6_FLOWLABEL_MASK;
+}
+
 /*
  *	Prototypes exported by ipv6
  */
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1334,7 +1334,7 @@ __u32 __get_hash_from_flowi6(const struc
 	keys->ports.src = fl6->fl6_sport;
 	keys->ports.dst = fl6->fl6_dport;
 	keys->keyid.keyid = fl6->fl6_gre_key;
-	keys->tags.flow_label = (__force u32)fl6->flowlabel;
+	keys->tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
 	keys->basic.ip_proto = fl6->flowi6_proto;
 
 	return flow_hash_from_keys(keys);
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1868,7 +1868,7 @@ out:
 	} else {
 		keys->addrs.v6addrs.src = key_iph->saddr;
 		keys->addrs.v6addrs.dst = key_iph->daddr;
-		keys->tags.flow_label = ip6_flowinfo(key_iph);
+		keys->tags.flow_label = ip6_flowlabel(key_iph);
 		keys->basic.ip_proto = key_iph->nexthdr;
 	}
 }
@@ -1889,7 +1889,7 @@ u32 rt6_multipath_hash(const struct net
 		} else {
 			hash_keys.addrs.v6addrs.src = fl6->saddr;
 			hash_keys.addrs.v6addrs.dst = fl6->daddr;
-			hash_keys.tags.flow_label = (__force u32)fl6->flowlabel;
+			hash_keys.tags.flow_label = (__force u32)flowi6_get_flowlabel(fl6);
 			hash_keys.basic.ip_proto = fl6->flowi6_proto;
 		}
 		break;
