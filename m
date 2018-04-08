Return-Path: <kernel-hardening-return-12894-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/vCC+I0CD8ZC0RCJOfn1XlWUBUMdthc9OXK2PpcLpOQKy6GzKv/wgOqHn88jrb5L5cPbXF
ARC-Seal: i=1; a=rsa-sha256; t=1523179362; cv=none;
        d=google.com; s=arc-20160816;
        b=vrjamPLUYZxVHMqCVzQYxC5k6t07bOFMJ+RA/otytDYV8bHabLnwg/2H9Opmx9kX4y
         6X633bo1xSp/OsYTY4oIm5pUio8xD7u/w6tNzjCDO3FS10auhQ8pO3WShwk+tqhvOo7Z
         nsXO18zB3KDfRH7WtkDmYljddxfYIR/+2qlV+kqa2GQxFB8+2rGmpk3gEywDtkbA5DMT
         i5nw6WexpQtOwWYfEQreI8fVAhM3jq6qaJJbpWWWQ24J1W31lxd4dRnXcWd5cR2NQ5h2
         e1qMllY6pWB9fe9oHL6QHMqx+LUk/F06yQZCX1MIPpvXTpjg2g4qU3cHjzollY/Qv4iy
         XfCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=z79Dd8v+HhnfiHCiNXBuuEruYs2tAkmvkBfxiY6aSoM=;
        b=SOg+glbBBbc2blNDI8DBzvDYaZ3P8b5g9BxZoLDdrPRHr2pFJ2/E9XiAu+xRhZbyE8
         /x08RHUyUQlomaozw95xD4cGGnapx+M7N2Wx1gnEYC0ZKdSROdan4Uxu9GRwrsQzgJtM
         Roy7vxgXhv2sNKM0i2GQo4cAlTI+2CxvVG4xoNOP/W5JiI4wFfwzL1SvB2YrvO0xWyFW
         2Vp2M9L/aHDOtUhm+VkxhNME08QHdnZ2mP+UmQeGSFo1BWZ7nNq2EEiMth41OABT0oZn
         nk5gJq4FtMv/xRpU2O/0DSYaMimFhCOHQOjYLWE9B5+DDQlyCzr0iwOQYGNO6WSG/oqD
         wgjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12894-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12894-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12894-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12894-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 8 Apr 2018 17:22:19 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 3/6] crypto: api - avoid VLA use
Message-ID: <20180408092219.s24ymooq7afu43c2@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-4-git-send-email-s.mesoraca16@gmail.com>
 <20180408031619.GB25197@gondor.apana.org.au>
 <CAJHCu1LiPkDzL8rQMDdope=di+TZxz6gXuMKFQi_YpkSNquJ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHCu1LiPkDzL8rQMDdope=di+TZxz6gXuMKFQi_YpkSNquJ_g@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113773763364977?=
X-GMAIL-MSGID: =?utf-8?q?1597169322888107467?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 08, 2018 at 11:07:12AM +0200, Salvatore Mesoraca wrote:
>
> > This check should be done when the algorithm is registered.  Perhaps
> > crypto_check_alg.
> 
> Please correct me if I'm wrong:
> isn't crypto_check_alg invoked also during hashing algorithm registration?
> In this patch-set I'm dealing only with ciphers, because the maximum
> block size (16)
> is relatively small and it's also the most common block size with
> ciphers (maybe I should
> have explicitly referenced ciphers in the macro names, my bad).
> I don't think that it would be OK to use a similar approach for hashes
> too, because some
> of them have block size >= 1024 bytes.

Yes we want to make it for ciphers only even if we move it to
crypto_check_alg.

For a legacy type like cipher cou can do it by

	if (!alg->cra_type && (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) ==
			      CRYPTO_ALG_TYPE_CIPHER)
		do_cipher_specific_check();

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
