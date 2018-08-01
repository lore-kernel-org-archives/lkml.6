Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED75C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1431720844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqXdeaQb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1431720844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbeHAXZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbeHAXZS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:18 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C999208A4;
        Wed,  1 Aug 2018 21:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159450;
        bh=XvADZW0uUCRGSHMZrsvaYZVooelUWCOcALcS0GJ9sBg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hqXdeaQbRFGusGv6RHy1tmorfXxMVSFddi/lpPy+LytRpfn1iV15DpyhqOduJ9qrf
         iSQ/ai8n9B8pAoBds4j4+CyZGW1Xp/nIZPxkLTynwlSWfwsapjoCazMMPmYVPcJizg
         JF5mLqt6WGZ+SWBkEoFG7ct5hpJuMBScAYv6D/nM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sandipan Das <sandipan@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/21] perf tests: Fix indexing when invoking subtests
Date:   Wed,  1 Aug 2018 18:36:36 -0300
Message-Id: <20180801213648.4814-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandipan Das <sandipan@linux.ibm.com>

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
-- 
2.14.4

