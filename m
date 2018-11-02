Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B04C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6BEA2084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBRmym91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BEA2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeKCEBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:01:16 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743FD2084A;
        Fri,  2 Nov 2018 18:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184780;
        bh=/CQwX9J7SmNqr07KY1ODgXPvi5oX5UDufa02epeGmzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qBRmym91aH9d1M0CFo7JF3+i+WB7oTp2t4Jn+a8/solg+711yjO2v16CRNlYcfJJ+
         VWmdH/VfYQS7xt+95OvH8Va/VhWjuwNa8QKzt6oGIBPBryelPumqyRktwasAvYHE8K
         Q2knfxNe+T8pv9d7VcQhGnvomPxJQwCARhN6S79Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 095/143] perf tests: Fix indexing when invoking subtests
Date:   Fri,  2 Nov 2018 19:34:40 +0100
Message-Id: <20181102182905.501056788@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit aa90f9f9554616d5738f7bedb4a8f0e5e14d1bc6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/tests/builtin-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5966f1f9b160..1c9bc3516f8b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -375,7 +375,7 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 	if (!t->subtest.get_nr)
 		pr_debug("%s:", t->desc);
 	else
-		pr_debug("%s subtest %d:", t->desc, subtest);
+		pr_debug("%s subtest %d:", t->desc, subtest + 1);
 
 	switch (err) {
 	case TEST_OK:
@@ -589,7 +589,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			for (subi = 0; subi < subn; subi++) {
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
-				err = test_and_print(t, skip, subi + 1);
+				err = test_and_print(t, skip, subi);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
 					skip = true;
 			}
-- 
2.17.1



