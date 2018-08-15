Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD90C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC523215A3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XoZGA/V1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC523215A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbeHOR1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 13:27:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeHOR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 13:27:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id g1-v6so1328621wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YLuXi23+ArSCZlOug6tM1PTKrq5zEYiQnVLNIr15KSw=;
        b=XoZGA/V1TsRXjtenjJ5/0O/571VWTDDXIzRv76qPkrW2BH5U3kvVDT+nTKYZMmYy1w
         qQrjT+Pk3xHtNzmBALNZieOy/VXaElzeNL1vYQyj0dQelzbbfhJgPX9kQIITVdpEY5wa
         Bs6FI1429yqjZqOLUIR6fUWXY+yympU15L5YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YLuXi23+ArSCZlOug6tM1PTKrq5zEYiQnVLNIr15KSw=;
        b=QEmeg3Lalu0bZanXdtbc/wNppVG+/xE2Vz1GkP1YUVh+f3ojopoHWzqp4MrQ5q20Zq
         wQ6C642ZlL/4P6cMVhqH5hGGSWKL11gfX2VscP2E7/tWXd7MOen5w9rAegt5cdV1ApaQ
         yVbi0L+y5GPBTw8KX4Akv+nqOmAaU3NzihsoatbD9Ml3Wfg+H3S/ySXJS5qKebK/vAx8
         l7P6GlVLsnNSbOoyDD6t+xA4rCWW+CqsW3boKVeXgvgUtEXBovyftzsEe8WxShnCzpou
         jcqmoh8ueH+GwiwDrqWxK4pQgznUDw1RWJXvra7vpbDqmHxKMcybeQhf9kF6uCjqwINv
         BGRg==
X-Gm-Message-State: AOUpUlEq0XeZWPBzZCwgz33QfbyvT1S30wEdI7qsM+VdADPOPYTbisGA
        jQDNQwzUNgSY+yFzfH9HQ2P5I6JT6vM=
X-Google-Smtp-Source: AA+uWPwAV3mQhlaK+7a8GPC0zsxEhqMvStLWhWcbCQayUZHxxa+sUWNC+nmHClAcZdGfQF1Yp6SVKA==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr17025552wrv.33.1534343695058;
        Wed, 15 Aug 2018 07:34:55 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id 185-v6sm3790187wmy.38.2018.08.15.07.34.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 07:34:54 -0700 (PDT)
Subject: Re: [PATCH] kdb: kdb_support: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Wessel <jason.wessel@windriver.com>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20180805024844.GA15367@embeddedor.com>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <4b9d2140-7e9b-82a1-ebbb-fa66a513087a@linaro.org>
Date:   Wed, 15 Aug 2018 15:34:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805024844.GA15367@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/18 03:48, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case, I replaced the code comments with
> a proper "fall through" annotation, which is what GCC is expecting
> to find.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   kernel/debug/kdb/kdb_support.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index 990b3cc..89ac604 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -432,7 +432,7 @@ int kdb_getphysword(unsigned long *word, unsigned long addr, size_t size)
>   				*word = w8;
>   			break;
>   		}
> -		/* drop through */
> +		/* fall through */
>   	default:
>   		diag = KDB_BADWIDTH;
>   		kdb_printf("kdb_getphysword: bad width %ld\n", (long) size);
> @@ -481,7 +481,7 @@ int kdb_getword(unsigned long *word, unsigned long addr, size_t size)
>   				*word = w8;
>   			break;
>   		}
> -		/* drop through */
> +		/* fall through */
>   	default:
>   		diag = KDB_BADWIDTH;
>   		kdb_printf("kdb_getword: bad width %ld\n", (long) size);
> @@ -525,7 +525,7 @@ int kdb_putword(unsigned long addr, unsigned long word, size_t size)
>   			diag = kdb_putarea(addr, w8);
>   			break;
>   		}
> -		/* drop through */
> +		/* fall through */
>   	default:
>   		diag = KDB_BADWIDTH;
>   		kdb_printf("kdb_putword: bad width %ld\n", (long) size);
> 

