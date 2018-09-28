Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D18AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 242822170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzr+Q31j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242822170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbeI1PMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 11:12:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52177 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbeI1PMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 11:12:31 -0400
Received: by mail-it1-f195.google.com with SMTP id 74-v6so1703706itw.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aYG1GqUuFPbDlJb8lTqv4mppTm4ZcDdb/ZYOuWmcGKI=;
        b=Yzr+Q31jiIl7HhzpDIEPciu2ui7jCwSvha6sfS2j/3iI0NIucMMHWSs4OXczptBvca
         dyrs6XhY32s0gZXsbw+zIinq2rrvUUafKQBi7YLkKy2Bmy5iDRcIwqfMBEeckbrVAiem
         Fkf9BajIR2EZcUIGj4pDtUzL9XhJxn6B2pPms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aYG1GqUuFPbDlJb8lTqv4mppTm4ZcDdb/ZYOuWmcGKI=;
        b=V+CFUcRlDTdPZQK66sjJjtb8vbSp0aeJQ1DUFvlIISnjYzr8LUjzXBXdEz2bpCb4gI
         f6lis/dSbKlqimsqGC2ytyEBgZMgubm9sMqcuqGsU1Q7vrbaJgiZxTPOr8btZ9zyLshq
         Wgfg3j40BSLXqHAkInJTcKEA5F4aU2dG1VPJLjN7ss83c8k/7uJATiUCU6hw6PHNMF7/
         /61DCfMjY/YKk5x+vviuHf2dZlW1OJWJb/asEs8USP82LbYvaxG5kCEpiAlgng3/FbSe
         TwY7K9Zg5pckSpatn7PlK8j1I6OWS4FHR0CrhVpoPgkKdKsnDbacoQDOPhG8fdBoEntW
         cQzQ==
X-Gm-Message-State: ABuFfojTQhOmHUNENWn6huovki4AFM/Il1g5WIss5FPWaTo1n4Y0aqVB
        kQ/ar6zuL5FXTK6FeNURSHHNk/OlYLAaOX+z70UIzQ==
X-Google-Smtp-Source: ACcGV62uvY7lyjHaC1MpfnplQWAPMm12kxRhni0HG09JcvwWI7uR6mePuPxEpkv0/t7EBo8oGMys12qq3XkR+ntqTr0=
X-Received: by 2002:a02:b015:: with SMTP id p21-v6mr12934045jah.2.1538124587636;
 Fri, 28 Sep 2018 01:49:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:2848:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 01:49:47
 -0700 (PDT)
In-Reply-To: <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 28 Sep 2018 10:49:47 +0200
Message-ID: <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Joe)

