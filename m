Return-Path: <kernel-hardening-return-12886-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49XCoyK9VWsD6RKHsLLU22FxEcxGjP5R8T/q98vLGh1AsUulQZ6ZzfHeSnkcdhRedYB4qDE
ARC-Seal: i=1; a=rsa-sha256; t=1523157628; cv=none;
        d=google.com; s=arc-20160816;
        b=YJ4+tZf/ff6ijhUYZSvxwCIrOML2O1KwWuSjkOoqY0OMDG+7X7gM+zbVOOX+uyy4zY
         cHYPuCPMilLMQBdJKPZj/ea9+0kh70tLMftisWmaIUsEflBSGyEtvReATl4Tgqoyz84x
         c3SycJs2iD4X4NEwY6kkHPVVkjO7+EwFglHkINq1lVRkt3gm82A/9T710AP75CYcZufM
         GYzLwynKqZJ5VGIvPzcHzgbvobM5Y46H4r7DLJSVwdZB/ICU88M26WRWXID2oQ8tyOsw
         BWpIxHb2JH9WliSsRScZO+Gn2h4uOe+Bfoq9F8A7e2ajNBsscPsob7EPH7JTxS4mV+dI
         dKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=bLdwmKEAJyfCTIw2vpG3n5RthjBWmKYNxDzcqZCBTE4=;
        b=iv6bxQqgju10fU/9hSAG4m01PzbYunX5K6/UFnQhw3LdKmUsR354R4NVhLf4IiG7LM
         1UWP1NWzvMDIMYvizqeSce31xo5P/pwZ3gKY24Ts3Lam+uZfPjvuL0p9HmQOc/JiLOgK
         yBvf6zyMDsTNn7HOSwAAhmVSfB2eTFbNTKPlY7VRR5BBfdkWr2e+clgC42zwgjqJdQUr
         El027Xyr17SeVu4jMJQ6EPdbz5mI/+qSZe574nY6BvZ/WKZ08Cfw/ZLdRZe8gohaX2DG
         3Fh1TGV08PLcKmHdmOXkwJIpTTwJS7PaHHkT1Q0806t4ssFv9xDTP+AHoyVDjsnSAcUk
         Eylg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12886-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12886-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12886-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12886-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 8 Apr 2018 11:19:35 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 2/6] crypto: ctr - avoid VLA use
Message-ID: <20180408031935.GC25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-3-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523126303-23205-3-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113761628441569?=
X-GMAIL-MSGID: =?utf-8?q?1597146533311390801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 08:38:19PM +0200, Salvatore Mesoraca wrote:
>
> @@ -206,6 +207,14 @@ static struct crypto_instance *crypto_ctr_alloc(struct rtattr **tb)
>  	if (alg->cra_blocksize < 4)
>  		goto out_put_alg;
>  
> +	/* Block size must be <= MAX_BLOCKSIZE. */
> +	if (alg->cra_blocksize > MAX_BLOCKSIZE)
> +		goto out_put_alg;
> +
> +	/* Alignmask must be <= MAX_ALIGNMASK. */
> +	if (alg->cra_alignmask > MAX_ALIGNMASK)
> +		goto out_put_alg;
> +

Since you're also adding a check to cipher algorithms in general,
none of these individual checks are needed anymore.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
