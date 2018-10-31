Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5896DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22DB92081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yUdyqMRV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DB92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbeKABor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbeKABoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:44:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9E62082E;
        Wed, 31 Oct 2018 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004358;
        bh=+3JUxhVKdTpjUtA8dfWW/YCyhGoqX7gu9bW44hP9f3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yUdyqMRVFcPrwBcK3HShE16L1FbNlLhs+Zyh9sMav44YVr6bSZKS1g9e22qys0OWJ
         Uj5MxiG9QHNlKSrVNToIKKaspuldMkEflwI7BE/YalUCekBvEfYx7yV2zWn5uTaRB3
         fGRNLicHrVmWkKZMI+SF7dtye9Ej+L7WKeHl4m6M=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/28] perf top: Allow disabling the overwrite mode
Date:   Wed, 31 Oct 2018 13:44:50 -0300
Message-Id: <20181031164508.4784-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In ebebbf082357 ("perf top: Switch default mode to overwrite mode") we
forgot to leave a way to disable that new default, add a --overwrite
option that can be disabled using --no-overwrite, since the code already
in such a way that we can readily disable this mode.

This is useful when investigating bugs with this mode like the recent
report from David Miller where lots of unknown symbols appear due to
disabling the events while processing them which disables all record
types, not just PERF_RECORD_SAMPLE, which makes it impossible to resolve
maps when we lose PERF_RECORD_MMAP records.

This can be easily seen while building a kernel, when there are lots of
short lived processes.

Reported-by: David Miller <davem@davemloft.net>
Acked-by: Kan Liang <kan.liang@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: https://lkml.kernel.org/n/tip-oqgsz2bq4kgrnnajrafcdhie@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 5 +++++
 tools/perf/builtin-top.c              | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 114fda12aa49..d4be6061fe1c 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -242,6 +242,11 @@ Default is to monitor all CPUS.
 --hierarchy::
 	Enable hierarchy output.
 
+--overwrite::
+	This is the default, but for investigating problems with it or any other strange
+	behaviour like lots of unknown samples, we may want to disable this mode by using
+	--no-overwrite.
+
 --force::
 	Don't do ownership validation.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d8751e749..214fad747b04 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1372,6 +1372,8 @@ int cmd_top(int argc, const char **argv)
 		    "Show raw trace event output (do not use print fmt or plugins)"),
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
+	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
+		    "Use a backward ring buffer, default: yes"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
-- 
2.14.4

