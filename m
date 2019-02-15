Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993CA222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191560;
	bh=dnLhiaghF/aczYCeFXdQbZikx6k9yrexCKYJzFFJXfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PSCBvmcMwZCBypg3cl9pWgn5/xStSntXkSZdmidqNZusyfc22SvFBhji1Sc7MwRLB
	 6/gBEIjttpgbmPJz7oQvVhuDbzfv1x7BvRrK1uQI2xpCtAWDvKdawlEpIVNqrfHRO0
	 PW2H82AKEqpe9VNTJS2/0CwzkJJ2jG7/NW7D+dqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbfBOAp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:43924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730220AbfBOAp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:45:56 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74139222A1;
        Fri, 15 Feb 2019 00:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191554;
        bh=dnLhiaghF/aczYCeFXdQbZikx6k9yrexCKYJzFFJXfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5vDPEp5CLCnNvZ/Ldf8sN/j/OJWyzaNw0FjIeRIWzYewde3OSR4PQyuykNEO1Xrd
         M0RapXeXJ41PedEiARdrzNzH/HZSnWfg6DK3EFK/i+v/AR97tUUU1uev+ksMJG3e6E
         ZoY8mt5eQGhcx1lSOxjZeab4rLKFUpOo2HDQL4qI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 01/43] perf record: Implement --affinity=node|cpu option
Date:   Thu, 14 Feb 2019 21:44:57 -0300
Message-Id: <20190215004539.23571-2-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

Implement --affinity=node|cpu option for the record mode defaulting
to system affinity mask bouncing.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/083f5422-ece9-10dd-8305-bf59c860f10f@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  5 +++++
 tools/perf/builtin-record.c              | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 02b4aa2621e7..8f0c2be34848 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -454,6 +454,11 @@ Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default:
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
index 3fdfbaebd95e..6c3719ac901d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1656,6 +1656,21 @@ static int parse_clockid(const struct option *opt, const char *str, int unset)
 	return -1;
 }
 
+static int record__parse_affinity(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset || !str)
+		return 0;
+
+	if (!strcasecmp(str, "node"))
+		opts->affinity = PERF_AFFINITY_NODE;
+	else if (!strcasecmp(str, "cpu"))
+		opts->affinity = PERF_AFFINITY_CPU;
+
+	return 0;
+}
+
 static int record__parse_mmap_pages(const struct option *opt,
 				    const char *str,
 				    int unset __maybe_unused)
@@ -1964,6 +1979,9 @@ static struct option __record_options[] = {
 		     &nr_cblocks_default, "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
+	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
+		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
+		     record__parse_affinity),
 	OPT_END()
 };
 
-- 
2.19.1

