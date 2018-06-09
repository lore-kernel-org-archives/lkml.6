Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id e37qGTH3G1v6AwAAmS7hNA
	; Sat, 09 Jun 2018 15:51:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C24B608C1; Sat,  9 Jun 2018 15:51:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ylPFPQUG"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BB572606FA;
	Sat,  9 Jun 2018 15:51:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB572606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932576AbeFIPvC (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932304AbeFIPb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:56 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D018C208A3;
        Sat,  9 Jun 2018 15:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558315;
        bh=jUAbeh7KTZk981dfR6NeZlat0Ju8GtK6i9+atF5Pmo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylPFPQUGsKEWKhrSuCB1cbYh2St5x9RpWO2zJ3LX/yv9vOOk5OpCAUCfBb2shGD7S
         THobdE4OLOpldDFk6j1Tn+KUObdAY4t8UKk4Xodhcj2YtUjfqersuBMfvQwlFGNuXW
         f3yf9Y8EtnVkQAYoiYcLgStrhRzRN5+c1f+uKioA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 14/48] ipv6: omit traffic class when calculating flow hash
Date: Sat,  9 Jun 2018 17:29:26 +0200
Message-Id: <20180609145948.561683312@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609145947.679103414@linuxfoundation.org>
References: <20180609145947.679103414@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv6/route.c          |    2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -918,6 +918,11 @@ static inline __be32 ip6_make_flowinfo(u
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
@@ -1850,7 +1850,7 @@ out:
 	keys->control.addr_type = FLOW_DISSECTOR_KEY_IPV6_ADDRS;
 	keys->addrs.v6addrs.src = key_iph->saddr;
 	keys->addrs.v6addrs.dst = key_iph->daddr;
-	keys->tags.flow_label = ip6_flowinfo(key_iph);
+	keys->tags.flow_label = ip6_flowlabel(key_iph);
 	keys->basic.ip_proto = key_iph->nexthdr;
 }
 
