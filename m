Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932425AbeCKWVR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 18:21:17 -0400
Received: from mail.us.es ([193.147.175.20]:46684 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932166AbeCKWVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 18:21:15 -0400
Date: Sun, 11 Mar 2018 23:21:10 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [RFC] netfilter: cttimeout: remove VLA in
 ctnl_timeout_parse_policy
Message-ID: <20180311222110.yk34o63ha5y34ssx@salvia>
References: <20180306184755.GA7628@embeddedgus>
 <20180311220414.feda33aw72zw2rko@salvia>
 <20df6b07-b3e7-7733-ee05-b12589bd287f@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20df6b07-b3e7-7733-ee05-b12589bd287f@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 11, 2018 at 05:12:09PM -0500, Gustavo A. R. Silva wrote:
> Hi Pablo,
> 
> On 03/11/2018 05:04 PM, Pablo Neira Ayuso wrote:
> > On Tue, Mar 06, 2018 at 12:47:55PM -0600, Gustavo A. R. Silva wrote:
> > > In preparation to enabling -Wvla, remove VLA and replace it
> > > with dynamic memory allocation.
> > 
> > Looks good but...
> > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > > ---
> > >   net/netfilter/nfnetlink_cttimeout.c | 12 ++++++++++--
> > >   1 file changed, 10 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
> > > index 95b0470..a2f7d92 100644
> > > --- a/net/netfilter/nfnetlink_cttimeout.c
> > > +++ b/net/netfilter/nfnetlink_cttimeout.c
> > > @@ -52,18 +52,26 @@ ctnl_timeout_parse_policy(void *timeouts,
> > >   			  struct net *net, const struct nlattr *attr)
> > >   {
> > >   	int ret = 0;
> > > +	struct nlattr **tb = NULL;
> > 
> > I think we don't need to initialize this, right?
> > 
> 
> We actually do have to initialized it because in the unlikely case that the
> code block inside the 'if' below is not executed, then we will end up
> freeing an uninitialized pointer.

I see, you're right indeed.

We can probably simplify this code, but just doing:

        if (!l4proto->ctnl_timeout.nlattr_to_obj))
                return 0;

        netlink attribute parsing here.

You could even remove the likely() thing, which doesn't make much
sense for control plane code.

I understand this is a larger change, but I think this function will
look better while we're removing VLA.

Would you mind having a look? I'd appreciate if so.

Thanks.
