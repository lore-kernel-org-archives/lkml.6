Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61211ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA738208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA738208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbeGQHGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:06:37 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35760 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeGQHGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:06:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ffJZp-0005am-L8; Tue, 17 Jul 2018 14:35:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ffJZd-0003AG-6y; Tue, 17 Jul 2018 14:35:01 +0800
Date:   Tue, 17 Jul 2018 14:35:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/11] crypto: xcbc: Remove VLA usage
Message-ID: <20180717063501.exqa54plsfjl4s73@gondor.apana.org.au>
References: <20180717042150.37761-1-keescook@chromium.org>
 <20180717042150.37761-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717042150.37761-2-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:21:40PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this uses
> the maximum blocksize and adds a sanity check. For xcbc, the blocksize
> must always be 16, so use that, since it's already being enforced during
> instantiation.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/xcbc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/xcbc.c b/crypto/xcbc.c
> index 25c75af50d3f..7aa03beed795 100644
> --- a/crypto/xcbc.c
> +++ b/crypto/xcbc.c
> @@ -57,6 +57,8 @@ struct xcbc_desc_ctx {
>  	u8 ctx[];
>  };
>  
> +#define XCBC_BLOCKSIZE	16
> +
>  static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
>  				     const u8 *inkey, unsigned int keylen)
>  {
> @@ -65,7 +67,10 @@ static int crypto_xcbc_digest_setkey(struct crypto_shash *parent,
>  	int bs = crypto_shash_blocksize(parent);
>  	u8 *consts = PTR_ALIGN(&ctx->ctx[0], alignmask + 1);
>  	int err = 0;
> -	u8 key1[bs];
> +	u8 key1[XCBC_BLOCKSIZE];
> +
> +	if (WARN_ON(bs > sizeof(key1)))
> +		return -EINVAL;

Please remove this.  You already checked it in xcbc_create.

In fact, you should just make bs XCBC_BLOCKSIZE unconditinoally
in this function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
