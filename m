Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7463C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7D021475
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDBUwC/3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7D021475
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbeHOSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbeHOSBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:01:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17CF6208B1;
        Wed, 15 Aug 2018 15:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534345716;
        bh=saqCbPQdbTOg1bpU2F2dW3RQXhHVCLRVEhgycrZnrhQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDBUwC/3vlBbwhCFcxZhc7CtHTVCBvk1Ankah/+mQrqQkUFfaroSHe6izr1fEndRt
         P8wrC2HqZl8TGxxBCxnIgwekNXCbAe5VFC2x3wo5ImI/Gu4ax9KmhvVyXqlHaJpW9w
         W6JAl0FK0G2ftGkFvdx8ZJN75mFcGS8RKyWFnKvo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 30/35] perf arm spe: Fix uninitialized record error variable
Date:   Wed, 15 Aug 2018 12:06:06 -0300
Message-Id: <20180815150611.32080-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180815150611.32080-1-acme@kernel.org>
References: <20180815150611.32080-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

The auxtrace init variable 'err' was not being initialized, leading perf
to abort early in an SPE record command when there was no explicit
error, rather only based whatever memory contents were on the stack.
Initialize it explicitly on getting an SPE successfully, the same way
cs-etm does.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: ffd3d18c20b8 ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
Link: http://lkml.kernel.org/r/20180810174512.52900813e57cbccf18ce99a2@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 1120e39c1b00..5ccfce87e693 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -194,6 +194,7 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
 	sper->itr.read_finish = arm_spe_read_finish;
 	sper->itr.alignment = 0;
 
+	*err = 0;
 	return &sper->itr;
 }
 
-- 
2.14.4

