Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeESCqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 22:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751323AbeESCp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 22:45:59 -0400
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 00/12] breakpoint: Rework arch validation v2
Date: Sat, 19 May 2018 04:45:37 +0200
Message-Id: <1526697950-7091-1-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Changes since v1:

- Avoid arch code duplication between check and commit. Use a temporary
  struct arch_hw_breakpoint to fill up arch data on the fly
  (Mark Rutland)

- Start with a default weak version of hw_breakpoint_arch_parse() that
  architectures override one by one (Peter Zijlstra, Andy Lutomirski)

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	perf/breakpoint-v2

HEAD: a350174ed8f7240b91ae46933bfe2274d3d03806

--- Summary ---

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
