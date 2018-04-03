Return-Path: <kernel-hardening-return-12846-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+ghtnPGg0KilxH2k9g0rAzTqZgOWyH1psnSlXdVWfFm+A/4k2XlD06F3G9ATxLRw6YuWR5
ARC-Seal: i=1; a=rsa-sha256; t=1522791445; cv=none;
        d=google.com; s=arc-20160816;
        b=OMI1NsyWUpaoZ0Huzxwcr1colEdErwKEDoBJUIF5W+3zuA9WG18T86BYX2UgmFZPDA
         ZvsBXnC34H2sXXjgpdOM231L9gmsqsFUMcZc+82lS3O6QrjX+RupzVDDAH1cuguJFTn9
         RHjnnV+nrMy2q87YqDMIONVNg1PKoHlmay244ajv5t5nSHM04tTh5OryNrLtFmhoeNHw
         6YNlwaR+ubvJre6c7DXWucagLEGPS4AOWpVe7HxZJ30TtnyXL4d0lLPjjQM0ecMdj3M0
         kSg3L/REwc8cWjQY6EpD1QW43BlWy8TokYQLLRTzYERoukS3ivXBHBD3k560OMQjWNrp
         4ayg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=hLxrMjalgMBXj7CM7s9ZOdVVPS9izkteu8Gmd42oHow=;
        b=C/JDEqlzrx/zTDCwu9Lvahk9d0GSMs6khq2XYCx0GIJNWM5dt1eYvYmVG6uQS/NHvG
         8isN2unQPuFgsXIq+wd0cnmWu6aYHmfXqZUn4+RdxxChcaJOoHj8Kdd6x+lvhl3JY4b5
         fdqnvw3r1T1bfYXUeSij4z/jUmvY0iFbdTwAFKfvy+RehnUHDXQwTvxtvnH/6ZDmvORi
         H21JhvIhFZsqa+VHir+nq2Cpaw8Kln+M/N8FOEHgEcyAwoOx5InyOtKat5N7HQFR+dGp
         vomtuuICXB5rq5TciWB+a9MQ6mvsuvJ+o5HHpZtxd6vqwxOJC2z1AWUc8/kgjAiT1q1p
         W2oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12846-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12846-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12846-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12846-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [v3] crypto: ctr - avoid VLA use
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>, linux-kernel@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com, linux-crypto@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Herbert Xu <herbert@gondor.apana.org.au>, Kees Cook <keescook@chromium.org>,
 Eric Biggers <ebiggers3@gmail.com>
References: <1522400006-8859-1-git-send-email-s.mesoraca16@gmail.com>
From: Laura Abbott <labbott@redhat.com>
Message-ID: <4e536889-439a-49e6-dd95-2d4286913202@redhat.com>
Date: Tue, 3 Apr 2018 14:37:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522400006-8859-1-git-send-email-s.mesoraca16@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596352141229362174?=
X-GMAIL-MSGID: =?utf-8?q?1596762562814641393?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/30/2018 01:53 AM, Salvatore Mesoraca wrote:
> All ciphers implemented in Linux have a block size less than or
> equal to 16 bytes and the most demanding hw require 16 bytes
> alignment for the block buffer.
> We avoid 2 VLAs[1] by always allocating 16 bytes with 16 bytes
> alignment, unless the architecture supports efficient unaligned
> accesses.
> We also check the selected cipher at instance creation time, if
> it doesn't comply with these limits, we fail the creation.
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>   crypto/ctr.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/crypto/ctr.c b/crypto/ctr.c
> index 854d924..49c469d 100644
> --- a/crypto/ctr.c
> +++ b/crypto/ctr.c
> @@ -21,6 +21,9 @@
>   #include <linux/scatterlist.h>
>   #include <linux/slab.h>
>   
> +#define MAX_BLOCKSIZE 16
> +#define MAX_ALIGNMASK 15
> +

Can we pull this out into a header file, I think this would cover

crypto/cipher.c: In function ‘cipher_crypt_unaligned’:
crypto/cipher.c:70:2: warning: ISO C90 forbids variable length array ‘buffer’ [-Wvla]
   u8 buffer[size + alignmask];
   ^~



>   struct crypto_ctr_ctx {
>   	struct crypto_cipher *child;
>   };
> @@ -58,7 +61,7 @@ static void crypto_ctr_crypt_final(struct blkcipher_walk *walk,
>   	unsigned int bsize = crypto_cipher_blocksize(tfm);
>   	unsigned long alignmask = crypto_cipher_alignmask(tfm);
>   	u8 *ctrblk = walk->iv;
> -	u8 tmp[bsize + alignmask];
> +	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
>   	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
>   	u8 *src = walk->src.virt.addr;
>   	u8 *dst = walk->dst.virt.addr;
> @@ -106,7 +109,7 @@ static int crypto_ctr_crypt_inplace(struct blkcipher_walk *walk,
>   	unsigned int nbytes = walk->nbytes;
>   	u8 *ctrblk = walk->iv;
>   	u8 *src = walk->src.virt.addr;
> -	u8 tmp[bsize + alignmask];
> +	u8 tmp[MAX_BLOCKSIZE + MAX_ALIGNMASK];
>   	u8 *keystream = PTR_ALIGN(tmp + 0, alignmask + 1);
>   
>   	do {
> @@ -206,6 +209,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
>   	if (alg->cra_blocksize < 4)
>   		goto out_put_alg;
>   
> +	/* Block size must be <= MAX_BLOCKSIZE. */
> +	if (alg->cra_blocksize > MAX_BLOCKSIZE)
> +		goto out_put_alg;
> +
> +	/* Alignmask must be <= MAX_ALIGNMASK. */
> +	if (alg->cra_alignmask > MAX_ALIGNMASK)
> +		goto out_put_alg;
> +
>   	/* If this is false we'd fail the alignment of crypto_inc. */
>   	if (alg->cra_blocksize % 4)
>   		goto out_put_alg;
> 
