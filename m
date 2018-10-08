Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905D3C67879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27EC920858
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 23:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gqud9ZaP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EC920858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbeJIGmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 02:42:46 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46450 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIGmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 02:42:46 -0400
Received: by mail-yw1-f65.google.com with SMTP id j202-v6so8786486ywa.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HzgMVd9djCU2L72Q4Gc+w9tBTB3FrYVxVbzZj0MyEyI=;
        b=Gqud9ZaPRTWT1dLinElnB7opkBjl5XKjMUF1uB1drS5R56oNmdckk/ZUVNPSORsU6q
         i2bfafvz+8Ihqb6JjexQJrnTqJMiy/86iUz9bl31HtpYfJHhLYaKCzEgNTXGtfOqJuSe
         DU02xbSgwhvx7zl0VZwKg07wm7lnBCBEAzWxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HzgMVd9djCU2L72Q4Gc+w9tBTB3FrYVxVbzZj0MyEyI=;
        b=radyU8gr7GLaSiytKntrLTqkM+Rn5CUOqEbt00CLKGk0qbJnctWKIapvX+7K4Ic/n1
         26N6rcPOeWEyxwqeLFpCnRrR258kjwmMKgCHr0EZobgQ0v5Ya+Z82kHF9m5gaVzAV2dz
         R17tGyxOEHkBh/CPOxhdS5eijDibAIq1HJCgTxzr9EAOs3vxG+hCWDEEcWErvwRPUoe4
         lOJOfnhEN/in+izGFFekcvdzRGqwsFw1Jp68O5ulelOawUJS5iqYxSSooT9Lj7+krqwy
         Bxn1ZYZUyzyECNMoYaqifUv7X5um81I3yiA5TX433pcILIyvm6DrBnxztDVWUlpKOcGI
         xfQw==
X-Gm-Message-State: ABuFfoh90cuOhlpy2ZoVGX0deJxew+VE5bRLr3XEOOaBZ0DtiAU6XNdv
        sv9VMLeW1+67F+c/s9w5cI9QMfcw9Eg=
X-Google-Smtp-Source: ACcGV63Ke1lIJw81jziFmLVWDayRbdX4Ahmr9SUALFpRIatTPt4i466yDPWqWCEKSvVSrykmDR2c+g==
X-Received: by 2002:a81:5146:: with SMTP id f67-v6mr14018678ywb.30.1539041317925;
        Mon, 08 Oct 2018 16:28:37 -0700 (PDT)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id 128-v6sm6942225ywx.108.2018.10.08.16.28.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 16:28:36 -0700 (PDT)
Received: by mail-yw1-f48.google.com with SMTP id y14-v6so8796848ywa.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 16:28:35 -0700 (PDT)
X-Received: by 2002:a81:9b83:: with SMTP id s125-v6mr14311094ywg.47.1539041315294;
 Mon, 08 Oct 2018 16:28:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 16:28:34 -0700 (PDT)
In-Reply-To: <20181008202209.GA6597@zn.tnic>
References: <20181005161333.765973-1-arnd@arndb.de> <tip-1be3f247c2882a82279cbcf43717581ea943b692@git.kernel.org>
 <20181008202209.GA6597@zn.tnic>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 16:28:34 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
