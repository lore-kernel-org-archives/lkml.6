Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEBMlo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:41:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36862 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751100AbeEBMlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:41:39 -0400
X-Google-Smtp-Source: AB8JxZp/xncJLjAFol6BHrpEtEZlbNOhAMQKo+372y6YIC455FNQMOeAk/4e8+uE75Rt9Qi+pLNSUQ==
Message-ID: <1525264896.14025.23.camel@arista.com>
Subject: Re: [PATCH] net/xfrm: Fix lookups for states with spi == 0
From: Dmitry Safonov <dima@arista.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Date: Wed, 02 May 2018 13:41:36 +0100
In-Reply-To: <20180502091125.jnzaaazh67z4ihyf@gondor.apana.org.au>
References: <20180502020220.2027-1-dima@arista.com>
         <20180502091125.jnzaaazh67z4ihyf@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-02 at 17:11 +0800, Herbert Xu wrote:
> On Wed, May 02, 2018 at 03:02:20AM +0100, Dmitry Safonov wrote:
> > It seems to be a valid use case to add xfrm state without
> > Security Parameter Indexes (SPI) value associated:
> > ip xfrm state add src $src dst $dst proto $proto mode $mode sel src
> > $src dst $dst $algo
> > 
> > The bad thing is that it's currently impossible to get/delete the
> > state
> > without SPI: __xfrm_state_insert() obviously doesn't add hash for
> > zero
> > SPI in xfrm.state_byspi, and xfrm_user_state_lookup() will fail as
> > xfrm_state_lookup() does lookups by hash.
> > 
> > It also isn't possible to workaround from userspace as
> > xfrm_id_proto_match() will be always true for ah/esp/comp protos.
> > 
> > So, don't try looking up by hash if SPI == 0.
> > 
> > Cc: Steffen Klassert <steffen.klassert@secunet.com>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> A zero SPI is illegal for many IPsec protocols because that value
> is used for other purposes, e.g., IKE encapsulation.

But still it's possible to create ipsec with zero SPI.
And it seems not making sense to search for a state with SPI hash if
request has zero SPI.

-- 
            Dima
