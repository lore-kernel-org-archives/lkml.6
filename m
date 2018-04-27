Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757737AbeD0Ruc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:50:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:55914 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932609AbeD0Rt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:49:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="scan'208";a="35787130"
Subject: [PATCH 8/9] x86, pkeys, selftests: add allow faults on unknown keys
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Dave Hansen <dave.hansen@linux.intel.com>,
        linuxram@us.ibm.com, tglx@linutronix.de, dave.hansen@intel.com,
        mpe@ellerman.id.au, mingo@kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 27 Apr 2018 10:45:40 -0700
References: <20180427174527.0031016C@viggo.jf.intel.com>
In-Reply-To: <20180427174527.0031016C@viggo.jf.intel.com>
Message-Id: <20180427174540.91C386B5@viggo.jf.intel.com>
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
