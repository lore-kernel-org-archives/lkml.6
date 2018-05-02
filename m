Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeEBNzu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:55:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:58147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbeEBNzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:55:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,354,1520924400";
   d="scan'208";a="225150788"
From: changbin.du@intel.com
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
Subject: [PATCH v2 5/5] asm-generic: fix build error in fix_to_virt with CONFIG_DEBUG_EXPERIENCE
Date: Wed,  2 May 2018 21:45:00 +0800
Message-Id: <1525268700-10631-6-git-send-email-changbin.du@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

With '-Og' optimization level, GCC would not optimize a count for a loop
as a constant value. But BUILD_BUG_ON() only accept compile-time constant
values.

arch/arm/mm/mmu.o: In function `fix_to_virt':
/home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
Makefile:1051: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Changbin Du <changbin.du@intel.com>
---
 include/asm-generic/fixmap.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3..a6576d4 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -28,7 +28,8 @@
  */
 static __always_inline unsigned long fix_to_virt(const unsigned int idx)
 {
-	BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
+	BUILD_BUG_ON(__builtin_constant_p(idx) &&
+		     idx >= __end_of_fixed_addresses);
 	return __fix_to_virt(idx);
 }
 
-- 
2.7.4
