Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936423AbeE2PoB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:44:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43342 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934948AbeE2Pn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:43:59 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: [PATCHv2 00/16] atomics: API cleanups
Date: Tue, 29 May 2018 16:43:30 +0100
Message-Id: <20180529154346.3168-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a few cleanups of the atomic API, fixing
inconsistencies between atomic_* and atomic64_*, and minimizing
repetition in arch code. This is nicer for arch code, and the improved
regularity will help when generating the atomic headers in future.

Since v1 [1]:
* Add missing inc_not_zero #define for x86_32
* Remove newly redundant test op definitions for riscv
* Remove atomic_inc_not_zero_hint()
* Make inc/dec ops optional

The bulk of the patches reorganise things so architectures consistently
provide <atomic>_fetch_add_unless(), with atomic_fetch_add_unless()
provided as a wrapper by core code. A generic fallback is provided for
<atomic>_fetch_add_unless(), based on <atomic>_read() and
<atomic>_try_cmpxchg().

Other patches in the series add common fallbacks for:

* atomic64_inc_not_zero() 
* <atomic>_inc_and_test()
* <atomic>_dec_and_test()
* <atomic>_sub_and_test()
* <atomic>add_negative()
* <atomic>_*inc*()
* <atomic>_*dec*()

... as almost all architectures provide (near-)identical implementation
of these today. Where an architecture provides a non-trivial definition,
it is updated to provide a matching preprocessor symbol, and the
instrumented atomics are updated correspondingly.

The end result is a strongly negative diffstat, though <linux/atomic.h>
grows by a reasonable amount. We could halve this in future by
templating the various fallbacks for atomic{,64}_t with code generation.

I've pushed this out to my atomics/api-cleanup branch [2] on kernel.org.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180523133533.1076-1-mark.rutland@arm.com
[2] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/api-cleanup

Mark Rutland (16):
  atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
  atomics/treewide: remove redundant atomic_inc_not_zero() definitions
  atomics/treewide: make atomic64_inc_not_zero() optional
  atomics/treewide: make atomic_fetch_add_unless() optional
  atomics: prepare for atomic64_fetch_add_unless()
  atomics/generic: define atomic64_fetch_add_unless()
  atomics/alpha: define atomic64_fetch_add_unless()
  atomics/arc: define atomic64_fetch_add_unless()
  atomics/arm: define atomic64_fetch_add_unless()
  atomics/powerpc: define atomic64_fetch_add_unless()
  atomics/riscv: define atomic64_fetch_add_unless()
  atomics/treewide: make atomic64_fetch_add_unless() optional
  atomics/treewide: make test ops optional
  atomics/treewide: remove atomic_inc_not_zero_hint()
  atomics/treewide: make unconditional inc/dec ops optional
  atomics/treewide: make conditional inc/dec ops optional

 arch/alpha/include/asm/atomic.h           |  56 ++---
 arch/arc/include/asm/atomic.h             |  78 ++-----
 arch/arm/include/asm/atomic.h             |  55 ++---
 arch/arm64/include/asm/atomic.h           |  47 +---
 arch/h8300/include/asm/atomic.h           |  15 +-
 arch/hexagon/include/asm/atomic.h         |  18 +-
 arch/ia64/include/asm/atomic.h            |  81 -------
 arch/m68k/include/asm/atomic.h            |  24 +-
 arch/mips/include/asm/atomic.h            | 172 --------------
 arch/openrisc/include/asm/atomic.h        |   4 +-
 arch/parisc/include/asm/atomic.h          | 107 ---------
 arch/powerpc/include/asm/atomic.h         |  52 ++---
 arch/riscv/include/asm/atomic.h           | 149 +-----------
 arch/s390/include/asm/atomic.h            |  65 ------
 arch/sh/include/asm/atomic.h              |  35 ---
 arch/sparc/include/asm/atomic_32.h        |  24 +-
 arch/sparc/include/asm/atomic_64.h        |  65 +-----
 arch/sparc/lib/atomic32.c                 |   4 +-
 arch/x86/include/asm/atomic.h             |  30 +--
 arch/x86/include/asm/atomic64_32.h        |  61 +----
 arch/x86/include/asm/atomic64_64.h        |  48 +---
 arch/xtensa/include/asm/atomic.h          |  98 --------
 drivers/block/rbd.c                       |   2 +-
 drivers/infiniband/core/rdma_core.c       |   2 +-
 fs/afs/rxrpc.c                            |   2 +-
 include/asm-generic/atomic-instrumented.h |  69 +++++-
 include/asm-generic/atomic.h              |  33 ---
 include/asm-generic/atomic64.h            |  14 +-
 include/linux/atomic.h                    | 371 +++++++++++++++++++++++++-----
 kernel/bpf/syscall.c                      |   4 +-
 lib/atomic64.c                            |  13 +-
 net/atm/pppoatm.c                         |   2 +-
 net/rxrpc/call_object.c                   |   2 +-
 net/rxrpc/conn_object.c                   |   4 +-
 net/rxrpc/local_object.c                  |   2 +-
 net/rxrpc/peer_object.c                   |   2 +-
 36 files changed, 499 insertions(+), 1311 deletions(-)

-- 
2.11.0
