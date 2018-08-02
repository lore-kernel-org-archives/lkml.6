Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 371842146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371842146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387394AbeHBKBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:01:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbeHBKBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:01:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728BUQq3431037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:11:30 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728BUEf3431034;
        Thu, 2 Aug 2018 01:11:30 -0700
Date:   Thu, 2 Aug 2018 01:11:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sandipan Das <tipbot@zytor.com>
Message-ID: <tip-aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6@git.kernel.org>
Cc:     tglx@linutronix.de, ravi.bangoria@linux.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, jolsa@redhat.com,
        mingo@kernel.org, heiko.carstens@de.ibm.com, acme@redhat.com,
        hpa@zytor.com, schwidefsky@de.ibm.com, brueckner@linux.ibm.com,
        sandipan@linux.ibm.com, linux-kernel@vger.kernel.org,
        tmricht@linux.ibm.com
Reply-To: naveen.n.rao@linux.vnet.ibm.com, jolsa@redhat.com,
          tglx@linutronix.de, ravi.bangoria@linux.ibm.com,
          heiko.carstens@de.ibm.com, hpa@zytor.com, acme@redhat.com,
          mingo@kernel.org, sandipan@linux.ibm.com, schwidefsky@de.ibm.com,
          brueckner@linux.ibm.com, tmricht@linux.ibm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20180726171733.33208-1-sandipan@linux.ibm.com>
References: <20180726171733.33208-1-sandipan@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Fix indexing when invoking subtests
Git-Commit-ID: aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6
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

Commit-ID:  aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6
Gitweb:     https://git.kernel.org/tip/aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6
Author:     Sandipan Das <sandipan@linux.ibm.com>
AuthorDate: Thu, 26 Jul 2018 22:47:33 +0530
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:52:51 -0300

perf tests: Fix indexing when invoking subtests

Recently, the subtest numbering was changed to start from 1.  While it
is fine for displaying results, this should not be the case when the
subtests are actually invoked.

Typically, the subtests are stored in zero-indexed arrays and invoked
based on the index passed to the main test function.  Since the index
now starts from 1, the second subtest in the array (index 1) gets
invoked instead of the first (index 0).  This applies to all of the
following subtests but for the last one, the subtest always fails
because it does not meet the boundary condition of the subtest index
being lesser than the number of subtests.

This can be observed on powerpc64 and x86_64 systems running Fedora 28
as shown below.

Before:

  # perf test "builtin clang support"
  55: builtin clang support                                 :
  55.1: builtin clang compile C source to IR                : Ok
  55.2: builtin clang compile C source to ELF object        : FAILED!

  # perf test "LLVM search and compile"
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : FAILED!

  # perf test "BPF filter"
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : FAILED!

After:

  # perf test "builtin clang support"
  55: builtin clang support                                 :
  55.1: builtin clang compile C source to IR                : Ok
  55.2: builtin clang compile C source to ELF object        : Ok

  # perf test "LLVM search and compile"
  38: LLVM search and compile                               :
  38.1: Basic BPF llvm compile                              : Ok
  38.2: kbuild searching                                    : Ok
  38.3: Compile source for BPF prologue generation          : Ok
  38.4: Compile source for BPF relocation                   : Ok

  # perf test "BPF filter"
  40: BPF filter                                            :
  40.1: Basic BPF filtering                                 : Ok
  40.2: BPF pinning                                         : Ok
  40.3: BPF prologue generation                             : Ok
  40.4: BPF relocation checker                              : Ok

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Fixes: 9ef0112442bd ("perf test: Fix subtest number when showing results")
Link: http://lkml.kernel.org/r/20180726171733.33208-1-sandipan@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4f5de8245b32..d7a5e1b9aa6f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -385,7 +385,7 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 	if (!t->subtest.get_nr)
 		pr_debug("%s:", t->desc);
 	else
-		pr_debug("%s subtest %d:", t->desc, subtest);
+		pr_debug("%s subtest %d:", t->desc, subtest + 1);
 
 	switch (err) {
 	case TEST_OK:
@@ -599,7 +599,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			for (subi = 0; subi < subn; subi++) {
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
-				err = test_and_print(t, skip, subi + 1);
+				err = test_and_print(t, skip, subi);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
 					skip = true;
 			}
