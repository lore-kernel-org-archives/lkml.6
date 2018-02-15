Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165924AbeBOR4G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 12:56:06 -0500
Received: from foss.arm.com ([217.140.101.70]:55958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164177AbeBOPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:30:14 -0500
From: Will Deacon <will.deacon@arm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        mingo@kernel.org, Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 0/5] Rewrite asm-generic/bitops/atomic.h and use on arm64
Date: Thu, 15 Feb 2018 15:29:30 +0000
Message-Id: <1518708575-12284-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Whilst investigating a livelock in fs/dcache.c [1], I noticed that the
arm64 test_and_set operation always writes back to memory even if the
value is already set. This led me to start hacking on improved versions
of our bitops, including an acquire version of test_and_set_bit_lock.

Since there was nothing arm64-specific about the resulting code, I figured
I'd replace what's sitting in asm-generic/bitops/atomic.h and simply include
that instead. I had to rejig a couple of #includes so that I can call into
atomic_* ops from bitops.h, but that was actually pretty straightforward.

Feedback welcome,

Will

[1] https://lkml.org/lkml/2018/2/13/414

--->8

Will Deacon (5):
  arm64: fpsimd: include <linux/init.h> in fpsimd.h
  asm-generic: Avoid including linux/kernel.h in asm-generic/bug.h
  asm-generic/bitops/atomic.h: Rewrite using atomic_fetch_*
  arm64: Replace our atomic bitops implementation with asm-generic
  arm64: bitops: Include <asm-generic/bitops/ext2-atomic-setbit.h>

 arch/arm64/include/asm/bitops.h     |  20 +---
 arch/arm64/include/asm/fpsimd.h     |   1 +
 arch/arm64/lib/Makefile             |   2 +-
 arch/arm64/lib/bitops.S             |  76 -------------
 include/asm-generic/bitops/atomic.h | 219 ++++++++++++------------------------
 include/asm-generic/bug.h           |   2 +-
 lib/errseq.c                        |   1 +
 7 files changed, 77 insertions(+), 244 deletions(-)
 delete mode 100644 arch/arm64/lib/bitops.S

-- 
2.1.4
