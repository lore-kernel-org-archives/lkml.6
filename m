Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA4BECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADE0620846
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 01:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3Gm0PHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADE0620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbeGNB3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 21:29:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36818 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbeGNB3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 21:29:51 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so12872740plp.3;
        Fri, 13 Jul 2018 18:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=su1/LdT4qPG7MZhIz3fGf4+FPklfKmvt6Xg8sIR8dxM=;
        b=K3Gm0PHmnb4V8RSXbbistOSk+W3QwMGO4TPd7IkjA8mvsrGgAS+JF+PZ9gHwV1Hkyz
         cWbSTLLRgKoPZlpzv/atPmEFhR20usNz6BFttmb2Zf0LHHBosmkmKks5ayg7ZywYpoZt
         U/rDQQE4afiw4fNqnRV6WxKxVE7ZFR60ooIWEq5+EHZZktTcw1gDP+cfsQD+mlVK8clB
         QXYw+I4KbuxB7uNOi0XI6oNZR8fRr3xvefIZIphztj6WsgPRdTz09hmqJo9ofcC6EhAK
         xdcpWwbyb/02RbDF/1g8aas/26baGF2UDHkG7NuCYDnw2hNKgQ2Py+8Nfr3/Kagpa5X6
         14Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=su1/LdT4qPG7MZhIz3fGf4+FPklfKmvt6Xg8sIR8dxM=;
        b=GcdCGQ4/QqTfTYxWykt9EjuJjGjo//vEIL5A2UIKK8k25qOM9LwrSx/z8xwkRbzN2z
         Qteabbr3zsXbsSYDB1TyvObzdvpbS+UpQDGbZ0mPxzuPZM+UgFdJIE74syCYOQkXKuM8
         2gRmyylA+WhESKmqAd4fD02dveojs5p/KLB/FpVZZq81AKk5lxHIky9i94SV+87ZcZsk
         BuddO9QmcfQ9ZkqoHxcYDszwWN2k48yrfUtrhR5uPi8IP4bVw9KwLfOF3olBHUejkia1
         frqt1ub/r45iceBXMSQvYXnVL3ns79F+jsySyd9saF08g+0LyAcZw793fd0i9vyRuEKe
         GyYg==
X-Gm-Message-State: AOUpUlFEHS46wjJj8vPk59jjzCY/K6O5zLfMGam+2zykeP1EyOij1a1l
        kl0SMts9zE874XNN74+C1b4=
X-Google-Smtp-Source: AAOMgpe8yYY3i++m5UGf5cEpc1wot6beezWx7hSEkO6Dpbf6LEQVe6Q/4KIvda7XIROCCx7VbdSz0Q==
X-Received: by 2002:a17:902:530a:: with SMTP id b10-v6mr8587179pli.316.1531530766894;
        Fri, 13 Jul 2018 18:12:46 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r87-v6sm66917091pfb.1.2018.07.13.18.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 18:12:45 -0700 (PDT)
Subject: Re: [v18,3/7] iomap: introduce io{read|write}64_{lo_hi|hi_lo}
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Suresh Warrier <warrier@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
References: <20180622194752.11221-4-logang@deltatee.com>
 <20180713233831.GA2946@roeck-us.net>
 <0a32dbb8-a1fa-f691-1d4a-9851b1496b9a@deltatee.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cc6cfb2a-d1d4-3328-3f49-07f7cec09faf@roeck-us.net>
Date:   Fri, 13 Jul 2018 18:12:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0a32dbb8-a1fa-f691-1d4a-9851b1496b9a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/2018 05:20 PM, Logan Gunthorpe wrote:
> 
> 
> On 13/07/18 05:38 PM, Guenter Roeck wrote:
>> This patch causes a build failure in -next when building
>> ppc:corenet64_smp_defconfig.
> 
> Thanks for the report. This 64bit IO stuff is a bit of a mess. It looks
> like your corner case arch and config was never covered by the kbuild
> robot which has run extensively on this patchset.
> 
> Anyway, I think the fix is to put back the ioread64/write64 prototypes
> (even though they are only used in this one corner).
> 
> Can you try it with the following patch to ensure it fixes things for you?
> 

It does.

Guenter

> Logan
> 
> --
> 
> diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
> index 5a4af0199b32..9f11a79e0d7a 100644
> --- a/include/asm-generic/iomap.h
> +++ b/include/asm-generic/iomap.h
> @@ -32,6 +32,11 @@ extern unsigned int ioread16be(void __iomem *);
>   extern unsigned int ioread32(void __iomem *);
>   extern unsigned int ioread32be(void __iomem *);
> 
> +#ifdef CONFIG_64BIT
> +extern u64 ioread64(void __iomem *);
> +extern u64 ioread64be(void __iomem *);
> +#endif
> +
>   #ifdef readq
>   #define ioread64_lo_hi ioread64_lo_hi
>   #define ioread64_hi_lo ioread64_hi_lo
> @@ -49,6 +54,11 @@ extern void iowrite16be(u16, void __iomem *);
>   extern void iowrite32(u32, void __iomem *);
>   extern void iowrite32be(u32, void __iomem *);
> 
> +#ifdef CONFIG_64BIT
> +extern void iowrite64(u64, void __iomem *);
> +extern void iowrite64be(u64, void __iomem *);
> +#endif
> +
>   #ifdef writeq
>   #define iowrite64_lo_hi iowrite64_lo_hi
>   #define iowrite64_hi_lo iowrite64_hi_lo
> 

