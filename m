Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B94C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB6FD20823
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="Psc6I4DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfBHJ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:56:54 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:45305 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfBHJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:56:53 -0500
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 04DE325BE72;
        Fri,  8 Feb 2019 20:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1549619811; bh=4iiox4Kt9PGuWxnqzfkvo074yaByLgoMV8mjvP/ryZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Psc6I4DFHwwya6AqCfb33NuJXK1Mkx+rlogwf5X8mPA/FYtNE/vNcLkb4p/JjW1S1
         r6awqVSDY/xs/xWAN0pzOCbL5DEDvRqqRbX0Azw0igdvddk1NF8dUYID8THpu2pn67
         XITtZ7dS/5XptIIHrJCyD9Sc6yZfTzZXQ8s6aZ3k=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id A9BDB940ABA; Fri,  8 Feb 2019 10:56:48 +0100 (CET)
Date:   Fri, 8 Feb 2019 10:56:48 +0100
From:   Simon Horman <horms@verge.net.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Wensong Zhang <wensong@linux-vs.org>, Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipvs: Use struct_size() helper
Message-ID: <20190208095648.la4ushbjxkqgqzb6@verge.net.au>
References: <20190208004456.GA15845@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208004456.GA15845@embeddedor>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 06:44:56PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
> 
> size = sizeof(struct foo) + count * sizeof(struct boo);
> instance = alloc(size, GFP_KERNEL)
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> size = struct_size(instance, entry, count);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Pablo, could you consider applying this?

> ---
>  net/netfilter/ipvs/ip_vs_ctl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
> index 7d6318664eb2..bcd9112f47d9 100644
> --- a/net/netfilter/ipvs/ip_vs_ctl.c
> +++ b/net/netfilter/ipvs/ip_vs_ctl.c
> @@ -2734,8 +2734,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
>  		int size;
>  
>  		get = (struct ip_vs_get_services *)arg;
> -		size = sizeof(*get) +
> -			sizeof(struct ip_vs_service_entry) * get->num_services;
> +		size = struct_size(get, entrytable, get->num_services);
>  		if (*len != size) {
>  			pr_err("length: %u != %u\n", *len, size);
>  			ret = -EINVAL;
> @@ -2776,8 +2775,7 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
>  		int size;
>  
>  		get = (struct ip_vs_get_dests *)arg;
> -		size = sizeof(*get) +
> -			sizeof(struct ip_vs_dest_entry) * get->num_dests;
> +		size = struct_size(get, entrytable, get->num_dests);
>  		if (*len != size) {
>  			pr_err("length: %u != %u\n", *len, size);
>  			ret = -EINVAL;
> -- 
> 2.20.1
> 
