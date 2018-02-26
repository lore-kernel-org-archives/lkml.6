Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeBZPFD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:05:03 -0500
Received: from foss.arm.com ([217.140.101.70]:51118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753871AbeBZPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:05:00 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org, yamada.masahiro@socionext.com,
        Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH v2 00/12] Rewrite asm-generic/bitops/{atomic,lock}.h and use on arm64
Date: Mon, 26 Feb 2018 15:04:48 +0000
Message-Id: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is version two of the RFC I previously posted here:

  https://www.spinics.net/lists/arm-kernel/msg634719.html

Changes since v1 include:

  * Fixed __clear_bit_unlock to work on archs with lock-based atomics
  * Moved lock ops into bitops/lock.h
  * Fixed build breakage on lesser-spotted architectures

Trying to fix the circular #includes introduced by pulling atomic.h
into btops/lock.h has been driving me insane. I've ended up moving some
basic BIT definitions into bits.h, but this might all be better in
const.h which is being proposed by Masahiro. Feedback is especially
welcome on this part.

I've not bothered optimising for the case of a 64-bit, big-endian
architecture that uses the generic implementation of atomic64_t because
it's both messy and hypothetical. The code here should still work
correctly for that case, it just sucks (as does the implementation
currently in mainline).

Cheers,

Will

--->8

Will Deacon (12):
  h8300: Don't include linux/kernel.h in asm/atomic.h
  m68k: Don't use asm-generic/bitops/lock.h
  asm-generic: Move some macros from linux/bitops.h to a new bits.h file
  openrisc: Don't pull in all of linux/bitops.h in asm/cmpxchg.h
  sh: Don't pull in all of linux/bitops.h in asm/cmpxchg-xchg.h
  arm64: fpsimd: include <linux/init.h> in fpsimd.h
  arm64: lse: Include compiler_types.h and export.h for out-of-line
    LL/SC
  arm64: cmpxchg: Include build_bug.h instead of bug.h for BUILD_BUG
  asm-generic/bitops/atomic.h: Rewrite using atomic_fetch_*
  asm-generic/bitops/lock.h: Rewrite using atomic_fetch_*
  arm64: Replace our atomic/lock bitop implementations with asm-generic
  arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>

 arch/arm64/include/asm/bitops.h     |  21 +---
 arch/arm64/include/asm/cmpxchg.h    |   2 +-
 arch/arm64/include/asm/fpsimd.h     |   1 +
 arch/arm64/include/asm/lse.h        |   2 +
 arch/arm64/lib/Makefile             |   2 +-
 arch/arm64/lib/bitops.S             |  76 ---------------
 arch/h8300/include/asm/atomic.h     |   4 +-
 arch/m68k/include/asm/bitops.h      |   6 +-
 arch/openrisc/include/asm/cmpxchg.h |   3 +-
 arch/sh/include/asm/cmpxchg-xchg.h  |   3 +-
 include/asm-generic/bitops/atomic.h | 188 +++++++-----------------------------
 include/asm-generic/bitops/lock.h   |  68 ++++++++++---
 include/asm-generic/bits.h          |  26 +++++
 include/linux/bitops.h              |  22 +----
 14 files changed, 135 insertions(+), 289 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S
 create mode 100644 include/asm-generic/bits.h

-- 
2.1.4
