Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751746AbeBZSFJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:09 -0500
Received: from mga02.intel.com ([134.134.136.20]:48839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbeBZSFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="20488735"
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>, Andi Kleen <ak@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 1/5] x86/boot/compressed/64: Describe the logic behind LA57 check
Date: Mon, 26 Feb 2018 21:04:47 +0300
Message-Id: <20180226180451.86788-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
References: <20180226180451.86788-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch explains the LA57 check in more details.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/pgtable_64.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 3f1697fcc7a8..45c76eff2718 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -18,10 +18,22 @@ struct paging_config paging_prepare(void)
 {
 	struct paging_config paging_config = {};
 
-	/* Check if LA57 is desired and supported */
-	if (IS_ENABLED(CONFIG_X86_5LEVEL) && native_cpuid_eax(0) >= 7 &&
-			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
+	/*
+	 * Check if LA57 is desired and supported.
+	 *
+	 * There are two parts to the check:
+	 *   - if the kernel supports 5-level paging: CONFIG_X86_5LEVEL=y
+	 *   - if the machine supports 5-level paging:
+	 *     + CPUID leaf 7 is supported
+	 *     + the leaf has the feature bit set
+	 *
+	 * That's substitute for boot_cpu_has() in early boot code.
+	 */
+	if (IS_ENABLED(CONFIG_X86_5LEVEL) &&
+			native_cpuid_eax(0) >= 7 &&
+			(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31)))) {
 		paging_config.l5_required = 1;
+	}
 
 	return paging_config;
 }
-- 
2.16.1
