Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965841AbeEIRSt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:18:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:65072 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965240AbeEIRSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="38056800"
Subject: [PATCH 02/13] x86/pkeys/selftests: Stop using assert()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:40 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171340.E63EF7DA@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

If we use assert(), the program "crashes".  That can be scary to users,
so stop doing it.  Just exit with a >0 exit code instead.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-do-not-assert tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-do-not-assert	2018-05-09 09:20:18.717698407 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-05-09 09:20:18.720698407 -0700
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
@@ -87,12 +86,17 @@ void cat_into_file(char *str, char *file
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
_
