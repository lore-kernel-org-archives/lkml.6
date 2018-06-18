Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF2D20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:19:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF2D20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936880AbeFRKTc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:19:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59298 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933409AbeFRKT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:19:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C7280D;
        Mon, 18 Jun 2018 03:19:29 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 812E43F25D;
        Mon, 18 Jun 2018 03:19:26 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will.deacon@arm.com,
        peterz@infradead.org, boqun.feng@gmail.com
Cc:     mingo@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        albert@sifive.com, arnd@arndb.de, benh@kernel.crashing.org,
        geert@linux-m68k.org, ink@jurassic.park.msu.ru,
        linux@armlinux.org.uk, mattst88@gmail.com, mpe@ellerman.id.au,
        palmer@sifive.com, paulus@samba.org, rth@twiddle.net,
        vgupta@synopsys.com
Subject: [PATCHv3 00/18] atomics: API cleanups
Date:   Mon, 18 Jun 2018 11:19:01 +0100
Message-Id: <20180618101919.51973-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Since v2 [2]
* Make test ops return bool
* Clean up ifdeffery for andnot opes
* Update comments for clarity
* Rebase to v4.18-rc1
* Accumulate acks
* Fix typos

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

I've pushed this out to my atomics/api-cleanup branch [3] on kernel.org.

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20180523133533.1076-1-mark.rutland@arm.com
[2] https://lkml.kernel.org/r/20180529154346.3168-1-mark.rutland@arm.com
[3] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/api-cleanup

Mark Rutland (18):
  atomics/treewide: s/__atomic_add_unless/atomic_fetch_add_unless/
  atomics/treewide: remove redundant atomic_inc_not_zero() definitions
  atomics/treewide: remove atomic_inc_not_zero_hint()
  atomics: make conditional ops return bool
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
  atomics/treewide: make unconditional inc/dec ops optional
  atomics/treewide: make conditional inc/dec ops optional
  atomics/treewide: clean up andnot ifdeffery

 arch/alpha/include/asm/atomic.h           |  56 ++--
 arch/arc/include/asm/atomic.h             |  86 ++-----
 arch/arm/include/asm/atomic.h             |  55 +---
 arch/arm64/include/asm/atomic.h           |  47 +---
 arch/h8300/include/asm/atomic.h           |  15 +-
 arch/hexagon/include/asm/atomic.h         |  18 +-
 arch/ia64/include/asm/atomic.h            |  81 ------
 arch/m68k/include/asm/atomic.h            |  24 +-
 arch/mips/include/asm/atomic.h            | 172 -------------
 arch/openrisc/include/asm/atomic.h        |   4 +-
 arch/parisc/include/asm/atomic.h          | 107 --------
 arch/powerpc/include/asm/atomic.h         |  52 ++--
 arch/riscv/include/asm/atomic.h           | 149 +----------
 arch/s390/include/asm/atomic.h            |  65 -----
 arch/sh/include/asm/atomic.h              |  35 ---
 arch/sparc/include/asm/atomic_32.h        |  24 +-
 arch/sparc/include/asm/atomic_64.h        |  65 +----
 arch/sparc/lib/atomic32.c                 |   4 +-
 arch/x86/include/asm/atomic.h             |  30 +--
 arch/x86/include/asm/atomic64_32.h        |  61 +----
 arch/x86/include/asm/atomic64_64.h        |  48 +---
 arch/xtensa/include/asm/atomic.h          |  98 -------
 drivers/block/rbd.c                       |   2 +-
 drivers/infiniband/core/rdma_core.c       |   2 +-
 fs/afs/rxrpc.c                            |   2 +-
 include/asm-generic/atomic-instrumented.h |  71 ++++-
 include/asm-generic/atomic.h              |  33 ---
 include/asm-generic/atomic64.h            |  15 +-
 include/linux/atomic.h                    | 415 +++++++++++++++++++++++-------
 kernel/bpf/syscall.c                      |   4 +-
 lib/atomic64.c                            |  12 +-
 net/atm/pppoatm.c                         |   2 +-
 net/rxrpc/call_object.c                   |   2 +-
 net/rxrpc/conn_object.c                   |   4 +-
 net/rxrpc/local_object.c                  |   2 +-
 net/rxrpc/peer_object.c                   |   2 +-
 36 files changed, 511 insertions(+), 1353 deletions(-)

-- 
2.11.0

