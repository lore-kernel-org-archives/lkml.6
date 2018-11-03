Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922EBC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BE42081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbXeG5Qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47BE42081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbeKDHUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 02:20:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbeKDHUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 02:20:32 -0500
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB0522081F;
        Sat,  3 Nov 2018 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541282877;
        bh=gIP1xwrTfHM6nDb1sJPzT56KtRWwnQQTgfIoPQFYnME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cbXeG5QjgR0KMyZ6Vr5UW8utkFiaezbhmLI86C74Z7zNlL+OKErhq/RFPXRR7L2oK
         fP8j38xMdcYpY6hfESH9qEXRg8C7kIC2LhmPd6i/PDB4wDS5/HQIbgVllzp6VZKvkT
         xgsDLtPYaiYK/b5Ls/1JlvFrZEv631DBcDX3PpX8=
Date:   Sat, 3 Nov 2018 15:07:55 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     dan.carpenter@oracle.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: crypto_user_stat: Zeroize whole structure given
 to user space
Message-ID: <20181103220553.GA808@sol.localdomain>
References: <1539952045-18784-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539952045-18784-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:27:25PM +0000, Corentin Labbe wrote:
> For preventing un-initilized data to be given to user-space (and so leak
> potential useful data), the crypto_stat structure must be correctly
> initialised.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: cac5818c25d0 ("crypto: user - Implement a generic crypto statistics")
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  crypto/crypto_user_stat.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/crypto/crypto_user_stat.c b/crypto/crypto_user_stat.c
> index 021ad06bbb62..9990c599f648 100644
> --- a/crypto/crypto_user_stat.c
> +++ b/crypto/crypto_user_stat.c
> @@ -37,6 +37,7 @@ static int crypto_report_aead(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&raead, 0, sizeof(struct crypto_stat));
>  	strncpy(raead.type, "aead", sizeof(raead.type));
>  
>  	v32 = atomic_read(&alg->encrypt_cnt);
> @@ -65,6 +66,7 @@ static int crypto_report_cipher(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rcipher, 0, sizeof(struct crypto_stat));
>  	strlcpy(rcipher.type, "cipher", sizeof(rcipher.type));
>  
>  	v32 = atomic_read(&alg->encrypt_cnt);
> @@ -93,6 +95,7 @@ static int crypto_report_comp(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rcomp, 0, sizeof(struct crypto_stat));
>  	strlcpy(rcomp.type, "compression", sizeof(rcomp.type));
>  	v32 = atomic_read(&alg->compress_cnt);
>  	rcomp.stat_compress_cnt = v32;
> @@ -120,6 +123,7 @@ static int crypto_report_acomp(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&racomp, 0, sizeof(struct crypto_stat));
>  	strlcpy(racomp.type, "acomp", sizeof(racomp.type));
>  	v32 = atomic_read(&alg->compress_cnt);
>  	racomp.stat_compress_cnt = v32;
> @@ -147,6 +151,7 @@ static int crypto_report_akcipher(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rakcipher, 0, sizeof(struct crypto_stat));
>  	strncpy(rakcipher.type, "akcipher", sizeof(rakcipher.type));
>  	v32 = atomic_read(&alg->encrypt_cnt);
>  	rakcipher.stat_encrypt_cnt = v32;
> @@ -177,6 +182,7 @@ static int crypto_report_kpp(struct sk_buff *skb, struct crypto_alg *alg)
>  	struct crypto_stat rkpp;
>  	u32 v;
>  
> +	memset(&rkpp, 0, sizeof(struct crypto_stat));
>  	strlcpy(rkpp.type, "kpp", sizeof(rkpp.type));
>  
>  	v = atomic_read(&alg->setsecret_cnt);
> @@ -203,6 +209,7 @@ static int crypto_report_ahash(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rhash, 0, sizeof(struct crypto_stat));
>  	strncpy(rhash.type, "ahash", sizeof(rhash.type));
>  
>  	v32 = atomic_read(&alg->hash_cnt);
> @@ -227,6 +234,7 @@ static int crypto_report_shash(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rhash, 0, sizeof(struct crypto_stat));
>  	strncpy(rhash.type, "shash", sizeof(rhash.type));
>  
>  	v32 = atomic_read(&alg->hash_cnt);
> @@ -251,6 +259,7 @@ static int crypto_report_rng(struct sk_buff *skb, struct crypto_alg *alg)
>  	u64 v64;
>  	u32 v32;
>  
> +	memset(&rrng, 0, sizeof(struct crypto_stat));
>  	strncpy(rrng.type, "rng", sizeof(rrng.type));
>  
>  	v32 = atomic_read(&alg->generate_cnt);
> -- 
> 2.18.1
> 

There are two more info leaks in the file that this doesn't fix.  I sent out a
fixed version here:

	https://patchwork.kernel.org/patch/10666775/

... as part of the series "crypto: crypto_user reporting fixes and cleanups".

- Eric
