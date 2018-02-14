Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030958AbeBNU7R (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:59:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:46830 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030206AbeBNU7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:59:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,514,1511856000";
   d="scan'208";a="18159259"
Subject: [PATCH] x86,
 nospec: Fix uninitialized mask in array_index_mask_nospec()
From: Dan Williams <dan.j.williams@intel.com>
To: mingo@kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 14 Feb 2018 12:50:10 -0800
Message-ID: <151864141010.23667.12512377970963681490.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Break the false dependency on the uninitialized value of 'mask' in
array_index_mask_nospec(). This potentially allows the CPU to rename the
register, avoids reports from tools that can detect uninitialized inline
asm arguments, and makes it explicit that this sequence wants the result
of (0 - 0 - CARRY).

Reported-by: Andi Kleen <ak@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/include/asm/barrier.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
index e1259f043ae9..b572b6a77e12 100644
--- a/arch/x86/include/asm/barrier.h
+++ b/arch/x86/include/asm/barrier.h
@@ -36,10 +36,10 @@
 static inline unsigned long array_index_mask_nospec(unsigned long index,
 		unsigned long size)
 {
-	unsigned long mask;
+	unsigned long mask = 0;
 
-	asm ("cmp %1,%2; sbb %0,%0;"
-			:"=r" (mask)
+	asm ("cmp %1,%2; sbb $0,%0;"
+			:"+r" (mask)
 			:"g"(size),"r" (index)
 			:"cc");
 	return mask;
