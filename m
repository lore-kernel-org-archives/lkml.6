Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753065AbeBENlh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:41:37 -0500
Received: from mail.efficios.com ([167.114.142.141]:52580 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeBENlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:41:31 -0500
Date: Mon, 5 Feb 2018 13:42:14 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <789113858.16035.1517838134232.JavaMail.zimbra@efficios.com>
Subject: [GIT PULL] membarrier updates for 4.16-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.141]
X-Mailer: Zimbra 8.7.11_GA_1854 (ZimbraWebClient - FF52 (Linux)/8.7.11_GA_1854)
Thread-Index: DsGz917rJ6HmlbmeUV5fSGITGEekTA==
Thread-Topic: membarrier updates for 4.16-rc1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

    Linux 4.15 (Sun Jan 28 13:20:33 2018 -0800)

are available in the Git repository at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rseq/linux-rseq.git tags/v4.15-membarrier-20180129

for you to fetch changes up to 04e4ffa593e410090c3a34e50d4c8082e11936af:

    membarrier: selftest: Test private expedited sync core cmd (Wed Nov 8 13:09:32 2017 -0500)

Thanks!

Mathieu

----------------------------------------------------------------

membarrier updates for 4.16

"powerpc: membarrier: Skip memory barrier in switch_mm()" takes care of
a TODO that was left in the private expedited implementation when merged
in 4.14: an extra memory barrier was added on context switch on powerpc.
Ensure that the barrier is only performed when scheduling between
different processes, only for threads belonging to processes that have
registered their intent to use the private expedited command.

"membarrier: provide GLOBAL_EXPEDITED command" adds new commands to
membarrier for registration and use of membarrier across processes
communicating through shared memory mappings. The non-expedited command
has proven to be really too slow (taking 10ms and more to complete) for
real-world use. The expedited version completes in a matter of
microseconds. This patch renames the pre-existing MEMBARRIER_CMD_SHARED
to MEMBARRIER_CMD_GLOBAL for consistency, keeping the old enum label
as an alias for backward compatibility.

"membarrier: Provide core serializing command" provides core
serialization for JIT reclaim. We received positive feedback from
Android developers that the proposed ABI fits their use-case.
Only x86 32/64 and arm 64 implement this command so far. This is
opt-in per architecture.

The other patches add selftests and documentation.

----------------------------------------------------------------

Mathieu Desnoyers (11):
  membarrier: selftest: Test private expedited cmd (v2)
  powerpc: membarrier: Skip memory barrier in switch_mm() (v7)
  membarrier: Document scheduler barrier requirements (v5)
  membarrier: provide GLOBAL_EXPEDITED command (v3)
  membarrier: selftest: Test global expedited cmd (v2)
  Introduce sync_core_before_usermode (v2)
  x86: Implement sync_core_before_usermode (v3)
  membarrier: Provide core serializing command (v3)
  membarrier: x86: Provide core serializing command (v4)
  membarrier: arm64: Provide core serializing command
  membarrier: selftest: Test private expedited sync core cmd

 MAINTAINERS                                        |   1 +
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/kernel/entry.S                          |   4 +
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/membarrier.h              |  27 +++
 arch/powerpc/mm/mmu_context.c                      |   7 +
 arch/x86/Kconfig                                   |   2 +
 arch/x86/entry/entry_32.S                          |   5 +
 arch/x86/entry/entry_64.S                          |   4 +
 arch/x86/include/asm/sync_core.h                   |  28 +++
 arch/x86/mm/tlb.c                                  |   6 +
 include/linux/sched/mm.h                           |  40 +++-
 include/linux/sync_core.h                          |  21 ++
 include/uapi/linux/membarrier.h                    |  74 ++++++-
 init/Kconfig                                       |   9 +
 kernel/sched/core.c                                |  57 +++--
 kernel/sched/membarrier.c                          | 177 +++++++++++++--
 .../testing/selftests/membarrier/membarrier_test.c | 237 +++++++++++++++++++--
 18 files changed, 633 insertions(+), 68 deletions(-)
 create mode 100644 arch/powerpc/include/asm/membarrier.h
 create mode 100644 arch/x86/include/asm/sync_core.h
 create mode 100644 include/linux/sync_core.h

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
