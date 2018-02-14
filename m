Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967433AbeBNLTJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:19:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:5270 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967376AbeBNLRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:17:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,512,1511856000";
   d="scan'208";a="34604551"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@suse.de>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/9] x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52
Date: Wed, 14 Feb 2018 14:16:48 +0300
Message-Id: <20180214111656.88514-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
References: <20180214111656.88514-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__PHYSICAL_MASK_SHIFT is used to define the mask that helps to extract
physical address from a page table entry.

Although, real physical address space available may differ between
machines, it's safe to use 52 as __PHYSICAL_MASK_SHIFT. Unused bits
above log2(MAXPHYADDR) up to bit 51 are reserved and must be 0.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/page_64_types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/page_64_types.h b/arch/x86/include/asm/page_64_types.h
index e1407312c412..f68e6526891d 100644
--- a/arch/x86/include/asm/page_64_types.h
+++ b/arch/x86/include/asm/page_64_types.h
@@ -52,11 +52,12 @@
 #define __START_KERNEL_map	_AC(0xffffffff80000000, UL)
 
 /* See Documentation/x86/x86_64/mm.txt for a description of the memory map. */
-#ifdef CONFIG_X86_5LEVEL
+
 #define __PHYSICAL_MASK_SHIFT	52
+
+#ifdef CONFIG_X86_5LEVEL
 #define __VIRTUAL_MASK_SHIFT	56
 #else
-#define __PHYSICAL_MASK_SHIFT	46
 #define __VIRTUAL_MASK_SHIFT	47
 #endif
 
-- 
2.15.1
