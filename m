Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeCXPVr (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 11:21:47 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40382 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeCXPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 11:21:46 -0400
X-Google-Smtp-Source: AIpwx4+yvxoXRddbMrLuG5ZGvMUhkz/5B8exvvFGPp3cNOzS9EMKxYhSc2X5kK9nU9BHiPOTgcnCRjn+sM/DoI9VOVI=
MIME-Version: 1.0
In-Reply-To: <87370pvdcm.fsf@xps13.shealevy.com>
References: <mhng-381d004e-2fbd-4012-9ccc-e845dd5396c0@palmer-si-x1c4> <87370pvdcm.fsf@xps13.shealevy.com>
From: Zong Li <zongbox@gmail.com>
Date: Sat, 24 Mar 2018 23:21:44 +0800
Message-ID: <CA+ZOyaiyz8OwG4txdEoYXOpzA3F7syxuOEoGaD=BatYwUfqG+Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
To: Shea Levy <shea@shealevy.com>
Cc: Palmer Dabbelt <palmer@sifive.com>, Zong Li <zong@andestech.com>,
        greentime@andestech.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        albert@sifive.com, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-24 20:59 GMT+08:00 Shea Levy <shea@shealevy.com>:
> Hi Palmer, Zong,
>
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Thu, 15 Mar 2018 01:50:40 PDT (-0700), zong@andestech.com wrote:
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
>>> This is the list of testing modules:
>>> # lsmod
>>> btrfs 7876158 0 - Live 0xffffffd00745d000
>>> ramoops 90806 0 - Live 0xffffffd0024b8000
>>> lzo 10554 0 - Live 0xffffffd002050000
>>> zstd_decompress 567575 1 btrfs, Live 0xffffffd00238b000
>>> zstd_compress 1543837 1 btrfs, Live 0xffffffd002211000
>>> zram 101300 0 - Live 0xffffffd0021b8000
>>> xxhash 62254 2 zstd_decompress,zstd_compress, Live 0xffffffd0020cf000
>>> xor 33246 1 btrfs, Live 0xffffffd002042000
>>> xfs 4395343 0 - Live 0xffffffd00399e000
>>> tun 252041 0 - Live 0xffffffd0038e0000
>>> test_user_copy 5265 0 - Live 0xffffffd003783000
>>> test_static_keys 19606 0 - Live 0xffffffd003717000
>>> test_static_key_base 7374 1 test_static_keys, Live 0xffffffd0036dc000
>>> test_printf 7804 0 [permanent], Live 0xffffffd00369c000
>>> test_module 1557 0 - Live 0xffffffd003646000
>>> test_kmod 49100 0 - Live 0xffffffd0035f2000
>>> test_bpf 1599301 0 - Live 0xffffffd003000000
>>> test_bitmap 4403 0 - Live 0xffffffd002dd8000
>>> reed_solomon 38866 1 ramoops, Live 0xffffffd002d86000
>>> raid6_pq 161872 1 btrfs, Live 0xffffffd002b9e000
>>> netdevsim 65401 0 - Live 0xffffffd002910000
>>>
>>> Signed-off-by: Zong Li <zong@andestech.com>
>>> ---
>>> Change in v2:
>>>  - Add compile option 'mno-relax' for build kernel module
>>>  - Just fail on ALIGN type, this is unexpected type with mno-relax.
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
>>>  arch/riscv/Kconfig                  |   5 +
>>>  arch/riscv/Makefile                 |   5 +
>>>  arch/riscv/configs/defconfig        |   2 +
>>>  arch/riscv/include/asm/module.h     | 113 +++++++++++++++++++++++
>>>  arch/riscv/include/uapi/asm/elf.h   |   7 ++
>>>  arch/riscv/kernel/Makefile          |   1 +
>>>  arch/riscv/kernel/module-sections.c | 156 +++++++++++++++++++++++++++++++
>>>  arch/riscv/kernel/module.c          | 179 ++++++++++++++++++++++++++++++++++--
>>>  arch/riscv/kernel/module.lds        |   8 ++
>>>  9 files changed, 470 insertions(+), 6 deletions(-)
>>>  create mode 100644 arch/riscv/include/asm/module.h
>>>  create mode 100644 arch/riscv/kernel/module-sections.c
>>>  create mode 100644 arch/riscv/kernel/module.lds
>>
>> Thanks!  I've added this to our for-next branch, so it should start to get a
>> bit more testing soon.  I've had a bit of the flu and am therefor a bit out of
>> it, so I'll try to look closer before the next merge window.
>>
>
> I've updated my kernel to point to riscv-all, and now I'm getting:
>
> scsi_mod: target ffffffe000029a80 can not be addressed by the 32-bit offset from PC = 00000000fe3be867
>
> Any idea why this might be? My patchset had a patch [1] to ensure
> modules were loaded within a 32 bit offset of the kernel text, do we
> need to include that?
>
> Thanks,
> Shea
>
> [1] http://lists.infradead.org/pipermail/linux-riscv/2018-February/000083.html
>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

Hi Shea,

I'm not sure what is the relocation type or program behavior on your situation.

For the code generation, the following relocation types only allow the
target offset in the 32 bit range:
- RISCV_PCREL_HI20
- RISCV_HI20
- RISCV_CALL
- RISCV_CALL_PLT without enabling MODULES_SECTIONS

In my view, we cannot limit the start address of kernel text is always
adjacent to the module region.
