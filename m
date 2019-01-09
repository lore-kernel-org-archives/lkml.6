Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19266C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEF620883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfAIJkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:40:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:25812 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfAIJkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:40:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 01:40:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,456,1539673200"; 
   d="scan'208";a="136660282"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2019 01:40:41 -0800
Received: from [10.125.252.236] (abudanko-mobl.ccr.corp.intel.com [10.125.252.236])
        by linux.intel.com (Postfix) with ESMTP id 6E1F7580490;
        Wed,  9 Jan 2019 01:40:38 -0800 (PST)
Subject: [PATCH v3 4/4] perf record: implement --affinity=node|cpu option
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8b8b2a81-ce18-8f33-780c-11ae1c937159@linux.intel.com>
Date:   Wed, 9 Jan 2019 12:40:37 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <b31ddfd5-a017-d8da-14eb-d1b48bfc255b@linux.intel.com>
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
changes in v3:
- adjusted indentation at record__parse_affinity()
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

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
index 553c2fabf3c1..94a966ba9a6f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1659,6 +1659,23 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	return -1;
 }
 
+static int record__parse_affinity(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset)
+		return 0;
+
+	if (str) {
+		if (!strcasecmp(str, "node"))
+			opts->affinity = PERF_AFFINITY_NODE;
+		else if (!strcasecmp(str, "cpu"))
+			opts->affinity = PERF_AFFINITY_CPU;
+	}
+
+	return 0;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -1966,6 +1983,9 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
+		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
+		     record__parse_affinity),
 	OPT_END()
 };
