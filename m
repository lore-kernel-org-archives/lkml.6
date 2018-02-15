Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426104AbeBOQgW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:36:22 -0500
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:57791 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1423965AbeBOQgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:16 -0500
From: Nadav Amit <namit@vmware.com>
To: Ingo Molnar <mingo@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Nadav Amit <namit@vmware.com>
Subject: [PATCH RFC v2 0/6] x86: Disabling PTI in compatibility mode
Date: Thu, 15 Feb 2018 08:35:56 -0800
Message-ID: <20180215163602.61162-1-namit@vmware.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatibility mode should be safe of Meltdown, since the pointers are only
32-bit long.  This can allow us to disable PTI selectively as long as x86-32
processes are running and to enable global pages throughout this time. These
patches may also be a basis for later disabling PTI selectively for "trusted"
processes.

The patches are marked as an RFC since they (specifically the last one) do not
coexist with Dave Hansen's enabling of global pages, and might have conflicts
with Joerg's work on 32-bit (although in this case, it should be easily
resolvable). They are also based on Linux 4.15.

I removed the PTI disabling while SMEP is unsupported, although I must admit I
did not fully understand why it is required. IIUC, Intel's indirect branch
prediction only predicts the low 32-bits of the target, which would still not
allow to manipulate the kernel to jump to userspace code through Spectre v2.

RFC v1 -> RFC v2:
- Handling the use of CS64 in compatibility mode (Andy)
- Holding the PTI disable indication per mm and not task (Andy)
- No PTI disabling if SMEP is unsupported (Dave, Ingo)
- Self-test and cleanup
- Enabling global pages while running in compatibility mode

Nadav Amit (6):
  x86: Skip PTI when disable indication is set
  x86: Save pti_disable for each mm_context
  x86: Switching page-table isolation
  x86: Disable PTI on compatibility mode
  x86: Use global pages when PTI is disabled
  selftest: x86: test using CS64 on compatibility-mode

 arch/x86/entry/calling.h              |  33 ++++++++
 arch/x86/include/asm/mmu.h            |   3 +
 arch/x86/include/asm/pti.h            |  70 +++++++++++++++++
 arch/x86/include/asm/tlbflush.h       |  35 ++++++++-
 arch/x86/kernel/asm-offsets.c         |   1 +
 arch/x86/kernel/process_64.c          |  13 +++-
 arch/x86/kernel/traps.c               |  23 +++++-
 arch/x86/mm/init.c                    |  14 ++--
 arch/x86/mm/pgtable.c                 |   4 +-
 arch/x86/mm/pti.c                     | 139 +++++++++++++++++++++++++++++++++-
 arch/x86/mm/tlb.c                     |  28 ++++++-
 tools/testing/selftests/x86/ldt_gdt.c |  41 ++++++++++
 12 files changed, 386 insertions(+), 18 deletions(-)

-- 
2.14.1
