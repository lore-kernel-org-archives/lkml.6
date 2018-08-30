Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47B3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5152C20645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="trmv4GOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5152C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=blackhole.kfki.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeH3Md1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:33:27 -0400
Received: from smtp-in.kfki.hu ([148.6.0.28]:56224 "EHLO smtp2.kfki.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbeH3Md0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:33:26 -0400
X-Greylist: delayed 546 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Aug 2018 08:33:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp2.kfki.hu (Postfix) with ESMTP id 6CADACC00DC;
        Thu, 30 Aug 2018 10:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        blackhole.kfki.hu; h=mime-version:user-agent:references
        :message-id:in-reply-to:from:from:date:date:received:received
        :received; s=20151130; t=1535617397; x=1537431798; bh=YtlCXSIAjj
        xfnJOPZXNg8rooPSKiA71ycVA30yEKtqk=; b=trmv4GOXZUtO8OTK9tp66ut95c
        rdKMUaD8UsTCsCr8o3yUlvX4FsTQl57PuxP4r95WN1LDnEimtEJyuVgBzWvOTek4
        bl95zoBAj7v/vkqxqYwaSjvQyndhz416f035UO6pzZzfnjvUVIM5qAjw4DnKFep3
        mJiZexWQKWrUj9wWk=
X-Virus-Scanned: Debian amavisd-new at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
        by localhost (smtp2.kfki.hu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP; Thu, 30 Aug 2018 10:23:17 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.kfki.hu [148.6.240.2])
        by smtp2.kfki.hu (Postfix) with ESMTP id B7570CC00D4;
        Thu, 30 Aug 2018 10:23:16 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
        id 8A443211CC; Thu, 30 Aug 2018 10:23:16 +0200 (CEST)
Date:   Thu, 30 Aug 2018 10:23:16 +0200 (CEST)
From:   Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To:     Eric Westbrook <eric@westbrook.io>
cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Netfilter Development <netfilter-devel@vger.kernel.org>,
        Netfilter Core Team <coreteam@netfilter.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Trivial Patch Monkey <trivial@kernel.org>
Subject: Re: [PATCH] netfilter: ipset: actually allow allowable CIDR 0 in
 hash:net,port,net
In-Reply-To: <a3d786d6-3608-8575-9901-afcf3a52693a@westbrook.io>
Message-ID: <alpine.DEB.2.11.1808301022280.588@blackhole.kfki.hu>
References: <a3d786d6-3608-8575-9901-afcf3a52693a@westbrook.io>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Eric Westbrook wrote:

> Allow /0 as advertised for hash:net,port,net sets.
> 
> For "hash:net,port,net", ipset(8) says that "either subnet
> is permitted to be a /0 should you wish to match port
> between all destinations."
> 
> Make that statement true.
> 
> Before:
> 
>     # ipset create cidrzero hash:net,port,net
>     # ipset add cidrzero 0.0.0.0/0,12345,0.0.0.0/0
>     ipset v6.34: The value of the CIDR parameter of the IP address is invalid
> 
>     # ipset create cidrzero6 hash:net,port,net family inet6
>     # ipset add cidrzero6 ::/0,12345,::/0
>     ipset v6.34: The value of the CIDR parameter of the IP address is invalid
> 
> After:
> 
>     # ipset create cidrzero hash:net,port,net
>     # ipset add cidrzero 0.0.0.0/0,12345,0.0.0.0/0
>     # ipset test cidrzero 192.168.205.129,12345,172.16.205.129
>     192.168.205.129,tcp:12345,172.16.205.129 is in set cidrzero.
> 
>     # ipset create cidrzero6 hash:net,port,net family inet6
>     # ipset add cidrzero6 ::/0,12345,::/0
>     # ipset test cidrzero6 fe80::1,12345,ff00::1
>     fe80::1,tcp:12345,ff00::1 is in set cidrzero6.
> 
> See also:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=200897
>   https://github.com/ewestbrook/linux/commit/df7ff6efb0934ab6acc11f003ff1a7580d6c1d9c
> 
> Signed-off-by: Eric Westbrook <linux@westbrook.io>

Patch is applied, thank you.

Best regards,
Jozsef

> ---
>  net/netfilter/ipset/ip_set_hash_netportnet.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/netfilter/ipset/ip_set_hash_netportnet.c b/net/netfilter/ipset/ip_set_hash_netportnet.c
> index d391485a6acd..613e18e720a4 100644
> --- a/net/netfilter/ipset/ip_set_hash_netportnet.c
> +++ b/net/netfilter/ipset/ip_set_hash_netportnet.c
> @@ -213,13 +213,13 @@ hash_netportnet4_uadt(struct ip_set *set, struct nlattr *tb[],
> 
>  	if (tb[IPSET_ATTR_CIDR]) {
>  		e.cidr[0] = nla_get_u8(tb[IPSET_ATTR_CIDR]);
> -		if (!e.cidr[0] || e.cidr[0] > HOST_MASK)
> +		if (e.cidr[0] > HOST_MASK)
>  			return -IPSET_ERR_INVALID_CIDR;
>  	}
> 
>  	if (tb[IPSET_ATTR_CIDR2]) {
>  		e.cidr[1] = nla_get_u8(tb[IPSET_ATTR_CIDR2]);
> -		if (!e.cidr[1] || e.cidr[1] > HOST_MASK)
> +		if (e.cidr[1] > HOST_MASK)
>  			return -IPSET_ERR_INVALID_CIDR;
>  	}
> 
> @@ -493,13 +493,13 @@ hash_netportnet6_uadt(struct ip_set *set, struct nlattr *tb[],
> 
>  	if (tb[IPSET_ATTR_CIDR]) {
>  		e.cidr[0] = nla_get_u8(tb[IPSET_ATTR_CIDR]);
> -		if (!e.cidr[0] || e.cidr[0] > HOST_MASK)
> +		if (e.cidr[0] > HOST_MASK)
>  			return -IPSET_ERR_INVALID_CIDR;
>  	}
> 
>  	if (tb[IPSET_ATTR_CIDR2]) {
>  		e.cidr[1] = nla_get_u8(tb[IPSET_ATTR_CIDR2]);
> -		if (!e.cidr[1] || e.cidr[1] > HOST_MASK)
> +		if (e.cidr[1] > HOST_MASK)
>  			return -IPSET_ERR_INVALID_CIDR;
>  	}
> 
> -- 
> 2.18.0
> 
> 

-
E-mail  : kadlec@blackhole.kfki.hu, kadlecsik.jozsef@wigner.mta.hu
PGP key : http://www.kfki.hu/~kadlec/pgp_public_key.txt
Address : Wigner Research Centre for Physics, Hungarian Academy of Sciences
          H-1525 Budapest 114, POB. 49, Hungary
