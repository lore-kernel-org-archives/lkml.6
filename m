Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeEKMJK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:09:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:44522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbeEKMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:09:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="227662793"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/2] x86/boot/compressed/64: Fix trampoline page table address calculation
Date: Fri, 11 May 2018 15:08:58 +0300
Message-Id: <20180511120859.26375-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
References: <20180511120859.26375-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh noticied that I calculate address of trampoline page table wrong in
cleanup_trampoline(). TRAMPOLINE_32BIT_PGTABLE_OFFSET has to be divided
by sizeof(unsigned long) since trampoline_32bit is unsigned long
pointer.

TRAMPOLINE_32BIT_PGTABLE_OFFSET is zero so the bug doesn't have a
visible effect.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Hugh Dickins <hughd@google.com>
Fixes: e9d0e6330eb8 ("x86/boot/compressed/64: Prepare new top-level page table for trampoline")
---
 arch/x86/boot/compressed/pgtable_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index a362fa0b849c..23707e1da1ff 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -130,7 +130,7 @@ void cleanup_trampoline(void *pgtable)
 {
 	void *trampoline_pgtable;
 
-	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET;
+	trampoline_pgtable = trampoline_32bit + TRAMPOLINE_32BIT_PGTABLE_OFFSET / sizeof(unsigned long);
 
 	/*
 	 * Move the top level page table out of trampoline memory,
-- 
2.17.0
