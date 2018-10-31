Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB97C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128EF20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNMjhIPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128EF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbeKABpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeKABpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:20 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0EF82081B;
        Wed, 31 Oct 2018 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004392;
        bh=QR/mk3a7bjxn6ckj/I9oSCOGXlVmT9ASs2D43tm52F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FNMjhIPjXry20WS0jGw4YOVAbMpsJbQ4ZNfCFxusebmYKx78DU2EgzcgFhSWrO2lF
         pcpwJ+E9IPTu1ElwdtcTxuk1jxdJT4LvXFoZvFJeXi5RsFH6hSftRmFs+Bhd+ZCt4S
         CT8CQ4lm5QRgj7WZ01hJVOipX1AxbF/Rhp+AnIa4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 20/28] perf trace beauty: Use the mmap flags table generated from headers
Date:   Wed, 31 Oct 2018 13:45:00 -0300
Message-Id: <20181031164508.4784-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Instead of requiring us to go on and edit sources to add new flag.

  # perf trace -e *mmap sleep 0.1
     0.025 ( 0.005 ms): sleep/29876 mmap(len: 163746, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa68ad1000
     0.059 ( 0.004 ms): sleep/29876 mmap(len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS) = 0x7faa68acf000
     0.069 ( 0.006 ms): sleep/29876 mmap(len: 3889792, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3) = 0x7faa6851f000
     0.086 ( 0.009 ms): sleep/29876 mmap(addr: 0x7faa688cb000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 1753088) = 0x7faa688cb000
     0.101 ( 0.005 ms): sleep/29876 mmap(addr: 0x7faa688d1000, len: 14976, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS) = 0x7faa688d1000
     0.348 ( 0.005 ms): sleep/29876 mmap(len: 111950656, prot: READ, flags: PRIVATE, fd: 3) = 0x7faa61a5b000
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ggmoy6vxoygh5yim890ht0kf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 48 ++++++++++--------------------------------
 1 file changed, 11 insertions(+), 37 deletions(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 0605593552c6..c534bd96ef5c 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: LGPL-2.1
 #include <uapi/linux/mman.h>
+#include <linux/log2.h>
 
 static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 					       struct syscall_arg *arg)
@@ -30,50 +31,23 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 
 #define SCA_MMAP_PROT syscall_arg__scnprintf_mmap_prot
 
+static size_t mmap__scnprintf_flags(unsigned long flags, char *bf, size_t size)
+{
+#include "trace/beauty/generated/mmap_flags_array.c"
+       static DEFINE_STRARRAY(mmap_flags);
+
+       return strarray__scnprintf_flags(&strarray__mmap_flags, bf, size, flags);
+}
+
 static size_t syscall_arg__scnprintf_mmap_flags(char *bf, size_t size,
 						struct syscall_arg *arg)
 {
-	int printed = 0, flags = arg->val;
+	unsigned long flags = arg->val;
 
 	if (flags & MAP_ANONYMOUS)
 		arg->mask |= (1 << 4) | (1 << 5); /* Mask 4th ('fd') and 5th ('offset') args, ignored */
 
-#define	P_MMAP_FLAG(n) \
-	if (flags & MAP_##n) { \
-		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
-		flags &= ~MAP_##n; \
-	}
-
-	P_MMAP_FLAG(SHARED);
-	P_MMAP_FLAG(PRIVATE);
-#ifdef MAP_32BIT
-	P_MMAP_FLAG(32BIT);
-#endif
-	P_MMAP_FLAG(ANONYMOUS);
-	P_MMAP_FLAG(DENYWRITE);
-	P_MMAP_FLAG(EXECUTABLE);
-	P_MMAP_FLAG(FILE);
-	P_MMAP_FLAG(FIXED);
-#ifdef MAP_FIXED_NOREPLACE
-	P_MMAP_FLAG(FIXED_NOREPLACE);
-#endif
-	P_MMAP_FLAG(GROWSDOWN);
-	P_MMAP_FLAG(HUGETLB);
-	P_MMAP_FLAG(LOCKED);
-	P_MMAP_FLAG(NONBLOCK);
-	P_MMAP_FLAG(NORESERVE);
-	P_MMAP_FLAG(POPULATE);
-	P_MMAP_FLAG(STACK);
-	P_MMAP_FLAG(UNINITIALIZED);
-#ifdef MAP_SYNC
-	P_MMAP_FLAG(SYNC);
-#endif
-#undef P_MMAP_FLAG
-
-	if (flags)
-		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
-
-	return printed;
+	return mmap__scnprintf_flags(flags, bf, size);
 }
 
 #define SCA_MMAP_FLAGS syscall_arg__scnprintf_mmap_flags
-- 
2.14.4

