Return-Path: <kernel-hardening-return-12617-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELt+XjWXZjmZWYmfCSPMz7fQlDzg7ngT13vd0hlhbagCnLiDhcmBwugZESvKKRKwwhPEWTbU
ARC-Seal: i=1; a=rsa-sha256; t=1521078723; cv=none;
        d=google.com; s=arc-20160816;
        b=YBSV0TBNJXbY97pBBmn9OorZ3oclktiialhB5xLS6XW/je+5S5VIwyWK2rqJLWRHZD
         YeaVM6ecHsQ8onzZswfU37wPYfWuQJZrkh5N6lX6EpK6K49O7fZcUrPpXKaMHogvPB8E
         d/0otcFttrWOXNyt2VIn1NPtDiM6dF8C/KhySS5w8b6U6bBmpfRvOy4UAbWU3NYrYR+G
         tYbrKuglmif5sdqqNd+GYePc3c+syHpadfuSnMpWFmhNhMl9JrY5Cpjylj4DIVKgm1ja
         XarBO23T2gCoZPvgxiEiU/xFFczSX4qQYy7bC6468VcT0hx1GZcFaJmg8ZZJbinZTyYm
         q19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=LwV6AisYl9ytSu3en+9dV0aANltLAbATCF63cQZ3GCs=;
        b=V6k6Tw1rdjJAggpJMiBEWWYr883PNp2CekE58lhVNBcOIA2lU1OWx2UmQGtq4K8F56
         glluMdlP0FrWjCyfdDJlp2h5cYEp/9Em+T/RA49VjY0ye5cdIdOz3xhgrj0IY1VjvVC+
         8of/XMDAOpFAI+uPyB6RSy68KNsoiS5AZY+Vb4ZHdnFwZFkmBgWmd7FOwWOuGCgKE5/D
         GGB/ftHMKxMAbono/N2rD35yvRl46EZTRynCXI2CJeSgk5qP8WYkb7OOhuGTnHdkIUMY
         GNZTR03/wrR7KXgaWuGNk1jpIyegq5HkbhLpw1frTqyPpQIfY7MlAtpBzvRvhwbYXvyN
         rZDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1gvuOLH;
       spf=pass (google.com: domain of kernel-hardening-return-12617-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12617-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=g1gvuOLH;
       spf=pass (google.com: domain of kernel-hardening-return-12617-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12617-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 18:51:39 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/2] big key: get rid of stack array allocation
Message-ID: <20180315015139.GA641@zzz.localdomain>
References: <20180313042907.29598-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313042907.29598-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795410426531293?=
X-GMAIL-MSGID: =?utf-8?q?1594966644067575995?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:29:06PM -0600, Tycho Andersen wrote:
> We're interested in getting rid of all of the stack allocated arrays in the
> kernel [1]. This patch removes one in keys by switching to malloc/free.
> Note that we use kzalloc, to avoid leaking the nonce. I'm not sure this is
> really necessary, but extra paranoia seems prudent.
> 
> Manually tested using the program from the add_key man page to trigger
> big_key.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: David Howells <dhowells@redhat.com>
> CC: James Morris <jmorris@namei.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  security/keys/big_key.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index fa728f662a6f..70f9f785c59d 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -108,13 +108,18 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
>  	 * an .update function, so there's no chance we'll wind up reusing the
>  	 * key to encrypt updated data. Simply put: one key, one encryption.
>  	 */
> -	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
> +	u8 *zero_nonce;
> +
> +	zero_nonce = kzalloc(crypto_aead_ivsize(big_key_aead), GFP_KERNEL);
> +	if (!zero_nonce)
> +		return -ENOMEM;
>  
>  	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
> -	if (!aead_req)
> +	if (!aead_req) {
> +		kfree(zero_nonce);
>  		return -ENOMEM;
> +	}
>  
> -	memset(zero_nonce, 0, sizeof(zero_nonce));
>  	aead_request_set_crypt(aead_req, buf->sg, buf->sg, datalen, zero_nonce);
>  	aead_request_set_callback(aead_req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
>  	aead_request_set_ad(aead_req, 0);
> @@ -131,6 +136,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
>  error:
>  	mutex_unlock(&big_key_aead_lock);
>  	aead_request_free(aead_req);
> +	kzfree(zero_nonce);
>  	return ret;

A dynamic allocation here doesn't make sense -- the algorithm is hard-coded to
AES-GCM, so the IV size is fixed.  You should just include <crypto/gcm.h> and
use GCM_AES_IV_LEN.  As a sanity check you can add
'BUG_ON(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_LEN' to big_key_init().

kzfree() also doesn't make sense since the nonce is not secret information.

Thanks,

Eric
