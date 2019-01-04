Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F7C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9711D20675
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfADKdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:33:09 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:35464 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfADKdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:33:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 7967B201BB;
        Fri,  4 Jan 2019 11:33:07 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P4A5vkdBQM0m; Fri,  4 Jan 2019 11:33:07 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 08269201B3;
        Fri,  4 Jan 2019 11:33:07 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 11:33:06 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 6A1C03180594;
 Fri,  4 Jan 2019 11:33:06 +0100 (CET)
Date:   Fri, 4 Jan 2019 11:33:06 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <suyanjun218@gmail.com>
Subject: Re: [PATCH] vti4: Fix a ipip packet processing bug in 'IPCOMP'
 virtual tunnel
Message-ID: <20190104103306.GH3581@gauss3.secunet.de>
References: <1546519721-30837-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190104074333.GE3581@gauss3.secunet.de>
 <a289564b-c33a-d2fb-dab2-31e15695844f@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a289564b-c33a-d2fb-dab2-31e15695844f@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 99C4CCE0-3E3B-4737-8154-B7440C709B11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 04:42:05PM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
> On 1/4/2019 3:43 PM, Steffen Klassert wrote:
> 
> > On Thu, Jan 03, 2019 at 07:48:41AM -0500, Su Yanjun wrote:
> > > Recently we run a network test over ipcomp virtual tunnel.We find that
> > > if a ipv4 packet needs fragment, then the peer can't receive
> > > it.
> > > 
> > > We deep into the code and find that when packet need fragment the smaller
> > > fragment will be encapsulated by ipip not ipcomp. So when the ipip packet
> > > goes into xfrm, it's skb->dev is not properly set. The ipv4 reassembly code
> > > always set skb'dev to the last fragment's dev. After ipv4 defrag processing,
> > > when the kernel rp_filter parameter is set, the skb will be drop by -EXDEV
> > > error.
> > Why not just leaving rp_filter disabled or in 'loose mode' if you use ipcomp?
> In my option rp_filter should not affect the ip_vti functionality.
> The root cause is the origin tunnel code doesn't update skb->dev.
> vti only cares about ipcomp, esp, ah packets.
> > > This patch adds compatible support for the ipip process in ipcomp virtual tunnel.
> > > 
> > > Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> > > ---
> > >   net/ipv4/ip_vti.c | 25 ++++++++++++++++++++++++-
> > >   1 file changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> > > index de31b30..63de2f6 100644
> > > --- a/net/ipv4/ip_vti.c
> > > +++ b/net/ipv4/ip_vti.c
> > > @@ -65,6 +65,9 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
> > >   		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
> > > +		if (iph->protocol == IPPROTO_IPIP)
> > > +			skb->dev = tunnel->dev;
> > > +
> > >   		return xfrm_input(skb, nexthdr, spi, encap_type);
> > >   	}
> > > @@ -76,10 +79,15 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
> > >   static int vti_rcv(struct sk_buff *skb)
> > >   {
> > > +	__be32 spi = 0;
> > > +	
> > >   	XFRM_SPI_SKB_CB(skb)->family = AF_INET;
> > >   	XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
> > > +	
> > > +	if (ip_hdr(skb)->protocol == IPPROTO_IPIP)
> > > +		spi = ip_hdr(skb)->saddr;
> > > -	return vti_input(skb, ip_hdr(skb)->protocol, 0, 0);
> > > +	return vti_input(skb, ip_hdr(skb)->protocol, spi, 0);
> > You use the src address as spi, how is this supposed to work?
> > 
> This code derives from xfrm4_tunnel and i just want the vti can handle ipip
> packet as xfrm4 tunnel does.

Ok, I see what it is. ipcomp needs an extra SA to handle the 'not
compressed' packets. This SA uses the src address as the spi.

So this is ok, but please add separate handlers for this case.
