Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeECFkq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 01:40:46 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39238 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeECFkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 01:40:43 -0400
Date: Thu, 3 May 2018 13:40:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
Subject: Re: [PATCH] net/xfrm: Fix lookups for states with spi == 0
Message-ID: <20180503054029.t4addjto3odlhr47@gondor.apana.org.au>
References: <20180502020220.2027-1-dima@arista.com>
 <20180502091125.jnzaaazh67z4ihyf@gondor.apana.org.au>
 <1525264896.14025.23.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525264896.14025.23.camel@arista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 01:41:36PM +0100, Dmitry Safonov wrote:
>
> But still it's possible to create ipsec with zero SPI.
> And it seems not making sense to search for a state with SPI hash if
> request has zero SPI.

Fair enough.  In fact a zero SPI is legal and defined for IPcomp.

The bug arose from this patch:

commit 7b4dc3600e4877178ba94c7fbf7e520421378aa6
Author: Masahide NAKAMURA <nakam@linux-ipv6.org>
Date:   Wed Sep 27 22:21:52 2006 -0700

    [XFRM]: Do not add a state whose SPI is zero to the SPI hash.
    
    SPI=0 is used for acquired IPsec SA and MIPv6 RO state.
    Such state should not be added to the SPI hash
    because we do not care about it on deleting path.
    
    Signed-off-by: Masahide NAKAMURA <nakam@linux-ipv6.org>
    Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

I think it would be better to revert this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
