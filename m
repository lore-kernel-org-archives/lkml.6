Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933367AbeCNDH4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 23:07:56 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40977 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933158AbeCNDHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 23:07:55 -0400
X-Google-Smtp-Source: AG47ELuDAqa4ujHqq0GLq0oPwIV8o+cbst7s8BtL5RZFGKaRUTouyeklvbF/QrOB7Md9r+aNi5fipw==
Date: Tue, 13 Mar 2018 20:07:52 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Mar 2018 20:05:19 PDT (-0700)
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
In-Reply-To: <CA+ZOyagHPWNw6uLAGri0cQph06MmspMjUZC--YBe8HRBA2Cd5g@mail.gmail.com>
CC: shea@shealevy.com, zong@andestech.com, albert@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime@andestech.com
From: Palmer Dabbelt <palmer@sifive.com>
To: zongbox@gmail.com
Message-ID: <mhng-bb15ab0a-464a-4baf-bd4c-e8c409722351@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Mar 2018 18:34:19 PDT (-0700), zongbox@gmail.com wrote:
> 2018-03-14 5:30 GMT+08:00 Shea Levy <shea@shealevy.com>:
>> Hi Palmer,
>>
>> Palmer Dabbelt <palmer@sifive.com> writes:
>>
>>> On Tue, 13 Mar 2018 01:35:05 PDT (-0700), zong@andestech.com wrote:
>>>> These patches resolve the some issues of loadable module.
>>>>   - symbol out of ranges
>>>>   - unknown relocation types
>>>>
>>>> The reference of external variable and function symbols
>>>> cannot exceed 32-bit offset ranges in kernel module.
>>>> The module only can work on the 32-bit OS or the 64-bit
>>>> OS with sv32 virtual addressing.
>>>>
>>>> These patches will generate the .got, .got.plt and
>>>> .plt sections during loading module, let it can refer
>>>> to the symbol which locate more than 32-bit offset.
>>>> These sections depend on the relocation types:
>>>>  - R_RISCV_GOT_HI20
>>>>  - R_RISCV_CALL_PLT
>>>>
>>>> These patches also support more relocation types
>>>>  - R_RISCV_CALL
>>>>  - R_RISCV_HI20
>>>>  - R_RISCV_LO12_I
>>>>  - R_RISCV_LO12_S
>>>>  - R_RISCV_RVC_BRANCH
>>>>  - R_RISCV_RVC_JUMP
>>>>  - R_RISCV_ALIGN
>>>>  - R_RISCV_ADD32
>>>>  - R_RISCV_SUB32
>>>>
>>>> Zong Li (11):
>>>>   RISC-V: Add sections of PLT and GOT for kernel module
>>>>   RISC-V: Add section of GOT.PLT for kernel module
>>>>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>>>>   RISC-V: Support CALL relocation type in kernel module
>>>>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>>>>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>>>>   RISC-V: Support ALIGN relocation type in kernel module
>>>>   RISC-V: Support ADD32 relocation type in kernel module
>>>>   RISC-V: Support SUB32 relocation type in kernel module
>>>>   RISC-V: Enable module support in defconfig
>>>>   RISC-V: Add definition of relocation types
>>>>
>>>>  arch/riscv/Kconfig                  |   5 ++
>>>>  arch/riscv/Makefile                 |   3 +
>>>>  arch/riscv/configs/defconfig        |   2 +
>>>>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>>>>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>>>>  arch/riscv/kernel/Makefile          |   1 +
>>>>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>>>>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>>  9 files changed, 480 insertions(+), 6 deletions(-)
>>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>>  create mode 100644 arch/riscv/kernel/module.lds
>>>
>>> This is the second set of patches that turn on modules, and it has the same
>>> R_RISCV_ALIGN problem as the other one
>>>
>>>     http://lists.infradead.org/pipermail/linux-riscv/2018-February/000081.html
>>>
>>> It looks like this one uses shared libraries for modules instead of static
>>> objects.  I think using shared objects is the right thing to do, as it'll allow
>>> us to place modules anywhere in the address space by having multiple GOTs and
>>> PLTs.
>>
>> Can you expand on this? It was my understanding that outside of the
>> context of multiple address spaces sharing code the GOT and PLT were
>> simply unnecessary overhead, what benefit would they bring here?
>>
>>> That's kind of complicated, though, so we can start with something
>>> simpler like this.
>
> Hi,
>
> The kernel module is a object file, it is not be linked by linker, the
> GOT and PLT
> sections will not be generated through -fPIC option, but it will
> generate the relative
> relocation type. As Palmer mention before, If we have GOT and PLT sections,
> we can put the module anywhere, even we support the KASLR in the kernel.

Sorry, I guess I meant PIC objects not shared objects (I keep forgetting about
PIE).  We'll probably eventually add large code model targets, but they might
end up just being functionally equilivant to PIE with multi-GOT and multi-PLT
so it might not matter.

Either way, this is the sanest way to do it for now.

> For the ALIGN problem, the kernel module loader is difficult to remove
> or migrate
> the module's code like relax doing, so the remnant nop instructions harm the
> performance,  I agree the point that adding the mno-relax option and checking
> the alignment in ALIGN type in module loader.

Sounds good.  I just merged the mno-relax stuff, it'll show up when I get
around to generating a 7.3.0 backport branch.  For now I think you should just
fail on R_RISCV_ALIGN and attempt to pass -mno-relax to the compiler (via
something like "$(call cc-option,-mno-relax)", like we do for
"-mstrict-align").  I don't think it's worth handling R_RISCV_ALIGN in the
kernel, as that's essentially the same as full relaxation support.

>>> That's kind of complicated, though, so we can start with something
>>> simpler like this.
>
> So what is the suggestion for that.

Well, I'm not really sure -- essentially the idea of proper multi-GOT and
multi-PLT support would be to merge the GOTs and PLTs of modules together when
they're within range of each other.  We haven't even figured this out in
userspace yet, so it's probably not worth attempting for kernel modules for a
bit.

If I understand your code correctly, you're currently generating one GOT and
one PLT per loaded module.  If that's the case, then this is correct, it's just
possible to save some memory by merging these tables.  It's probably not worth
the complexity for kernel modules for a while.