On 28 September 2018 at 10:28, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 25 September 2018 at 16:56, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> Sometimes it's useful to amortize calls to XSAVE/XRSTOR and the related
>> FPU/SIMD functions over a number of calls, because FPU restoration is
>> quite expensive. This adds a simple header for carrying out this pattern:
>>
>>     simd_context_t simd_context;
>>
>>     simd_get(&simd_context);
>>     while ((item = get_item_from_queue()) != NULL) {
>>         encrypt_item(item, simd_context);
>>         simd_relax(&simd_context);
>>     }
>>     simd_put(&simd_context);
>>
>> The relaxation step ensures that we don't trample over preemption, and
>> the get/put API should be a familiar paradigm in the kernel.
>>
>> On the other end, code that actually wants to use SIMD instructions can
>> accept this as a parameter and check it via:
>>
>>    void encrypt_item(struct item *item, simd_context_t *simd_context)
>>    {
>>        if (item->len > LARGE_FOR_SIMD && simd_use(simd_context))
>>            wild_simd_code(item);
>>        else
>>            boring_scalar_code(item);
>>    }
>>
>> The actual XSAVE happens during simd_use (and only on the first time),
>> so that if the context is never actually used, no performance penalty is
>> hit.
>>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>> Cc: Samuel Neves <sneves@dei.uc.pt>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Greg KH <gregkh@linuxfoundation.org>
>> Cc: linux-arch@vger.kernel.org
>> ---
>>  arch/alpha/include/asm/Kbuild      |  5 ++-
>>  arch/arc/include/asm/Kbuild        |  1 +
>>  arch/arm/include/asm/simd.h        | 63 ++++++++++++++++++++++++++++++
>>  arch/arm64/include/asm/simd.h      | 51 +++++++++++++++++++++---
>>  arch/c6x/include/asm/Kbuild        |  3 +-
>>  arch/h8300/include/asm/Kbuild      |  3 +-
>>  arch/hexagon/include/asm/Kbuild    |  1 +
>>  arch/ia64/include/asm/Kbuild       |  1 +
>>  arch/m68k/include/asm/Kbuild       |  1 +
>>  arch/microblaze/include/asm/Kbuild |  1 +
>>  arch/mips/include/asm/Kbuild       |  1 +
>>  arch/nds32/include/asm/Kbuild      |  7 ++--
>>  arch/nios2/include/asm/Kbuild      |  1 +
>>  arch/openrisc/include/asm/Kbuild   |  7 ++--
>>  arch/parisc/include/asm/Kbuild     |  1 +
>>  arch/powerpc/include/asm/Kbuild    |  3 +-
>>  arch/riscv/include/asm/Kbuild      |  3 +-
>>  arch/s390/include/asm/Kbuild       |  3 +-
>>  arch/sh/include/asm/Kbuild         |  1 +
>>  arch/sparc/include/asm/Kbuild      |  1 +
>>  arch/um/include/asm/Kbuild         |  3 +-
>>  arch/unicore32/include/asm/Kbuild  |  1 +
>>  arch/x86/include/asm/simd.h        | 44 ++++++++++++++++++++-
>>  arch/xtensa/include/asm/Kbuild     |  1 +
>>  include/asm-generic/simd.h         | 20 ++++++++++
>>  include/linux/simd.h               | 28 +++++++++++++
>>  26 files changed, 234 insertions(+), 21 deletions(-)
>>  create mode 100644 arch/arm/include/asm/simd.h
>>  create mode 100644 include/linux/simd.h
>>
>> diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
>> index 0580cb8c84b2..07b2c1025d34 100644
>> --- a/arch/alpha/include/asm/Kbuild
>> +++ b/arch/alpha/include/asm/Kbuild
>> @@ -2,14 +2,15 @@
>>
>>
>>  generic-y += compat.h
>> +generic-y += current.h
>>  generic-y += exec.h
>>  generic-y += export.h
>>  generic-y += fb.h
>>  generic-y += irq_work.h
>> +generic-y += kprobes.h
>>  generic-y += mcs_spinlock.h
>>  generic-y += mm-arch-hooks.h
>>  generic-y += preempt.h
>>  generic-y += sections.h
>> +generic-y += simd.h
>>  generic-y += trace_clock.h
>> -generic-y += current.h
>> -generic-y += kprobes.h
>
> Given that this patch applies to all architectures at once, it is
> probably better to drop the unrelated reordering hunks to avoid
> conflicts.
>
>> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
>> index feed50ce89fa..a7f4255f1649 100644
>> --- a/arch/arc/include/asm/Kbuild
>> +++ b/arch/arc/include/asm/Kbuild
>> @@ -22,6 +22,7 @@ generic-y += parport.h
>>  generic-y += pci.h
>>  generic-y += percpu.h
>>  generic-y += preempt.h
>> +generic-y += simd.h
>>  generic-y += topology.h
>>  generic-y += trace_clock.h
>>  generic-y += user.h
>> diff --git a/arch/arm/include/asm/simd.h b/arch/arm/include/asm/simd.h
>> new file mode 100644
>> index 000000000000..263950dd69cb
>> --- /dev/null
>> +++ b/arch/arm/include/asm/simd.h
>> @@ -0,0 +1,63 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>> + */
>> +
>> +#include <linux/simd.h>
>> +#ifndef _ASM_SIMD_H
>> +#define _ASM_SIMD_H
>> +
>> +#ifdef CONFIG_KERNEL_MODE_NEON
>> +#include <asm/neon.h>
>> +
>> +static __must_check inline bool may_use_simd(void)
>> +{
>> +       return !in_interrupt();
>> +}
>> +
>
> Remember this guy?
>
> https://marc.info/?l=linux-arch&m=149631094625176&w=2
>
> That was never merged, so let's get it right this time.
>
...
>> diff --git a/include/linux/simd.h b/include/linux/simd.h
>> new file mode 100644
>> index 000000000000..33bba21012ff
>> --- /dev/null
>> +++ b/include/linux/simd.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
>> + */
>> +
>> +#ifndef _SIMD_H
>> +#define _SIMD_H
>> +
>> +typedef enum {
>> +       HAVE_NO_SIMD = 1 << 0,
>> +       HAVE_FULL_SIMD = 1 << 1,
>> +       HAVE_SIMD_IN_USE = 1 << 31
>> +} simd_context_t;
>> +

Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
about it): the use of typedef in new code is strongly discouraged.
This policy predates my involvement, so perhaps Joe can elaborate on
the rationale?


>> +#include <linux/sched.h>
>> +#include <asm/simd.h>
>> +
>> +static inline void simd_relax(simd_context_t *ctx)
>> +{
>> +#ifdef CONFIG_PREEMPT
>> +       if ((*ctx & HAVE_SIMD_IN_USE) && need_resched()) {
>> +               simd_put(ctx);
>> +               simd_get(ctx);
>> +       }
>> +#endif
>
> Could we return a bool here indicating whether we rescheduled or not?
> In some cases, we could pass that into the asm code as a 'reload'
> param, allowing repeated loads of key schedules, round constant tables
> or S-boxes to be elided.
>
>> +}
>> +
>> +#endif /* _SIMD_H */
>> --
>> 2.19.0
>>
