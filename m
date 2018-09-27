Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2282BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0D2172A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEgffWSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF0D2172A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeI1F25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:28:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43538 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1F24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:28:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id j26-v6so2903480pfi.10;
        Thu, 27 Sep 2018 16:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NFu6zxSuoolFFDIUMKLRrnHWCMxchV5f82Kp8PXbhW0=;
        b=MEgffWSPV6m1KtG+xhSt93DbgvJKy32Xl2xU3woQEU3Qpr6pqh3FDYFnm0XDEfXKU8
         LSqNdYR4IgCk18XBYW+8r2eZdffEUewd3j8cU0xoswcsfFFBDZ93coyoj4rgOvMJs/ae
         STz25hlVpOF50ww5bwHYIvQWK61Tb/bMgdOYyhst/4guYL12FjWyIXOExx88LFQRpzRT
         zfa+Sw5g04Z3VIkNK+qJVXWB/FujHTcXmS1up1nLFlTGvbYWlOrXrtNzuMk7ZEjnt5YP
         vDkkLZj0fTaQJkzhkAomj+oWA9yrAtDcNtN50uw9LKmFOIpsQnFBEWuRK9DA+aWQK1e+
         XLlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NFu6zxSuoolFFDIUMKLRrnHWCMxchV5f82Kp8PXbhW0=;
        b=BtHxaL+YV12i3dcdsfkyUHBki2RT0aWWH1cN1PN4WBjOjELnCZPpJTEjIvSFUG8zVD
         o5brUlx3kH35x5XiIejLOt3eqi5HyDZYBkMUyBkhSh5MvN81x1wNE3/V3LY27nD9TFSp
         Qs/bzR47q0e27yHg/IT05qP3BLWgfjHQzmbNhNYPSVecZCxTBIR/cxx3qyoMdj9YCJqa
         LSJxmHCTRE//wJDTSqfMAXlNRv5hB/9mzOaOCBWmJzSNjwAhgsN+jVmtU+pMTklwnisp
         aikD2tcVeeYQfdNF4cZ+up5BX+bdla/rcnD+lBjnQ/0lU2+r//JsBmmnZEXDhAm2q9Ad
         efoQ==
X-Gm-Message-State: ABuFfoiYJTPErk/lNMTaPwmZ93z5PhDcvV5lPdgabEZVsSVRcGO9wELg
        QKDv6h++CFGez0bpVlYl7jY=
X-Google-Smtp-Source: ACcGV62VZkH8yAixK/ooIhKBBZXwD2DbXUxCqz3CYVENI+LD+xTXhki0e2UthzjYvUD6RxuNfYv4Dg==
X-Received: by 2002:a63:1b0b:: with SMTP id b11-v6mr3015879pgb.66.1538089694874;
        Thu, 27 Sep 2018 16:08:14 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id i186-v6sm4294429pge.80.2018.09.27.16.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 16:08:14 -0700 (PDT)
Date:   Thu, 27 Sep 2018 16:08:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Flavio Leitner <fbl@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: check if the socket netns is correct.
Message-ID: <20180927230813.GB29261@roeck-us.net>
References: <20180927204629.GA4680@roeck-us.net>
 <20180927225824.GT2702@plex.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927225824.GT2702@plex.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 07:58:24PM -0300, Flavio Leitner wrote:
> On Thu, Sep 27, 2018 at 01:46:29PM -0700, Guenter Roeck wrote:
> > Hi Flavio,
> > 
> > On Wed, Jun 27, 2018 at 10:34:25AM -0300, Flavio Leitner wrote:
> > > Netfilter assumes that if the socket is present in the skb, then
> > > it can be used because that reference is cleaned up while the skb
> > > is crossing netns.
> > > 
> > > We want to change that to preserve the socket reference in a future
> > > patch, so this is a preparation updating netfilter to check if the
> > > socket netns matches before use it.
> > > 
> > > Signed-off-by: Flavio Leitner <fbl@redhat.com>
> > > Acked-by: Florian Westphal <fw@strlen.de>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > ---
> > ...
> > > --- a/net/netfilter/xt_socket.c
> > > +++ b/net/netfilter/xt_socket.c
> > > @@ -56,8 +56,12 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
> > >  	struct sk_buff *pskb = (struct sk_buff *)skb;
> > >  	struct sock *sk = skb->sk;
> > >  
> > > +	if (!net_eq(xt_net(par), sock_net(sk)))
> > > +		sk = NULL;
> > > +
> > 
> > I am having trouble with this code. With CONFIG_NET_NS enabled, it crashes
> > for me in read_pnet() because sk is NULL.
> > 
> > >  	if (!sk)
> > >  		sk = nf_sk_lookup_slow_v4(xt_net(par), skb, xt_in(par));
> > 
> > The old code seems to suggest that sk == NULL was possible.
> > 
> > I see the problem with the Chrome OS kernel rebased to v4.19-rc5, so I
> > can not guarantee that this really an upstream problem. The change seems
> > odd, though. Are you sure that it is not (or, rather, no longer) necessary
> > to check if sk == NULL before dereferencing it in sock_net() ?
> 
> Oops, it is necessary but if it's not and the netns doesn't match, we need
> do the lookup. So, could you check if this fixes the problem for you?
> 
> From a5f927e7f1368d753f87cb978d630d786d5adb62 Mon Sep 17 00:00:00 2001
> From: Flavio Leitner <fbl@redhat.com>
> Date: Thu, 27 Sep 2018 19:36:28 -0300
> Subject: [PATCH] xt_socket: check sk before checking for netns.
> 
> Only check for the network namespace if the socket is available.
> 
> Fixes: f564650106a6 ("netfilter: check if the socket netns is correct.")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Flavio Leitner <fbl@redhat.com>

This fixes the problem for me.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

> ---
>  net/netfilter/xt_socket.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
> index 0472f3472842..ada144e5645b 100644
> --- a/net/netfilter/xt_socket.c
> +++ b/net/netfilter/xt_socket.c
> @@ -56,7 +56,7 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
>  	struct sk_buff *pskb = (struct sk_buff *)skb;
>  	struct sock *sk = skb->sk;
>  
> -	if (!net_eq(xt_net(par), sock_net(sk)))
> +	if (sk && !net_eq(xt_net(par), sock_net(sk)))
>  		sk = NULL;
>  
>  	if (!sk)
> @@ -117,7 +117,7 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
>  	struct sk_buff *pskb = (struct sk_buff *)skb;
>  	struct sock *sk = skb->sk;
>  
> -	if (!net_eq(xt_net(par), sock_net(sk)))
> +	if (sk && !net_eq(xt_net(par), sock_net(sk)))
>  		sk = NULL;
>  
>  	if (!sk)
> -- 
> 2.14.4
> 
