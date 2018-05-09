Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965783AbeEIRSo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:18:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:22733 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965240AbeEIRSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="227180567"
Subject: [PATCH 00/13] [v4] x86, pkeys: two protection keys bug fixes
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, shakeelb@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:36 -0700
Message-Id: <20180509171336.76636D88@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi x86 maintainers,

This set has been seen quite a few changes and additions since the
last post.  Details below.

Changes from v3:
 * Reordered patches following Ingo's recommendations: Introduce
   failing selftests first, then the kernel code to fix the test
   failure.
 * Increase verbosity and accuracy of do_not_expect_pk_fault()
   messages.
 * Removed abort() use from tests.  Crashing is not nice.
 * Remove some dead debugging code, fixing dprint_in_signal.
 * Fix deadlocks from using printf() and friends in signal
   handlers.

Changes from v2:
 * Clarified commit message in patch 1/9 taking some feedback from
   Shuah.

Changes from v1:
 * Added Fixes: and cc'd stable.  No code changes.

--

This fixes two bugs, and adds selftests to make sure they stay fixed:

1. pkey 0 was not usable via mprotect_pkey() because it had never
   been explicitly allocated.
2. mprotect(PROT_EXEC) memory could sometimes be left with the
   implicit exec-only protection key assigned.

I already posted #1 previously.  I'm including them both here because
I don't think it's been picked up in case folks want to pull these
all in a single bundle.

Dave Hansen (13):
      x86/pkeys/selftests: give better unexpected fault error messages
      x86/pkeys/selftests: Stop using assert()
      x86/pkeys/selftests: remove dead debugging code, fix dprint_in_signal
      x86/pkeys/selftests: avoid printf-in-signal deadlocks
      x86/pkeys/selftests: Allow faults on unknown keys
      x86/pkeys/selftests: Factor out "instruction page"
      x86/pkeys/selftests: Add PROT_EXEC test
      x86/pkeys/selftests: Fix pkey exhaustion test off-by-one
      x86/pkeys: Override pkey when moving away from PROT_EXEC
      x86/pkeys/selftests: Fix pointer math
      x86/pkeys/selftests: Save off 'prot' for allocations
      x86/pkeys/selftests: Add a test for pkey 0
      x86/pkeys: Do not special case protection key 0

 arch/x86/include/asm/mmu_context.h            |   2 +-
 arch/x86/include/asm/pkeys.h                  |  18 +-
 arch/x86/mm/pkeys.c                           |  21 +-
 tools/testing/selftests/x86/pkey-helpers.h    |  20 +-
 tools/testing/selftests/x86/protection_keys.c | 187 +++++++++++++-----
 5 files changed, 173 insertions(+), 75 deletions(-)

Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>p
Cc: Shuah Khan <shuah@kernel.org>
Cc: Shakeel Butt <shakeelb@google.com>
