Return-Path: <kernel-hardening-return-12614-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs1DShSo8U7xztFnaLWTpTI81uT6G3Mp79HyTualxnLba7USkSTT8R52Qdz5rgbZlgc0Hta
ARC-Seal: i=1; a=rsa-sha256; t=1521052343; cv=none;
        d=google.com; s=arc-20160816;
        b=XtzqxbOIwPqY5xGzdSmoXMNh8i2p++bdoCS1REiQtYtgTUIWvmKrrYH/uNiaEUKYnD
         0VpmGC2SBm3vhi6PoNpOjMoMv8Vnmo0HUGPlMt85NFnkChJicWshFd+DHTXsyJoCXRpS
         IrGMlfLUbNOnzj3/r6mixA+qpjN9ApMsAWVEvsJJAb593K7ld0piLvldRJerUv9yG6gF
         npLHxKZD55SVCNudl9J+QKZzypL0guwAFziTf9pD8dq6Inl4eEFn667qTOHGe+eTBTFT
         NERLGiksEXCOa8OOJ5tH3S8EM82LIWh4F/kKwF0SSBwLiyFo/Qf6CHwKB7ddmR4EOfWR
         INWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=ZRR9oW93e2doPJGvMvssT2Dovtx0fD9pmQjDrsFof2E=;
        b=qXvYqCsIGl8j4yvRXo+zA6IKeyyuwfHkJPpfhCjWJIdm0Kxo+Yd9JsMik79hW7kWsm
         LrN+pTRFYhiLpggaI4pn9ZE3tHyVYN3j9dpHrbO5ObJS/PjDEHxPXH2b8KAldK3uWAZ+
         OFWPXBzpDDegevHGJJu7rCawMubpY9QBsbG7s4TmKs1ux1XuoP5I18n+x5B4c5vKps2j
         iw1h9qXC6bnrMI9+8xrqZ8rZdX63AofiJ/lWhi8wr89D77CkTSPSnzCzaBewHQaUCmsc
         +uv04bgw0Gyhu9tkZqo4TqUHmdNpTbHUHv9955SU8+iJi0aBgLCYdc5PiYzcoZOt2Lxp
         oxog==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MieebkXd;
       spf=pass (google.com: domain of kernel-hardening-return-12614-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12614-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MieebkXd;
       spf=pass (google.com: domain of kernel-hardening-return-12614-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12614-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 11:31:57 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] crypto: ctr: avoid VLA use
Message-ID: <20180314183157.GA183724@gmail.com>
References: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521033450-14447-1-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594919197404593745?=
X-GMAIL-MSGID: =?utf-8?q?1594938982323198855?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:17:30PM +0100, Salvatore Mesoraca wrote:
> All ciphers implemented in Linux have a block size less than or
> equal to 16 bytes and the most demanding hw require 16 bits
> alignment for the block buffer.
> We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bits
> alignment, unless the architecture support efficient unaligned
> accesses.
> We also check, at runtime, that our assumptions still stand,
> possibly dynamically allocating a new buffer, just in case
> something changes in the future.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
> 
> Notes:
>     Can we maybe skip the runtime check?
> 
>  crypto/ctr.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/crypto/ctr.c b/crypto/ctr.c
> index 854d924..f37adf0 100644
> --- a/crypto/ctr.c
> +++ b/crypto/ctr.c
> @@ -35,6 +35,16 @@ struct crypto_rfc3686_req_ctx {
>  	struct skcipher_request subreq CRYPTO_MINALIGN_ATTR;
>  };
>  
> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> +#define DECLARE_CIPHER_BUFFER(name) u8 name[16]
> +#else
> +#define DECLARE_CIPHER_BUFFER(name) u8 __aligned(16) name[16]
> +#endif
> +
> +#define CHECK_CIPHER_BUFFER(name, size, align)			\
> +	likely(size <= sizeof(name) &&				\
> +	       name == PTR_ALIGN(((u8 *) name), align + 1))
> +
>  static int crypto_ctr_setkey(struct crypto_tfm *parent, const u8 *key,
>  			     unsigned int keylen)
>  {
> @@ -52,22 +62,35 @@ static int crypto_ctr_setkey(struct crypto_tfm *parent, const u8 *key,
>  	return err;
>  }
>  
> -static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
> -				   struct crypto_cipher *tfm)
> +static int crypto_ctr_crypt_final(struct blkcipher_walk *walk,
> +				  struct crypto_cipher *tfm)
>  {
>  	unsigned int bsize = crypto_cipher_blocksize(tfm);
>  	unsigned long alignmask = crypto_cipher_alignmask(tfm);
>  	u8 *ctrblk = walk->iv;
> -	u8 tmp[bsize + alignmask];
> -	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
>  	u8 *src = walk->src.virt.addr;
>  	u8 *dst = walk->dst.virt.addr;
>  	unsigned int nbytes = walk->nbytes;
> +	DECLARE_CIPHER_BUFFER(tmp);
> +	u8 *keystream, *tmp2;
> +
> +	if (CHECK_CIPHER_BUFFER(tmp, bsize, alignmask))
> +		keystream = tmp;
> +	else {
> +		tmp2 = kmalloc(bsize + alignmask, GFP_ATOMIC);
> +		if (!tmp2)
> +			return -ENOMEM;
> +		keystream = PTR_ALIGN(tmp2 + 0, alignmask + 1);
> +	}
>  
>  	crypto_cipher_encrypt_one(tfm, keystream, ctrblk);
>  	crypto_xor_cpy(dst, keystream, src, nbytes);
>  
>  	crypto_inc(ctrblk, bsize);
> +
> +	if (unlikely(keystream != tmp))
> +		kfree(tmp2);
> +	return 0;
>  }

This seems silly; isn't the !CHECK_CIPHER_BUFFER() case unreachable?  Did you
even test it?  If there's going to be limits, the crypto API ought to enforce
them when registering an algorithm.

A better alternative may be to move the keystream buffer into the request
context, which is allowed to be variable length.  It looks like that would
require converting the ctr template over to the skcipher API, since the
blkcipher API doesn't have a request context.  But my understanding is that that
will need to be done eventually anyway, since the blkcipher (and ablkcipher) API
is going away.  I converted a bunch of algorithms recently and I can look at the
remaining ones in crypto/*.c if no one else gets to it first, but it may be a
little while until I have time.

Also, I recall there being a long discussion a while back about how
__aligned(16) doesn't work on local variables because the kernel's stack pointer
isn't guaranteed to maintain the alignment assumed by the compiler (see commit
b8fbe71f7535)...

Eric
