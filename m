Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033150AbeCARKl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:10:41 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:53951 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032742AbeCARKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:10:39 -0500
X-Google-Smtp-Source: AG47ELv4PrpdF1rWn19e4MktPGXg3I0uzjn7I0hMLuY4Aokw9a/y7AV7uJZokKaWm2jwv4xGKoF0PpryL2ve8dmjvvU=
MIME-Version: 1.0
In-Reply-To: <20180301170826.GA2678@arm.com>
References: <20180301162803.5490-1-robh@kernel.org> <20180301170826.GA2678@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 1 Mar 2018 17:10:38 +0000
Message-ID: <CAKv+Gu8E=wg-=KCtsR=GFEwT1SsEaGFujBx8PNq0JkCAmJYktw@mail.gmail.com>
Subject: Re: [PATCH] arm64/efi: Make strrchr() available to the EFI namespace
To: Will Deacon <will.deacon@arm.com>
Cc: Rob Herring <robh@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 March 2018 at 17:08, Will Deacon <will.deacon@arm.com> wrote:
> On Thu, Mar 01, 2018 at 10:28:03AM -0600, Rob Herring wrote:
>> libfdt gained a new dependency on strrchr, so make it available to the
>> EFI namespace before we update libfdt.
>>
>> Thanks to Ard for providing this fix.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> Please ack. This is a dependency on a dtc upstream sync.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
>
> As an aside, I noticed that this __efistub prefixing is also being
> applied to mapping symbols, so we get crazy stuff like __efistub_$x. I
> didn't get round to working out whether that's going to be problematic,
> but maybe it's all fine...
>

Ugh. Those mapping symbols.

We can filter them explicitly in scripts/kallsyms, I guess, or even
better, get rid of all __efistub_ symbols entirely (since they are
either aliases or part of __init code)


>>
>>  arch/arm64/kernel/image.h | 1 +
>>  arch/arm64/lib/strrchr.S  | 2 +-
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
>> index c7fcb232fe47..a820ed07fb80 100644
>> --- a/arch/arm64/kernel/image.h
>> +++ b/arch/arm64/kernel/image.h
>> @@ -103,6 +103,7 @@ __efistub_strlen          = KALLSYMS_HIDE(__pi_strlen);
>>  __efistub_strnlen            = KALLSYMS_HIDE(__pi_strnlen);
>>  __efistub_strcmp             = KALLSYMS_HIDE(__pi_strcmp);
>>  __efistub_strncmp            = KALLSYMS_HIDE(__pi_strncmp);
>> +__efistub_strrchr            = KALLSYMS_HIDE(__pi_strrchr);
>>  __efistub___flush_dcache_area        = KALLSYMS_HIDE(__pi___flush_dcache_area);
>>
>>  #ifdef CONFIG_KASAN
>> diff --git a/arch/arm64/lib/strrchr.S b/arch/arm64/lib/strrchr.S
>> index 61eabd9a289a..f8e2784d5752 100644
>> --- a/arch/arm64/lib/strrchr.S
>> +++ b/arch/arm64/lib/strrchr.S
>> @@ -40,4 +40,4 @@ ENTRY(strrchr)
>>       b       1b
>>  2:   mov     x0, x3
>>       ret
>> -ENDPROC(strrchr)
>> +ENDPIPROC(strrchr)
>> --
>> 2.14.1
>>
