Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B82C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B8E218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 10:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfAYKql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 05:46:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35592 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfAYKqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 05:46:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so6231623wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 02:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vgcYcXElp2D9+8LvroyhCZE4sigZ9M+hQE82VSfBbfM=;
        b=oUrq4XKsL3PgjrvdPgh4+zJ1syjp5OXY5JI7/akvaxWdSQjTpbJvnpYnAqZEDYfDiw
         XIxr4SBi7rAHVGQ41jeDE4I/PTUqj5nFoDfR306BAR3WiIywUxmikQGGPRf5SAUcMcpb
         tsMxhx3/l7SmAAhOlDdZodff1WoEGzLrpgHyTTFBNydtXiZikrJPUUL9zpODgmkgNOdM
         IweoZk0EHI5v1FB2GXX6aqbbi4U+T+VL/9QhNaXUcmufILOnx++zV01+tOb7wHwb+DuI
         7PmM3UTPePvXidsHzFT6iUuwh1+XnoC6YEJSC+QxDDStxkrTIV7gnQEJbadzIenzRoYo
         ziUg==
X-Gm-Message-State: AJcUukdhkgFBWmTJZh5KvT0andkR0HMeUsHkrxKXW5yWcPXHha41hG+s
        BY+DGFqugcmCIp8IIYMtmoyvzeZUHiQ=
X-Google-Smtp-Source: ALg8bN5PdKmAco1p7qqhv2hoX1dNf6dxq4gQNgjZQgHoWicCJBrBmsf78X0CjrKz81QoZ11PMi1fTg==
X-Received: by 2002:a1c:f509:: with SMTP id t9mr6724937wmh.76.1548413198042;
        Fri, 25 Jan 2019 02:46:38 -0800 (PST)
Received: from [10.200.153.26] (ovpn-brq.redhat.com. [213.175.37.11])
        by smtp.gmail.com with ESMTPSA id q12sm38602793wmf.2.2019.01.25.02.46.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 02:46:37 -0800 (PST)
Subject: Re: [PATCH] lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases
 as __pure
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Martin Sebor <msebor@gcc.gnu.org>, linux-kernel@vger.kernel.org
References: <20190124154420.GA11471@gmail.com>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <29e55819-2246-f79a-9ca0-291d975981b6@redhat.com>
Date:   Fri, 25 Jan 2019 11:46:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190124154420.GA11471@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/19 7:44 AM, Miguel Ojeda wrote:
> The upcoming GCC 9 release extends the -Wmissing-attributes warnings
> (enabled by -Wall) to C and aliases: it warns when particular function
> attributes are missing in the aliases but not in their target.
> 
> In particular, it triggers here because crc32_le_base/__crc32c_le_base
> aren't __pure while their target crc32_le/__crc32c_le are.
> 
> These aliases are used by architectures as a fallback in accelerated
> versions of CRC32. See commit 9784d82db3eb ("lib/crc32: make core crc32()
> routines weak so they can be overridden").
> 
> Therefore, being fallbacks, it is likely that even if the aliases
> were called from C, there wouldn't be any optimizations possible.
> Currently, the only user is arm64, which calls this from asm.
> 
> Still, marking the aliases as __pure makes sense and is a good idea
> for documentation purposes and possible future optimizations,
> which also silences the warning.
> 
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
> I am picking this up through the compiler-attributes tree
> and putting it into -next along with the other cleanup
> for -Wmissing-attributes (unless some other maintainer wants it).
> 
>   lib/crc32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/crc32.c b/lib/crc32.c
> index 45b1d67a1767..4a20455d1f61 100644
> --- a/lib/crc32.c
> +++ b/lib/crc32.c
> @@ -206,8 +206,8 @@ u32 __pure __weak __crc32c_le(u32 crc, unsigned char const *p, size_t len)
>   EXPORT_SYMBOL(crc32_le);
>   EXPORT_SYMBOL(__crc32c_le);
>   
> -u32 crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> -u32 __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
> +u32 __pure crc32_le_base(u32, unsigned char const *, size_t) __alias(crc32_le);
> +u32 __pure __crc32c_le_base(u32, unsigned char const *, size_t) __alias(__crc32c_le);
>   
>   /*
>    * This multiplies the polynomials x and y modulo the given modulus.
> 


Tested-by: Laura Abbott <labbott@redhat.com>
