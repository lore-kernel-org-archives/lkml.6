Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8CBC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C211120864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C211120864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968307AbeFRIly (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:41:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36938 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968196AbeFRIiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:13 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 899FFC5C;
        Mon, 18 Jun 2018 08:38:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellermen <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 160/189] x86/pkeys/selftests: Add PROT_EXEC test
Date:   Mon, 18 Jun 2018 10:14:16 +0200
Message-Id: <20180618081215.655070976@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

[ Upstream commit 6af17cf89e99b64cf1f660bf848755442ab2f047 ]

Under the covers, implement executable-only memory with
protection keys when userspace calls mprotect(PROT_EXEC).

But, we did not have a selftest for that.  Now we do.

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
Link: http://lkml.kernel.org/r/20180509171348.9EEE4BEF@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/x86/protection_keys.c |   44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -1303,6 +1303,49 @@ void test_executing_on_unreadable_memory
 	expected_pk_fault(pkey);
 }
 
+void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
+{
+	void *p1;
+	int scratch;
+	int ptr_contents;
+	int ret;
+
+	dprintf1("%s() start\n", __func__);
+
+	p1 = get_pointer_to_instructions();
+	lots_o_noops_around_write(&scratch);
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+
+	/* Use a *normal* mprotect(), not mprotect_pkey(): */
+	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
+	pkey_assert(!ret);
+
+	dprintf2("pkru: %x\n", rdpkru());
+
+	/* Make sure this is an *instruction* fault */
+	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
+	lots_o_noops_around_write(&scratch);
+	do_not_expect_pk_fault("executing on PROT_EXEC memory");
+	ptr_contents = read_ptr(p1);
+	dprintf2("ptr (%p) contents@%d: %x\n", p1, __LINE__, ptr_contents);
+	expected_pk_fault(UNKNOWN_PKEY);
+
+	/*
+	 * Put the memory back to non-PROT_EXEC.  Should clear the
+	 * exec-only pkey off the VMA and allow it to be readable
+	 * again.  Go to PROT_NONE first to check for a kernel bug
+	 * that did not clear the pkey when doing PROT_NONE.
+	 */
+	ret = mprotect(p1, PAGE_SIZE, PROT_NONE);
+	pkey_assert(!ret);
+
+	ret = mprotect(p1, PAGE_SIZE, PROT_READ|PROT_EXEC);
+	pkey_assert(!ret);
+	ptr_contents = read_ptr(p1);
+	do_not_expect_pk_fault("plain read on recently PROT_EXEC area");
+}
+
 void test_mprotect_pkey_on_unsupported_cpu(int *ptr, u16 pkey)
 {
 	int size = PAGE_SIZE;
@@ -1327,6 +1370,7 @@ void (*pkey_tests[])(int *ptr, u16 pkey)
 	test_kernel_gup_of_access_disabled_region,
 	test_kernel_gup_write_to_write_disabled_region,
 	test_executing_on_unreadable_memory,
+	test_implicit_mprotect_exec_only_memory,
 	test_ptrace_of_child,
 	test_pkey_syscalls_on_non_allocated_pkey,
 	test_pkey_syscalls_bad_args,


