Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752992AbeEOR6D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 13:58:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:36270 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752495AbeEOR6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 13:58:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="228737166"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] x86/mtrr: Convert to use match_string() helper
Date: Tue, 15 May 2018 20:57:59 +0300
Message-Id: <20180515175759.89315-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper returns index of the matching string in an array.
Replace the open coded array lookup.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

- reword commit message

 arch/x86/kernel/cpu/mtrr/if.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index d0fd1a5a098e..3cbae60663fa 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -137,17 +137,16 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
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
