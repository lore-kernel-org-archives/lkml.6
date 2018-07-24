Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A464220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 09:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdj4C9du"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A464220856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeGXKf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 06:35:59 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54136 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGXKf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 06:35:59 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so2836131itw.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5fLFfRtDNFAhjKepKt65blVg7Xqmkg4Qd/Izcov6HGE=;
        b=kdj4C9duSXwQuLnSvn7OEvswzd1TQkvhYqwgJaB2EHBQPaHQtendRsAoN7Y0jIK4PF
         Lojs+n2ZQZFzNtOWaGaNoEyP8JBz8InhaokpcoVTLdvNGrZoDcPnmmaASOWbmf4avFem
         auPh1fqauv/vgmpf+niSRknvYneA+bYrqPW+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5fLFfRtDNFAhjKepKt65blVg7Xqmkg4Qd/Izcov6HGE=;
        b=Fx2k4oyZfzd6DCr8+HQGSxzao3BdI6wUdMIwPif8iizgT9kynbP98Vdhpk6CoQClR9
         o5yD58nxbg6hM8r2QWjWqONNZKPb3dG3lfDiJ/aLybpJqGCqzhhbe5FZha/HpPTX0jg9
         sDXuz91x7tOOv2Eyb6knPnhHxhMFwcArYXAYn7oiOlcIlQx5x0q5ZuaIXYg31P97qNC9
         KN0VvgfCP2z3+tFH9caNo5bDQvMD8PqnyjeXrq3INkmh4965Ejl2b65NJtXCdB7S+VeC
         cgjWsjxNNyAaERJOLiZHJZyRhvIBZvVKy39ammm2mG4QRcx/4kF8DXWvg7xPMNs+HpvT
         xy+A==
X-Gm-Message-State: AOUpUlFfwRatf/gb0mxigzpBAUXfx7A86oW9MrczT9MC+L9gEjUBgUyD
        c1sJcSzVdJ9qe1hnFPN2LtTsaF7wEUnhek9kV0wc7g==
X-Google-Smtp-Source: AAOMgpfQCq68gyys3tVj24UHSCvoYPEf2MwGKCMkLE219Nb9kitH/fCBf2erdrLkDbEtq4/hAui+fcvIxL48nrL/keo=
X-Received: by 2002:a24:64d6:: with SMTP id t205-v6mr2010336itc.138.1532424624449;
 Tue, 24 Jul 2018 02:30:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 02:30:23
 -0700 (PDT)
In-Reply-To: <CAK8P3a0bOYPtsCb8_etWtFCsnjB-xkMPFiy7iBubThi0b-LtVg@mail.gmail.com>
References: <20180724090545.2270d975@canb.auug.org.au> <20180724002630.GV11258@linaro.org>
 <CAK8P3a0bOYPtsCb8_etWtFCsnjB-xkMPFiy7iBubThi0b-LtVg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 24 Jul 2018 11:30:23 +0200
Message-ID: <CAKv+Gu8T9WJN6SNndcVNafaqCfNpEuSx5XRqdrM8DOjzfyZzqg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the arm64 tree
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 July 2018 at 10:12, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Jul 24, 2018 at 2:26 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> On Tue, Jul 24, 2018 at 09:05:45AM +1000, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the arm64 tree, today's linux-next build (x86_64
>>> allmodconfig) produced this warning:
>>
>> Where can I find this specific branch?
>>
>>> drivers/acpi/Kconfig:6:error: recursive dependency detected!
>>> drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI
>>
>> My patch created an additional dependency like:
>>   menu ACPI
>>     ...
>>     depends on IA64 || X86 || (ARM64 && EFI)
>>
>>> arch/x86/Kconfig:1920:        symbol EFI depends on ACPI
>>
>> So I don't understand why this change makes a warning on x86_64 build.
>> Is this a real recursive dependency?
>
> On x86, we have
>
> config EFI
>         bool "EFI runtime service support"
>         depends on ACPI
>
> Kconfig cannot know that CONFIG_ARM64 is never set on x86, while
> X86 is always set. So to Kconfig it it appears like a recursive
> dependency.
>
> The best workaround I can see is to have an intermediate symbol
> on ARM64 that is invisible to Kconfig on x86, like
>
> config ARCH_SUPPORTS_ACPI
>         def_bool EFI
>
> and then have ACPI depend on that.
>

I suppose you mean

depends on IA64 || X86 || ARCH_SUPPORTS_ACPI

right?

Instead, perhaps we could have

config ARCH_SUPPORTS_ACPI
        def_bool IA64 || X86

and make CONFIG_ACPI depend on that. Then, we can set it conditionally
in arch/arm64/Kconfig if CONFIG_EFI is enabled.
