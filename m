Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD588C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7367F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lb6Y6O5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7367F214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbeISFJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 01:09:11 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38214 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbeISFJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 01:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=77NKSh5AejSBCDfkHAPAXmt6dWtQYE/qJkV2jp49roE=;
        b=lb6Y6O5KpN8LESWwJBkzFSt6CZzHrV5KPGSx5mPwfTsZ5WN5P0ZRRf+hAqhIEO5uPlS+hdlis/orSN/DD9wZ467Ppe8HcMvJA5e/g3Fbe9ZwDD8IXgIHNPwEZ0d11P8NYuQPhpw3q9MqQMeEYxrFp5AAVKcwcLqRC/47YiYufXg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g2PVT-0003mM-DO; Wed, 19 Sep 2018 01:34:11 +0200
Date:   Wed, 19 Sep 2018 01:34:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH net-next v5 20/20] net: WireGuard secure network tunnel
Message-ID: <20180918233411.GB17466@lunn.ch>
References: <20180918161646.19105-1-Jason@zx2c4.com>
 <20180918161646.19105-21-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918161646.19105-21-Jason@zx2c4.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define push_rcu(stack, p, len) ({                                             \
> +		if (rcu_access_pointer(p)) {                                   \
> +			BUG_ON(len >= 128);                                    \
> +			stack[len++] = rcu_dereference_raw(p);                 \
> +		}                                                              \
> +		true;                                                          \
> +	})
> +static void root_free_rcu(struct rcu_head *rcu)
> +{
> +	struct allowedips_node *node, *stack[128] = {
> +		container_of(rcu, struct allowedips_node, rcu) };
> +	unsigned int len = 1;
> +
> +	while (len > 0 && (node = stack[--len]) &&
> +	       push_rcu(stack, node->bit[0], len) &&
> +	       push_rcu(stack, node->bit[1], len))
> +		kfree(node);
> +}

Hi Jason

I see this BUG_ON() is still here. It really needs to be removed. It
does not look like you need to crash the kernel here. Can you add in a
test of len >= 128, do a WARN and then return. I think you then leak
some memory, but i would much prefer that to a crashed machine.

     Andrew
