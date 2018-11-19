Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C5DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F48E2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TxwCm+8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F48E2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbeKTCfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:35:53 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40200 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbeKTCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:35:53 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so7685768ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 08:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfG0f3G14jneJGCMcZFwZWehZ7Zpe9fHp6TlDcuLyZg=;
        b=TxwCm+8glaar6whJ1dvF3Ol7ch5uJg2McmLbfCvs8uGuJQw6exeq/HrFkEdZE9wsZN
         epyE7/XcMliirWCrKgXSBJvg1u+uaVPV2ceDR0f6NrFtZLHiQOez1CQHak6ujnf9LslM
         CU2jaTS3+TrejqsHKX7yBf2MRwNtIu+n5fZlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfG0f3G14jneJGCMcZFwZWehZ7Zpe9fHp6TlDcuLyZg=;
        b=g5i+DXtDMOQZkU3NqMj894lcj8hg64rS9CPb9lBbF/Mwj/ydm+KG18LQreoDSFY1Rt
         ComLNJ7Za4nvSKYQSOWXz2PLZywH8+rGJlveRJk21LsFXr+P2kMi5wGl/hPeXuXUYoh5
         /+eiPJEo4ReS9yp0C2vr9pz3MA+J8GCsT+eoj7+Z/zGZ/S7O0HPkBKiKr74wjdOPQ0nD
         TKt/8VIMN3OatPhqYIT42CLXp8QfYNozlzrel5G4HWIwgwGzMAc8+KmVzVbQnjhsqk3q
         hks+9DEAbYWEFH0aZN9sOd/nUOtsXinheLhgRpPFj6COPIwP9JGaBmjiGFCNiGg925wT
         op8g==
X-Gm-Message-State: AA+aEWYJZ9fgYtsa8wf6caMyBt660Hc0GPewh/nbzGW51prFCNfhJrLu
        2TqYGl7K66f57QMQyc2hN4qBJ3XYge7AoZZGzNJX3A==
X-Google-Smtp-Source: AFSGD/W+CnFl6M4+VmAGputo/rUhOgPA6J4lxNxd4F+g+jZFlHemtHtTiW/LC1OEDJdnBVIJ+E3w2Zqe655oWNoczhE=
X-Received: by 2002:a24:710:: with SMTP id f16mr1125512itf.121.1542643910066;
 Mon, 19 Nov 2018 08:11:50 -0800 (PST)
MIME-Version: 1.0
References: <1542612560-10089-1-git-send-email-sunrui26@huawei.com>
In-Reply-To: <1542612560-10089-1-git-send-email-sunrui26@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 19 Nov 2018 08:11:38 -0800
Message-ID: <CAKv+Gu_=e70fzmVRuo7A4ObdNfWt=mQSU+n7E_HkRuqLV0fnMg@mail.gmail.com>
Subject: Re: [PATCH] arm64:crc:accelerated-crc32-by-64bytes
To:     sunrui26@huawei.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
>
> add 64 bytes loop to acceleration calculation
>

Can you share some performance numbers please?

Also, we don't need 64 byte, 32 byte and 16 byte code paths: just make
the 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.


> Signed-off-by: Rui Sun <sunrui26@huawei.com>
> ---
>  arch/arm64/lib/crc32.S | 54 ++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 50 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S
> index 5bc1e85..2b37009 100644
> --- a/arch/arm64/lib/crc32.S
> +++ b/arch/arm64/lib/crc32.S
> @@ -15,15 +15,61 @@
>         .cpu            generic+crc
>
>         .macro          __crc32, c
> -0:     subs            x2, x2, #16
> -       b.mi            8f
> +
> +64: cmp     x2, #64
> +    b.lt    32f
> +
> +    adds    x11, x1, #16
> +    adds    x12, x1, #32
> +    adds    x13, x1, #48
> +
> +0 : subs    x2, x2, #64
> +    b.mi    32f
> +
> +    ldp     x3, x4, [x1], #64
> +    ldp     x5, x6, [x11], #64
> +    ldp     x7, x8, [x12], #64
> +    ldp     x9, x10,[x13], #64
> +

Can we do this instead, and get rid of the temp variables?

    ldp     x3, x4, [x1], #64
    ldp     x5, x6, [x1, #-48]
    ldp     x7, x8, [x1, #-32]
    ldp     x9, x10,[x1, #-16]

> + CPU_BE( rev     x3, x3      )
> + CPU_BE( rev     x4, x4      )
> + CPU_BE( rev     x5, x5      )
> + CPU_BE( rev     x6, x6      )
> + CPU_BE( rev     x7, x7      )
> + CPU_BE( rev     x8, x8      )
> + CPU_BE( rev     x9, x9      )
> + CPU_BE( rev     x10,x10     )
> +
> +    crc32\c\()x w0, w0, x3
> +    crc32\c\()x w0, w0, x4
> +    crc32\c\()x w0, w0, x5
> +    crc32\c\()x w0, w0, x6
> +    crc32\c\()x w0, w0, x7
> +    crc32\c\()x w0, w0, x8
> +    crc32\c\()x w0, w0, x9
> +    crc32\c\()x w0, w0, x10
> +
> +    b.ne       0b
> +    ret
> +
> +32: tbz     x2, #5, 16f
> +    ldp     x3, x4, [x1], #16
> +    ldp     x5, x6, [x1], #16
> +CPU_BE( rev     x3, x3      )
> +CPU_BE( rev     x4, x4      )
> +CPU_BE( rev     x5, x5      )
> +CPU_BE( rev     x6, x6      )
> +    crc32\c\()x w0, w0, x3
> +    crc32\c\()x w0, w0, x4
> +    crc32\c\()x w0, w0, x5
> +    crc32\c\()x w0, w0, x6
> +
> +16: tbz     x2, #4, 8f
>         ldp             x3, x4, [x1], #16
>  CPU_BE(        rev             x3, x3          )
>  CPU_BE(        rev             x4, x4          )
>         crc32\c\()x     w0, w0, x3
>         crc32\c\()x     w0, w0, x4
> -       b.ne            0b
> -       ret
>
>  8:     tbz             x2, #3, 4f
>         ldr             x3, [x1], #8
> --
> 1.8.3.1
>
