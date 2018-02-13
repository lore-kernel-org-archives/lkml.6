Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966105AbeBMXd2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:33:28 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33762 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966027AbeBMXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:33:26 -0500
X-Google-Smtp-Source: AH8x226Irm4t2i8rzfZl40PG79dsUlrYD4JjZlXX0/qIc8SovF3Q19lLzmXFJXIWgd7Io3ZRy7PJTN2kFvSWH3xDL7w=
MIME-Version: 1.0
In-Reply-To: <CAP8WD_bZFWx=MadMfSb_nXYgNocxHjG1+WaJ38GqeBF559SDVw@mail.gmail.com>
References: <CAP8WD_bdbmAp=bYAXp--36SME5Cgn42ovz+YpjEt94fzaVt4Ew@mail.gmail.com>
 <20180213165159.GR695913@devbig577.frc2.facebook.com> <CAP8WD_Z+yYXiRUZt4eMo2+zOSPFhsw=XiqJQUqVZFGGnGoWdPg@mail.gmail.com>
 <CAGXu5jLz+6ky3i4ShE2b+31UDi0cakQqa8YVdJo4F3NK2i2eTA@mail.gmail.com> <CAP8WD_bZFWx=MadMfSb_nXYgNocxHjG1+WaJ38GqeBF559SDVw@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 15:33:24 -0800
X-Google-Sender-Auth: s0NcAwOaEmyma6Dl8H1LtoZ4h2s
Message-ID: <CAGXu5j+pCrOD9_t+3o2tyzfKuuMem5fsGfr2XQH-XEKUf=Hufg@mail.gmail.com>
Subject: Re: x86/stack protector: X86_32_LAZY_GS=n hangs kernel on old processors
To: whiteheadm@acm.org
Cc: Tejun Heo <tj@kernel.org>, jeremy@xensource.com,
        Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 3:14 PM, tedheadster <tedheadster@gmail.com> wrote:
> Kees,
>   I am running the 4.16-rc1 release. My arch/x86/Kconfig has this logic:
>
> config X86_32_LAZY_GS
>         def_bool y
>         depends on X86_32 && CC_STACKPROTECTOR_NONE
>
> I get a hang on i486 when I choose any of these configuration options:
>
> CONFIG_CC_STACKPROTECTOR_AUTO=y
> CONFIG_CC_STACKPROTECTOR_REGULAR=y
> CONFIG_CC_STACKPROTECTOR_STRONG=y
>
> Also, CONFIG_X86_32_LAZY_GS does not appear in any of these config
> files, not even as "# CONFIG_X86_32_LAZY_GS is not set", which I
> thought was strange.

I think that's normal because it's forced to be unselectedable due to
CC_STACKPROTECTOR_NONE not being set.

> The only configuration that works on i486 is:
>
> CONFIG_CC_STACKPROTECTOR_NONE=y
> CONFIG_X86_32_LAZY_GS=y
>
> Now it gets interesting. All four of these configurations boots
> successfully when compiled for, and run on, a Pentium 4 M
> (CONFIG_PENTIUM4). So it certainly is related to what version of the
> processor you use.
>
> I will continue to try other configuration combinations and report back.

Okay, that's pretty weird. And does 4.15 boot with either of:

CONFIG_CC_STACKPROTECTOR_REGULAR=y
CONFIG_CC_STACKPROTECTOR_STRONG=y

Because if so, I'm very confused. If it does _not_ boot, then I can
chalk this up to an untested CPU/compiler combo and disable _AUTO on
X86_32, as there appears to be a pre-existing conflict there. (I doubt
it will turn out to be that easy... it never is.)

FWIW, the core change is 2bc2f688fdf8808de4f36be563ccdb0bde7c0c54
(though the next two commits build on it and introduce _AUTO).

-Kees

-- 
Kees Cook
Pixel Security
