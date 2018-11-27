Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34125C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F171920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RZAEXTul";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HSg0enEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F171920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbeK0ULA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:11:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:43928 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbeK0ULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:11:00 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9A2E060B12; Tue, 27 Nov 2018 09:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543310025;
        bh=r60PUISgllzhLFCivXzbigHr+td5AcXOrS8X/5wqQEw=;
        h=From:To:Cc:Subject:Date:From;
        b=RZAEXTulcToNHzwlvyCwIvbHHy22l2jiMfjMi7dmCNXaM6gnF84Bc4E6ELVEZuxOz
         kE4z9mMUtP/h+BVYZ5pGFxc7rt8OGCC4HKwhOou0U2CC+cPzjp/ajM9aBBmeDdW3FT
         76oIghDnspNGZclVbwouYefgarxz3l8sHjlpTrsM=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3486660351;
        Tue, 27 Nov 2018 09:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1543310024;
        bh=r60PUISgllzhLFCivXzbigHr+td5AcXOrS8X/5wqQEw=;
        h=From:To:Cc:Subject:Date:From;
        b=HSg0enECWE2XCaia8OSCEcXEnHLuJn2K0GaD9DCAM/Er88PL0lLqZtAd3zKknVhE0
         jZb5/lKeJD8cez+XCHAM9DqyXksquMDRxRQNH66HqpCiEu4BboxVx4e8AXA2kKQoYA
         nN97FCNQHzdVWfYCK9lJ8rzXfwOVD154ng3mq9E8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3486660351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf/core: declare the percpu variable properly
Date:   Tue, 27 Nov 2018 14:43:32 +0530
Message-Id: <1543310012-7967-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports the current declaration of percpu variable with
below warning

warning: incorrect type in initializer (different address spaces)
         expected void const [noderef] <asn:3>*__vpp_verify
         got struct perf_cpu_context *<noident>

Fix it by declaring it properly.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>

---
 include/linux/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 53c500f..1d5c551 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -262,8 +262,8 @@ struct pmu {
 	 */
 	int				capabilities;
 
-	int * __percpu			pmu_disable_count;
-	struct perf_cpu_context * __percpu pmu_cpu_context;
+	int __percpu			*pmu_disable_count;
+	struct perf_cpu_context __percpu *pmu_cpu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
 	int				hrtimer_interval_ms;
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

