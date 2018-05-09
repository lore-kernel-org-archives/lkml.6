Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965855AbeEIRSy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:18:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:63856 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965240AbeEIRSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:18:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="52900932"
Subject: [PATCH 04/13] x86/pkeys/selftests: Avoid printf-in-signal deadlocks
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Wed, 09 May 2018 10:13:44 -0700
References: <20180509171336.76636D88@viggo.jf.intel.com>
In-Reply-To: <20180509171336.76636D88@viggo.jf.intel.com>
Message-Id: <20180509171344.C53FD2F3@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

printf() and friends are unusable in signal handlers.  They deadlock.
The pkey selftest does not do any normal printing in signal handlers,
only extra debugging.  So, just print the format string so we get
*some* output when debugging.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/pkey-helpers.h |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff -puN tools/testing/selftests/x86/pkey-helpers.h~pkeys-selftests-avoid-print-in-signal-deadlocks tools/testing/selftests/x86/pkey-helpers.h
--- a/tools/testing/selftests/x86/pkey-helpers.h~pkeys-selftests-avoid-print-in-signal-deadlocks	2018-05-09 09:20:19.738698404 -0700
+++ b/tools/testing/selftests/x86/pkey-helpers.h	2018-05-09 09:20:19.742698404 -0700
@@ -26,30 +26,26 @@ static inline void sigsafe_printf(const
 {
 	va_list ap;
 
-	va_start(ap, format);
 	if (!dprint_in_signal) {
+		va_start(ap, format);
 		vprintf(format, ap);
+		va_end(ap);
 	} else {
 		int ret;
-		int len = vsnprintf(dprint_in_signal_buffer,
-				    DPRINT_IN_SIGNAL_BUF_SIZE,
-				    format, ap);
 		/*
-		 * len is amount that would have been printed,
-		 * but actual write is truncated at BUF_SIZE.
+		 * No printf() functions are signal-safe.
+		 * They deadlock easily. Write the format
+		 * string to get some output, even if
+		 * incomplete.
 		 */
-		if (len > DPRINT_IN_SIGNAL_BUF_SIZE)
-			len = DPRINT_IN_SIGNAL_BUF_SIZE;
-		ret = write(1, dprint_in_signal_buffer, len);
+		ret = write(1, format, strlen(format));
 		if (ret < 0)
-			abort();
+			exit(1);
 	}
-	va_end(ap);
 }
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)
_
