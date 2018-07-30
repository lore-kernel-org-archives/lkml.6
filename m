Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA85C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFE4208A2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 20:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYiPsH2O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DFE4208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbeG3W1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 18:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:43528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbeG3W1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 18:27:48 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB176208A3;
        Mon, 30 Jul 2018 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532983862;
        bh=PgYvRfDS2uaFo3XlCXLKG3nevcFUOOLX6AybE/g9C0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uYiPsH2Oqj6deJ8y85vpbtfLinlxUvQdP+5lK5FeMrA0Ev+/ML1xu4KoYcqR3fDOn
         ERXm8ICMi10gqhGko/JPGZ+cnaMgMUOHrNa8+WGLjwtjh8NOdA5gGkXm6Fwi6xlV6L
         ZIKWN7m+zkTq90wxbDIZQCbgzshvKOBjGYp/ibOg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 5/5] perf tools: Fix the build on the alpine:edge distro
Date:   Mon, 30 Jul 2018 17:50:31 -0300
Message-Id: <20180730205031.12853-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180730205031.12853-1-acme@kernel.org>
References: <20180730205031.12853-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

