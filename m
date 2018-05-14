Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753382AbeENMls (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:41:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752930AbeENMlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:41:44 -0400
Date: Mon, 14 May 2018 05:41:20 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-86b9eea230edf4c67d4d4a70fba9b74505867a25@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, linuxram@us.ibm.com, shuah@kernel.org,
        mpe@ellerman.id.au, akpm@linux-foundation.org, dave.hansen@intel.com,
        hpa@zytor.com, torvalds@linux-foundation.org, mingo@kernel.org,
        peterz@infradead.org
Reply-To: mpe@ellerman.id.au, akpm@linux-foundation.org, dave.hansen@intel.com,
        hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com, linuxram@us.ibm.com, shuah@kernel.org
In-Reply-To: <20180509171340.E63EF7DA@viggo.jf.intel.com>
References: <20180509171340.E63EF7DA@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Stop using assert()
Git-Commit-ID: 86b9eea230edf4c67d4d4a70fba9b74505867a25
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

Commit-ID:  86b9eea230edf4c67d4d4a70fba9b74505867a25
Gitweb:     https://git.kernel.org/tip/86b9eea230edf4c67d4d4a70fba9b74505867a25
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:40 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Stop using assert()

If we use assert(), the program "crashes".  That can be scary to users,
so stop doing it.  Just exit with a >0 exit code instead.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180509171340.E63EF7DA@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/protection_keys.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index a0f0a732784b..8537a7cfe1cc 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -72,10 +72,9 @@ extern void abort_hooks(void);
 				test_nr, iteration_nr);	\
 		dprintf0("errno at assert: %d", errno);	\
 		abort_hooks();			\
-		assert(condition);		\
+		exit(__LINE__);			\
 	}					\
 } while (0)
-#define raw_assert(cond) assert(cond)
 
 void cat_into_file(char *str, char *file)
 {
@@ -87,12 +86,17 @@ void cat_into_file(char *str, char *file)
 	 * these need to be raw because they are called under
 	 * pkey_assert()
 	 */
-	raw_assert(fd >= 0);
+	if (fd < 0) {
+		fprintf(stderr, "error opening '%s'\n", str);
+		perror("error: ");
+		exit(__LINE__);
+	}
+
 	ret = write(fd, str, strlen(str));
 	if (ret != strlen(str)) {
 		perror("write to file failed");
 		fprintf(stderr, "filename: '%s' str: '%s'\n", file, str);
-		raw_assert(0);
+		exit(__LINE__);
 	}
 	close(fd);
 }
