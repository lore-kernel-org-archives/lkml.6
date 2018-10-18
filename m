Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01206C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DD921473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DD921473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeJRQpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:45:03 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:11447 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727486AbeJRQpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:45:02 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id w9I8jdUK004409;
        Thu, 18 Oct 2018 16:45:39 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Thu, 18 Oct 2018
 16:43:43 +0800
From:   Nickhu <nickhu@andestech.com>
To:     <greentime@andestech.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <deanbo422@gmail.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <arnd@arndb.de>,
        <sboyd@codeaurora.org>, <geert@linux-m68k.org>,
        <zong@andestech.com>, <ebiederm@xmission.com>,
        <akpm@linux-foundation.org>, <gregkh@linuxfoundation.org>,
        <pombredanne@nexb.com>, <tglx@linutronix.de>,
        <kstewart@linuxfoundation.org>, <devicetree@vger.kernel.org>
CC:     Nickhu <nickhu@andestech.com>, <green.hu@gmail.com>
Subject: [PATCH 4/5] nds32: Fix perf multiple events map to same counter.
Date:   Thu, 18 Oct 2018 16:43:16 +0800
Message-ID: <a683ef0bac252d0a0982643e9095dc0fc46a1305.1539745993.git.nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1539745993.git.nickhu@andestech.com>
References: <cover.1539745993.git.nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com w9I8jdUK004409
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there are multiple events map to the same counter, the counter
counts inaccurately. This is because each counter only counts one event
in the same time.
So when there are multiple events map to same counter, they have to take
turns in each context.

There are two solution:
1. Print the error message when multiple events map to the same counter.
But print the error message would let the program hang in loop. The ltp
(linux test program) would be failed when the program hang in loop.

2. Don't print the error message, the ltp would pass. But the user need to
have the knowledge that don't count the events which map to the same
counter, or the user will get the inaccurate results.

We choose method 2 for the solution

Signed-off-by: Nickhu <nickhu@andestech.com>
---
 arch/nds32/include/asm/pmu.h       |  1 +
 arch/nds32/kernel/perf_event_cpu.c | 30 ++++++++++++++++++++----------
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/nds32/include/asm/pmu.h b/arch/nds32/include/asm/pmu.h
index 3fbbe97c2d42..e75ec34af5f6 100644
--- a/arch/nds32/include/asm/pmu.h
+++ b/arch/nds32/include/asm/pmu.h
@@ -55,6 +55,7 @@ enum { PFMC0, PFMC1, PFMC2, MAX_COUNTERS };
  */
 #define NDS32_IDX_CYCLE_COUNTER			0
 #define NDS32_IDX_COUNTER0			1
+#define NDS32_IDX_COUNTER1			2
 #define NDS32_IDX_COUNTER_LAST(cpu_pmu) \
 	(NDS32_IDX_CYCLE_COUNTER + (cpu_pmu)->num_events - 1)
 
diff --git a/arch/nds32/kernel/perf_event_cpu.c b/arch/nds32/kernel/perf_event_cpu.c
index 7bb4ebb87b5c..e9a0d8bb2bc1 100644
--- a/arch/nds32/kernel/perf_event_cpu.c
+++ b/arch/nds32/kernel/perf_event_cpu.c
@@ -566,16 +566,26 @@ static int nds32_pmu_get_event_idx(struct pmu_hw_events *cpuc,
 	/*
 	 * Try to get the counter for correpsonding event
 	 */
-	if (!test_and_set_bit(idx, cpuc->used_mask))
-		return idx;
-
-	/*
-	 * The counter is in use.
-	 * The system will hang in the loop.
-	 */
-	pr_err
-	("Multiple events map to one counter, the behavior is undefined.\n");
-	return -EPERM;
+	if (evtype == SPAV3_0_SEL_TOTAL_CYCLES) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+		if (!test_and_set_bit(NDS32_IDX_COUNTER0, cpuc->used_mask))
+			return NDS32_IDX_COUNTER0;
+		if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
+			return NDS32_IDX_COUNTER1;
+	} else if (evtype == SPAV3_1_SEL_COMPLETED_INSTRUCTION) {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+		else if (!test_and_set_bit(NDS32_IDX_COUNTER1, cpuc->used_mask))
+			return NDS32_IDX_COUNTER1;
+		else if (!test_and_set_bit
+			 (NDS32_IDX_CYCLE_COUNTER, cpuc->used_mask))
+			return NDS32_IDX_CYCLE_COUNTER;
+	} else {
+		if (!test_and_set_bit(idx, cpuc->used_mask))
+			return idx;
+	}
+	return -EAGAIN;
 }
 
 static void nds32_pmu_start(struct nds32_pmu *cpu_pmu)
-- 
2.17.0

