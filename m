Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30F3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F09221722
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F09221722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeI1FTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:19:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37908 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbeI1FTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:19:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id 204-v6so2051381qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mCv2JKDw33wX2+s+FsaNiZiYTNcK2ntzUThB4xzL/Ko=;
        b=pWg9Kbe7muwf7CHhjLNzUeUMWan00N8x1whJJQPj9Ak+DBHN+J+Th838Z3q8sV5ld0
         CuNQYMn/W/3YZM2IvrNqBUHz/ZNu2uxCWgTL6uF3fOqg7JKADGFaKtkeADjEIqYxk2Gs
         bfUWRRSZMdY8L2sN3YwsVfkKSjNaBsBbRyB+2lNhesEM6y6Nk/xouEBbLIXurM9sx0Fj
         kNwp6ieUQk50KFAhqOazB/DZ3Stzs4pJArS+2bIndDlZVPovRss3BeyD9X61QYVK/2X7
         dwQUfpKIhtM6AQXU5KWgzzHltpLL6srJWPkStSjFUiiw6RooEsrzFxcWAb0ylJCZyzEf
         KOqQ==
X-Gm-Message-State: ABuFfog+8nJnG3h1EMaQWImPmTVawFFOUNwQDemCjhZFUSc2lnQV52FM
        PXFRde6zo0Nh/+OYWUidFIZD4A==
X-Google-Smtp-Source: ACcGV61hJNK4V//mCqzOVUlHQS5kF+Pa60/IRBXoT7Snd9IvTmlLfXh+3Pqa0lCsH1m4OdULKX2u8w==
X-Received: by 2002:a37:2ec3:: with SMTP id u186-v6mr9852788qkh.72.1538089108337;
        Thu, 27 Sep 2018 15:58:28 -0700 (PDT)
Received: from localhost ([177.183.215.101])
        by smtp.gmail.com with ESMTPSA id 20-v6sm2021654qkd.83.2018.09.27.15.58.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:58:27 -0700 (PDT)
Date:   Thu, 27 Sep 2018 19:58:24 -0300
From:   Flavio Leitner <fbl@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: check if the socket netns is correct.
Message-ID: <20180927225824.GT2702@plex.lan>
References: <20180927204629.GA4680@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927204629.GA4680@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 01:46:29PM -0700, Guenter Roeck wrote:
> Hi Flavio,
> 
> On Wed, Jun 27, 2018 at 10:34:25AM -0300, Flavio Leitner wrote:
> > Netfilter assumes that if the socket is present in the skb, then
> > it can be used because that reference is cleaned up while the skb
> > is crossing netns.
> > 
> > We want to change that to preserve the socket reference in a future
> > patch, so this is a preparation updating netfilter to check if the
> > socket netns matches before use it.
> > 
> > Signed-off-by: Flavio Leitner <fbl@redhat.com>
> > Acked-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > ---
> ...
> > --- a/net/netfilter/xt_socket.c
> > +++ b/net/netfilter/xt_socket.c
> > @@ -56,8 +56,12 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
> >  	struct sk_buff *pskb = (struct sk_buff *)skb;
> >  	struct sock *sk = skb->sk;
> >  
> > +	if (!net_eq(xt_net(par), sock_net(sk)))
> > +		sk = NULL;
> > +
> 
> I am having trouble with this code. With CONFIG_NET_NS enabled, it crashes
> for me in read_pnet() because sk is NULL.
> 
> >  	if (!sk)
> >  		sk = nf_sk_lookup_slow_v4(xt_net(par), skb, xt_in(par));
> 
> The old code seems to suggest that sk == NULL was possible.
> 
> I see the problem with the Chrome OS kernel rebased to v4.19-rc5, so I
> can not guarantee that this really an upstream problem. The change seems
> odd, though. Are you sure that it is not (or, rather, no longer) necessary
> to check if sk == NULL before dereferencing it in sock_net() ?

Oops, it is necessary but if it's not and the netns doesn't match, we need
do the lookup. So, could you check if this fixes the problem for you?

From a5f927e7f1368d753f87cb978d630d786d5adb62 Mon Sep 17 00:00:00 2001
From: Flavio Leitner <fbl@redhat.com>
Date: Thu, 27 Sep 2018 19:36:28 -0300
Subject: [PATCH] xt_socket: check sk before checking for netns.

Only check for the network namespace if the socket is available.

Fixes: f564650106a6 ("netfilter: check if the socket netns is correct.")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Flavio Leitner <fbl@redhat.com>
---
 net/netfilter/xt_socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_socket.c b/net/netfilter/xt_socket.c
index 0472f3472842..ada144e5645b 100644
--- a/net/netfilter/xt_socket.c
+++ b/net/netfilter/xt_socket.c
@@ -56,7 +56,7 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
 	struct sk_buff *pskb = (struct sk_buff *)skb;
 	struct sock *sk = skb->sk;
 
-	if (!net_eq(xt_net(par), sock_net(sk)))
+	if (sk && !net_eq(xt_net(par), sock_net(sk)))
 		sk = NULL;
 
 	if (!sk)
@@ -117,7 +117,7 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
 	struct sk_buff *pskb = (struct sk_buff *)skb;
 	struct sock *sk = skb->sk;
 
-	if (!net_eq(xt_net(par), sock_net(sk)))
+	if (sk && !net_eq(xt_net(par), sock_net(sk)))
 		sk = NULL;
 
 	if (!sk)
-- 
2.14.4

