Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeA3Nwy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:52:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:2986 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeA3Nwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:52:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,435,1511856000";
   d="scan'208";a="15534794"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 0/4] x86: 5-level related changes into decompression code
Date: Tue, 30 Jan 2018 16:52:34 +0300
Message-Id: <20180130135239.72244-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patcheset is a preparation for boot-time switching between paging
modes. Please apply.

The first patch is pure cosmetic change: it gives file with KASLR helpers
a proper name.

The last three patches bring support of booting into 5-level paging mode if
a bootloader put the kernel above 4G.

Patch 2/4 Renames l5_paging_required() into paging_prepare() and change
interface of the function.
Patch 3/4 Handles allocation of space for trampoline and gets it prepared.
Patch 4/4 Gets trampoline used.

v8:
 - Support switching from 5- to 4-level paging.
v7:
 - Fix booting when 5-level paging is enabled before handing off boot to
   the kernel, like in kexec() case.

Kirill A. Shutemov (4):
  x86/boot/compressed/64: Rename pagetable.c to kaslr_64.c
  x86/boot/compressed/64: Introduce paging_prepare()
  x86/boot/compressed/64: Prepare trampoline memory
  x86/boot/compressed/64: Handle 5-level paging boot if kernel is above
    4G

 arch/x86/boot/compressed/Makefile                  |   2 +-
 arch/x86/boot/compressed/head_64.S                 | 158 ++++++++++++++-------
 .../boot/compressed/{pagetable.c => kaslr_64.c}    |   0
 arch/x86/boot/compressed/pgtable.h                 |  18 +++
 arch/x86/boot/compressed/pgtable_64.c              |  77 ++++++++--
 5 files changed, 189 insertions(+), 66 deletions(-)
 rename arch/x86/boot/compressed/{pagetable.c => kaslr_64.c} (100%)
 create mode 100644 arch/x86/boot/compressed/pgtable.h

-- 
2.15.1
