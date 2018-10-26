Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34970ECDE47
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054FE2082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054FE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeJ0Efm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:35:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:50067 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbeJ0Efl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:35:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2018 12:57:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,429,1534834800"; 
   d="scan'208";a="103608979"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2018 12:57:21 -0700
Subject: [PATCH 2/2] x86/selftests/pkeys: fork() to check for state being preserved
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        peterz@infradead.org, mpe@ellerman.id.au, will.deacon@arm.com,
        luto@kernel.org, jroedel@suse.de
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 26 Oct 2018 12:51:47 -0700
References: <20181026195146.9C7C1136@viggo.jf.intel.com>
In-Reply-To: <20181026195146.9C7C1136@viggo.jf.intel.com>
Message-Id: <20181026195147.78D4C275@viggo.jf.intel.com>
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
---

 b/tools/testing/selftests/x86/protection_keys.c |   30 ++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff -puN tools/testing/selftests/x86/protection_keys.c~x86-pkeys-no-init-at-fork-selftests tools/testing/selftests/x86/protection_keys.c
--- a/tools/testing/selftests/x86/protection_keys.c~x86-pkeys-no-init-at-fork-selftests	2018-10-26 09:26:51.970102217 -0700
+++ b/tools/testing/selftests/x86/protection_keys.c	2018-10-26 09:26:51.974102217 -0700
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
@@ -1152,10 +1167,17 @@ void test_pkey_alloc_exhaust(int *ptr, u
 		if ((new_pkey == -1) && (errno == ENOSPC)) {
 			dprintf2("%s() failed to allocate pkey after %d tries\n",
 				__func__, nr_allocated_pkeys);
-			break;
+		} else {
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
_
