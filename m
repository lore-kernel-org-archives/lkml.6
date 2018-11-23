Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE5EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BEE206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 01:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="A5mJscS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BEE206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439205AbeKWLsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:48:13 -0500
Received: from m12-12.163.com ([220.181.12.12]:33205 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeKWLsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 06:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=FVnCK
        iRPOtTHhR3R2VXIEQAgOV0yCduGKgfYTIdPMGA=; b=A5mJscS6TPbcS6rQG4clZ
        Pgrub6Be22qZpgoFsaTlMSLL2L8IyqNt1aAP26WE4rMh0rne4s1uFUTWFAwTRLKh
        TqbzoBQCEb8LpC3Ex083OnpDmzZBNPo8hCdS+esSc7ylFaXyqhQlkszeWKbuhVuB
        yZQOAy3Q7PgK7RG+vSb9u4=
Received: from bp (unknown [106.120.213.96])
        by smtp8 (Coremail) with SMTP id DMCowABX5nJwUvdbvHbqBQ--.22330S2;
        Fri, 23 Nov 2018 09:05:53 +0800 (CST)
Date:   Fri, 23 Nov 2018 09:05:55 +0800
From:   PanBian <bianpan2016@163.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: do not free algorithm before using
Message-ID: <20181123010555.GA83154@bp>
Reply-To: PanBian <bianpan2016@163.com>
References: <1542880816-63838-1-git-send-email-bianpan2016@163.com>
 <20181122144441.tkfmrq3lzibq2g3y@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122144441.tkfmrq3lzibq2g3y@gondor.apana.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CM-TRANSID: DMCowABX5nJwUvdbvHbqBQ--.22330S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF15Cr4UAryrAw1rurW5Awb_yoW8Cr4fpr
        WrJFW8JFWktrZ0kFZ29a1rXry8W3yI9r15GrWUCryIvwnxXr1kJr9Fyr47XF42yF1kJryr
        JrZ7Wr97Z3WjkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jNvtAUUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBzxEIclaD0YLuDwAAsD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:44:41PM +0800, Herbert Xu wrote:
> On Thu, Nov 22, 2018 at 06:00:16PM +0800, Pan Bian wrote:
> > In multiple functions, the algorithm fields are read after its reference
> > is dropped through crypto_mod_put. In this case, the algorithm memory
> > may be freed, resulting in use-after-free bugs. This patch delays the
> > put operation until the algorithm is never used.
> > 
> > Signed-off-by: Pan Bian <bianpan2016@163.com>
> 
> I don't think this patch is needed.
> 
> > ---
> >  crypto/cbc.c  | 6 ++++--
> >  crypto/cfb.c  | 6 ++++--
> >  crypto/pcbc.c | 6 ++++--
> >  3 files changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/crypto/cbc.c b/crypto/cbc.c
> > index b761b1f..dd5f332 100644
> > --- a/crypto/cbc.c
> > +++ b/crypto/cbc.c
> > @@ -140,9 +140,8 @@ static int crypto_cbc_create(struct crypto_template *tmpl, struct rtattr **tb)
> >  	spawn = skcipher_instance_ctx(inst);
> >  	err = crypto_init_spawn(spawn, alg, skcipher_crypto_instance(inst),
> >  				CRYPTO_ALG_TYPE_MASK);
> > -	crypto_mod_put(alg);
> >  	if (err)
> > -		goto err_free_inst;
> > +		goto err_put_alg;
> 
> We can safely drop the reference to the algorithm because the spawn
> is now meant to hold a reference to it.  As long as the spawn is
> alive so will the algorithm.

Thanks for your explanation! But I find that the function
crypto_init_spawn just lets spawn->alg point to the algorithm without 
increasing the reference count, i.e., alg->cra_refcnt. So I am confused
about how this can protect the algorithm from being freed. Maybe I
missed some key points. Could you please explain it in more details?

Thank you!

Best regards,
Pan Bian

> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

