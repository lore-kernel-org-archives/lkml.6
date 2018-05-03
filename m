Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeECVMW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 17:12:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:24035 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751074AbeECVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 17:12:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="51335449"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/mtrr: Convert to use match_string() helper
Date: Fri,  4 May 2018 00:12:17 +0300
Message-Id: <20180503211217.47822-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/if.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 558444b23923..42b4f2f3b557 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -149,17 +149,16 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 		return -EINVAL;
 	ptr = skip_spaces(ptr + 5);
 
-	for (i = 0; i < MTRR_NUM_TYPES; ++i) {
-		if (strcmp(ptr, mtrr_strings[i]))
-			continue;
-		base >>= PAGE_SHIFT;
-		size >>= PAGE_SHIFT;
-		err = mtrr_add_page((unsigned long)base, (unsigned long)size, i, true);
-		if (err < 0)
-			return err;
-		return len;
-	}
-	return -EINVAL;
+	i = match_string(mtrr_strings, MTRR_NUM_TYPES, ptr);
+	if (i < 0)
+		return i;
+
+	base >>= PAGE_SHIFT;
+	size >>= PAGE_SHIFT;
+	err = mtrr_add_page((unsigned long)base, (unsigned long)size, i, true);
+	if (err < 0)
+		return err;
+	return len;
 }
 
 static long
-- 
2.17.0
