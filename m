Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D6CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1F72088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFCdjSJn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1F72088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeGYTOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:46 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A8D920852;
        Wed, 25 Jul 2018 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541720;
        bh=5Tt66/uVgsK0Z7CWtKsJepCE4MBSg0b8En87fzcq0ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tFCdjSJnMHAyK29mQWbJZ9GWZFl5+7X4zoz2ADMCnbvu/ALfGbTWucqPvUrkBbKn4
         2epGLzY7U0sTXYW91Akdv8OGBIuSq3BpqVZIb4Vo+qwXntlbXHkMEX3RT1gteE1YPY
         Q9mCzAgZXA502DWMJ6L0+qOrX22glSppEftjn4M0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 18/27] perf trace arm64: Use generated syscall table
Date:   Wed, 25 Jul 2018 14:59:52 -0300
Message-Id: <20180725180001.15108-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

This should speed up accessing new system calls introduced with the
kernel rather than waiting for libaudit updates to include them.

It also enables users to specify wildcards, for example, perf trace -e
'open*', just like was already possible on x86, s390, and powerpc, which
means arm64 can now pass the "Check open filename arg using perf trace +
vfs_getname" test.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180706163454.f714b9ab49ecc8566a0b3565@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config   | 2 ++
 tools/perf/util/syscalltbl.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f5a3b402589e..d3318f99006c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -54,6 +54,8 @@ endif
 
 ifeq ($(SRCARCH),arm64)
   NO_PERF_REGS := 0
+  NO_SYSCALL_TABLE := 0
+  CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 0ee7f568d60c..3393d7ee9401 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -38,6 +38,10 @@ static const char **syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char **syscalltbl_native = syscalltbl_powerpc_32;
+#elif defined(__aarch64__)
+#include <asm/syscalls.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_ARM64_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_arm64;
 #endif
 
 struct syscall {
-- 
2.14.4

