Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbeEWNfn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:35:43 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55266 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932876AbeEWNfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:35:42 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@synopsys.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>
Subject: [PATCH 00/13] atomics: API cleanups
Date: Wed, 23 May 2018 14:35:20 +0100
Message-Id: <20180523133533.1076-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains a few cleanups of the atomic API, fixing an
inconsistency between atomic_* and atomic64_*, and minimizing repetition
in arch code. This is nicer for arch code, and the improved regularity
will help when generating the atomic headers in future.

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

... as almost all architectures provide identical implementation of
these today.

The end result is a strongly negative diffstat, though <linux/atomic.h>
grows by a reasonable amount. When we generate the headers, we can halve
this by templating the various fallbacks for atomic{,64}_t.

I've pushed this out to my atomics/api-cleanup branch [1] on kernel.org.

Thanks,
Mark.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/api-cleanup

Mark Rutland (13):
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

 arch/alpha/include/asm/atomic.h           |  43 +++----
 arch/arc/include/asm/atomic.h             |  66 ++--------
 arch/arm/include/asm/atomic.h             |  43 ++-----
 arch/arm64/include/asm/atomic.h           |  23 ----
 arch/h8300/include/asm/atomic.h           |   8 +-
 arch/hexagon/include/asm/atomic.h         |  12 +-
 arch/ia64/include/asm/atomic.h            |  56 ---------
 arch/m68k/include/asm/atomic.h            |  19 +--
 arch/mips/include/asm/atomic.h            | 134 --------------------
 arch/openrisc/include/asm/atomic.h        |   4 +-
 arch/parisc/include/asm/atomic.h          |  72 -----------
 arch/powerpc/include/asm/atomic.h         |  47 ++-----
 arch/riscv/include/asm/atomic.h           |  27 +---
 arch/s390/include/asm/atomic.h            |  40 ------
 arch/sh/include/asm/atomic.h              |  29 -----
 arch/sparc/include/asm/atomic_32.h        |  19 +--
 arch/sparc/include/asm/atomic_64.h        |  52 --------
 arch/sparc/lib/atomic32.c                 |   4 +-
 arch/x86/include/asm/atomic.h             |  25 +---
 arch/x86/include/asm/atomic64_32.h        |  54 --------
 arch/x86/include/asm/atomic64_64.h        |  25 +---
 arch/xtensa/include/asm/atomic.h          |  66 ----------
 drivers/block/rbd.c                       |   2 +-
 drivers/infiniband/core/rdma_core.c       |   2 +-
 fs/afs/rxrpc.c                            |   2 +-
 include/asm-generic/atomic-instrumented.h |  42 ++++++-
 include/asm-generic/atomic.h              |  20 ---
 include/asm-generic/atomic64.h            |   8 +-
 include/linux/atomic.h                    | 198 +++++++++++++++++++++++++++++-
 kernel/bpf/syscall.c                      |   4 +-
 lib/atomic64.c                            |  13 +-
 net/rxrpc/call_object.c                   |   2 +-
 net/rxrpc/conn_object.c                   |   4 +-
 net/rxrpc/local_object.c                  |   2 +-
 net/rxrpc/peer_object.c                   |   2 +-
 35 files changed, 329 insertions(+), 840 deletions(-)

-- 
2.11.0
