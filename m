Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeCZRaP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:30:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:63104 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeCZR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:29:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,365,1517904000";
   d="scan'208";a="31428241"
Subject: [PATCH 8/9] x86, pkeys, selftests: add allow faults on unknown keys
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Mon, 26 Mar 2018 10:27:33 -0700
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
In-Reply-To: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
Message-Id: <20180326172733.F975879E@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

The exec-only pkey is allocated inside the kernel and userspace
is not told what it is.  So, allow PK faults to occur that have
an unknown key.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Michael Ellermen <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
---

 b/tools/testing/selftests/x86/protection_keys.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-unknown-exec-only-key tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~pkeys-selftests-unknown-exec-only-key	2018-03-26 10:22:37.549170187 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-03-26 10:22:37.553170187 -0700
@@ -922,13 +922,21 @@ void *malloc_pkey(long size, int prot, u
 }
 
 int last_pkru_faults;
+#define UNKNOWN_PKEY -2
 void expected_pk_fault(int pkey)
 {
 	dprintf2("%s(): last_pkru_faults: %d pkru_faults: %d\n",
 			__func__, last_pkru_faults, pkru_faults);
 	dprintf2("%s(%d): last_si_pkey: %d\n", __func__, pkey, last_si_pkey);
 	pkey_assert(last_pkru_faults + 1 == pkru_faults);
-	pkey_assert(last_si_pkey == pkey);
+
+       /*
+	* For exec-only memory, we do not know the pkey in
+	* advance, so skip this check.
+	*/
+	if (pkey != UNKNOWN_PKEY)
+		pkey_assert(last_si_pkey == pkey);
+
 	/*
 	 * The signal handler shold have cleared out PKRU to let the
 	 * test program continue.  We now have to restore it.
_
