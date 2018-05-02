Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeEBJLl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:11:41 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38480 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEBJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:11:37 -0400
Date: Wed, 2 May 2018 17:11:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] net/xfrm: Fix lookups for states with spi == 0
Message-ID: <20180502091125.jnzaaazh67z4ihyf@gondor.apana.org.au>
References: <20180502020220.2027-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180502020220.2027-1-dima@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:02:20AM +0100, Dmitry Safonov wrote:
> It seems to be a valid use case to add xfrm state without
> Security Parameter Indexes (SPI) value associated:
> ip xfrm state add src $src dst $dst proto $proto mode $mode sel src $src dst $dst $algo
> 
> The bad thing is that it's currently impossible to get/delete the state
> without SPI: __xfrm_state_insert() obviously doesn't add hash for zero
> SPI in xfrm.state_byspi, and xfrm_user_state_lookup() will fail as
> xfrm_state_lookup() does lookups by hash.
> 
> It also isn't possible to workaround from userspace as
> xfrm_id_proto_match() will be always true for ah/esp/comp protos.
> 
> So, don't try looking up by hash if SPI == 0.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>

A zero SPI is illegal for many IPsec protocols because that value
is used for other purposes, e.g., IKE encapsulation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
