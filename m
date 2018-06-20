Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17193C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCC420020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCC420020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933160AbeFTUNF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:13:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44197 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932743AbeFTUNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:13:04 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 419wxQ3wXXz9ttmm;
        Wed, 20 Jun 2018 22:12:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id KbvIZRcsls5i; Wed, 20 Jun 2018 22:12:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 419wxQ3GC4z9ttmD;
        Wed, 20 Jun 2018 22:12:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C89358B83D;
        Wed, 20 Jun 2018 22:13:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id UXn0TvKEAZvK; Wed, 20 Jun 2018 22:13:02 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A1C68B82D;
        Wed, 20 Jun 2018 22:13:02 +0200 (CEST)
Subject: Re: [PATCH 03/11] crypto: ahash: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alasdair Kergon <agk@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <20180620190408.45104-1-keescook@chromium.org>
 <20180620190408.45104-4-keescook@chromium.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d6c501ae-8429-3c6c-2368-16a1f68372e2@c-s.fr>
Date:   Wed, 20 Jun 2018 20:13:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620190408.45104-4-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 07:04 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> introduces max size macros for ahash, as already done for shash, and
> adjust the crypto user to max state size.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

I get:

crypto/algif_hash.c: In function ‘hash_accept’:
crypto/algif_hash.c:276:1: warning: the frame size of 2048 bytes is 
larger than 1024 bytes [-Wframe-larger-than=]

Christophe

> ---
>   crypto/ahash.c        | 4 ++--
>   crypto/algif_hash.c   | 2 +-
>   include/crypto/hash.h | 3 +++
>   3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/ahash.c b/crypto/ahash.c
> index a64c143165b1..6435bdbe42fd 100644
> --- a/crypto/ahash.c
> +++ b/crypto/ahash.c
> @@ -550,8 +550,8 @@ static int ahash_prepare_alg(struct ahash_alg *alg)
>   {
>   	struct crypto_alg *base = &alg->halg.base;
>   
> -	if (alg->halg.digestsize > PAGE_SIZE / 8 ||
> -	    alg->halg.statesize > PAGE_SIZE / 8 ||
> +	if (alg->halg.digestsize > AHASH_MAX_DIGESTSIZE ||
> +	    alg->halg.statesize > AHASH_MAX_STATESIZE ||
>   	    alg->halg.statesize == 0)
>   		return -EINVAL;
>   
> diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
> index bfcf595fd8f9..8974ee8ebead 100644
> --- a/crypto/algif_hash.c
> +++ b/crypto/algif_hash.c
> @@ -239,7 +239,7 @@ static int hash_accept(struct socket *sock, struct socket *newsock, int flags,
>   	struct alg_sock *ask = alg_sk(sk);
>   	struct hash_ctx *ctx = ask->private;
>   	struct ahash_request *req = &ctx->req;
> -	char state[crypto_ahash_statesize(crypto_ahash_reqtfm(req)) ? : 1];
> +	char state[AHASH_MAX_STATESIZE];
>   	struct sock *sk2;
>   	struct alg_sock *ask2;
>   	struct hash_ctx *ctx2;
> diff --git a/include/crypto/hash.h b/include/crypto/hash.h
> index 308aad8bf523..b9df568dc98e 100644
> --- a/include/crypto/hash.h
> +++ b/include/crypto/hash.h
> @@ -64,6 +64,9 @@ struct ahash_request {
>   	void *__ctx[] CRYPTO_MINALIGN_ATTR;
>   };
>   
> +#define AHASH_MAX_DIGESTSIZE	(PAGE_SIZE / 8)
> +#define AHASH_MAX_STATESIZE	(PAGE_SIZE / 8)
> +
>   #define AHASH_REQUEST_ON_STACK(name, ahash) \
>   	char __##name##_desc[sizeof(struct ahash_request) + \
>   		crypto_ahash_reqsize(ahash)] CRYPTO_MINALIGN_ATTR; \
> 
