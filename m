Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D507C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F820656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfAOJhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:37:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41853 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfAOJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:37:49 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0F9bV3s2457799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jan 2019 01:37:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0F9bVBd2457795;
        Tue, 15 Jan 2019 01:37:31 -0800
Date:   Tue, 15 Jan 2019 01:37:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-e1812933b17be7814f51b6c310c5d1ced7a9a5f5@git.kernel.org>
Cc:     mpe@ellerman.id.au, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
        mingo@kernel.org, luto@kernel.org, peterz@infradead.org,
        jroedel@suse.de, dave.hansen@linux.intel.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, jroedel@suse.de, dave.hansen@linux.intel.com,
          luto@kernel.org, mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, bp@alien8.de,
          mpe@ellerman.id.au, will.deacon@arm.com
In-Reply-To: <20190102215657.585704B7@viggo.jf.intel.com>
References: <20190102215657.585704B7@viggo.jf.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/selftests/pkeys: Fork() to check for state
 being preserved
Git-Commit-ID: e1812933b17be7814f51b6c310c5d1ced7a9a5f5
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e1812933b17be7814f51b6c310c5d1ced7a9a5f5
Gitweb:     https://git.kernel.org/tip/e1812933b17be7814f51b6c310c5d1ced7a9a5f5
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Wed, 2 Jan 2019 13:56:57 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 15 Jan 2019 10:33:45 +0100

x86/selftests/pkeys: Fork() to check for state being preserved

There was a bug where the per-mm pkey state was not being preserved across
fork() in the child.  fork() is performed in the pkey selftests, but all of
the pkey activity is performed in the parent.  The child does not perform
any actions sensitive to pkey state.

To make the test more sensitive to these kinds of bugs, add a fork() where
the parent exits, and execution continues in the child.

To achieve this let the key exhaustion test not terminate at the first
allocation failure and fork after 2*NR_PKEYS loops and continue in the
child.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Cc: peterz@infradead.org
Cc: mpe@ellerman.id.au
Cc: will.deacon@arm.com
Cc: luto@kernel.org
Cc: jroedel@suse.de
Cc: stable@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20190102215657.585704B7@viggo.jf.intel.com

---
 tools/testing/selftests/x86/protection_keys.c | 41 ++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/x86/protection_keys.c b/tools/testing/selftests/x86/protection_keys.c
index 460b4bdf4c1e..5d546dcdbc80 100644
--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1133,6 +1133,21 @@ void test_pkey_syscalls_bad_args(int *ptr, u16 pkey)
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
@@ -1141,7 +1156,7 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
 	int nr_allocated_pkeys = 0;
 	int i;
 
-	for (i = 0; i < NR_PKEYS*2; i++) {
+	for (i = 0; i < NR_PKEYS*3; i++) {
 		int new_pkey;
 		dprintf1("%s() alloc loop: %d\n", __func__, i);
 		new_pkey = alloc_pkey();
@@ -1152,20 +1167,26 @@ void test_pkey_alloc_exhaust(int *ptr, u16 pkey)
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
 
-	/*
-	 * ensure it did not reach the end of the loop without
-	 * failure:
-	 */
-	pkey_assert(i < NR_PKEYS*2);
-
 	/*
 	 * There are 16 pkeys supported in hardware.  Three are
 	 * allocated by the time we get here:
