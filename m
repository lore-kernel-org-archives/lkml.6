Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1461CECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D4207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="il9A2LDE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9D4207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJ0Dk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 23:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:33020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbeJ0Dk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 23:40:27 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 050C52064A;
        Fri, 26 Oct 2018 19:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540580535;
        bh=qETIq4NsNMWTM/trZ2h7aWKDKuy/ibQi5WHSnYatr0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=il9A2LDEuovntAe/YZ41j+1UEInbth049uUlFXYwBgC89pHbfzoO7Kg/tkiESIaD8
         hM8Wj1qe5HTqCdsWxWsKsoMhSAOsiBO+6/mc82qNA2F5D02jn+KhL42hutYmuf/+IS
         qNHqN/NDMHMiajMuTN8AarIG7PEUlq8qNxdTtggU=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9A4F0142C5F; Fri, 26 Oct 2018 16:02:11 -0300 (-03)
Date:   Fri, 26 Oct 2018 16:02:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Wang Nan <wangnan0@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: A concern about overflow ring buffer mode
Message-ID: <20181026190211.GF3353@kernel.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org>
 <20181026184255.GE3353@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026184255.GE3353@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, I'm adding the following to my tree to help in diagnosing problems
with this overwrite mode:


From 40feb09001c7cc2ba8aeaa0a8f03b6d28fa4ca95 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 26 Oct 2018 15:55:23 -0300
Subject: [PATCH 1/1] perf top: Allow disabling the overwrite mode

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

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Miller <davem@davemloft.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
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

