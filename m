Return-Path: <kernel-hardening-return-13104-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/4SptYUTeag90HdK83FkC1RD9GU+X8EGWeGqNZbTa7i1w/1VGl/oKRA+1KBayVxaw9EVgQ
ARC-Seal: i=1; a=rsa-sha256; t=1524545355; cv=none;
        d=google.com; s=arc-20160816;
        b=bNi/ge0YD0B9uH6ozoQuyImZ4ZWHf2hjbQNNS7syQJfbOssfROH7xWdZaUOkcc/PpG
         LZoqNpxnb1mbNL0b2huzc8EjBfBT3uOVfAlMepC/mmC1RERadQGi39AtH7e0AfPJ5AMa
         0wC3Rwh3hlACMEpAGCqIcLm3t55h4Xb87Q18jz/AWELizhnDH2a1dukaTA1R10wI1KfZ
         4Yng7GcvgaFn2KsaHs1BENiMtk7pHzUUc67J7jW8fRpQUP9cBsBLIYm+pU22hxLs01RZ
         lvzS607kWl6tD5XangDgbxGGU/jeC9rKZBS17yv2oIdWHDN3ZxT4weIeobIfyTbq8Lpl
         2CFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=f0WDbUWyWUY4pixtq78Efq/RSe+g3NjOSUdppJWV/WI=;
        b=hTJQSslhZpzpWQdYFWVM0pvs7lK9pkMaBVXqtqV17E/6qTjiyrtP5xp8EDfDR1RID2
         YLwUp6sB0HQqq/tWOk2ragvhk8/vVVul5Wuik9I9ENEGIXzjKVby0uFTqqG9jGt0x5wd
         zuZxPRw0Y6ejdvBqH5lNgK6n0DdMSgBk8T2zm2zLqr8XOVxbR+AFvA6F+cefpLVHb3xW
         b9+0iKXIe9ifc9dHtmb3PytkfHzXXEjNBSbT01yl9XJM3fvELUmkoBeHeiZ341Twl496
         AH5ybmnJqIBygjmEv15qR9RDuhl7DScS8FaU03fOW4tr75JsYZEE/jgIafPHuhKRAs53
         5u9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PzO6ycnY;
       spf=pass (google.com: domain of kernel-hardening-return-13104-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13104-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=PzO6ycnY;
       spf=pass (google.com: domain of kernel-hardening-return-13104-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13104-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 23 Apr 2018 21:50:15 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/3] big key: get rid of stack array allocation
Message-ID: <20180424045015.GA4281@sol.localdomain>
References: <20180424010321.14739-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424010321.14739-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598589451187807410?=
X-GMAIL-MSGID: =?utf-8?q?1598601670131967247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Tycho,

On Mon, Apr 23, 2018 at 07:03:19PM -0600, Tycho Andersen wrote:
> We're interested in getting rid of all of the stack allocated arrays in the
> kernel [1]. This patch simply hardcodes the iv length to match that of the
> hardcoded cipher.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> v2: hardcode the length of the nonce to be the GCM AES IV length, and do a
>     sanity check in init(), Eric Biggers
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> CC: David Howells <dhowells@redhat.com>
> CC: James Morris <jmorris@namei.org>
> CC: "Serge E. Hallyn" <serge@hallyn.com>
> CC: Jason A. Donenfeld <Jason@zx2c4.com>
> CC: Eric Biggers <ebiggers3@gmail.com>
> ---
>  security/keys/big_key.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 933623784ccd..75c46786a166 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -22,6 +22,7 @@
>  #include <keys/user-type.h>
>  #include <keys/big_key-type.h>
>  #include <crypto/aead.h>
> +#include <crypto/gcm.h>
>  
>  struct big_key_buf {
>  	unsigned int		nr_pages;
> @@ -109,7 +110,7 @@ static int big_key_crypt(enum big_key_op op, struct big_key_buf *buf, size_t dat
>  	 * an .update function, so there's no chance we'll wind up reusing the
>  	 * key to encrypt updated data. Simply put: one key, one encryption.
>  	 */
> -	u8 zero_nonce[crypto_aead_ivsize(big_key_aead)];
> +	u8 zero_nonce[GCM_AES_IV_SIZE];
>  
>  	aead_req = aead_request_alloc(big_key_aead, GFP_KERNEL);
>  	if (!aead_req)
> @@ -425,6 +426,12 @@ static int __init big_key_init(void)
>  		pr_err("Can't alloc crypto: %d\n", ret);
>  		return ret;
>  	}
> +
> +	if (unlikely(crypto_aead_ivsize(big_key_aead) != GCM_AES_IV_SIZE)) {
> +		WARN(1, "big key algorithm changed?");
> +		return -EINVAL;
> +	}
> +

'big_key_aead' needs to be freed on error.

	err = -EINVAL;
	goto free_aead;

Also how about defining the IV size next to the algorithm name?
Then all the algorithm details would be on adjacent lines:

static const char big_key_alg_name[] = "gcm(aes)";
#define BIG_KEY_IV_SIZE         GCM_AES_IV_SIZE

- Eric
