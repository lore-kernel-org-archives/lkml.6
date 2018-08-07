Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF2DC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8A021759
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8A021759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731989AbeHGL7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:59:12 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:41710 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHGL7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:59:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fmyYR-0001r0-M2; Tue, 07 Aug 2018 17:45:27 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fmyYD-0006xd-OA; Tue, 07 Aug 2018 17:45:13 +0800
Date:   Tue, 7 Aug 2018 17:45:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
Message-ID: <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
References: <20180802215118.17752-1-keescook@chromium.org>
 <20180802215118.17752-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802215118.17752-2-keescook@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 02:51:10PM -0700, Kees Cook wrote:
> When pstore was refactored to use the crypto compress API in:
> 
>   commit cb3bee0369bc ("pstore: Use crypto compress API")
> 
> nearly all the pstore-specific compression routines were replaced with
> the existing crypto compression API. One case remained: calculating the
> "worst case" compression sizes ahead of time so it could have a buffer
> preallocated for doing compression (which was called "zbufsize").
> 
> To make pstore fully algorithm-agnostic, the compression API needs to
> grow this functionality. This adds the interface to support querying the
> "worst case" estimate, with a new "zbufsize" routine that each compressor
> can implement. The per-compressor implementations come in later commits.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  crypto/compress.c                   |  9 +++++++++
>  include/crypto/internal/scompress.h | 11 +++++++++++
>  include/linux/crypto.h              | 12 ++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/crypto/compress.c b/crypto/compress.c
> index f2d522924a07..29a80bb3b9d3 100644
> --- a/crypto/compress.c
> +++ b/crypto/compress.c
> @@ -33,12 +33,21 @@ static int crypto_decompress(struct crypto_tfm *tfm,
>  	                                                   dlen);
>  }
>  
> +static int crypto_zbufsize(struct crypto_tfm *tfm,
> +			   unsigned int slen, unsigned int *dlen)
> +{
> +	if (!tfm->__crt_alg->cra_compress.coa_zbufsize)
> +		return -ENOTSUPP;
> +	return tfm->__crt_alg->cra_compress.coa_zbufsize(tfm, slen, dlen);
> +}

Please don't add new features to the old compress interface.  Any
new improvements should be added to scomp/acomp only.  Users who
need new features should be converted.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
