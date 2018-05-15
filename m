Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753913AbeEOSH2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:07:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:52921 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753013AbeEOSFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,404,1520924400";
   d="scan'208";a="39554518"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] x86/mtrr: Convert to use strncpy_from_user() helper
Date: Tue, 15 May 2018 21:05:35 +0300
Message-Id: <20180515180535.89703-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the open coded string fetch from the user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/cpu/mtrr/if.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index e4adad68b5e5..3cbae60663fa 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -105,17 +105,9 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 
 	memset(line, 0, LINE_SIZE);
 
-	length = len;
-	length--;
-
-	if (length > LINE_SIZE - 1)
-		length = LINE_SIZE - 1;
-
+	length = strncpy_from_user(line, buf, LINE_SIZE - 1);
 	if (length < 0)
-		return -EINVAL;
-
-	if (copy_from_user(line, buf, length))
-		return -EFAULT;
+		return length;
 
 	strim(line);
 
-- 
2.17.0
