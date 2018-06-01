Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFAIIf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 04:08:35 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37229 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750916AbeFAII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 04:08:27 -0400
X-Google-Smtp-Source: ADUXVKIMDy82A+5gMmBnH/zmsaOzeiU94F0XMhhzs1rAX5o1hhIHjpN/nXurAT+AcaUzSU1MKgHzXg==
From: Jun Yao <yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        greg@kroah.com
Subject: [PATCH 0/4] arm64/mm: migrate swapper_pg_dir
Date: Fri,  1 Jun 2018 16:08:19 +0800
Message-Id: <20180601080819.11712-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, The offset between swapper_pg_dir and _text is
fixed. When attackers know the address of _text(no KASLR or
breaking KASLR), they can caculate the address of
swapper_pg_dir. Then KSMA(Kernel Space Mirroring Attack) can
be applied.

The principle of KSMA is to insert a carefully constructed PGD
entry into the translation table. The type of this entry is
block, which maps the kernel text and its access permissions
bits are 01. The user process can then modify kernel text
directly through this mapping.

To protect against KSMA, these patches migrate swapper_pg_dir
to new place, which is dynamically allocated. Since it is
allocated during the kernel boot process and the address is
relatively fixed, further randomization may be required.

Jun Yao (4):
  arm64/mm: pass swapper_pg_dir as an argument to __enable_mmu()
  arm64/mm: introduce variable to save new swapper_pg_dir address
  arm64/mm: make tramp_pg_dir and swapper_pg_dir adjacent
  arm64/mm: migrate swapper_pg_dir and tramp_pg_dir

 arch/arm64/include/asm/mmu_context.h |  6 +--
 arch/arm64/include/asm/pgtable.h     |  2 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/entry.S            |  4 +-
 arch/arm64/kernel/head.S             | 10 ++--
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  2 +
 arch/arm64/kernel/vmlinux.lds.S      |  9 ++--
 arch/arm64/mm/kasan_init.c           |  6 +--
 arch/arm64/mm/mmu.c                  | 75 +++++++++++++++++-----------
 10 files changed, 71 insertions(+), 47 deletions(-)

-- 
2.17.0
