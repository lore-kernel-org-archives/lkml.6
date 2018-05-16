Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeEPKfA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:35:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35737 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751046AbeEPKe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:34:58 -0400
Date: Wed, 16 May 2018 03:33:53 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-13a4db9d75ec5dbca4bd6229e149e061ef7a6bf0@git.kernel.org>
Cc: akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        dvlasenk@redhat.com, toshi.kani@hp.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, mcgrof@suse.com, bp@alien8.de, peterz@infradead.org,
        tglx@linutronix.de, luto@kernel.org, torvalds@linux-foundation.org,
        jpoimboe@redhat.com, brgerst@gmail.com, hpa@zytor.com
Reply-To: luto@kernel.org, brgerst@gmail.com, jpoimboe@redhat.com,
        hpa@zytor.com, torvalds@linux-foundation.org, toshi.kani@hp.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, dvlasenk@redhat.com,
        tglx@linutronix.de, bp@alien8.de, mcgrof@suse.com, mingo@kernel.org,
        peterz@infradead.org
In-Reply-To: <20180515175759.89315-1-andriy.shevchenko@linux.intel.com>
References: <20180515175759.89315-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mtrr: Convert to use match_string() helper
Git-Commit-ID: 13a4db9d75ec5dbca4bd6229e149e061ef7a6bf0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  13a4db9d75ec5dbca4bd6229e149e061ef7a6bf0
Gitweb:     https://git.kernel.org/tip/13a4db9d75ec5dbca4bd6229e149e061ef7a6bf0
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 15 May 2018 20:57:59 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 09:47:22 +0200

x86/mtrr: Convert to use match_string() helper

The helper returns index of the matching string in an array.
Replace the open coded array lookup with match_string().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Toshi Kani <toshi.kani@hp.com>
Link: http://lkml.kernel.org/r/20180515175759.89315-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
