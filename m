Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbeBGNMT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 08:12:19 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44056 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753497AbeBGNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 08:12:18 -0500
X-Google-Smtp-Source: AH8x225SblfYgrN7nE9hc66m2YTf2wm2/ZilXqS+z0SzE65F1IuJK5pv/TnxUQ8KKyOERtecTf22uA==
Date: Wed, 7 Feb 2018 14:12:14 +0100
From: Corentin Labbe <clabbe.montjoie@gmail.com>
To: Artem Savkov <asavkov@redhat.com>
Cc: Artem Savkov <artem.savkov@gmail.com>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sun4i_ss_prng: fix return value of
 sun4i_ss_prng_generate
Message-ID: <20180207131214.GC19249@Red>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
 <20180206212022.1309-2-artem.savkov@gmail.com>
 <20180207095659.GA19249@Red>
 <20180207105201.pnn2s57wdk5zuda2@shodan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207105201.pnn2s57wdk5zuda2@shodan.usersys.redhat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2018 at 11:52:01AM +0100, Artem Savkov wrote:
> On Wed, Feb 07, 2018 at 10:56:59AM +0100, Corentin Labbe wrote:
> > On Tue, Feb 06, 2018 at 10:20:21PM +0100, Artem Savkov wrote:
> > > According to crypto/rng.h generate function should return 0 on success
> > > and < 0 on error.
> > > 
> > > Fixes: b8ae5c7387ad ("crypto: sun4i-ss - support the Security System PRNG")
> > > Signed-off-by: Artem Savkov <artem.savkov@gmail.com>
> > > ---
> > >  drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> > > index 0d01d1624252..5754e0b92fb0 100644
> > > --- a/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> > > +++ b/drivers/crypto/sunxi-ss/sun4i-ss-prng.c
> > > @@ -52,5 +52,5 @@ int sun4i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
> > >  
> > >  	writel(0, ss->base + SS_CTL);
> > >  	spin_unlock(&ss->slock);
> > > -	return dlen;
> > > +	return 0;
> > >  }
> > > -- 
> > > 2.15.1
> > > 
> > 
> > According to Documentation/crypto/api-samples.rst ("Code Example For Random Number Generator Usage")
> > you must return the length of data generated.
> 
> I don't think that example is the same as rng_alg.generate, it has a
> different protottype.

crypto_rng_get_bytes() use crypto_rng_generate() which work on crypto_rng

> 
> > So crypto_rng_generate/crypto_rng_get_bytes documentation in crypto/rng.h must be fixed.
> 
> It's not just documentation, every other rng driver returns it this way
> and it gets aead_init_geniv() (and subsequently crypto_create_tfm())
> really confused because they expect the return value to be 0 or < 0.
> 

Perhaps the example is wrong because "copied from/inspirated by" hwrng API which have this behavior.

After checking, other crypto_rng driver, you are probably right, so you can add:
Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
Regards
