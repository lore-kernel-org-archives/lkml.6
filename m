Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeBUKJz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:09:55 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:55062 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932631AbeBUKJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:09:54 -0500
X-Google-Smtp-Source: AH8x227X5C1Xa5dEj674kPGhLjgNHJOkn9X1zCdQoTcoZJs+8PhMdWASNfbdIbIdsIX+KgwH/ZO5WcecFpuRo2J/t8U=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a11uyLcB=42ZTFOMDvxv5XZ3tCPh+f_MN6SEAjmPRRjtg@mail.gmail.com>
References: <20180220215954.4092811-1-arnd@arndb.de> <20180220215954.4092811-4-arnd@arndb.de>
 <CAKv+Gu-Be_saZeHzpWrjJBdeiOSJih0H-d1pjkpj+sq7ytLVyw@mail.gmail.com> <CAK8P3a11uyLcB=42ZTFOMDvxv5XZ3tCPh+f_MN6SEAjmPRRjtg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 21 Feb 2018 10:09:53 +0000
Message-ID: <CAKv+Gu-PR4mS+oB6fdGhpG3Fp+OhZUr=KkbueOoC9YpmDQgeqQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] [HACK] pass endianess flag to LTO linker
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 February 2018 at 09:48, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 21, 2018 at 9:37 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> On 20 February 2018 at 21:59, Arnd Bergmann <arnd@arndb.de> wrote:
>>> We need some way to pass -mbig-endian to the linker during the
>>> LTO link stage, otherwise we get a waning like
>>>
>>> arm-linux-gnueabi/bin/ld: arch/arm/lib/clearbit.o: compiled for a big endian system and target is little endian
>>>
>>> for each file we link in.
>>>
>>> There is probably a better method of passing that flag, I'm just
>>> adding it to a different hack that I added earlier for x86 LTO
>>> here.
>>>
>>
>> In general, LTO requires that *all* C flags are passed to the linker.
>> Given that linking now involves code generation, any C flag that
>> affects code generation must be visible to the linker as well, which
>> includes all the tweaks and overrides that we add per-file or
>> per-directory. It is not clear to me how much of this is carried in
>> the intermediate representation as metadata, but we should probably
>> err on the side of caution here, and update the Kbuild routines to
>> pass the complete value of KBUILD_CFLAGS (or whatever it is called) to
>> ld as well.
>
> It looks like we're just missing KBUILD_CPPFLAGS.
>
> However, I wonder for the more general case what happens to files
> that require non-standard CFLAGS.

That was kind of my point, yes.

> In some cases we turn off
> some optimization step for a file, we might remove '-pg', or build for
> a particular target architecture. Do we have to turn off -flto for any file
> that requires this for correct behavior?
>

Excellent question. I think the problem is that the file boundary is
becoming blurred with LTO, and so any option that is absolutely
required to build a single file correctly may need to be applied to
vmlinux as a whole. Whether that is the case for any particular option
depends on which compiler pass(es) is (are) affected by the option,
i.e., whether it is taken into account when creating the intermediate
representation.
