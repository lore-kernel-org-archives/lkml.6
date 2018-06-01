Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFARvy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 13:51:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58067 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeFARvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 13:51:53 -0400
Date: Fri, 1 Jun 2018 19:51:50 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: David Ahern <dsahern@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net] ipv6: omit traffic class when calculating flow hash
Message-ID: <20180601175150.jgmmdygb2pzjvmqo@unicorn.suse.cz>
References: <20180601112948.93BE7A0C48@unicorn.suse.cz>
 <4c70b2ef-20c2-0e7c-d1f6-7d4c97e566f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c70b2ef-20c2-0e7c-d1f6-7d4c97e566f2@gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 10:42:10AM -0600, David Ahern wrote:
> 
> Can you make an inline for the flowlabel conversion. Something like this:
> 
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index 798558fd1681..e36eca2f8531 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -284,6 +284,11 @@ struct ip6_flowlabel {
>  #define IPV6_FLOWLABEL_MASK            cpu_to_be32(0x000FFFFF)
>  #define IPV6_FLOWLABEL_STATELESS_FLAG  cpu_to_be32(0x00080000)
> 
> +static inline u32 flowi6_get_flowlabel(const struct flowi6 *fl6)
> +{
> +       return (__force u32)(fl6->flowlabel & IPV6_FLOWLABEL_MASK);
> +}
> +
>  #define IPV6_TCLASS_MASK (IPV6_FLOWINFO_MASK & ~IPV6_FLOWLABEL_MASK)
>  #define IPV6_TCLASS_SHIFT      20
> 
> From there we can fix the flow struct to have flowinfo instead of
> flowlabel and use the macro to hide the conversion.

I'll send v2 with inline helper. I'm just not sure about including the
cast as this way the helper would be useful for hash key which is not
clear from the name. So it seems more appropriate to either introduce a
helper which just does the masking or helper which does also the copying
into struct flow_keys.

Michal Kubecek
