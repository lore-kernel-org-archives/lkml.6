Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388AC208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388AC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbeGaHl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 03:41:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbeGaHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 03:41:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6V63E662594610
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 30 Jul 2018 23:03:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6V63ELL2594607;
        Mon, 30 Jul 2018 23:03:14 -0700
Date:   Mon, 30 Jul 2018 23:03:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9r1pifftxvuxms8l7ir73p5l@git.kernel.org>
Cc:     tglx@linutronix.de, namhyung@kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, dsahern@gmail.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
          namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          dsahern@gmail.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix the build on the alpine:edge
 distro
Git-Commit-ID: 44fe619b1418ff4e9d2f9518a940fbe2fb686a08
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

Commit-ID:  44fe619b1418ff4e9d2f9518a940fbe2fb686a08
Gitweb:     https://git.kernel.org/tip/44fe619b1418ff4e9d2f9518a940fbe2fb686a08
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 30 Jul 2018 13:15:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 30 Jul 2018 13:15:03 -0300

perf tools: Fix the build on the alpine:edge distro

The UAPI file byteorder/little_endian.h uses the __always_inline define
without including the header where it is defined, linux/stddef.h, this
ends up working in all the other distros because that file gets included
seemingly by luck from one of the files included from little_endian.h.

But not on Alpine:edge, that fails for all files where perf_event.h is
included but linux/stddef.h isn't include before that.

Adding the missing linux/stddef.h file where it breaks on Alpine:edge to
fix that, in all other distros, that is just a very small header anyway.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9r1pifftxvuxms8l7ir73p5l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/util/pmu.c | 1 +
 tools/perf/arch/x86/util/tsc.c | 1 +
 tools/perf/perf.h              | 1 +
 tools/perf/util/header.h       | 1 +
 tools/perf/util/namespaces.h   | 1 +
 5 files changed, 5 insertions(+)

diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
index 63a74c32ddc5..e33ef5bc31c5 100644
--- a/tools/perf/arch/x86/util/pmu.c
+++ b/tools/perf/arch/x86/util/pmu.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <string.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../util/intel-pt.h"
diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index 06bae7023a51..950539f9a4f7 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -2,6 +2,7 @@
 #include <stdbool.h>
 #include <errno.h>
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 #include "../../perf.h"
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index a1a97956136f..d215714f48df 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -5,6 +5,7 @@
 #include <time.h>
 #include <stdbool.h>
 #include <linux/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 
 extern bool test_attr__enabled;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 90d4577a92dc..6d7fe44aadc0 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_HEADER_H
 #define __PERF_HEADER_H
 
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <sys/types.h>
 #include <stdbool.h>
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index 760558dcfd18..cae1a9a39722 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -10,6 +10,7 @@
 #define __PERF_NAMESPACES_H
 
 #include <sys/types.h>
+#include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include <linux/refcount.h>
 #include <linux/types.h>
