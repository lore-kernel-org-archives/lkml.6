Return-Path: <kernel-hardening-return-12860-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+4/NaqHS5zRPR5QwmYGlQU9a01WY+jvqf0Nxg262Hr3wU/+PkLVdu5ACZ0OXD3yQicOTNU
ARC-Seal: i=1; a=rsa-sha256; t=1522914085; cv=none;
        d=google.com; s=arc-20160816;
        b=Ft5dA2JRD6o2wsI1m9M2p63mWKDmpWDqYLfDZHXP1niX/ssVOF5nOsSOyaOjQAC/VF
         MTRwdVoGz2I3Tij/C7QcJ2a3ruAiQGhHNBoYT+ow0t5OErf5CzJs1JxMXOCuM8HPuoH3
         LdOXsYhJptQxWYTjatz3Im6zFSVyhYMuuYYKTls5mQdI4CgvVKsMnx2LoWGYW95ylNz2
         hVwbrvhqbgNt5V0WcSSKsoEvs0F9rn0bEgztu+s/k10aoSMx0NyRWJdrPwz4zWIw/Hxp
         ZOYv54VYq+XduqXvWkj4bWnZGMv2+5sBssZojwOnm3WZqFUK+KHeK9NmNHZFuxwbohgU
         dpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=lpCS20MwfKcij7ZoAryIg5YpLPwVlYXVGHTA6qNl7dU=;
        b=vYLeuXuWwLKUPJSRzs2DT3zoJHO8rvcrfK3cYe6SC1plfA5KKZITsIVmnSj+Jn89Mk
         kBA3G/2Vu/+JvFU3lVoZL1EuE9VPC6CA6bms+wO9GppV30vHA9tXEa3JDLzgTAaHCvk8
         g/RCr/BzgPTtgEedvEeLSTGrXZdejv4muOQf3tZE4e9b5VLznzGT8cf/B1gCeGB7O+oL
         g51TCMpSSYYrhWDBYdPRrjc/6vDmxmtDkY/i35AX7013stwHFRPnMOXQkC4s4eC+ncr1
         fnfF8fRnJtZnFtdSSHDZkCfIsek88vdGjdHSBwCexf8syfvsVgunIq8/pL1TlmWUVHQR
         69sA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=aZ9q0Kvz;
       spf=pass (google.com: domain of kernel-hardening-return-12860-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12860-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@rasmusvillemoes.dk header.s=google header.b=aZ9q0Kvz;
       spf=pass (google.com: domain of kernel-hardening-return-12860-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12860-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCHv3] gpio: Remove VLA from gpiolib
To: Laura Abbott <labbott@redhat.com>,
 Linus Walleij <linus.walleij@linaro.org>, Kees Cook <keescook@chromium.org>,
 Lukas Wunner <lukas@wunner.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-hardening@lists.openwall.com
References: <20180328181809.24505-1-labbott@redhat.com>
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e359dc22-ee4c-4ca8-c953-df7d6a4b4062@rasmusvillemoes.dk>
Date: Thu, 5 Apr 2018 09:41:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180328181809.24505-1-labbott@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596206473991489239?=
X-GMAIL-MSGID: =?utf-8?q?1596891159774179021?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-28 20:18, Laura Abbott wrote:
> The new challenge is to remove VLAs from the kernel
> (see https://lkml.org/lkml/2018/3/7/621) to eventually
> turn on -Wvla.
> 
> Using a kmalloc array is the easy way to fix this but kmalloc is still
> more expensive than stack allocation. Introduce a fast path with a
> fixed size stack array to cover most chip with gpios below some fixed
> amount. The slow path dynamically allocates an array to cover those
> chips with a large number of gpios.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v3: Split out from the series since patches have been picked up
> independently. Fold in patch from Lukas Wunner to introduce slow/fast
> paths. I took his suggestions to go with 384 as the maximum number of
> gpios. Also fixed one 0-day bot issue where I forgot to change the
> return type.
>  
>  	while (i < array_size) {
>  		struct gpio_chip *chip = desc_array[i]->gdev->chip;
> -		unsigned long mask[BITS_TO_LONGS(chip->ngpio)];
> -		unsigned long bits[BITS_TO_LONGS(chip->ngpio)];
> +		unsigned long fastpath[2 * BITS_TO_LONGS(FASTPATH_NGPIO)];
> +		unsigned long *slowpath = NULL, *mask, *bits;
>  		int first, j, ret;
>  
> +		if (likely(chip->ngpio <= FASTPATH_NGPIO)) {
> +			memset(fastpath, 0, sizeof(fastpath));
> +			mask = fastpath;
> +			bits = fastpath + BITS_TO_LONGS(FASTPATH_NGPIO);
> +		} else {
> +			slowpath = kcalloc(2 * BITS_TO_LONGS(chip->ngpio),
> +					   sizeof(*slowpath),
> +					   can_sleep ? GFP_KERNEL : GFP_ATOMIC);
> +			if (!slowpath)
> +				return -ENOMEM;
> +			mask = slowpath;
> +			bits = slowpath + BITS_TO_LONGS(chip->ngpio);
> +		}
> +

To avoid the static analysis complaints about the "if (slowpath)
kfree(slowpath)" pattern, I'd suggest getting rid of the slowpath
variable and simply assign the kcalloc directly to mask. Then the
condition becomes "if (mask != fastpath) kfree(mask)". A comment won't
silence subsequenct coccicheck runs, and unfortunately probably won't
prevent certain individuals from sending auto-generated patches.

Maybe also pull out the "bits = mask + BITS_TO_LONGS(chip->ngpio)" to
the common path.

Another thing: Maybe a pr_warn or at least a pr_info would be in order
when a gpio chip with > FASTPATH_NGPIO lines is registered? And if that
triggers for a lot of different SoCs, one could consider changing it to
a CONFIG_ thing, or just bumping it to 512 if that would seem to cover
all the reports.

Rasmus
