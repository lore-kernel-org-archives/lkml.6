Return-Path: <kernel-hardening-return-12618-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuROVXx9TJYP/iAcG/9HrtpH3ChzZPWxM8q37cGMprX42f9AzQ2e1Ga6w0rimoOUouh5Y7K
ARC-Seal: i=1; a=rsa-sha256; t=1521080496; cv=none;
        d=google.com; s=arc-20160816;
        b=yOnx8vhgDABW7XDO4gsNUrDBe0+9Ms9CpcNFOhE75kuffu/o1sx/+tSanv3S+HEBtr
         RBt2iaMkYm0DgIrw9qqwY2LN4vwLHeNVdimzomfgeZkJhYOicM+QCl3xbX11w2JvBwUz
         XrZZd5KmyH8R1V2mClj61iDJrC7MHg5A1v3tnWrCSEgf83UGeZR5phYmQJUOibbMTLxE
         Tl6H3JN+lHbvj0H+ob0ETbU/SrGvH0HugT+4lr4IlRlpvH9R1oncZgG1wTn+sA2NuAjN
         IVETUwHBeL0TKSmyngNS5H79NLIiJMtVfabf6uJmelNCkakxPqxM+F95ptfePlk8CK0q
         Vl+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=WF9GhqY4W9FduHQpGRK1dCrhzauUTMJnGfiYvkwadug=;
        b=hivjdgv+qM1KeaMjpQvmf6fCB81mTnC58eehOPSANezpkwFNyP2zgxMtQ57y+uaW6K
         BUZQjZ01WTuUaK5Ywy4IWuXf6K9qcMGZsds5+fGNYX6RMnBumgcrzF0w+T/68OrBvmIU
         5GChA51QPPjbZzaxRtQ73HHF/xOpr3Vu+67ZZTVYMvpCXx1mj7y8XhJSHiODnQIjzaN9
         3uFmoAQyp/VX9LF71C5ISmYhNwzwnr0kPes2ceXCi4OdRUj07Mpm9gq2OH1K7HtJ+y4R
         Yke+B365E2TH9VgJhfK54jxRD76K2O1zjitX9r4YXhKV8e++4u0SiMWXyBBBUMZyIpr4
         aYmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dt7fBHdA;
       spf=pass (google.com: domain of kernel-hardening-return-12618-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12618-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=dt7fBHdA;
       spf=pass (google.com: domain of kernel-hardening-return-12618-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12618-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 19:21:12 -0700
From: Eric Biggers <ebiggers3@gmail.com>
To: Tycho Andersen <tycho@tycho.ws>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH 2/2] dh key: get rid of stack array allocation
Message-ID: <20180315022112.GB641@zzz.localdomain>
References: <20180313042907.29598-1-tycho@tycho.ws>
 <20180313042907.29598-2-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313042907.29598-2-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594795386978188484?=
X-GMAIL-MSGID: =?utf-8?q?1594968502547961033?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 10:29:07PM -0600, Tycho Andersen wrote:
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

This is just hashing zeroes.  Why not use the zeroes at the end of the 'src'
buffer which was allocated as 'outbuf' in __keyctl_dh_compute()?  It's already
the right size.  It might even simplify the code a bit since
crypto_shash_update() would no longer need to be in a loop.

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

Why not instead round the allocated size of 'outbuf' in keyctl_dh_compute_kdf()
up to the next 'crypto_shash_digestsize()'-boundary?  Then this temporary buffer
wouldn't be needed at all.

It would be nice if people thought about how to properly solve the problems when
doing these VLA conversions, rather than mindlessly replacing them with
kmalloc...

Eric
