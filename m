Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18614C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCEFA20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 07:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEFA20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbeLLHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:44:47 -0500
Received: from mga12.intel.com ([192.55.52.136]:41937 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbeLLHor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 02:44:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 23:44:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117927942"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Dec 2018 23:44:46 -0800
Received: from [10.125.251.226] (abudanko-mobl.ccr.corp.intel.com [10.125.251.226])
        by linux.intel.com (Postfix) with ESMTP id 21EF65803DC;
        Tue, 11 Dec 2018 23:44:43 -0800 (PST)
Subject: [PATCH v1 3/3] perf record: implement --affinity=node|cpu option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c7372f82-314c-29fd-d8c8-c6892f1df3ed@linux.intel.com>
Date:   Wed, 12 Dec 2018 10:44:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <42c2dcb4-7e6f-fcdb-7c87-e55ccb9884b0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Implement --affinity=node|cpu option for the record mode defaulting
to system affinity mask bouncing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index d232b13ea713..efb839784f32 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -440,6 +440,11 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
 Asynchronous mode is supported only when linking Perf tool with libc library
 providing implementation for Posix AIO API.
 
+--affinity=mode::
+Set affinity mask of trace reading thread according to the policy defined by 'mode' value:
+  node - thread affinity mask is set to NUMA node cpu mask of the processed mmap buffer
+  cpu  - thread affinity mask is set to cpu of the processed mmap buffer
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1a1438c73f96..3b4b47055aa1 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1649,6 +1649,21 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	ui__warning("unknown clockid %s, check man page\n", ostr);
 	return -1;
 }
+static int record__parse_affinity(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (!unset) {
+		if (str) {
+			if (!strcasecmp(str, "node"))
+				opts->affinity = PERF_AFFINITY_NODE;
+			else if (!strcasecmp(str, "cpu"))
+				opts->affinity = PERF_AFFINITY_CPU;
+		}
+	}
+
+	return 0;
+}
 
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
@@ -1957,6 +1972,9 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
+		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
+		     record__parse_affinity),
 	OPT_END()
 };
