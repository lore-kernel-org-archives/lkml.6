Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8670C6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE8E20843
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 22:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGE2/mgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE8E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbeKDIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbeKDIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:05:18 -0500
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net [67.185.97.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C69622081F;
        Sat,  3 Nov 2018 22:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541285556;
        bh=MtE0eqAmwtZ0PllBYVlIge75laabJ6C5nZl96vxpRaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGE2/mgAX/+I4avS4cFwuUboNZmvcZscpG+dl9X4AxBaCv9q2I2K6LBtUYWiPNgJ0
         G49edVakUfPFcbW5GDGYTEfnU/7fD9Wt5hTZ8tue0B1fpohF2QOFCI1P7pAHtFnNT7
         M8jgVs73Qq0EtfOPmCwCTWi8Udmd96VL4cLwsxJQ=
Date:   Sat, 3 Nov 2018 15:52:35 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        nhorman@tuxdriver.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] crypto: Implement a generic crypto statistics
Message-ID: <20181103225234.GD808@sol.localdomain>
References: <1537351855-16618-1-git-send-email-clabbe@baylibre.com>
 <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537351855-16618-2-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 10:10:54AM +0000, Corentin Labbe wrote:
> diff --git a/include/uapi/linux/cryptouser.h b/include/uapi/linux/cryptouser.h
> index 19bf0ca6d635..6dafbc3e4414 100644
> --- a/include/uapi/linux/cryptouser.h
> +++ b/include/uapi/linux/cryptouser.h
> @@ -29,6 +29,7 @@ enum {
>  	CRYPTO_MSG_UPDATEALG,
>  	CRYPTO_MSG_GETALG,
>  	CRYPTO_MSG_DELRNG,
> +	CRYPTO_MSG_GETSTAT,
>  	__CRYPTO_MSG_MAX
>  };
>  #define CRYPTO_MSG_MAX (__CRYPTO_MSG_MAX - 1)
> @@ -50,6 +51,16 @@ enum crypto_attr_type_t {
>  	CRYPTOCFGA_REPORT_AKCIPHER,	/* struct crypto_report_akcipher */
>  	CRYPTOCFGA_REPORT_KPP,		/* struct crypto_report_kpp */
>  	CRYPTOCFGA_REPORT_ACOMP,	/* struct crypto_report_acomp */
> +	CRYPTOCFGA_STAT_LARVAL,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_HASH,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_BLKCIPHER,	/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_AEAD,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_COMPRESS,	/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_RNG,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_CIPHER,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_AKCIPHER,	/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_KPP,		/* struct crypto_stat */
> +	CRYPTOCFGA_STAT_ACOMP,		/* struct crypto_stat */
>  	__CRYPTOCFGA_MAX
>  
>  #define CRYPTOCFGA_MAX (__CRYPTOCFGA_MAX - 1)
> @@ -65,6 +76,47 @@ struct crypto_user_alg {
>  	__u32 cru_flags;
>  };
>  
> +struct crypto_stat {
> +	char type[CRYPTO_MAX_NAME];
> +	union {
> +		__u32 stat_encrypt_cnt;
> +		__u32 stat_compress_cnt;
> +		__u32 stat_generate_cnt;
> +		__u32 stat_hash_cnt;
> +		__u32 stat_setsecret_cnt;
> +	};
> +	union {
> +		__u64 stat_encrypt_tlen;
> +		__u64 stat_compress_tlen;
> +		__u64 stat_generate_tlen;
> +		__u64 stat_hash_tlen;
> +	};
> +	union {
> +		__u32 stat_akcipher_err_cnt;
> +		__u32 stat_cipher_err_cnt;
> +		__u32 stat_compress_err_cnt;
> +		__u32 stat_aead_err_cnt;
> +		__u32 stat_hash_err_cnt;
> +		__u32 stat_rng_err_cnt;
> +		__u32 stat_kpp_err_cnt;
> +	};
> +	union {
> +		__u32 stat_decrypt_cnt;
> +		__u32 stat_decompress_cnt;
> +		__u32 stat_seed_cnt;
> +		__u32 stat_generate_public_key_cnt;
> +	};
> +	union {
> +		__u64 stat_decrypt_tlen;
> +		__u64 stat_decompress_tlen;
> +	};
> +	union {
> +		__u32 stat_verify_cnt;
> +		__u32 stat_compute_shared_secret_cnt;
> +	};
> +	__u32 stat_sign_cnt;
> +};
> +

All the 32-bit fields need to be 64-bit.  In some cases, UINT32_MAX crypto
operations can be done in seconds.

It's also weird that everything shares the same crypto_stat structure.  I think
there should be a different struct for each algorithm type, like there is for
the existing crypto_user algorithm reporting.  In fact you are kind of already
doing that since the struct is loaded full of unions.  But it would be much
cleaner to use actually different structures.

- Eric
