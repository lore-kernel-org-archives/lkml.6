Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2772FC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01628217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBHLyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:54:54 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:50978 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726081AbfBHLyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:54:53 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1gs4k3-0001Wf-Uv; Fri, 08 Feb 2019 12:54:48 +0100
Date:   Fri, 8 Feb 2019 12:54:47 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Sander Eikelenboom <linux@eikelenboom.it>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 5.0-rc5 regression with NAT, bisected to: netfilter: nat:
 remove l4proto->manip_pkt
Message-ID: <20190208115447.ojyfhenf44kqs3w4@breakpoint.cc>
References: <40b70892-daf5-28d7-28b5-869911faf2bb@eikelenboom.it>
 <20190208070710.rcbj6exqwz6m2o7o@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208070710.rcbj6exqwz6m2o7o@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Sander Eikelenboom <linux@eikelenboom.it> wrote:
> > L.S.,
> > 
> > While trying out a 5.0-RC5 kernel I seem to have stumbled over a regression with NAT.
> > (using an nftables firewall with NAT and connection tracking).
> > 
> > Unfortunately it isn't too obvious since no errors are logged, but on clients it
> > causes symptoms like firefox intermittently not being able to load pages with:
> >     Network Protocol Error
> >     An error occurred during a connection to www.example.com
> >     The page you are trying to view cannot be shown because an error in the network protocol was detected.
> >     Please contact the website owners to inform them of this problem.
> > 
> > But it's only intermittently, so i can still visit some webpages with clients, 
> > could be that packet size and or fragments are at play ?
> > 
> > So I tried testing with git://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git with 
> > e8c32c32b48c2e889704d8ca0872f92eb027838e as last commit, to be sure to have the latest netdev has to offer,
> > but to no avail. 
> > 
> > After that I tried to git bisect and ended up with:
> > 
> > faec18dbb0405c7d4dda025054511dc3a6696918 is the first bad commit
> > commit faec18dbb0405c7d4dda025054511dc3a6696918
> > Author: Florian Westphal <fw@strlen.de>
> > Date:   Thu Dec 13 16:01:33 2018 +0100
> > 
> >     netfilter: nat: remove l4proto->manip_pkt
> 
> Thanks, this is immensely helpful.
> 
> I think I see the bug, we can't use target->dst.protonum in
> nf_nat_l4proto_manip_pkt(), it will be TCP in case we're dealing
> with a related icmp packet.
> 
> I will send a patch in a few hours when I get back.

Sander, does this patch fix things for you?

Thanks!

diff --git a/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c b/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
--- a/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_nat_l3proto_ipv4.c
@@ -215,6 +215,7 @@ int nf_nat_icmp_reply_translation(struct sk_buff *skb,
 
 	/* Change outer to look like the reply to an incoming packet */
 	nf_ct_invert_tuplepr(&target, &ct->tuplehash[!dir].tuple);
+	target.dst.protonum = IPPROTO_ICMP;
 	if (!nf_nat_ipv4_manip_pkt(skb, 0, &target, manip))
 		return 0;
 
diff --git a/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c b/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
--- a/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
+++ b/net/ipv6/netfilter/nf_nat_l3proto_ipv6.c
@@ -226,6 +226,7 @@ int nf_nat_icmpv6_reply_translation(struct sk_buff *skb,
 	}
 
 	nf_ct_invert_tuplepr(&target, &ct->tuplehash[!dir].tuple);
+	target.dst.protonum = IPPROTO_ICMPV6;
 	if (!nf_nat_ipv6_manip_pkt(skb, 0, &target, manip))
 		return 0;
 
