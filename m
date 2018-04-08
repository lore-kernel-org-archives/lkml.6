Return-Path: <kernel-hardening-return-12885-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49NbHc8QllBEr6TSnI7u8mcBy5fIlnVjLAO9WeE5CBnoc1tQzqTtI+7uPJ0j5zKpSk0n27g
ARC-Seal: i=1; a=rsa-sha256; t=1523157430; cv=none;
        d=google.com; s=arc-20160816;
        b=pRxQVKf5MCgcv8rd35nCFDtD6Ek2ESmgqI1O1YUT/oCYXBY8za2GfMoPeGGvF83TYs
         uC5+LtCG87IPHTt8UwJLCfTwUM75QQZPtNR23b8ZWvWWjSxeBZXAJpu71nnr1ilZRR14
         eFqIz2I+PyMuhUOPwCH3TjG/8NgH+5Qay8ExfEeLwzl2d901aucFregdRKHg7nAQk+vH
         Y1xQqeX4rsGabu7MUFsLO073DbRyo4R/Whn3tMFqpnSStu4yWkr/sq46ExymW83KiGNz
         oXAmIU551Y6ztGFe0MEiywkdjUfcDH+ig9vaV/ULeMgebauwjN+/E0SmsjuWXHOz2z2C
         hGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=BCklTb1ilLtiiibpZEmX1ZzWKMK5NdnLVRkDECek0Os=;
        b=J2gsv7LSHjiAWq2hTG+akGJKRSc4rAlPHRO6XPzWmBhV7lH0rm/i7Ms2X+hjAlxqVn
         QUagM25WkX/coF35jiXLDZEEih0yFiyx5/nC6ORtGiXIj//SeGtBBYVKVoLJ87E8ud2l
         Cgn1D9dCSjXjo/Z8b+T9IlrLxpvlSgZlxNYRsXZkVAj4fYtCq+wreuOyjK7sBK8YPjAN
         Wy2yMi71+vryXBDlA8Aq6fEvO6+Ichfp4r2JemNJLim5S2aCpOTS3iWOMXcxo45PHFdl
         0mFcFaiZfQtfwqtzW+arxWS7p7BuBvmQBGfkZHVBxbPvFVT+aa/RuwU5gj13LSGyKvlP
         umWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12885-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12885-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12885-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12885-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 8 Apr 2018 11:16:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 3/6] crypto: api - avoid VLA use
Message-ID: <20180408031619.GB25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597146325863800526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 08:38:20PM +0200, Salvatore Mesoraca wrote:
>
>  int crypto_init_cipher_ops(struct crypto_tfm *tfm)
>  {
> +	const unsigned long alignmask = crypto_tfm_alg_alignmask(tfm);
> +	const unsigned int size = crypto_tfm_alg_blocksize(tfm);
>  	struct cipher_tfm *ops = &tfm->crt_cipher;
>  	struct cipher_alg *cipher = &tfm->__crt_alg->cra_cipher;
>  
> +	if (size > MAX_BLOCKSIZE || alignmask > MAX_ALIGNMASK)
> +		return -EINVAL;
> +

This check should be done when the algorithm is registered.  Perhaps
crypto_check_alg.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
