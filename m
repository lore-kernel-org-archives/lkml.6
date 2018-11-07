Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC1FC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16DA20844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 00:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TQH6Na6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16DA20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731081AbeKGJgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:36:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45362 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731002AbeKGJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:36:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id o19-v6so6972288pll.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 16:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=hubmrFzQ0plWGuu2K62h+KATnuMFguTUWrWDDvxDlQA=;
        b=TQH6Na6j0dexD5BQKsAoXyU0XrjFqmJUGL4ucj2LeR4rD3SvMuwSqW2OcgThS5TNiI
         YElZoSnziQriuTFp3ZW4cPe5Bb5SNcph0V6iV9XfJeXCwFcH1G0b75yYtHveV/pL5jE2
         fsb8egP8nn0GxyFeg/O8PLEBjtcnUeb48fcZc6umcD9r08hYC3WJi6m4bmxPAtiDvPX6
         bK4rgg2b1Gv6ewHyXwNwh42E3Ud6aRcDhYoq4lF0J4KNfrUa5vjaQ3Rk2uqqUGlTMYVg
         Q98b0Bps6hhrkzchZJ/s4AdlMzdUzsMpsveymxH52vBxQapo5FAKUQ9TDh/tNe9ADj+a
         8DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=hubmrFzQ0plWGuu2K62h+KATnuMFguTUWrWDDvxDlQA=;
        b=oxK+pIuZ1uhEE6sp8A8Ud2ztBaqK5Hu25vOa4TmQ7XwjdVdrFuDFu0XCcoVTgCVLUl
         Teetjnj1tDCk+9XLR1wpUt0nQM5FRap/dKFjnkJUphr6Vse248EEIrjBLjWki2Q3xhng
         r+7INNAxkTZiZfxqPpqOIoDcQJbAiliRLsQqMA++0Dnm5e06UeNIVoPqGafVCM2N3udQ
         c2XTos4PdBkHPYJQEl3z90cQ+Y5iLd8s8B5om49+j3+aOVRRE5ME3Bl/5IsFgY5aasLD
         Lm7c/IZsbZhoSRAjhZS5wCJhRjwSYr/bYyVtkGFhT7CNJkvHC7FFF7APi2C+D37tM+ji
         Tkiw==
X-Gm-Message-State: AGRZ1gIBdThOzA89WHdT8Pfypz3Ah7yIaVHYQ4O2sfVKommF5bv23PF0
        5e5xsbsdAyQEDYR6EhQDYKDhfw==
X-Google-Smtp-Source: AJdET5dCNX5Km13vLHHBwP8jKdRGdL5LmAHk44e9Ozyk61W3YmhdBhYJIfeGJ24EK5AzMvNc6terYg==
X-Received: by 2002:a17:902:162:: with SMTP id 89-v6mr28414420plb.293.1541549293315;
        Tue, 06 Nov 2018 16:08:13 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id a11-v6sm28378058pff.8.2018.11.06.16.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 16:08:12 -0800 (PST)
Date:   Tue, 06 Nov 2018 16:08:12 -0800 (PST)
X-Google-Original-Date: Tue, 06 Nov 2018 16:07:51 PST (-0800)
Subject:     Re: [PATCH] riscv: add asm/unistd.h UAPI header
In-Reply-To: <CAK8P3a3JcztCSYBuu5ZJXaV83VNLv_1v3v-EKMR+tC1oOsQesw@mail.gmail.com>
CC:     david.abdurachmanov@gmail.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcin.juszkiewicz@linaro.org, linux@roeck-us.net
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-3c26b2fb-0c11-42f2-9026-1113b200a7b2@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Nov 2018 12:56:15 PST (-0800), Arnd Bergmann wrote:
> On 11/5/18, David Abdurachmanov <david.abdurachmanov@gmail.com> wrote:
>> Marcin Juszkiewicz reported issues while generating syscall table for riscv
>> using 4.20-rc1. The patch refactors our unistd.h files to match some other
>> architectures.
>>
>> - Add asm/unistd.h UAPI header, which has __ARCH_WANT_NEW_STAT
>> - Remove asm/syscalls.h UAPI header and merge to asm/unistd.h
>> - Adjust kernel asm/unistd.h
>>
>> So now asm/unistd.h UAPI header should show all syscalls for riscv.
>>
>> Before this, Makefile simply put `#include <asm-generic/unistd.h>` into
>> generated asm/unistd.h UAPI header thus user didn't see:
>>
>> - __NR_riscv_flush_icache
>> - __NR_newfstatat
>> - __NR_fstat
>>
>> which are supported by riscv kernel.
>>
>> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>
> Thanks for addressing this, your patch correctly fixes riscv64, and
> I should have noticed the mistake when I originally merged the
> broken patch.
>
> However, looking closer I found another problem with the original
> patch that your fix does not address:
>
> __ARCH_WANT_NEW_STAT should only be set on 64-bit
> architectures.
>
> For a 32-bit architecture, we only want __ARCH_WANT_STAT64 if
> any. For 64-bit architectures with compat mode, we still need to
> set __ARCH_WANT_STAT64 from the non-uapi file so we get
> the syscall implementation.
>
> If we don't care about the riscv32 ABI changing yet, we can
> decide to leave out __ARCH_WANT_STAT64 here, and require
> glibc to implement it using statx() like any new architecture.
> stat64 is not y2038 safe, and statx replaces it because of that.

Thanks for pointing this out.   A while ago we decided the rv32 ABI was 
"slushy": it can change if it has a good reason to.  Right now the only planned 
changes are the y2038 changes, which I consider this a part of.  For some 
reason I thought we'd already done this, but since we haven't then I think it 
should go in sooner rather than later -- that will help the glibc guys get 
everything lined up.

The target is still the next glibc release (Feb 1st) for a stable RV32I ABI.  
That's progressing well, with one last blocking issue related to some of our 
floating-point emulation routines before we can submit the port.  This should 
give us ample time to line up the ABIs correctly so everything works.

So I think the correct answer here is to drop __ARCH_WANT_STAT64 from RISC-V.

>> Fixes: 67314ec7b025
>
> That line should be formatted as
>
> Fixes: 67314ec7b025 ("RISC-V: Request newstat syscalls")

Yep, and I have 

[pretty]
	fixes = Fixes: %h (\"%s\")

to make that slightly easier for me to remember :).
