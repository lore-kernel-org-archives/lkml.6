Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeEPKfY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:35:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53397 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeEPKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:35:23 -0400
Date: Wed, 16 May 2018 03:34:24 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-7f8ec5a4f01aa7d03e94a3d99d7b5f9c02d7fe5a@git.kernel.org>
Cc: peterz@infradead.org, brgerst@gmail.com, linux-kernel@vger.kernel.org,
        dvlasenk@redhat.com, mcgrof@suse.com, mingo@kernel.org,
        tglx@linutronix.de, bp@alien8.de, jpoimboe@redhat.com,
        andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org,
        luto@kernel.org, toshi.kani@hp.com, hpa@zytor.com,
        akpm@linux-foundation.org
Reply-To: brgerst@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mcgrof@suse.com, dvlasenk@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, bp@alien8.de,
        jpoimboe@redhat.com, andriy.shevchenko@linux.intel.com,
        luto@kernel.org, torvalds@linux-foundation.org, toshi.kani@hp.com,
        hpa@zytor.com, akpm@linux-foundation.org
In-Reply-To: <20180515180535.89703-1-andriy.shevchenko@linux.intel.com>
References: <20180515180535.89703-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mtrr: Convert to use strncpy_from_user() helper
Git-Commit-ID: 7f8ec5a4f01aa7d03e94a3d99d7b5f9c02d7fe5a
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

Commit-ID:  7f8ec5a4f01aa7d03e94a3d99d7b5f9c02d7fe5a
Gitweb:     https://git.kernel.org/tip/7f8ec5a4f01aa7d03e94a3d99d7b5f9c02d7fe5a
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 15 May 2018 21:05:35 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 16 May 2018 09:47:23 +0200

x86/mtrr: Convert to use strncpy_from_user() helper

Replace the open coded string fetch from user-space with strncpy_from_user().

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
Link: http://lkml.kernel.org/r/20180515180535.89703-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/mtrr/if.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mtrr/if.c b/arch/x86/kernel/cpu/mtrr/if.c
index 42b4f2f3b557..c610f47373e4 100644
--- a/arch/x86/kernel/cpu/mtrr/if.c
+++ b/arch/x86/kernel/cpu/mtrr/if.c
@@ -106,17 +106,9 @@ mtrr_write(struct file *file, const char __user *buf, size_t len, loff_t * ppos)
 
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
 
 	linelen = strlen(line);
 	ptr = line + linelen - 1;
