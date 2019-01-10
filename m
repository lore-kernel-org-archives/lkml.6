Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F05C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C502214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfAJPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:11:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:52066 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfAJPLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:11:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43b8bY6kk1z9txVh;
        Thu, 10 Jan 2019 16:11:37 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OB5aXy-xxub9; Thu, 10 Jan 2019 16:11:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43b8bY5rgPz9v113;
        Thu, 10 Jan 2019 16:11:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49E458B89F;
        Thu, 10 Jan 2019 16:11:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VPY-PNP9W8vp; Thu, 10 Jan 2019 16:11:39 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E90158B898;
        Thu, 10 Jan 2019 16:11:38 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BFEBB6BF21; Thu, 10 Jan 2019 15:11:38 +0000 (UTC)
Message-Id: <cover.1547132681.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 00/15] powerpc/32s: Use BATs/LTLBs for STRICT_KERNEL_RWX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 10 Jan 2019 15:11:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to:
- use BATs with STRICT_KERNEL_RWX on book3s (See patch 12 for details.)
- use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 14 for a few details.)

v2:
- Fix patch 2 (was patch 3 in v1) based on feedback from Jonathan.
- Added support for 8xx with LTLBs.
- Added systematic population of pagetables for Abatron BDI.

Christophe Leroy (15):
  powerpc/mm/32: add base address to mmu_mapin_ram()
  powerpc/mm/32s: rework mmu_mapin_ram()
  powerpc/mm/32s: use generic mmu_mapin_ram() for all blocks.
  powerpc/32: always populate page tables for Abatron BDI.
  powerpc/wii: remove wii_mmu_mapin_mem2()
  powerpc/mm/32s: use _PAGE_EXEC in setbat()
  powerpc/mm/32s: add setibat() clearibat() and update_bats()
  powerpc/32: add helper to write into segment registers
  powerpc/mmu: add is_strict_kernel_rwx() helper
  powerpc/kconfig: define PAGE_SHIFT inside Kconfig
  powerpc/kconfig: define CONFIG_DATA_SHIFT and CONFIG_ETEXT_SHIFT
  powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX
  powerpc/kconfig: make _etext and data areas alignment configurable on
    Book3s 32
  powerpc/8xx: don't disable large TLBs with CONFIG_STRICT_KERNEL_RWX
  powerpc/kconfig: make _etext and data areas alignment configurable on
    8xx

 arch/powerpc/Kconfig                          |  60 +++++++++
 arch/powerpc/include/asm/book3s/32/mmu-hash.h |   2 +
 arch/powerpc/include/asm/book3s/32/pgtable.h  |  11 ++
 arch/powerpc/include/asm/mmu.h                |  11 ++
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  |   3 +-
 arch/powerpc/include/asm/page.h               |  13 +-
 arch/powerpc/include/asm/reg.h                |   5 +
 arch/powerpc/kernel/head_32.S                 |  35 +++++
 arch/powerpc/kernel/head_8xx.S                |  33 ++++-
 arch/powerpc/kernel/vmlinux.lds.S             |   9 +-
 arch/powerpc/mm/40x_mmu.c                     |   2 +-
 arch/powerpc/mm/44x_mmu.c                     |   2 +-
 arch/powerpc/mm/8xx_mmu.c                     |  33 ++++-
 arch/powerpc/mm/fsl_booke_mmu.c               |   2 +-
 arch/powerpc/mm/init_32.c                     |   6 +-
 arch/powerpc/mm/mmu_decl.h                    |  10 +-
 arch/powerpc/mm/pgtable_32.c                  |  38 +++---
 arch/powerpc/mm/ppc_mmu_32.c                  | 178 ++++++++++++++++++++++----
 arch/powerpc/platforms/embedded6xx/wii.c      |  24 ----
 19 files changed, 378 insertions(+), 99 deletions(-)

-- 
2.13.3

