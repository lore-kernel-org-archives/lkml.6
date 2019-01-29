Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5B5C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7BCF20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548763651;
	bh=OERJQzXY9jCfsvIvHqXSYV6/kKrpht4QBGwQvm1Lkuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LDcxkRVBn/yQq0aSVXidIwbGh4AaAm73/d8fDwz69MHHalcI8AZW2N14bOWQ/JcW+
	 cblK/gVOTcfqMNb422ukomHCdG1QZJIheFisRcK7r/ZJQ9LJvZ44DeaH0PnqnUfLQw
	 sQXpCsaFJ4n8gayGWHKd4BCCPL1qjKu+OGH2Pz2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfA2LkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbfA2LkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:40:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A402620989;
        Tue, 29 Jan 2019 11:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762018;
        bh=OERJQzXY9jCfsvIvHqXSYV6/kKrpht4QBGwQvm1Lkuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFFzLo8ZMIXw49jWkmB3RDsTW7YGI1mh1bolAxsLTPLCcaVcvZP33KbTWN9Kv3yRI
         TTMbPvE+iZ3rLFd2HcmNCTbrBFjH2pWrjW50d0eSvD58s8GlRUy32xMLICilIUN/Pm
         vefrlqBMxfcR8llOjkW2yybM1aDFKf2i1xGHm0hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        hpa@zytor.com, peterz@infradead.org, mpe@ellerman.id.au,
        will.deacon@arm.com, luto@kernel.org, jroedel@suse.de
Subject: [PATCH 4.20 081/117] x86/selftests/pkeys: Fork() to check for state being preserved
Date:   Tue, 29 Jan 2019 12:35:32 +0100
Message-Id: <20190129113211.511805965@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit e1812933b17be7814f51b6c310c5d1ced7a9a5f5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/protection_keys.c |   41 +++++++++++++++++++-------
 1 file changed, 31 insertions(+), 10 deletions(-)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
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


