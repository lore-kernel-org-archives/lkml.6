Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5518F21929
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388794AbeLUVg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:36:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:6014 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732832AbeLUVg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:36:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 13:36:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,383,1539673200"; 
   d="scan'208";a="112483876"
Received: from sjchrist-coffee.jf.intel.com ([10.54.74.154])
  by orsmga003.jf.intel.com with ESMTP; 21 Dec 2018 13:36:58 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v3 1/2] x86/fault: Reword initial BUG message for unhandled page faults
Date:   Fri, 21 Dec 2018 13:36:56 -0800
Message-Id: <20181221213657.27628-2-sean.j.christopherson@intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181221213657.27628-1-sean.j.christopherson@intel.com>
References: <20181221213657.27628-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reword the NULL pointer dereference case to simply state that a NULL
pointer was dereferenced, i.e. drop "unable to handle" as that implies
that there are instances where the kernel actual does handle NULL
pointer dereferences, which is not true barring funky exception fixup.

For the non-NULL case, replace "kernel paging request" with "page fault"
as the kernel can technically oops on faults that originated in user
code.  Dropping "kernel" also allows future patches to provide detailed
information on where the fault occurred, e.g. user vs. kernel, without
conflicting with the initial BUG message.

In both cases, replace "at address=" with wording more appropriate to
the oops, as "at" may be interpreted as stating that the address is the
RIP of the instruction that faulted.

Last, and probably least, further qualify the NULL-pointer path by
checking that the fault actually originated in kernel code.  It's
technically possible for userspace to map address 0, and not printing
a super specific message is the least of our worries if the kernel does
manage to oops on an actual NULL pointer dereference from userspace.

Before:
    BUG: unable to handle kernel NULL pointer dereference at ffffbeef00000000
    BUG: unable to handle kernel paging request at ffffbeef00000000

After:
    BUG: kernel NULL pointer dereference, address = 0000000000000008
    BUG: unable to handle page fault for address = ffffbeef00000000

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/mm/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 2ff25ad33233..39dccdfef496 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -644,9 +644,12 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code, unsigned long ad
 				from_kuid(&init_user_ns, current_uid()));
 	}
 
-	pr_alert("BUG: unable to handle kernel %s at %px\n",
-		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
-		 (void *)address);
+	if (address < PAGE_SIZE && !user_mode(regs))
+		pr_alert("BUG: kernel NULL pointer dereference, address = %px\n",
+			(void *)address);
+	else
+		pr_alert("BUG: unable to handle page fault for address = %px\n",
+			(void *)address);
 
 	err_txt[0] = 0;
 
-- 
2.19.2