Message-ID: <CAGXu5j+4hjJSFpYi=5SqDmkonJ79J=hcb65qJC8+_r6+5NHewg@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/mm: Avoid VLA in pgd_alloc()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 1:22 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Oct 05, 2018 at 09:24:53AM -0700, tip-bot for Arnd Bergmann wrote:
>> Commit-ID:  1be3f247c2882a82279cbcf43717581ea943b692
>> Gitweb:     https://git.kernel.org/tip/1be3f247c2882a82279cbcf43717581ea943b692
>> Author:     Arnd Bergmann <arnd@arndb.de>
>> AuthorDate: Fri, 5 Oct 2018 18:13:16 +0200
>> Committer:  Ingo Molnar <mingo@kernel.org>
>> CommitDate: Fri, 5 Oct 2018 18:16:55 +0200
>>
>> x86/mm: Avoid VLA in pgd_alloc()
>>
>> Turning on -Wvla found a new VLA usage:
>>
>>   arch/x86/mm/pgtable.c: In function 'pgd_alloc':
>>   include/linux/build_bug.h:29:45: error: ISO C90 forbids variable length array 'u_pmds' [-Werror=vla]
>>   arch/x86/mm/pgtable.c:190:34: note: in expansion of macro 'static_cpu_has'
>>    #define PREALLOCATED_USER_PMDS  (static_cpu_has(X86_FEATURE_PTI) ? \
>>                                     ^~~~~~~~~~~~~~
>>   arch/x86/mm/pgtable.c:431:16: note: in expansion of macro 'PREALLOCATED_USER_PMDS'
>>     pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
>>                 ^~~~~~~~~~~~~~~~~~~~~~
>>
>> Use the actual size of the array that is used for X86_FEATURE_PTI
>> instead of the variable size.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Joerg Roedel <jroedel@suse.de>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Toshi Kani <toshi.kani@hpe.com>
>> Fixes: 68664695ae57 ("Makefile: Globally enable VLA warning")
>> Fixes: f59dbe9ca670 ("x86/pgtable/pae: Use separate kernel PMDs for user page-table")
>> Link: http://lkml.kernel.org/r/20181005161333.765973-1-arnd@arndb.de
>> Signed-off-by: Ingo Molnar <mingo@kernel.org>
>> ---
>>  arch/x86/mm/pgtable.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index 089e78c4effd..386b43e3e0ac 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -189,6 +189,7 @@ static void pgd_dtor(pgd_t *pgd)
>>   */
>>  #define PREALLOCATED_USER_PMDS        (static_cpu_has(X86_FEATURE_PTI) ? \
>>                                       KERNEL_PGD_PTRS : 0)
>> +#define MAX_PREALLOCATED_USER_PMDS KERNEL_PGD_PTRS
>>
>>  void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
>>  {
>> @@ -211,6 +212,7 @@ void pud_populate(struct mm_struct *mm, pud_t *pudp, pmd_t *pmd)
>>  /* No need to prepopulate any pagetable entries in non-PAE modes. */
>>  #define PREALLOCATED_PMDS    0
>>  #define PREALLOCATED_USER_PMDS        0
>> +#define MAX_PREALLOCATED_USER_PMDS 0
>>  #endif       /* CONFIG_X86_PAE */
>>
>>  static void free_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
>> @@ -428,8 +430,8 @@ static inline void _pgd_free(pgd_t *pgd)
>>  pgd_t *pgd_alloc(struct mm_struct *mm)
>>  {
>>       pgd_t *pgd;
>> -     pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
>> -     pmd_t *pmds[PREALLOCATED_PMDS];
>> +     pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
>> +     pmd_t *pmds[MAX_PREALLOCATED_USER_PMDS];
>>
>>       pgd = _pgd_alloc();
>
> For whatever reason - probably because it forced
> MAX_PREALLOCATED_USER_PMDS be KERNEL_PGD_PTRS and not 0 (and I don't
> have CONFIG_PAGE_TABLE_ISOLATION so it was 0 here with my .config
> before) but this patch causes the fun below.
>
> If I revert it, no splat.
>
> Also, config has CONFIG_X86_PAE=y. And CONFIG_STACKPROTECTOR_STRONG=y. If I
> disable _STRONG, it boots too. Attached.

This really should mean that the stack canary changed. Either the
stack canary wasn't prepared yet (but this is from run_init_process(),
which is WELL after boot_init_stack_canary()), or the canary was
actually stomped on, which would certainly be a bug in the existing
code.

Ah! I see it now. "pmds" shouldn't have changed, it's not .._USER_PMDS...

-       pmd_t *u_pmds[PREALLOCATED_USER_PMDS];
-       pmd_t *pmds[PREALLOCATED_PMDS];
+       pmd_t *u_pmds[MAX_PREALLOCATED_USER_PMDS];
+       pmd_t *pmds[MAX_PREALLOCATED_USER_PMDS];

-Kees

>
> [    1.749047] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0
> [    1.750306] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W         4.19.0-rc6+ #5
> [    1.751353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
> [    1.752452] Call Trace:
> [    1.752902]  dump_stack+0x66/0x95
> [    1.753426]  panic+0x94/0x1dd
> [    1.753922]  __stack_chk_fail+0x1e/0x20
> [    1.754486]  ? pgd_alloc+0x29e/0x2a0
> [    1.755028]  pgd_alloc+0x29e/0x2a0
> [    1.755556]  mm_init.isra.60+0x1ec/0x210
> [    1.756128]  mm_alloc+0x30/0x40
> [    1.756635]  __do_execve_file+0x378/0x930
> [    1.757215]  ? __do_execve_file+0x108/0x930
> [    1.757820]  ? kmem_cache_alloc+0x123/0x220
> [    1.758414]  do_execve+0x2c/0x30
> [    1.758936]  run_init_process+0x31/0x36
> [    1.759501]  ? rest_init+0xb0/0xb0
> [    1.760029]  try_to_run_init_process+0x11/0x33
> [    1.760644]  ? rest_init+0xb0/0xb0
> [    1.761173]  kernel_init+0x9e/0xda
> [    1.761705]  ret_from_fork+0x2e/0x38
> [    1.762309] Kernel Offset: disabled
> [    1.762858] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: pgd_alloc+0x29e/0x2a0 ]---
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.



-- 
Kees Cook
Pixel Security
