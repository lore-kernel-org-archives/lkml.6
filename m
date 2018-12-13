Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0CCC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDB620880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FDB620880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbeLML1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:27:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:46630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbeLML1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 06:27:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53C4FADE6;
        Thu, 13 Dec 2018 11:27:50 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id ACFD8E1116; Thu, 13 Dec 2018 12:27:48 +0100 (CET)
Date:   Thu, 13 Dec 2018 12:27:48 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Oskolkov <posk@google.com>,
        Gustavo Figueira <gfigueira@suse.com>
Subject: Re: [PATCH net] net: ipv4: do not handle duplicate fragments as
 overlapping
Message-ID: <20181213112748.GF21324@unicorn.suse.cz>
References: <20181213022800.9D298E1116@unicorn.suse.cz>
 <cb96bca9-1dda-b243-b581-91f1b51f1517@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb96bca9-1dda-b243-b581-91f1b51f1517@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:20:42PM -0800, Eric Dumazet wrote:
> On 12/12/2018 06:28 PM, Michal Kubecek wrote:
> > Since commit 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping
> > segments.") IPv4 reassembly code drops the whole queue whenever an
> > overlapping fragment is received. However, the test is written in a way
> > which detects duplicate fragments as overlapping so that in environments
> > with many duplicate packets, fragmented packets may be undeliverable.
> > 
> > Add an extra test and for (potentially) duplicate fragment, only drop the
> > new fragment rather than the whole queue. Only starting offset and length
> > are checked, not the contents of the fragments as that would be too
> > expensive.  Check for duplicity with last (tail) fragment first as in real
> > life scenarios this should be the most frequent case and we would have to
> > iterate through the whole "run" otherwise.
> > 
> > Fixes: 7969e5c40dfd ("ip: discard IPv4 datagrams with overlapping segments.")
> > Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
> > ---
> >  net/ipv4/ip_fragment.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> > index aa0b22697998..f09e3683b209 100644
> > --- a/net/ipv4/ip_fragment.c
> > +++ b/net/ipv4/ip_fragment.c
> > @@ -436,6 +436,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
> >  			ip4_frag_append_to_last_run(&qp->q, skb);
> >  		else
> >  			ip4_frag_create_run(&qp->q, skb);
> > +	} else if (offset == prev_tail->ip_defrag_offset &&
> > +		   skb->len == prev_tail->len) {
> > +		/* potential duplicate of last fragment */
> > +		goto err;
> 
> What value is in @err variable at this point ?
> 
> Are you sure callers expect to receive -EINVAL ?

That's what they get if one of the earliery sanity checks fails so I
thought it would be the safest bet as that's something they certainly
can get already.

I tracked down the callers and almost all of them eventually ignore the
return value and only care if it's zero or not. The only exception was
one path in openvswitch where the value would be propagated to doit()
genetlink handler.

> >  	} else {
> >  		/* Binary search. Note that skb can become the first fragment,
> >  		 * but not the last (covered above).
> > @@ -449,8 +453,16 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
> >  			else if (offset >= skb1->ip_defrag_offset +
> >  						FRAG_CB(skb1)->frag_run_len)
> >  				rbn = &parent->rb_right;
> > -			else /* Found an overlap with skb1. */
> > +			else {
> > +				/* check for potential duplicate */
> > +				while (skb1 && skb1->ip_defrag_offset < offset)
> > +					skb1 = FRAG_CB(skb1)->next_frag;
> > +				if (skb1 && offset == skb1->ip_defrag_offset &&
> > +				    skb->len == skb1->len)
> > +					goto err;
> 
> Maybe we should not care, if the node in the rbtree contains the range of this
> incoming fragment, do not worry about finding if it is overlap or not ?
> 
> I am nervous about adding back a linear scan.

After rethinking it again, I agree. Unlike in the IPv6 case, we don't
have an RFC strictly requiring us to drop the whole queue and the
requirement from RFC 7522 (for IPv6) seems to be motivated by the risk
of later fragments rewriting header fields. That cannot happen if we
drop the later fragment (which doesn't bring any new data anyway).

And for FragmentSmack type attack, thorough check would in fact help the
attacker, as you pointed out.

I'll send a v2.

> > +				/* Found an overlap */
> >  				goto overlap;
> > +			}
> >  		} while (*rbn);
> >  		/* Here we have parent properly set, and rbn pointing to
> >  		 * one of its NULL left/right children. Insert skb.
