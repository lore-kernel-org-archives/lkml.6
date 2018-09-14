Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7E9ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA4C720853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 11:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C720853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stwm.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeINRDW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 13:03:22 -0400
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:60140 "EHLO
        email.studentenwerk.mhn.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727403AbeINRDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 13:03:22 -0400
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
        by email.studentenwerk.mhn.de (Postfix) with ESMTP id 42BYhT0FB2zMkwG;
        Fri, 14 Sep 2018 13:49:13 +0200 (CEST)
From:   Wolfgang Walter <linux@stwm.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        christophe.gouault@6wind.com
Subject: Re: Regression: kernel 4.14 an later very slow with many ipsec tunnels
Date:   Fri, 14 Sep 2018 13:49:12 +0200
Message-ID: <1803078.0j2GCQWPfR@stwm.de>
User-Agent: KMail/4.14.3 (Linux/4.14.61-debian64.all+1.1; KDE/4.14.13; x86_64; ; )
In-Reply-To: <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
References: <20180913135844.3ut6fxgx67t6ndtu@breakpoint.cc> <20180914050651.GD23674@gauss3.secunet.de> <20180914055437.77pffp2jrbfnykbp@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 14. September 2018, 07:54:37 schrieb Florian Westphal:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > On Thu, Sep 13, 2018 at 11:03:25PM +0200, Florian Westphal wrote:
> > > David Miller <davem@davemloft.net> wrote:
> > > > From: Florian Westphal <fw@strlen.de>
> > > > Date: Thu, 13 Sep 2018 18:38:48 +0200
> > > > 
> > > > > Wolfgang Walter <linux@stwm.de> wrote:
> > > > >> What I can say is that it depends mainly on number of policy rules
> > > > >> and SA.
> > > > > 
> > > > > Thats already a good hint, I guess we're hitting long hash chains in
> > > > > xfrm_policy_lookup_bytype().
> > > > 
> > > > I don't really see how recent changes can influence that.
> > > 
> > > I don't think there is a recent change that did this.
> > > 
> > > Walter says < 4.14 is ok, so this is likely related to flow cache
> > > removal.
> > > 
> > > F.e. it looks like all prefixed policies end up in a linked list
> > > (net->xfrm.policy_inexact) and are not even in a hash table.
> > > 
> > > I am staring at b58555f1767c9f4e330fcf168e4e753d2d9196e0
> > > but can't figure out how to configure that away from the
> > > 'no hashing for prefixed policies' default or why we even have
> > > policy_inexact in first place :/
> > 
> > The hash threshold can be configured like this:
> > 
> > ip x p set hthresh4 0 0
> > 
> > This sets the hash threshold to local /0 and remote /0 netmasks.
> > With this configuration, all policies should go to the hashtable.
> 
> Yes, but won't they all be hashed to same bucket?
> 
> [ jhash(addr & 0, addr & 0) ] ?
> 
> > Default hash thresholds are local /32 and remote /32 netmasks, so
> > all prefixed policies go to the inexact list.
> 
> Yes.
> 
> Wolfgang, before having to work on getting perf into your router image
> can you perhaps share a bit of info about the policies you're using?
> 
> How many are there?  Are they prefixed or not ("10.1.2.1")?

All rules are tunnel rules. That is they are rules like (in strongswan 
notation)

conn A-to-B
        left=111.111.111.111
        leftsubnet=10.148.32.0/24
        leftsigkey=....
        right=111.111.111.222
        rightsubnet=10.148.13.224/29
        rightsigkey=....
		esp=aes128ctr-sha1-ecp256-esn!
		ike=aes128ctr-sha1-ecp256!
		mobike=no
		type=tunnel
		....

(... other options not important here).


leftsubnet and rightsubnet may have any prefix from /30 to /16 here (we do not 
yet use ipv6 but will do so next year).

We have about 3000 of them.

strongswan install IN, FWD and OUT rules for that in the kernel security 
policy database with automated generated priorities (and SAs are generated 
when strongswan actually establish a tunnel).

Also some of the rules overlap in range, that means ordering is important. 

With IKEv2 this may happens automatically for SAs even if you avoid it in your 
rule set as IKEv2 allows narrowing.

In policies you most often get this if you want to excempt a certain network 
or host. We have a about 70 of them at the moment.

We do not use other possible selectors beside src-addr-range and dst-addr-
range (you could additionally select by protocol (icmp, udp, tcp), src- and 
dst-port-range). So theoretically you could have a ruleset where there is a 
rule with exempts all connection to dst port 22 for several network or applies 
different encryption options and so on.

A rule determins what has to be done with the packet (sending or receiving) 
from an ipsec-point of view: allow it without ipsec-transformation, block it 
completely, or require certain ipsec transformation (use this or that 
ecnryption scheme, use header compression,  use transport or tunnel mode, ...)

So for any packet the kernel sends it has to look up if there are SAs which 
matches and from these chose that with the highest priority (which is that one 
with the lowest priority field). If there is none he has to lookup if there is 
a matching policy, again choosing the one with the highest priority (and then 
let the IKE-daemon actually establish a SA). For tunnel-mode he actually has 
to do it twice, I think, as the tunnel-paket again passes ipsec.

For every packet it receives and which ist not an ipsec paket he has to do a 
lookup in the policy database to see if it should have been (or if it is 
allowed or blocked). If no rule is found it is allowed without encryption. We 
have 29.000 allow rules. I did deactivate them for the tests with 4.14 and 
4.18 as these makes things horrible. They are automatically generated from our 
declarativ network description and we actually don't need them as they do not 
overlap with the remote networks tunneled via ipsec. They did not impose any 
burden for 4.9 and earlier.

We sometimes need them (say if 10.10.0.0/16 is remote but 10.10.1.0 which is 
local).

So this is basically the multidimensional packet classifiction problem: from a 
set of m-dimensional blocks find that one with the highest priority which 
contains a certain point.

The dimension here are src-addr-range, dst-addr-range, protocol, src-port-
range, dst-port-range.

If your rule is itself a point you may hash it (and you can only do this if it 
is sure that there is no other non-point rule with higher prio matching this 
point rule as there is no such rule that a more specific rule beats a less 
specific rule (this would be ill defined)).

Here an example how strongswan allows you to use all of the above selectors 
for your rules. For example you could write for leftsubnet:

leftsubnet=10.0.0.1[tcp/http],10.0.0.2[6/80]
leftsubnet=fec1::1[udp],10.0.0.0/16[/53].
leftsubnet=fec1::1[udp/%any],10.0.0.0/16[%any/53]
leftsubnet=fec1::1[udp/%any],10.0.0.0/16[%any/1024-32000]

So ipsec with large policy-database without xfrm flow cache is comparable with 
a large netfilter ruleset (with only one chain) without conntrack.

Regards,
-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
