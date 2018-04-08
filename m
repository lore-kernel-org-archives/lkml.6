Return-Path: <kernel-hardening-return-12884-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/wNqtk9S8A/WJqYG0UDadkRN+K9V+laEITFoB9CZyRXaNM8Yxncu59V9vcFR+TjMs7IafH
ARC-Seal: i=1; a=rsa-sha256; t=1523157361; cv=none;
        d=google.com; s=arc-20160816;
        b=034BtJiSEJZsmbq8P8BYhV/QlsSSVWOMCNC8Xc6ZjnxC8crXeF3gBxKf3Cyb+J1MDf
         g21z7PozzheWmMo66b58TemX+4A9NVyehMwwT0HhbnJkfET1h3BitfSjr1QHTwQ5pH7L
         DLbaG6X0bD0d49kpGWy1Sdz1Amvw/6CUUaPRZneQIpSHiE7xsTCSKQsteArawDAw4Nui
         Zc6d9MlbQLkzD+q+reax/DQpz89YBBfBov0b3JpOZLISnapm3foLgVmMU6J7pgwZVza6
         +ooq1KV0TXw9bR6JmVVyKB3glWN7rGjPhkHVgTK5V2pILUI7aQof52jtkSdb7iT245R3
         lJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=J7VzfgjH9kZsaVsARQSfczpPgqUQDVa9VrhjMY/0rNs=;
        b=nbT7p+p6dmUtpJRW9ax19USnr4PB+8HG/0IKKjspqnkSNPVf8o9d+Q81g4/nTJ8Kms
         pL7AsJwmxUxvI70MRz3rIE9tvfkqX5MEtM9a0r7sdmT/IDiuZVw8TOsLkUKLy/GENe+0
         Z4Gwdber7bD43q4nkQShsUAnwnmwMvwgfeMx1ETGjkhdGEefDmmE5zVcfk56O1VVfyMu
         6VlR//s0jUvY56tBB+7bg/mZYzFEfW8jr/nm2NMn8ZLEKyyOIZ+kY+9dc3GUfprKK5Fd
         KyG2M+K9+NnaV4OvalcXGercm7KJQplQdjxeIEF3IDZcseaRtLWpfqssrw+agiG0PsLd
         jCUw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12884-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12884-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12884-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12884-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 8 Apr 2018 11:15:00 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <keescook@chromium.org>,
	Eric Biggers <ebiggers3@gmail.com>,
	Laura Abbott <labbott@redhat.com>
Subject: Re: [PATCH 1/6] crypto: api - laying macros for statically allocated
 buffers
Message-ID: <20180408031500.GA25197@gondor.apana.org.au>
References: <1523126303-23205-1-git-send-email-s.mesoraca16@gmail.com>
 <1523126303-23205-2-git-send-email-s.mesoraca16@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523126303-23205-2-git-send-email-s.mesoraca16@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597113752919288094?=
X-GMAIL-MSGID: =?utf-8?q?1597146253702516918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Apr 07, 2018 at 08:38:18PM +0200, Salvatore Mesoraca wrote:
> Creating 2 new compile-time constants for internal use,
> in preparation for the removal of VLAs[1] from crypto code.
> All ciphers implemented in Linux have a block size less than or
> equal to 16 bytes and the most demanding hw require 16 bytes
> alignment for the block buffer.
> 
> [1] http://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Salvatore Mesoraca <s.mesoraca16@gmail.com>
> ---
>  crypto/internal.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/crypto/internal.h b/crypto/internal.h
> index 9a3f399..89ae41e 100644
> --- a/crypto/internal.h
> +++ b/crypto/internal.h
> @@ -26,6 +26,14 @@
>  #include <linux/rwsem.h>
>  #include <linux/slab.h>
>  
> +/*
> + * Maximum values for blocksize and alignmask, used to allocate
> + * static buffers that are big enough for any combination of
> + * ciphers and architectures.
> + */
> +#define MAX_BLOCKSIZE			16
> +#define MAX_ALIGNMASK			15

No please don't put this here if you intend on using it everywhere.
This file is reserved for truly internal bits.

Perhaps include/crypto/algapi.h would be a better place.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
