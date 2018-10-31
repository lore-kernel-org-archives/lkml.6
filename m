Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81030C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400112080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 400112080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeKAHDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:03:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKAHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:03:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM3g3I2558810
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:03:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM3gtG2558807;
        Wed, 31 Oct 2018 15:03:42 -0700
Date:   Wed, 31 Oct 2018 15:03:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ehvf77vi1si9409r7p4wx788@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, dsahern@gmail.com, davem@davemloft.net,
        wangnan0@huawei.com, adrian.hunter@intel.com, kan.liang@intel.com,
        acme@redhat.com, jolsa@kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          kan.liang@intel.com, adrian.hunter@intel.com,
          wangnan0@huawei.com, davem@davemloft.net, dsahern@gmail.com,
          namhyung@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de
In-Reply-To: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
References: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Do not use overwrite mode by default
Git-Commit-ID: 218d61110f69632974034b6e27686ce482a1c455
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

Commit-ID:  218d61110f69632974034b6e27686ce482a1c455
Gitweb:     https://git.kernel.org/tip/218d61110f69632974034b6e27686ce482a1c455
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 29 Oct 2018 09:47:00 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:31 -0300

perf top: Do not use overwrite mode by default

Enabling --overwrite mode allows us to to use just the most recent
records, which helps in high core count machines such as Knights
Landing/Mill, but right now is being disabled by default as the pausing
used in this technique is leading to loss of metadata events such as
PERF_RECORD_MMAP which makes 'perf top' unable to resolve samples,
leading to lots of unknown samples appearing on the UI.

Enabling this may be useful if you are in such machines and profiling a
workload that doesn't creates short lived threads and/or doesn't uses
many executable mmap operations.

Work is being planed to solve this situation, till then, this will
remain disabled by default.

Reported-by: David Miller <davem@davemloft.net>
Acked-by: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/r/4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: https://lkml.kernel.org/n/tip-ehvf77vi1si9409r7p4wx788@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 11 ++++++++---
 tools/perf/builtin-top.c              | 11 +++++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index d4be6061fe1c..808b664343c9 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -243,9 +243,14 @@ Default is to monitor all CPUS.
 	Enable hierarchy output.
 
 --overwrite::
-	This is the default, but for investigating problems with it or any other strange
-	behaviour like lots of unknown samples, we may want to disable this mode by using
-	--no-overwrite.
+	Enable this to use just the most recent records, which helps in high core count
+	machines such as Knights Landing/Mill, but right now is disabled by default as
+	the pausing used in this technique is leading to loss of metadata events such
+	as PERF_RECORD_MMAP which makes 'perf top' unable to resolve samples, leading
+	to lots of unknown samples appearing on the UI. Enable this if you are in such
+	machines and profiling a workload that doesn't creates short lived threads and/or
+	doesn't uses many executable mmap operations. Work is being planed to solve
+	this situation, till then, this will remain disabled by default.
 
 --force::
 	Don't do ownership validation.
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 214fad747b04..8e29e0cc8626 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1257,7 +1257,14 @@ int cmd_top(int argc, const char **argv)
 				.uses_mmap   = true,
 			},
 			.proc_map_timeout    = 500,
-			.overwrite	= 1,
+			/*
+			 * FIXME: This will lose PERF_RECORD_MMAP and other metadata
+			 * when we pause, fix that and reenable. Probably using a
+			 * separate evlist with a dummy event, i.e. a non-overwrite
+			 * ring buffer just for metadata events, while PERF_RECORD_SAMPLE
+			 * stays in overwrite mode. -acme
+			 * */
+			.overwrite	= 0,
 		},
 		.max_stack	     = sysctl__max_stack(),
 		.annotation_opts     = annotation__default_options,
@@ -1373,7 +1380,7 @@ int cmd_top(int argc, const char **argv)
 	OPT_BOOLEAN(0, "hierarchy", &symbol_conf.report_hierarchy,
 		    "Show entries in a hierarchy"),
 	OPT_BOOLEAN(0, "overwrite", &top.record_opts.overwrite,
-		    "Use a backward ring buffer, default: yes"),
+		    "Use a backward ring buffer, default: no"),
 	OPT_BOOLEAN(0, "force", &symbol_conf.force, "don't complain, do it"),
 	OPT_UINTEGER(0, "num-thread-synthesize", &top.nr_threads_synthesize,
 			"number of thread to run event synthesize"),
