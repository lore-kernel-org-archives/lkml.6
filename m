Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD96920874
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfABWCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:02:46 -0500
Received: from mga11.intel.com ([192.55.52.93]:46021 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbfABWCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:02:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 14:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="132467448"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 02 Jan 2019 14:02:40 -0800
Subject: [PATCH 2/2] x86/selftests/pkeys: fork() to check for state being preserved
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, mpe@ellerman.id.au, will.deacon@arm.com,
        luto@kernel.org, jroedel@suse.de, stable@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 02 Jan 2019 13:56:57 -0800
References: <20190102215653.4D7C8AF4@viggo.jf.intel.com>
In-Reply-To: <20190102215653.4D7C8AF4@viggo.jf.intel.com>
Message-Id: <20190102215657.585704B7@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

There was a bug where the per-mm pkey state was not being preserved
across fork() in the child.  fork() is performed in the pkey
selftests, but all of our pkey activity is performed in the parent.
The child does not perform any actions sensitive to pkey state.

To make the test more sensitive to these kinds of bugs, add a
fork() where we let the parent exit, and continue execution in
the child.

This patch removes an early 'break;' on the first allocation failure,
making the test sensitive to mis-allowed allocations after fork().
However, this means that the loop always runs to completion and we
must remove the test ensuring the loop never completes.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: stable@vger.kernel.org
---

 b/tools/testing/selftests/x86/protection_keys.c |   41 ++++++++++++++++++------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~x86-pkeys-no-init-at-fork-selftests tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~x86-pkeys-no-init-at-fork-selftests	2019-01-02 13:53:53.721951964 -0800
+++ b/tools/testing/selftests/x86/protection_keys.c	2019-01-02 13:53:53.724951964 -0800
@@ -1133,6 +1133,21 @@ void test_pkey_syscalls_bad_args(int *pt
 	pkey_assert(err);
 }
 
+void become_child(void)
+{
+	pid_t forkret;
+
+	forkret = fork();
+	pkey_assert(forkret >= 0);
+	dprintf3("[%d] fork() ret: %d\n", getpid(), forkret);
+
+	if (!forkret) {
+		/* in the child */
+		return;
+	}
+	exit(0);
+}
+
 /* Assumes that all pkeys other than 'pkey' are unallocated */
 void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 {
@@ -1141,7 +1156,7 @@ void test_pkey_alloc_exhaust(int *ptr, u
 	int nr_allocated_pkeys = 0;
 	int i;
 
-	for (i = 0; i < NR_PKEYS*2; i++) {
+	for (i = 0; i < NR_PKEYS*3; i++) {
 		int new_pkey;
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
@@ -1152,21 +1167,27 @@ void test_pkey_alloc_exhaust(int *ptr, u
 		if ((new_pkey == -1) && (errno == ENOSPC)) {
 			dprintf2("%s() failed to allocate pkey after %d tries\n",
 				__func__, nr_allocated_pkeys);
-			break;
+		} else {
+			/*
+			 * Ensure the number of successes never
+			 * exceeds the number of keys supported
+			 * in the hardware.
+			 */
+			pkey_assert(nr_allocated_pkeys < NR_PKEYS);
+			allocated_pkeys[nr_allocated_pkeys++] = new_pkey;
 		}
-		pkey_assert(nr_allocated_pkeys < NR_PKEYS);
-		allocated_pkeys[nr_allocated_pkeys++] = new_pkey;
+
+		/*
+		 * Make sure that allocation state is properly
+		 * preserved across fork().
+		 */
+		if (i == NR_PKEYS*2)
+			become_child();
 	}
 
 	dprintf3("%s()::%d\n", __func__, __LINE__);
 
 	/*
-	 * ensure it did not reach the end of the loop without
-	 * failure:
-	 */
-	pkey_assert(i < NR_PKEYS*2);
-
-	/*
 	 * There are 16 pkeys supported in hardware.  Three are
 	 * allocated by the time we get here:
 	 *   1. The default key (0)
_
