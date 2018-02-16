Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965283AbeBPLtz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:49:55 -0500
Received: from mga02.intel.com ([134.134.136.20]:60284 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935132AbeBPLtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:49:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,519,1511856000";
   d="scan'208";a="31977728"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/3] x86/mm/5lvl: Optimize boot-time switching, allow more Xen modes
Date: Fri, 16 Feb 2018 14:49:45 +0300
Message-Id: <20180216114948.68868-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last batch of patches that enable boot-time switching
between paging modes.

The first patch allows two more Xen modes to be enabled with
CONFIG_X86_5LEVEL=y. These modes don't support 5-level paging,
but we can use them when boot into 4-level paging mode.

The last two patches optimize switching between paging modes by
using code pathching in all hot paths.

Please review and cosider applying.

Kirill A. Shutemov (3):
  x86/xen: Allow XEN_PV and XEN_PVH to be enabled with X86_5LEVEL
  x86/mm: Redefine some of page table helpers as macros
  x86/mm: Offset boot-time paging mode switching cost

 arch/x86/boot/compressed/misc.h         |  5 +++++
 arch/x86/entry/entry_64.S               | 11 ++---------
 arch/x86/include/asm/paravirt.h         | 23 +++++++++++++----------
 arch/x86/include/asm/pgtable_64_types.h |  5 ++++-
 arch/x86/kernel/head64.c                |  9 +++++++--
 arch/x86/kernel/head_64.S               | 14 +++++++-------
 arch/x86/mm/kasan_init_64.c             |  6 ++++++
 arch/x86/xen/Kconfig                    |  5 -----
 arch/x86/xen/mmu_pv.c                   | 21 +++++++++++++++++++++
 9 files changed, 65 insertions(+), 34 deletions(-)

-- 
2.15.1
