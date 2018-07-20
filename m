Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2B9ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511CD206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 11:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511CD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbeGTLs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:48:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32844 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728254AbeGTLsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:48:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0913272630;
        Fri, 20 Jul 2018 11:00:43 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6287111DCF5;
        Fri, 20 Jul 2018 11:00:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 4/4] perf tools: Move syscall_64.tbl check into check-headers.sh
Date:   Fri, 20 Jul 2018 13:00:36 +0200
Message-Id: <20180720110036.32251-4-jolsa@kernel.org>
In-Reply-To: <20180720110036.32251-1-jolsa@kernel.org>
References: <20180720110036.32251-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 11:00:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 11:00:43 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Probably leftover from the time we introducd the check-headers.sh script.

Link: http://lkml.kernel.org/n/tip-oh56ckqztoc07we7mtdphu7r@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/arch/x86/Makefile | 3 ---
 tools/perf/check-headers.sh  | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 1a38e78117ce..8cc6642fce7a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -19,9 +19,6 @@ systbl := $(sys)/syscalltbl.sh
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sys)/syscall_64.tbl $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-        (diff -B arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl >/dev/null) \
-        || echo "Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sys)/syscall_64.tbl 'x86_64' > $@
 
 clean::
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 73e723675c5f..2c10e46d98e9 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -93,3 +93,6 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+
+# diff non-symmetric files
+check_2 arch/x86/entry/syscalls/syscall_64.tbl ../../arch/x86/entry/syscalls/syscall_64.tbl
-- 
2.17.1

