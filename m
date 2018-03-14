Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeCNBeW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 21:34:22 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35210 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932732AbeCNBeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 21:34:20 -0400
X-Google-Smtp-Source: AG47ELt4FbbOTM5qbGhlCJGLpKhiwcvLFLT/QtRhguHHjmcccscQFefkCzYwTflcCkHG+mveVwVQhK8v2fffFxldalk=
MIME-Version: 1.0
In-Reply-To: <87sh93zmr6.fsf@xps13.shealevy.com>
References: <mhng-dcc790fc-8fd7-41c8-84c8-cc4b8bd662ea@palmer-si-x1c4> <87sh93zmr6.fsf@xps13.shealevy.com>
From: Zong Li <zongbox@gmail.com>
Date: Wed, 14 Mar 2018 09:34:19 +0800
Message-ID: <CA+ZOyagHPWNw6uLAGri0cQph06MmspMjUZC--YBe8HRBA2Cd5g@mail.gmail.com>
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
To: Shea Levy <shea@shealevy.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Zong Li <zong@andestech.com>,
        albert@sifive.com, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-14 5:30 GMT+08:00 Shea Levy <shea@shealevy.com>:
> Hi Palmer,
>
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
>>> These patches resolve the some issues of loadable module.
>>>   - symbol out of ranges
>>>   - unknown relocation types
>>>
>>> The reference of external variable and function symbols
>>> cannot exceed 32-bit offset ranges in kernel module.
>>> The module only can work on the 32-bit OS or the 64-bit
>>> OS with sv32 virtual addressing.
>>>
>>> These patches will generate the .got, .got.plt and
>>> .plt sections during loading module, let it can refer
>>> to the symbol which locate more than 32-bit offset.
>>> These sections depend on the relocation types:
>>>  - R_RISCV_GOT_HI20
>>>  - R_RISCV_CALL_PLT
>>>
>>> These patches also support more relocation types
>>>  - R_RISCV_CALL
>>>  - R_RISCV_HI20
>>>  - R_RISCV_LO12_I
>>>  - R_RISCV_LO12_S
>>>  - R_RISCV_RVC_BRANCH
>>>  - R_RISCV_RVC_JUMP
>>>  - R_RISCV_ALIGN
>>>  - R_RISCV_ADD32
>>>  - R_RISCV_SUB32
>>>
>>> Zong Li (11):
>>>   RISC-V: Add sections of PLT and GOT for kernel module
>>>   RISC-V: Add section of GOT.PLT for kernel module
>>>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>>>   RISC-V: Support CALL relocation type in kernel module
>>>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>>>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>>>   RISC-V: Support ALIGN relocation type in kernel module
>>>   RISC-V: Support ADD32 relocation type in kernel module
>>>   RISC-V: Support SUB32 relocation type in kernel module
>>>   RISC-V: Enable module support in defconfig
>>>   RISC-V: Add definition of relocation types
>>>
>>>  arch/riscv/Kconfig                  |   5 ++
>>>  arch/riscv/Makefile                 |   3 +
>>>  arch/riscv/configs/defconfig        |   2 +
>>>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>>>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>>>  arch/riscv/kernel/Makefile          |   1 +
>>>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>>>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>  create mode 100644 arch/riscv/kernel/module.lds
>>
>> This is the second set of patches that turn on modules, and it has the same
>> R_RISCV_ALIGN problem as the other one
>>
>>     http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>>
>> It looks like this one uses shared libraries for modules instead of static
>> objects.  I think using shared objects is the right thing to do, as it'll allow
>> us to place modules anywhere in the address space by having multiple GOTs and
>> PLTs.
>
> Can you expand on this? It was my understanding that outside of the
> context of multiple address spaces sharing code the GOT and PLT were
> simply unnecessary overhead, what benefit would they bring here?
>
>> That's kind of complicated, though, so we can start with something
>> simpler like this.

Hi,

The kernel module is a object file, it is not be linked by linker, the
GOT and PLT
sections will not be generated through -fPIC option, but it will
generate the relative
relocation type. As Palmer mention before, If we have GOT and PLT sections,
we can put the module anywhere, even we support the KASLR in the kernel.

For the ALIGN problem, the kernel module loader is difficult to remove
or migrate
the module's code like relax doing, so the remnant nop instructions harm the
performance,  I agree the point that adding the mno-relax option and checking
the alignment in ALIGN type in module loader.

>> That's kind of complicated, though, so we can start with something
>> simpler like this.

So what is the suggestion for that.

Thanks a lot.
