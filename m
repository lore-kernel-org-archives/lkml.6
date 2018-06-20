Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A1C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC5B20020
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 20:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC5B20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933129AbeFTUQp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 16:16:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:6185 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932742AbeFTUQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 16:16:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 419x1f19tBz9ttrR;
        Wed, 20 Jun 2018 22:16:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HltAnGvRSs1p; Wed, 20 Jun 2018 22:16:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 419x1f0Yq3z9ttqq;
        Wed, 20 Jun 2018 22:16:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73BD08B83D;
        Wed, 20 Jun 2018 22:16:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2t-xx8Ci7b3p; Wed, 20 Jun 2018 22:16:42 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D5C258B82D;
        Wed, 20 Jun 2018 22:16:41 +0200 (CEST)
Subject: Re: [PATCH 06/11] crypto: cbc: Remove VLA usage
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
 <20180620190408.45104-7-keescook@chromium.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1e08a813-1872-4372-1c2c-d8fd02dfb63a@c-s.fr>
Date:   Wed, 20 Jun 2018 20:16:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180620190408.45104-7-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/20/2018 07:04 PM, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> uses the upper bounds on blocksize.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

crypto/cbc.c: In function ‘crypto_cbc_decrypt’:
crypto/cbc.c:79:1: warning: the frame size of 2144 bytes is larger than 
1024 bytes [-Wframe-larger-than=]

Christophe

> ---
>   include/crypto/cbc.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
> index f5b8bfc22e6d..260096bcf99b 100644
> --- a/include/crypto/cbc.h
> +++ b/include/crypto/cbc.h
> @@ -113,7 +113,7 @@ static inline int crypto_cbc_decrypt_inplace(
>   	unsigned int bsize = crypto_skcipher_blocksize(tfm);
>   	unsigned int nbytes = walk->nbytes;
>   	u8 *src = walk->src.virt.addr;
> -	u8 last_iv[bsize];
> +	u8 last_iv[CRYPTO_ALG_MAX_BLOCKSIZE];
>   
>   	/* Start of the last block. */
>   	src += nbytes - (nbytes & (bsize - 1)) - bsize;
> 
