Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FF7C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D88259D4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D88259D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeFYNAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:00:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62739 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbeFYNAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:00:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41Dq5N0Kszz9tvV8;
        Mon, 25 Jun 2018 14:59:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fJUnT0KEzHqN; Mon, 25 Jun 2018 14:59:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41Dq5M6ZL8z9tvTy;
        Mon, 25 Jun 2018 14:59:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5880F8B7C4;
        Mon, 25 Jun 2018 14:59:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yQ-P65uSUlrL; Mon, 25 Jun 2018 14:59:59 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.35])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AB178B7A0;
        Mon, 25 Jun 2018 14:59:59 +0200 (CEST)
Subject: Re: [PATCH v2 1/2] crypto: Fix -Wstringop-truncation warnings
To:     Stafford Horne <shorne@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
References: <20180625124538.21051-1-shorne@gmail.com>
 <20180625124538.21051-2-shorne@gmail.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2588342c-50da-a75b-3e51-32e3d931644c@c-s.fr>
Date:   Mon, 25 Jun 2018 14:59:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625124538.21051-2-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/06/2018 à 14:45, Stafford Horne a écrit :
> As of GCC 9.0.0 the build is reporting warnings like:
> 
>      crypto/ablkcipher.c: In function ‘crypto_ablkcipher_report’:
>      crypto/ablkcipher.c:374:2: warning: ‘strncpy’ specified bound 64 equals destination size [-Wstringop-truncation]
>        strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         sizeof(rblkcipher.geniv));
>         ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This means the strnycpy might create a non null terminated string.  Fix this by
> explicitly performing '\0' termination.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Eric Biggers <ebiggers3@gmail.com>
> Cc: Nick Desaulniers <nick.desaulniers@gmail.com>
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>   crypto/ablkcipher.c | 2 ++
>   crypto/blkcipher.c  | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
> index d880a4897159..1edb5000d783 100644
> --- a/crypto/ablkcipher.c
> +++ b/crypto/ablkcipher.c
> @@ -373,6 +373,7 @@ static int crypto_ablkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>   	strncpy(rblkcipher.type, "ablkcipher", sizeof(rblkcipher.type));
>   	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<default>",
>   		sizeof(rblkcipher.geniv));

Is it worth copying something we are going to discard at the following 
line ? Shouldn't you limit the copy to      sizeof(rblkcipher.geniv) - 1   ?

> +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
>   
>   	rblkcipher.blocksize = alg->cra_blocksize;
>   	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> @@ -447,6 +448,7 @@ static int crypto_givcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>   	strncpy(rblkcipher.type, "givcipher", sizeof(rblkcipher.type));
>   	strncpy(rblkcipher.geniv, alg->cra_ablkcipher.geniv ?: "<built-in>",
>   		sizeof(rblkcipher.geniv));

Same comment here.

Christophe

> +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
>   
>   	rblkcipher.blocksize = alg->cra_blocksize;
>   	rblkcipher.min_keysize = alg->cra_ablkcipher.min_keysize;
> diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
> index 01c0d4aa2563..dd4dcab3766a 100644
> --- a/crypto/blkcipher.c
> +++ b/crypto/blkcipher.c
> @@ -512,6 +512,7 @@ static int crypto_blkcipher_report(struct sk_buff *skb, struct crypto_alg *alg)
>   	strncpy(rblkcipher.type, "blkcipher", sizeof(rblkcipher.type));
>   	strncpy(rblkcipher.geniv, alg->cra_blkcipher.geniv ?: "<default>",
>   		sizeof(rblkcipher.geniv));
> +	rblkcipher.geniv[sizeof(rblkcipher.geniv) - 1] = '\0';
>   
>   	rblkcipher.blocksize = alg->cra_blocksize;
>   	rblkcipher.min_keysize = alg->cra_blkcipher.min_keysize;
> 
