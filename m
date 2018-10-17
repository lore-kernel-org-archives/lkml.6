Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092BAECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7E521470
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyEGMhrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7E521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJRGxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727611AbeJRGxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:53:24 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5835621479;
        Wed, 17 Oct 2018 22:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539816930;
        bh=nQRzyft1tm4Z80dXsaBl5A/uAphA8Sk12OFAMu4qOWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyEGMhrBlvb+HQO3sWq6zmiB3OQfYi1G+uc0PmWYRjmO34aSMvry2qtEtFr1g2IfR
         GneQSSZ/gNPN4AnVPT1YqO9kkn/a4iSzusLDJCe0BtYyM7g2tpyubuE7/KbqGsd6UP
         GSsjwc2L+WEW/PjEo51W7bk9OVCqvdHPlmwXidg8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/11] Revert "perf tools: Fix PMU term format max value calculation"
Date:   Wed, 17 Oct 2018 19:54:53 -0300
Message-Id: <20181017225501.32150-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181017225501.32150-1-acme@kernel.org>
References: <20181017225501.32150-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

