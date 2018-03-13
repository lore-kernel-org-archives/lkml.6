Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932789AbeCMKgB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:36:01 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51099 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932778AbeCMKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:35:56 -0400
X-Google-Smtp-Source: AG47ELtF9UqalW1IDb1/PPn1cvJZvRabUY8nMlVHtYr04wxdZZloYcS/CoMgpQco9/CUfNh43RRg/Xe4WFhmHzNwCss=
MIME-Version: 1.0
In-Reply-To: <cover.1520928420.git.zong@andestech.com>
References: <cover.1520928420.git.zong@andestech.com>
From: Zong Li <zongbox@gmail.com>
Date: Tue, 13 Mar 2018 18:35:55 +0800
Message-ID: <CA+ZOyaj6hb5M6pwGR=9vRr_D8j=Xa1wBHK94A6Qpbb9+RbkwRQ@mail.gmail.com>
Subject: Re: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
To: Zong Li <zong@andestech.com>, palmer@sifive.com, albert@sifive.com,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greentime@andestech.com, patches@groups.riscv.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-13 16:35 GMT+08:00 Zong Li <zong@andestech.com>:
>
> These patches resolve the some issues of loadable module.
>   - symbol out of ranges
>   - unknown relocation types
>
> The reference of external variable and function symbols
> cannot exceed 32-bit offset ranges in kernel module.
> The module only can work on the 32-bit OS or the 64-bit
> OS with sv32 virtual addressing.
>
> These patches will generate the .got, .got.plt and
> .plt sections during loading module, let it can refer
> to the symbol which locate more than 32-bit offset.
> These sections depend on the relocation types:
>  - R_RISCV_GOT_HI20
>  - R_RISCV_CALL_PLT
>
> These patches also support more relocation types
>  - R_RISCV_CALL
>  - R_RISCV_HI20
>  - R_RISCV_LO12_I
>  - R_RISCV_LO12_S
>  - R_RISCV_RVC_BRANCH
>  - R_RISCV_RVC_JUMP
>  - R_RISCV_ALIGN
>  - R_RISCV_ADD32
>  - R_RISCV_SUB32
>
> Zong Li (11):
>   RISC-V: Add sections of PLT and GOT for kernel module
>   RISC-V: Add section of GOT.PLT for kernel module
>   RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
>   RISC-V: Support CALL relocation type in kernel module
>   RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
>   RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
>   RISC-V: Support ALIGN relocation type in kernel module
>   RISC-V: Support ADD32 relocation type in kernel module
>   RISC-V: Support SUB32 relocation type in kernel module
>   RISC-V: Enable module support in defconfig
>   RISC-V: Add definition of relocation types
>
>  arch/riscv/Kconfig                  |   5 ++
>  arch/riscv/Makefile                 |   3 +
>  arch/riscv/configs/defconfig        |   2 +
>  arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
>  arch/riscv/include/uapi/asm/elf.h   |  24 +++++
>  arch/riscv/kernel/Makefile          |   1 +
>  arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
>  arch/riscv/kernel/module.lds        |   8 ++
>  9 files changed, 480 insertions(+), 6 deletions(-)
>  create mode 100644 arch/riscv/include/asm/module.h
>  create mode 100644 arch/riscv/kernel/module-sections.c
>  create mode 100644 arch/riscv/kernel/module.lds
>
> --
> 2.16.1
>

This is the list of testing modules:

# lsmod
btrfs 7876158 0 - Live 0xffffffd00745d000
ramoops 90806 0 - Live 0xffffffd0024b8000
lzo 10554 0 - Live 0xffffffd002050000
zstd_decompress 567575 1 btrfs, Live 0xffffffd00238b000
zstd_compress 1543837 1 btrfs, Live 0xffffffd002211000
zram 101300 0 - Live 0xffffffd0021b8000
xxhash 62254 2 zstd_decompress,zstd_compress, Live 0xffffffd0020cf000
xor 33246 1 btrfs, Live 0xffffffd002042000
xfs 4395343 0 - Live 0xffffffd00399e000
tun 252041 0 - Live 0xffffffd0038e0000
test_user_copy 5265 0 - Live 0xffffffd003783000
test_static_keys 19606 0 - Live 0xffffffd003717000
test_static_key_base 7374 1 test_static_keys, Live 0xffffffd0036dc000
test_printf 7804 0 [permanent], Live 0xffffffd00369c000
test_module 1557 0 - Live 0xffffffd003646000
test_kmod 49100 0 - Live 0xffffffd0035f2000
test_bpf 1599301 0 - Live 0xffffffd003000000
test_bitmap 4403 0 - Live 0xffffffd002dd8000
reed_solomon 38866 1 ramoops, Live 0xffffffd002d86000
raid6_pq 161872 1 btrfs, Live 0xffffffd002b9e000
netdevsim 65401 0 - Live 0xffffffd002910000
lzo_decompress 9580 2 btrfs,lzo, Live 0xffffffd002813000
lzo_compress 21527 2 btrfs,lzo, Live 0xffffffd0027d9000
libcrc32c 2730 1 xfs, Live 0xffffffd00273c000
fuse 676371 0 - Live 0xffffffd0024d0000
exportfs 24850 1 xfs, Live 0xffffffd0020c7000
echainiv 11953 0 - Live 0xffffffd00205a000
