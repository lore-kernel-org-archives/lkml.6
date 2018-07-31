Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E73EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GDhcsxF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BABB420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeGaVoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:44:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:51977 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbeGaVoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=QC/I0CZi/6LkQTjc9+mu8tTeq8br6lXSkpa4j5DUQUI=;
        b=GDhcsxF83I/zRdgeg9Ux8jTLAby7447RAzt7oNBEZL0iSgHAVC2VeLsalcp/qunqBer1ffBSN6yU98DJBEKB6boO04mMLWlm5CzRawLnBlFYubnzc0PFO+hPyOH72wGuAxBllyE/u4ljdU/5Kc90l7EXMFuDCPt44Uf+/mJ+AZk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1fkaqd-0000OV-UB; Tue, 31 Jul 2018 22:02:23 +0200
Date:   Tue, 31 Jul 2018 22:02:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 3/3] net: WireGuard secure network tunnel
Message-ID: <20180731200223.GA32125@lunn.ch>
References: <20180731191102.2434-1-Jason@zx2c4.com>
 <20180731191102.2434-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731191102.2434-4-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason

I just gave this patch to checkpatch.pl...

total: 6 errors, 763 warnings, 6514 lines checked

It would be good to reduce these numbers.

> +static __always_inline void swap_endian(u8 *dst, const u8 *src, u8 bits)

There is a general preference to not force the compile to
inline. Leave it to decide.

> +#define push(stack, p, len) ({ \
> +	if (rcu_access_pointer(p)) { \
> +		BUG_ON(len >= 128); \
> +		stack[len++] = rcu_dereference_protected(p, lockdep_is_held(lock)); \
> +	} \
> +	true; \
> +})

> +#undef push
> +

> +#define push(p) ({ BUG_ON(len >= 128); stack[len++] = p; })

This is going to lead to bugs, coders thinking push() does one thing,
when it actually does something else. I would suggest making these
helper functions, with useful names.

> +/* Returns a strong reference to a peer */
> +static __always_inline struct wireguard_peer *lookup(struct allowedips_node __rcu *root, u8 bits, const void *be_ip)
> +{
> +	struct wireguard_peer *peer = NULL;
> +	struct allowedips_node *node;
> +	u8 ip[16] __aligned(__alignof(u64));

netdev code requires that all local variables are in reverse christmas tree.

       Andrew
