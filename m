Return-Path: <kernel-hardening-return-12511-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvc2FTbAVuDw2Zw+ajUinsjh6/COp1KwElClkJ/4S67Uz9jHPnaGCfJRsdl9hakbYdinX7i
ARC-Seal: i=1; a=rsa-sha256; t=1520962762; cv=none;
        d=google.com; s=arc-20160816;
        b=ekXyVB1BVb4dFtV8mhBpw2BUpi6DDTYn4PHrmWekchC2JKCa1gJ75dIq2rYU7h43Go
         YyV4Sf+PlSMpyt2HrEKg+4PKAlFkIxbYwteX6ODztQ5C2mWQwqTo/fJrgtqjCWaXRC6Y
         K/SkhEAhs7lCv9Y3G6XCEiBNc/YC6dImKIEzb1RiOYe1yqxIefYwavsPUHni4WC6neqF
         QLYg4kdH1QQIaipYX7upS//4emgtFpU8//6BDCh0HcLYeR07fFzmg2t2S3fbj9UyeG5x
         JgyPW1iu/6nZjzS6u9Pj8Cw+KnSxUMJqjRWaumkRoWXkY1DnC15PTM6T5YZfurTd2A8t
         4+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=OGorCORTG1h99xv6KxW/Vx2q7ldQEou7Bq+yROgH/y0=;
        b=zfg/hTssM71ai4JUeXVoINC47AlSC211BPsuHbMwOm4+luUApoOmcowfnkzepNnone
         jKovTbARZsZmEAqEILZmv8wnsjBRNQDlAyGSLmeRW1o7ixBWoLEGOMFNJfF9lR/Ve93p
         E0/LYoKPWyBCPnoZA6JzBTvkvNoPaUmVB9peACyNcvBzaqSYfBxmU4jIDZiN3z8BgVlA
         +ullqR7tg91vIU+IHss0BfKSQGdafmGwopdhNR5TKRQAYwCteWGn4ZfO0xC2xoJc18wJ
         /8CtvMZJbD+s4O1e6dNSLYohnpIAVxJyGvjRLRbXHQd2ddFFyo2n9lb2Lx4Fz3+b7lqz
         Yq8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12511-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12511-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12511-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12511-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 13 Mar 2018 12:39:03 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 2/2] dh key: get rid of stack array allocation
Message-ID: <20180313173903.GA19174@mail.hallyn.com>
References: <20180313042907.29598-1-tycho@tycho.ws>
 <20180313042907.29598-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313042907.29598-2-tycho@tycho.ws>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795386978188484?=
X-GMAIL-MSGID: =?utf-8?q?1594845049236197740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Tycho Andersen (tycho@tycho.ws):
> Similarly to the previous patch, we would like to get rid of stack
> allocated arrays: https://lkml.org/lkml/2018/3/7/621
> 
> In this case, we can also use a malloc style approach to free the temporary
> buffer, being careful to also use kzfree to free them (indeed, at least one
> of these has a memzero_explicit, but it seems like maybe they both
> should?).
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: David Howells <dhowells@redhat.com>
> CC: James Morris <jmorris@namei.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>

Acked-by: Serge Hallyn <serge@hallyn.com>

for both, thanks.

> ---
>  security/keys/dh.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/security/keys/dh.c b/security/keys/dh.c
> index d1ea9f325f94..f02261b24759 100644
> --- a/security/keys/dh.c
> +++ b/security/keys/dh.c
> @@ -162,19 +162,27 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
>  			goto err;
>  
>  		if (zlen && h) {
> -			u8 tmpbuffer[h];
> +			u8 *tmpbuffer;
>  			size_t chunk = min_t(size_t, zlen, h);
> -			memset(tmpbuffer, 0, chunk);
> +
> +			err = -ENOMEM;
> +			tmpbuffer = kzalloc(chunk, GFP_KERNEL);
> +			if (!tmpbuffer)
> +				goto err;
>  
>  			do {
>  				err = crypto_shash_update(desc, tmpbuffer,
>  							  chunk);
> -				if (err)
> +				if (err) {
> +					kzfree(tmpbuffer);
>  					goto err;
> +				}
>  
>  				zlen -= chunk;
>  				chunk = min_t(size_t, zlen, h);
>  			} while (zlen);
> +
> +			kzfree(tmpbuffer);
>  		}
>  
>  		if (src && slen) {
> @@ -184,13 +192,20 @@ static int kdf_ctr(struct kdf_sdesc *sdesc, const u8 *src, unsigned int slen,
>  		}
>  
>  		if (dlen < h) {
> -			u8 tmpbuffer[h];
> +			u8 *tmpbuffer;
> +
> +			err = -ENOMEM;
> +			tmpbuffer = kzalloc(h, GFP_KERNEL);
> +			if (!tmpbuffer)
> +				goto err;
>  
>  			err = crypto_shash_final(desc, tmpbuffer);
> -			if (err)
> +			if (err) {
> +				kzfree(tmpbuffer);
>  				goto err;
> +			}
>  			memcpy(dst, tmpbuffer, dlen);
> -			memzero_explicit(tmpbuffer, h);
> +			kzfree(tmpbuffer);
>  			return 0;
>  		} else {
>  			err = crypto_shash_final(desc, dst);
> -- 
> 2.15.1
