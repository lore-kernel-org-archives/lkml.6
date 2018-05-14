Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753429AbeENMmn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 08:42:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54717 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753414AbeENMml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 08:42:41 -0400
Date: Mon, 14 May 2018 05:42:18 -0700
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-caf9eb6b4c82fc6cbd03697052ff22d97b0c377b@git.kernel.org>
Cc: shuah@kernel.org, hpa@zytor.com, peterz@infradead.org,
        dave.hansen@intel.com, mpe@ellerman.id.au, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, tglx@linutronix.de, akpm@linux-foundation.org,
        linuxram@us.ibm.com
Reply-To: dave.hansen@intel.com, mpe@ellerman.id.au, peterz@infradead.org,
        shuah@kernel.org, hpa@zytor.com, akpm@linux-foundation.org,
        linuxram@us.ibm.com, tglx@linutronix.de, mingo@kernel.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dave.hansen@linux.intel.com
In-Reply-To: <20180509171344.C53FD2F3@viggo.jf.intel.com>
References: <20180509171344.C53FD2F3@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/pkeys/selftests: Avoid printf-in-signal
 deadlocks
Git-Commit-ID: caf9eb6b4c82fc6cbd03697052ff22d97b0c377b
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

Commit-ID:  caf9eb6b4c82fc6cbd03697052ff22d97b0c377b
Gitweb:     https://git.kernel.org/tip/caf9eb6b4c82fc6cbd03697052ff22d97b0c377b
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 9 May 2018 10:13:44 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 14 May 2018 11:14:45 +0200

x86/pkeys/selftests: Avoid printf-in-signal deadlocks

printf() and friends are unusable in signal handlers.  They deadlock.
The pkey selftest does not do any normal printing in signal handlers,
only extra debugging.  So, just print the format string so we get
*some* output when debugging.

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
Link: http://lkml.kernel.org/r/20180509171344.C53FD2F3@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/testing/selftests/x86/pkey-helpers.h | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/pkey-helpers.h b/tools/testing/selftests/x86/pkey-helpers.h
index b3cb7670e026..254e5436bdd9 100644
--- a/tools/testing/selftests/x86/pkey-helpers.h
+++ b/tools/testing/selftests/x86/pkey-helpers.h
@@ -26,30 +26,26 @@ static inline void sigsafe_printf(const char *format, ...)
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
