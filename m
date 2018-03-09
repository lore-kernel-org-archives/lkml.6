Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeCIQ0W (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:26:22 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:54790 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751170AbeCIQ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:26:21 -0500
Date: Fri, 9 Mar 2018 17:26:08 +0100
From: Florian Westphal <fw@strlen.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        David Miller <davem@davemloft.net>, rga@amazon.de,
        bridge@lists.linux-foundation.org, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        aliguori@amazon.com, nbd@openwrt.org
Subject: Re: [RFC PATCH v2] bridge: make it possible for packets to traverse
 the bridge without hitting netfilter
Message-ID: <20180309162608.GC19924@breakpoint.cc>
References: <1424705163-13428-1-git-send-email-imrep.amz@gmail.com>
 <20150223160619.GF24297@breakpoint.cc>
 <54EEF32D.2010202@amazon.de>
 <20150226.113431.238255529591339000.davem@davemloft.net>
 <54F982B5.90108@gmail.com>
 <20150306142932.GA15926@salvia>
 <20150306163700.GC20382@breakpoint.cc>
 <1520609475.17937.42.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520609475.17937.42.camel@infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
> 
> 
> On Fri, 2015-03-06 at 17:37 +0100, Florian Westphal wrote:
> > 
> > > > I did performance measurements in the following way:
> > > > 
> > > > Removed those pieces of the packet pipeline that I don't necessarily
> > > > need one-by-one.  Then measured their effect on small packet
> > > > performance.
> > > > 
> > > > This was the only part that produced considerable effect.
> > > > 
> > > > The pure speculation was about why the effect is more than 15%
> > > > increase in packet throughput, although the code path avoided
> > > > contains way less code than 15% of the packet pipeline.  It seems,
> > > > Felix Fietkau profiled similar changes, and found my guess well
> > > > founded.
> > > > 
> > > > Now could anybody explain me what else is wrong with my patch?
> > > 
> > > We have to come up with a more generic solution for this.
> > 
> > Jiri Benc suggested to allowing to attach netfilter hooks e.g. via tc
> > action, maybe that would be an option worth investigating.
> > 
> > Then you could for instance add filtering rules only to the bridge port
> > that needs it.
> > 
> > > These sysfs tweaks you're proposing look to me like an obscure way to
> > > tune this.
> > 
> > I agree, adding more tunables isn't all that helpful, in the past this
> > only helped to prolong the problem.
> 
> How feasible would it be to make it completely dynamic?
> 
> A given hook could automatically disable itself (for a given device) if
> the result of running it the first time was *tautologically* false for
> that device (i.e. regardless of the packet itself, or anything else).
> 
> The hook would need to be automatically re-enabled if the rule chain
> ever changes (and might subsequently disable itself again).
> 
> Is that something that's worth exploring for the general case?

AF_BRIDGE hooks sit in the net namespace, so its enough for
one bridge to request filtering to bring in the hook overhead for all
bridges in the same netns.

Alternatives:
- place the bridges that need filtering in different netns
- use tc ingress for filtering
- use nftables ingress hook for filtering (it sits in almost same
  location as tc ingress hook) to attach the ruleset to those bridge
  ports that need packet filtering.

(The original request came from user with tons of bridges where only
 one single bridge needed filtering).

One alternative I see is to place the bridge hooks into the
bridge device (net_bridge struct, which is in netdev private area).

But, as you already mentioned we would need to annotate the hooks
to figure out which device(s) they are for.

This sounds rather fragile to me, so i would just use nft ingress:

#!/sbin/nft -f

table netdev ingress {
  chain in_public { type filter hook ingress device eth0 priority 0;
   ip saddr 192.168.0.1 counter
 }
}
