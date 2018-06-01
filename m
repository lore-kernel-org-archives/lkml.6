Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751993AbeFAOcV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 10:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeFAOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 10:32:19 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [GIT PULL] breakpoint: Rework arch validation v3
Date: Fri,  1 Jun 2018 16:31:53 +0200
Message-Id: <1527863526-32677-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

Please pull the perf/breakpoint-v3 branch that can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/breakpoint-v3

HEAD: 3c0681cc01b39e7fac6eb810e82380165c9b56f1

Changes since v2:

* Constify the struct perf_event_attr passed in hw_breakpoint_parse()
* Add acks
	
---
When we modify a hardware breakpoint, the architecture code fills up
the architecture data as the validation of generic attributes progresses.
If something goes wrong in the middle, the architecture data changes
aren't rolled back and we are left with a halfway fiddled breakpoint.

This set fixes the various misdesigns that back this bad behaviour.

Thanks,
	Frederic
---

Frederic Weisbecker (12):
      perf/breakpoint: Split attribute parse and commit
      perf/breakpoint: Pass arch breakpoint struct to arch_check_bp_in_kernelspace()
      x86: Implement hw_breakpoint_arch_parse()
      powerpc: Implement hw_breakpoint_arch_parse()
      arm: Implement hw_breakpoint_arch_parse()
      arm64: Implement hw_breakpoint_arch_parse()
      sh: Remove "struct arch_hw_breakpoint::name" unused field
      sh: Implement hw_breakpoint_arch_parse()
      xtensa: Implement hw_breakpoint_arch_parse()
      perf/breakpoint: Remove default hw_breakpoint_arch_parse()
      perf/breakpoint: Pass new breakpoint type to modify_breakpoint_slot()
      perf/breakpoint: Clean up and consolidate modify_user_hw_breakpoint_check()


 arch/arm/include/asm/hw_breakpoint.h     |   7 +-
 arch/arm/kernel/hw_breakpoint.c          |  78 +++++++++---------
 arch/arm64/include/asm/hw_breakpoint.h   |   7 +-
 arch/arm64/kernel/hw_breakpoint.c        |  86 ++++++++++----------
 arch/powerpc/include/asm/hw_breakpoint.h |   7 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  47 ++++++-----
 arch/sh/include/asm/hw_breakpoint.h      |   8 +-
 arch/sh/kernel/hw_breakpoint.c           |  53 ++++++-------
 arch/x86/include/asm/hw_breakpoint.h     |   7 +-
 arch/x86/kernel/hw_breakpoint.c          | 131 ++++++++++++++++---------------
 arch/xtensa/include/asm/hw_breakpoint.h  |   7 +-
 arch/xtensa/kernel/hw_breakpoint.c       |  40 ++++------
 kernel/events/hw_breakpoint.c            |  92 +++++++++++++---------
 13 files changed, 294 insertions(+), 276 deletions(-)
