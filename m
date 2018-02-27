Date: Tue, 27 Feb 2018 14:11:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Kubecek <mkubecek@suse.cz>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Manoj Boopathi Raj <manojboopathi@google.com>
Subject: Re: [PATCH 4.4 002/193] net: replace dst_cache ip6_tunnel
 implementation with the generic one
Message-ID: <20180227131135.GH32493@kroah.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170326.406395326@linuxfoundation.org>
 <20180227080500.p6truendtzuis7jb@unicorn.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180227080500.p6truendtzuis7jb@unicorn.suse.cz>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 09:05:01AM +0100, Michal Kubecek wrote:
> On Fri, Feb 23, 2018 at 07:23:55PM +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Paolo Abeni <pabeni@redhat.com>
> > 
> > commit 607f725f6f7d5ec3759fbc16224afb60e2152a5b upstream.
> > 
> > This also fix a potential race into the existing tunnel code, which
> > could lead to the wrong dst to be permanenty cached:
> > 
> > CPU1:					CPU2:
> >   <xmit on ip6_tunnel>
> >   <cache lookup fails>
> >   dst = ip6_route_output(...)
> > 					<tunnel params are changed via nl>
> > 					dst_cache_reset() // no effect,
> > 							// the cache is empty
> >   dst_cache_set() // the wrong dst
> > 	// is permanenty stored
> > 	// into the cache
> > 
> > With the new dst implementation the above race is not possible
> > since the first cache lookup after dst_cache_reset will fail due
> > to the timestamp check
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Suggested-and-acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Manoj Boopathi Raj <manojboopathi@google.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > ---
> ...
> > --- a/net/ipv6/ip6_gre.c
> > +++ b/net/ipv6/ip6_gre.c
> ...
> > @@ -1053,7 +962,6 @@ static int ip6_tnl_xmit2(struct sk_buff
> >  	struct ipv6_tel_txoption opt;
> >  	struct dst_entry *dst = NULL, *ndst = NULL;
> >  	struct net_device *tdev;
> > -	bool use_cache = false;
> >  	int mtu;
> >  	unsigned int max_headroom = sizeof(struct ipv6hdr);
> >  	u8 proto;
> > @@ -1061,39 +969,28 @@ static int ip6_tnl_xmit2(struct sk_buff
> >  
> >  	/* NBMA tunnel */
> >  	if (ipv6_addr_any(&t->parms.raddr)) {
> > -		if (skb->protocol == htons(ETH_P_IPV6)) {
> > -			struct in6_addr *addr6;
> > -			struct neighbour *neigh;
> > -			int addr_type;
> > -
> > -			if (!skb_dst(skb))
> > -				goto tx_err_link_failure;
> > -
> > -			neigh = dst_neigh_lookup(skb_dst(skb),
> > -						 &ipv6_hdr(skb)->daddr);
> > -			if (!neigh)
> > -				goto tx_err_link_failure;
> > +		struct in6_addr *addr6;
> > +		struct neighbour *neigh;
> > +		int addr_type;
> > +
> > +		if (!skb_dst(skb))
> > +			goto tx_err_link_failure;
> >  
> > -			addr6 = (struct in6_addr *)&neigh->primary_key;
> > -			addr_type = ipv6_addr_type(addr6);
> > +		neigh = dst_neigh_lookup(skb_dst(skb),
> > +					 &ipv6_hdr(skb)->daddr);
> > +		if (!neigh)
> > +			goto tx_err_link_failure;
> >  
> > -			if (addr_type == IPV6_ADDR_ANY)
> > -				addr6 = &ipv6_hdr(skb)->daddr;
> > +		addr6 = (struct in6_addr *)&neigh->primary_key;
> > +		addr_type = ipv6_addr_type(addr6);
> >  
> > -			memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> > -			neigh_release(neigh);
> > -		}
> > -	} else if (t->parms.proto != 0 && !(t->parms.flags &
> > -					    (IP6_TNL_F_USE_ORIG_TCLASS |
> > -					     IP6_TNL_F_USE_ORIG_FWMARK))) {
> > -		/* enable the cache only if neither the outer protocol nor the
> > -		 * routing decision depends on the current inner header value
> > -		 */
> > -		use_cache = true;
> > -	}
> > +		if (addr_type == IPV6_ADDR_ANY)
> > +			addr6 = &ipv6_hdr(skb)->daddr;
> >  
> > -	if (use_cache)
> > -		dst = ip6_tnl_dst_get(t);
> > +		memcpy(&fl6->daddr, addr6, sizeof(fl6->daddr));
> > +		neigh_release(neigh);
> > +	} else if (!fl6->flowi6_mark)
> > +		dst = dst_cache_get(&t->dst_cache);
> >  
> >  	if (!ip6_tnl_xmit_ctl(t, &fl6->saddr, &fl6->daddr))
> >  		goto tx_err_link_failure;
> > @@ -1156,8 +1053,8 @@ static int ip6_tnl_xmit2(struct sk_buff
> >  		skb = new_skb;
> >  	}
> >  
> > -	if (use_cache && ndst)
> > -		ip6_tnl_dst_set(t, ndst);
> > +	if (!fl6->flowi6_mark && ndst)
> > +		dst_cache_set_ip6(&t->dst_cache, ndst, &fl6->saddr);
> >  	skb_dst_set(skb, dst);
> >  
> >  	skb->transport_header = skb->network_header;
> 
> This part looks essentially like a revert of earlier commit befb92542439
> ("ipv6: check skb->protocol before lookup for nexthop", mainline
> 199ab00f3cdb). Is it possible that it comes from an incorrect resolution
> of the conflict caused by these two being backported in opposite order
> (befb92542439 < b8c7f80cbdcd) than the original mainline commits
> (607f725f6f7d < 199ab00f3cdb)?

Hm, I don't really know, it seems to be correct to me...

Manoj, any ideas?  You did this backport.

thanks,

greg k-h
