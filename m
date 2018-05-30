Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968855AbeE3JNM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:13:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44545 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965335AbeE3JNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:13:08 -0400
X-Google-Smtp-Source: ADUXVKLGY/hKJWTsZ+UFpOA7+5KQ7cO1yaaoDVYLqzK9TrrLHmc2SABYvCNC5OYHcZLjOPs0pbQMVg==
From: YaoJun <yaojun8558363@gmail.com>
To: kernel-hardening@lists.openwall.com
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: [PATCH 0/4] arm64/mm: migrate swapper_pg_dir
Date: Wed, 30 May 2018 17:12:55 +0800
Message-Id: <20180530091259.9386-1-yaojun8558363@gmail.com>
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

YaoJun (4):
  arm64/mm: Introduce __pa_swapper_pg_dir to save physical
	    address of swapper_pg_dir. And pass it as an
	    argument to __enable_mmu().
  arm64/mm: Introduce new_swapper_pg_dir to save virtual
	    address of new swapper_pg_dir.
  arm64/mm: Make tramp_pg_dir and swapper_pg_dir adjacent.
  arm64/mm: Migrate swapper_pg_dir and tramp_pg_dir.

 arch/arm64/include/asm/mmu_context.h |  6 +--
 arch/arm64/include/asm/pgtable.h     |  2 +
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/entry.S            |  4 +-
 arch/arm64/kernel/head.S             | 10 ++--
 arch/arm64/kernel/hibernate.c        |  2 +-
 arch/arm64/kernel/sleep.S            |  2 +
 arch/arm64/kernel/vmlinux.lds.S      | 10 ++--
 arch/arm64/mm/kasan_init.c           |  6 +--
 arch/arm64/mm/mmu.c                  | 72 ++++++++++++++++++++--------
 10 files changed, 75 insertions(+), 41 deletions(-)

-- 
2.17.0
