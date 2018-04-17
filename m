Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeDQRLL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:11:11 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36292 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753315AbeDQRLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:11:08 -0400
X-Google-Smtp-Source: AIpwx48hx2gwTSLCXKmjvj7gNMLwuG895P+ZwTd00mwUncvYkC9fnpiDcuBMC5c/BkUyqQFKQtzFq6fNYPNJnDAT5I0=
MIME-Version: 1.0
In-Reply-To: <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
References: <20180417104909.22D416C07D@po15720vm.idsi0.si.c-s.fr>
 <CA+7wUszKbPKu86jSprEBJsxJOmyAc42x5S4XmPce_RFXTsHTfQ@mail.gmail.com> <e49e2296-11f8-a2fa-6b64-db18ba5db641@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Tue, 17 Apr 2018 19:10:46 +0200
X-Google-Sender-Auth: 1J8fIKkVVYqquUz15DeA2EBX8GA
Message-ID: <CA+7wUswJoGnb50y8jbPfsi9ztCO1jZ+O4cirHtXc7gp7MXRm5Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Allow selection of CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3HHBFMQ003247

On Tue, Apr 17, 2018 at 6:49 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 17/04/2018 à 18:45, Mathieu Malaterre a écrit :
>>
>> On Tue, Apr 17, 2018 at 12:49 PM, Christophe Leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> This option does dead code and data elimination with the linker by
>>> compiling with -ffunction-sections -fdata-sections and linking with
>>> --gc-sections.
>>>
>>> By selecting this option on mpc885_ads_defconfig,
>>> vmlinux LOAD segment size gets reduced by 10%
>>>
>>> Program Header before the patch:
>>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>>>           filesz 0x0036eda4 memsz 0x0038de04 flags rwx
>>>
>>> Program Header after the patch:
>>>      LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
>>>           filesz 0x00316da4 memsz 0x00334268 flags rwx
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/Kconfig | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 8fe4353be5e3..e1fac49cf465 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -888,6 +888,14 @@ config PPC_MEM_KEYS
>>>
>>>            If unsure, say y.
>>>
>>> +config PPC_UNUSED_ELIMINATION
>>> +       bool "Eliminate unused functions and data from vmlinux"
>>> +       default n
>>> +       select LD_DEAD_CODE_DATA_ELIMINATION
>>> +       help
>>> +         Select this to do dead code and data elimination with the
>>> linker
>>> +         by compiling with -ffunction-sections -fdata-sections and
>>> linking
>>> +         with --gc-sections.
>>>   endmenu
>>>
>>
>> Just for reference, I cannot boot my Mac Mini G4 anymore (yaboot). The
>> messages I can see (prom_init) are:
>
>
> Which version of GCC do you use ?

$ powerpc-linux-gnu-gcc --version
powerpc-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

this is simply coming from:

$ apt-cache policy crossbuild-essential-powerpc
crossbuild-essential-powerpc:
  Installed: 12.3
  Candidate: 12.3
  Version table:
 *** 12.3 500
        500 http://ftp.fr.debian.org/debian stretch/main amd64 Packages
        500 http://ftp.fr.debian.org/debian stretch/main i386 Packages
        100 /var/lib/dpkg/status


> Can you provide the generated System.map with and without that option active
> ?

$ du -sh g4/System.map.*
1.7M g4/System.map.with
1.8M g4/System.map.without

Will send them by private emails.

> Thanks
> Christophe
>
>
>>
>> ---
>> done
>> copying OF device tree...
>> Building dt strings...
>> Building dt structure...
>> Device tree strings 0x01100000 -> 0x01100e02
>> Device tree struct   0x01101000 -> 0x01109000
>> Quiescing Open Firmware ...
>> Booting Linux via __start() @ 0x00140000 ...
>> _
>> ---
>>
>>
>>
>>>   config ISA_DMA_API
>>> --
>>> 2.13.3
>>>
>
