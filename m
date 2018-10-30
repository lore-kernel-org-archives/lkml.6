Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F91C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9898D20880
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JL5ZIRdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9898D20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbeJ3WWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727759AbeJ3WWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:22:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC42420838;
        Tue, 30 Oct 2018 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906114;
        bh=80yzpRLYH1oQf8gAvSM+Gr8JpPmPBXGEW5mvV7Y/MKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JL5ZIRdUzi4cUitMTl3uXXqjxyf1RL5xPnIrmy4VAQLDBMUl6/elsMEroCYj4b56p
         /km07za3qM9M8pZ7QveqOPQuXR+u84M/Vszqv6DygCWvVU2zYc+KPLVpRlFqjZpgxu
         ZRrQUJ1K2sLj/e3E1u/uMj18kqlKvVRUMK43OZyc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 02/19] Revert "perf tools: Fix PMU term format max value calculation"
Date:   Tue, 30 Oct 2018 09:28:07 -0400
Message-Id: <20181030132824.218056-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132824.218056-1-sashal@kernel.org>
References: <20181030132824.218056-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 1b9caa10b31dda0866f4028e4bfb923fb6e4072f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/pmu.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index d87d458996b7..dceef4725d33 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -754,13 +754,14 @@ static void pmu_format_value(unsigned long *format, __u64 value, __u64 *v,
 
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
2.17.1

