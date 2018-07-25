Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0A2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27CC20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27CC20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbeGYWHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:07:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59749 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbeGYWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:07:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKrhhD501934
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:53:43 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKrhfj501931;
        Wed, 25 Jul 2018 13:53:43 -0700
Date:   Wed, 25 Jul 2018 13:53:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-9ef0112442bdddef5fb55adf20b3a5464b33de75@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tmricht@linux.ibm.com,
        schwidefsky@de.ibm.com, acme@redhat.com, heiko.carstens@de.ibm.com,
        mingo@kernel.org, brueckner@linux.ibm.com, tglx@linutronix.de,
        hpa@zytor.com
Reply-To: tmricht@linux.ibm.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, tglx@linutronix.de, brueckner@linux.ibm.com,
          heiko.carstens@de.ibm.com, mingo@kernel.org, acme@redhat.com,
          schwidefsky@de.ibm.com
In-Reply-To: <20180724134858.100644-1-tmricht@linux.ibm.com>
References: <20180724134858.100644-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: Fix subtest number when showing results
Git-Commit-ID: 9ef0112442bdddef5fb55adf20b3a5464b33de75
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

Commit-ID:  9ef0112442bdddef5fb55adf20b3a5464b33de75
Gitweb:     https://git.kernel.org/tip/9ef0112442bdddef5fb55adf20b3a5464b33de75
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Tue, 24 Jul 2018 15:48:58 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:55:51 -0300

perf test: Fix subtest number when showing results

Perf test 40 for example has several subtests numbered 1-4 when
displaying the start of the subtest. When the subtest results
are displayed the subtests are numbered 0-3.

Use this command to generate trace output:

  [root@s35lp76 perf]# ./perf test -Fv 40 2>/tmp/bpf1

Fix this by adjusting the subtest number when show the
subtest result.

Output before:

  [root@s35lp76 perf]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 0: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 1: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 2: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 3: Ok
  [root@s35lp76 perf]#

Output after:

  root@s35lp76 ~]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 1: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 2: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 3: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 4: Ok
  [root@s35lp76 ~]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180724134858.100644-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index dd850a26d579..4f5de8245b32 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -599,7 +599,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			for (subi = 0; subi < subn; subi++) {
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
-				err = test_and_print(t, skip, subi);
+				err = test_and_print(t, skip, subi + 1);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
 					skip = true;
 			}
