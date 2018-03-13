Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCMIsT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:48:19 -0400
Received: from exmail.andestech.com ([59.124.169.137]:62208 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeCMIsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:48:17 -0400
From: Zong Li <zong@andestech.com>
To: <palmer@sifive.com>, <albert@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <zong@andestech.com>, <zongbox@gmail.com>
CC: <greentime@andestech.com>
Subject: [PATCH 00/11] RISC-V: Resolve the issue of loadable module on 64-bit
Date: Tue, 13 Mar 2018 16:35:05 +0800
Message-ID: <cover.1520928420.git.zong@andestech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.1.85]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w2D8Wt9W024930
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches resolve the some issues of loadable module.
  - symbol out of ranges
  - unknown relocation types

The reference of external variable and function symbols
cannot exceed 32-bit offset ranges in kernel module.
The module only can work on the 32-bit OS or the 64-bit
OS with sv32 virtual addressing.

These patches will generate the .got, .got.plt and
.plt sections during loading module, let it can refer
to the symbol which locate more than 32-bit offset.
These sections depend on the relocation types:
 - R_RISCV_GOT_HI20
 - R_RISCV_CALL_PLT

These patches also support more relocation types
 - R_RISCV_CALL
 - R_RISCV_HI20
 - R_RISCV_LO12_I
 - R_RISCV_LO12_S
 - R_RISCV_RVC_BRANCH
 - R_RISCV_RVC_JUMP
 - R_RISCV_ALIGN
 - R_RISCV_ADD32
 - R_RISCV_SUB32

Zong Li (11):
  RISC-V: Add sections of PLT and GOT for kernel module
  RISC-V: Add section of GOT.PLT for kernel module
  RISC-V: Support GOT_HI20/CALL_PLT relocation type in kernel module
  RISC-V: Support CALL relocation type in kernel module
  RISC-V: Support HI20/LO12_I/LO12_S relocation type in kernel module
  RISC-V: Support RVC_BRANCH/JUMP relocation type in kernel modulewq
  RISC-V: Support ALIGN relocation type in kernel module
  RISC-V: Support ADD32 relocation type in kernel module
  RISC-V: Support SUB32 relocation type in kernel module
  RISC-V: Enable module support in defconfig
  RISC-V: Add definition of relocation types

 arch/riscv/Kconfig                  |   5 ++
 arch/riscv/Makefile                 |   3 +
 arch/riscv/configs/defconfig        |   2 +
 arch/riscv/include/asm/module.h     | 112 +++++++++++++++++++++++
 arch/riscv/include/uapi/asm/elf.h   |  24 +++++
 arch/riscv/kernel/Makefile          |   1 +
 arch/riscv/kernel/module-sections.c | 156 ++++++++++++++++++++++++++++++++
 arch/riscv/kernel/module.c          | 175 ++++++++++++++++++++++++++++++++++--
 arch/riscv/kernel/module.lds        |   8 ++
 9 files changed, 480 insertions(+), 6 deletions(-)
 create mode 100644 arch/riscv/include/asm/module.h
 create mode 100644 arch/riscv/kernel/module-sections.c
 create mode 100644 arch/riscv/kernel/module.lds

-- 
2.16.1
