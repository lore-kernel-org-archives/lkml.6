Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB54C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00AFB208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00AFB208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934410AbeGFFvo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:51:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33444 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934326AbeGFFvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:40 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5163B86A;
        Fri,  6 Jul 2018 05:51:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vincent Bernat <vincent@bernat.im>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 41/61] netfilter: ip6t_rpfilter: provide input interface for route lookup
Date:   Fri,  6 Jul 2018 07:47:05 +0200
Message-Id: <20180706054713.908655929@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
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

From: Vincent Bernat <vincent@bernat.im>

commit cede24d1b21d68d84ac5a36c44f7d37daadcc258 upstream.

In commit 47b7e7f82802, this bit was removed at the same time the
RT6_LOOKUP_F_IFACE flag was removed. However, it is needed when
link-local addresses are used, which is a very common case: when
packets are routed, neighbor solicitations are done using link-local
addresses. For example, the following neighbor solicitation is not
matched by "-m rpfilter":

    IP6 fe80::5254:33ff:fe00:1 > ff02::1:ff00:3: ICMP6, neighbor
    solicitation, who has 2001:db8::5254:33ff:fe00:3, length 32

Commit 47b7e7f82802 doesn't quite explain why we shouldn't use
RT6_LOOKUP_F_IFACE in the rpfilter case. I suppose the interface check
later in the function would make it redundant. However, the remaining
of the routing code is using RT6_LOOKUP_F_IFACE when there is no
source address (which matches rpfilter's case with a non-unicast
destination, like with neighbor solicitation).

Signed-off-by: Vincent Bernat <vincent@bernat.im>
Fixes: 47b7e7f82802 ("netfilter: don't set F_IFACE on ipv6 fib lookups")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter/ip6t_rpfilter.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -48,6 +48,8 @@ static bool rpfilter_lookup_reverse6(str
 	}
 
 	fl6.flowi6_mark = flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
+	if ((flags & XT_RPFILTER_LOOSE) == 0)
+		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *) ip6_route_lookup(net, &fl6, lookup_flags);
 	if (rt->dst.error)


