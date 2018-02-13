Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965364AbeBMRkP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:40:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:21712 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934279AbeBMRkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:40:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="17829561"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrei Vagin <avagin@virtuozzo.com>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/boot/compressed/64: Do not truncate gdt address
Date: Tue, 13 Feb 2018 20:40:09 +0300
Message-Id: <20180213174009.12323-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before going to 32-bit trampoline we need to load GDT to make sure that
we have the table with 32-bit code segment.

The load was implemented incorrectly and the table address is truncated
to 32-bit. It causes problems if gdt is above 4G.

Reported-and-tested-by: Andrei Vagin <avagin@virtuozzo.com>
Fixes: b4b56015ed1c ("x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 70b30f2bc9e0..99a0e7993252 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -332,7 +332,7 @@ ENTRY(startup_64)
 
 	/* Make sure we have GDT with 32-bit code segment */
 	leaq	gdt(%rip), %rax
-	movl	%eax, gdt64+2(%rip)
+	movq	%rax, gdt64+2(%rip)
 	lgdt	gdt64(%rip)
 
 	/*
-- 
2.15.1
