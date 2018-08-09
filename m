Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50046C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAD62183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXdDXvte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAD62183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbeHIRYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:43 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 210A221D62;
        Thu,  9 Aug 2018 14:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826766;
        bh=TeFC1Rxf6RqJJ9B6jvy3+XSiElSaSUB04XZd7Dqma+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VXdDXvteNrjSLlH7AlTystzPBuAcEYsiArfTUFPyHR+fkYcZW93r9AGjgHpT2uCG0
         YbGJBFtkB4M0sgtIjvOiYubtlvws9tx2YQF/9nxs5VwWvpt/hs4MUi1PUV8+NILvba
         TEVCVRGt5MRPorqO+uDW5OGiAbJ5NM7tN1z2LnUI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Sean V Kelley <seanvk.dev@oregontracks.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/44] perf vendor events arm64: Enable JSON events for eMAG
Date:   Thu,  9 Aug 2018 11:57:48 -0300
Message-Id: <20180809145822.21391-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean V Kelley <seanvk.dev@oregontracks.org>

This patch adds the Ampere Computing eMAG file.  This platform follows
the ARMv8 recommended IMPLEMENTATION DEFINED events, where applicable.

Signed-off-by: Sean V Kelley <seanvk.dev@oregontracks.org>
Reviewed-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
LPU-Reference: 20180803041811.17065-1-seanvk.dev@oregontracks.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/arm64/ampere/emag/core-imp-def.json       | 32 ++++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |  1 +
 2 files changed, 33 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
new file mode 100644
index 000000000000..bc03c06c3918
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/emag/core-imp-def.json
@@ -0,0 +1,32 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+   },
+   {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index f03e26ecb658..59cd8604b0bd 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -16,3 +16,4 @@
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
+0x00000000500f0000,v1,ampere/emag,core
-- 
2.14.4

