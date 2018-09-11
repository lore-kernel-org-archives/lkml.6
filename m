Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4F2C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA3C20833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="luGKqThT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA3C20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeIKS3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:29:40 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59020 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbeIKS3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=V+USUOH0ERvU4B5ZofNspJgFIRNwHminsDlNtiit9w8=;
        b=luGKqThTm9DCGG/LPnsrmleUNllvT0uVcJTpMU79HdAKpIMJzVnps85agjpWH8bCxcshTru8OAT+HDtCXrHNkdDf1Ssdio3yh/EKMvhrOi4uvARJ5vYTo3Hm6ETY8Z0O/406lyBdyjXStacCDN9Wdfl5eg9uoCvakdxn0M8lhLY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fzikD-00083J-1D; Tue, 11 Sep 2018 15:30:17 +0200
Date:   Tue, 11 Sep 2018 15:30:17 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v3 17/17] net: WireGuard secure network tunnel
Message-ID: <20180911133017.GJ30395@lunn.ch>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-19-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911010838.8818-19-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 07:08:38PM -0600, Jason A. Donenfeld wrote:
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> ---

Hi Jason

I don't know if any of the crypto people are reviewing the networking
code, but i don't think there are many networking people reviewing the
crypto code.

So please can you put the change log between versions for the
networking code here, where we can easily see it.

> +++ b/drivers/net/wireguard/allowedips.c
> @@ -0,0 +1,404 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include "allowedips.h"
> +#include "peer.h"
> +
> +struct allowedips_node {
> +	struct wireguard_peer __rcu *peer;
> +	struct rcu_head rcu;
> +	struct allowedips_node __rcu *bit[2];
> +	/* While it may seem scandalous that we waste space for v4,
> +	 * we're alloc'ing to the nearest power of 2 anyway, so this
> +	 * doesn't actually make a difference.
> +	 */
> +	u8 bits[16] __aligned(__alignof(u64));
> +	u8 cidr, bit_at_a, bit_at_b;
> +};
> +
> +static __always_inline void swap_endian(u8 *dst, const u8 *src, u8 bits)
> +{
> +	if (bits == 32)
> +		*(u32 *)dst = be32_to_cpu(*(const __be32 *)src);
> +	else if (bits == 128) {
> +		((u64 *)dst)[0] = be64_to_cpu(((const __be64 *)src)[0]);
> +		((u64 *)dst)[1] = be64_to_cpu(((const __be64 *)src)[1]);
> +	}
> +}

I see you have yet again completely ignored my request to either
1) Remove the inline
2) Argue why it should be kept.

Ignoring reviewer comments is not going to help your cause.

> +void allowedips_init(struct allowedips *table)
> +{
> +	table->root4 = table->root6 = NULL;
> +	table->seq = 1;
> +}

You have a number of global scope functions which are polluting the
namespace. Anything which is global scope needs a prefix. If my
grep-foo is correct, the prefix wg_ is currently unused. It is also
reasonably normal for static members to also make use of the prefix,
but not a must.

    Andrew
