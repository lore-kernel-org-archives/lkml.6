Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B2C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6B721476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6B721476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbeJRORE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:17:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:17:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9I6H0dE707545
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 17 Oct 2018 23:17:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9I6H0g0707542;
        Wed, 17 Oct 2018 23:17:00 -0700
Date:   Wed, 17 Oct 2018 23:17:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1b9caa10b31dda0866f4028e4bfb923fb6e4072f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ak@linux.intel.com,
        mpetlan@redhat.com, hpa@zytor.com, kan.liang@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        namhyung@kernel.org, peterz@infradead.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: acme@redhat.com, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, namhyung@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, mingo@kernel.org, kan.liang@linux.intel.com,
          hpa@zytor.com, mpetlan@redhat.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com
In-Reply-To: <20181003072046.29276-1-jolsa@kernel.org>
References: <20181003072046.29276-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] Revert "perf tools: Fix PMU term format max value
 calculation"
Git-Commit-ID: 1b9caa10b31dda0866f4028e4bfb923fb6e4072f
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

Commit-ID:  1b9caa10b31dda0866f4028e4bfb923fb6e4072f
Gitweb:     https://git.kernel.org/tip/1b9caa10b31dda0866f4028e4bfb923fb6e4072f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 3 Oct 2018 09:20:46 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Oct 2018 10:48:55 -0300

Revert "perf tools: Fix PMU term format max value calculation"

This reverts commit ac0e2cd555373ae6f8f3a3ad3fbbf5b6d1e7aaaa.

Michael reported an issue with oversized terms values assignment
and I noticed there was actually a misunderstanding of the max
value check in the past.

The above commit's changelog says:

  If bit 21 is set, there is parsing issues as below.

    $ perf stat -a -e uncore_qpi_0/event=0x200002,umask=0x8/
    event syntax error: '..pi_0/event=0x200002,umask=0x8/'
                                      \___ value too big for format, maximum is 511

But there's no issue there, because the event value is distributed
along the value defined by the format. Even if the format defines
separated bit, the value is treated as a continual number, which
should follow the format definition.

In above case it's 9-bit value with last bit separated:
  $ cat uncore_qpi_0/format/event
  config:0-7,21

Hence the value 0x200002 is correctly reported as format violation,
because it exceeds 9 bits. It should have been 0x102 instead, which
sets the 9th bit - the bit 21 of the format.

  $ perf stat -vv -a -e uncore_qpi_0/event=0x102,umask=0x8/
  Using CPUID GenuineIntel-6-2D
  ...
  ------------------------------------------------------------
  perf_event_attr:
    type                             10
    size                             112
    config                           0x200802
    sample_type                      IDENTIFIER
  ...

Reported-by: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: ac0e2cd55537 ("perf tools: Fix PMU term format max value calculation")
Link: http://lkml.kernel.org/r/20181003072046.29276-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index afd68524ffa9..7799788f662f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -930,13 +930,14 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 
 static __u64 pmu_format_max_value(const unsigned long *format)
 {
-	__u64 w = 0;
-	int fbit;
-
-	for_each_set_bit(fbit, format, PERF_PMU_FORMAT_BITS)
-		w |= (1ULL << fbit);
+	int w;
 
-	return w;
+	w = bitmap_weight(format, PERF_PMU_FORMAT_BITS);
+	if (!w)
+		return 0;
+	if (w < 64)
+		return (1ULL << w) - 1;
+	return -1;
 }
 
 /*
