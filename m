Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933291AbeCNDvd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:51:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46775 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932842AbeCNDvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:51:32 -0400
X-Google-Smtp-Source: AG47ELtKg7PqB7vbVuplHoyhOiU4MOYgoLaSsdKyjm0QKo5K65SqqSZcfR9TdcR5gSu5pwpIOZCS6A==
Date: Tue, 13 Mar 2018 20:51:30 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Mar 2018 20:46:00 PDT (-0700)
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <87sh93zmr6.fsf@xps13.shealevy.com>
CC: zong@andestech.com, albert@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com, zongbox@gmail.com,
        greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: shea@shealevy.com
Message-ID: <mhng-708caadb-a358-4f86-95d7-173e6bb787bc@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 14:30:53 PDT (-0700), shea@shealevy.com wrote:
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

We don't currently have any position-dependent RISC-V code models larger than
"medany", in which all code and data must live within a single 32-bit
addressable range.  The PLT and GOT sort of provide an out here, so the code
only needs to get to the table (which can then get anywhere via an indirection
layer).

This is relevant for Linux modules because it lets us load modules anywhere in
the address space.  It's also a bit of a headache, as it either requires a
GOT+PLT per module (which is big) or merging tables (which is hard).
