Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB959C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F772170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm9t5CFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F772170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeI1DGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:06:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42079 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeI1DGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:06:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so2698828pff.9;
        Thu, 27 Sep 2018 13:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Qrxf2CwmV5xXbtJHRNVV1V5yDASXcDwCTky+rlu0EzQ=;
        b=Lm9t5CFXVHzwLDSLhliManWf06X0r7emNkMC4dej8l+q8L1HuMgCJeUU61sfq6lpIr
         8lzUT9eJXT7XbMjJApKu7QIcenGlKuKCHh0bALZF9jl5zB7WWOlj4ZsYxxZcvEXJdNMe
         S/QJn60VaJtjEfgTFajmMxnsGGrCdIt1W9IWex2iyQj1Bmgq5e6FJluokGeMdrR76aqq
         BZrzW1bRtP1Zkx/MNxKrwU0oHjhAFTNvznepB/hMltCQN9zg1OfqfPQ2lBXme093ww2h
         p2UTINu1hkntUFj4IAqowd8Q5y8DvGmuq3e1YT9NF2r0eAc/B1qO9Zyi8P++qY6cNF1g
         n0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Qrxf2CwmV5xXbtJHRNVV1V5yDASXcDwCTky+rlu0EzQ=;
        b=SF1p0NumlnYA2OAfuNxQ3MRzVyshHbVHFLafXMF4i0DaM2IeWgU1Beounb+lMMAFKY
         TvV7x7GIXdvNegEWh6rnU82XfoeLYl6IceY5BBmM8PRvoeEXyJTwxIdVuef3K1+Zh/Gv
         4JWord+TivePjMlMsCf3oPQ3dZlNYKP69WNV1uCK8NdqavjfAqB6WMsG4bWsaJ4G+m6g
         tXrRhPNwrILXn5unVluSXwe4yp5eAqapF94qmFyV448ISk3N3J+M1XZ5yIV3mlkSnrL1
         xq/cjd+lglUTlzqjxHBIbhYGSuBDlzC8tOOQf/3fqa8U5MnyFY+byPM813tUxvq8Kv2A
         ofmw==
X-Gm-Message-State: ABuFfoid1lRkzrU7dQjelLaGak0ac0Y2E7sPHxcc/m5LWfdT+F0kpOjQ
        EPG0SwrgBY8KomHFmUMYbgE=
X-Google-Smtp-Source: ACcGV60z8ALsED8SX/n7DSc3VGwGevOzC9jgOIaPgzro+l5ZIc/O++BhOCaAfqk5F4t0HH5QNazNkQ==
X-Received: by 2002:a63:ba5e:: with SMTP id l30-v6mr11728272pgu.76.1538081191647;
        Thu, 27 Sep 2018 13:46:31 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a11-v6sm262404pgw.54.2018.09.27.13.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 13:46:30 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:46:29 -0700
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
Message-ID: <20180927204629.GA4680@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Flavio,

On Wed, Jun 27, 2018 at 10:34:25AM -0300, Flavio Leitner wrote:
> Netfilter assumes that if the socket is present in the skb, then
> it can be used because that reference is cleaned up while the skb
> is crossing netns.
> 
> We want to change that to preserve the socket reference in a future
> patch, so this is a preparation updating netfilter to check if the
> socket netns matches before use it.
> 
> Signed-off-by: Flavio Leitner <fbl@redhat.com>
> Acked-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
...
> --- a/net/netfilter/xt_socket.c
> +++ b/net/netfilter/xt_socket.c
> @@ -56,8 +56,12 @@ socket_match(const struct sk_buff *skb, struct xt_action_param *par,
>  	struct sk_buff *pskb = (struct sk_buff *)skb;
>  	struct sock *sk = skb->sk;
>  
> +	if (!net_eq(xt_net(par), sock_net(sk)))
> +		sk = NULL;
> +

I am having trouble with this code. With CONFIG_NET_NS enabled, it crashes
for me in read_pnet() because sk is NULL.

>  	if (!sk)
>  		sk = nf_sk_lookup_slow_v4(xt_net(par), skb, xt_in(par));

The old code seems to suggest that sk == NULL was possible.

I see the problem with the Chrome OS kernel rebased to v4.19-rc5, so I
can not guarantee that this really an upstream problem. The change seems
odd, though. Are you sure that it is not (or, rather, no longer) necessary
to check if sk == NULL before dereferencing it in sock_net() ?

> +
>  	if (sk) {
>  		bool wildcard;
>  		bool transparent = true;
> @@ -113,8 +117,12 @@ socket_mt6_v1_v2_v3(const struct sk_buff *skb, struct xt_action_param *par)
>  	struct sk_buff *pskb = (struct sk_buff *)skb;
>  	struct sock *sk = skb->sk;
>  
> +	if (!net_eq(xt_net(par), sock_net(sk)))
> +		sk = NULL;
> +
Same here.

>  	if (!sk)
>  		sk = nf_sk_lookup_slow_v6(xt_net(par), skb, xt_in(par));
> +
>  	if (sk) {
>  		bool wildcard;
>  		bool transparent = true;

Thanks,
Guenter
