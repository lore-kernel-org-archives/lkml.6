Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024A7C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE34920818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpwXAyrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE34920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbeKIHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:43:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:36580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731917AbeKIHny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:54 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE132148E;
        Thu,  8 Nov 2018 22:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714782;
        bh=zSzR99+lxbD/GVFKVE+bQLLYWR+uC2SyjEIllmMNabM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpwXAyrYmdCLv2APkzY09zmTAjPKIoSKcmHUxvjgV7Of+awGeUg0sp87tZr29N5Lt
         w65LltI+7J8PpHibeut4dDEsqSeBU3+/PkKYw4vPWKxnC5hImCJ77X1ecwChAaAcTw
         fwvOm6nCgpzOqNboxxvZxbCaF/TbjhO/Je1Lyq0s=
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
Subject: [PATCH 4.9 125/171] perf tests: Fix indexing when invoking subtests
Date:   Thu,  8 Nov 2018 13:51:35 -0800
Message-Id: <20181108215136.280871434@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index ade7213943ad..03239956987f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -335,7 +335,7 @@ static int test_and_print(struct test *t, bool force_skip, int subtest)
 	if (!t->subtest.get_nr)
 		pr_debug("%s:", t->desc);
 	else
-		pr_debug("%s subtest %d:", t->desc, subtest);
+		pr_debug("%s subtest %d:", t->desc, subtest + 1);
 
 	switch (err) {
 	case TEST_OK:
@@ -413,7 +413,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
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



