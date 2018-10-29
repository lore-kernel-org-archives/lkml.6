Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9622C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950E02084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHnE5+ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950E02084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJ2VwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:52:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbeJ2VwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:52:09 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B8802082D;
        Mon, 29 Oct 2018 13:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540818214;
        bh=rWkvN35ArfA/P0K4whT8szAcNK249q70oOANmzkVvYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MHnE5+riKEa76nR0hJUXUNCYsPvfS7LEKmCI8eL4MxMiYYPii7k4lbWTwNKSmXCJd
         zLvePCTVMMlUVBc3/N8dX1vyvsBgslHs5e9qCIquS+/1CPJxuOZ574C4adzGrlsWOo
         8PsLbQNHgkVh0HF4sOo9C21FPRknnlnFTQUc4bGE=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 3EA6F142C5F; Mon, 29 Oct 2018 10:03:31 -0300 (-03)
Date:   Mon, 29 Oct 2018 10:03:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
Message-ID: <20181029130331.GC21857@kernel.org>
References: <20181026.104513.2239058788450235574.davem@davemloft.net>
 <20181026183805.GD3353@kernel.org>
 <20181026184255.GE3353@kernel.org>
 <20181026190211.GF3353@kernel.org>
 <3b81c999-9039-94e9-7a74-cdbd48fca08b@linux.intel.com>
 <20181026191231.GG3353@kernel.org>
 <65cbd052-15d9-f3fb-4a8f-781c3ce7a297@linux.intel.com>
 <20181026192424.GH3353@kernel.org>
 <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 26, 2018 at 04:11:51PM -0400, Liang, Kan escreveu:
> On 10/26/2018 3:24 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 26, 2018 at 03:16:29PM -0400, Liang, Kan escreveu:
> > > On 10/26/2018 3:12 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 26, 2018 at 03:07:40PM -0400, Liang, Kan escreveu:
> > > > > On 10/26/2018 3:02 PM, Arnaldo Carvalho de Melo wrote:
> > > > I checked and both have the same result. But I still think there is
> > > > value in having the shorter form, ok?

> > > Sure.

> > Ok.

> > I think that we should default back to --no-overwrite till we get this
> > sorted out, as the effect is easily noticeable, as David reported and I
> > reproduced, when doing kernel builds.
 
> It is mainly for performance reason to switch to overwrite mode. The impact
> was very small when I did my test. But now the effect is easily noticeable
> in other tests. Yes, I agree. We may change it back to non-overwrite mode
> until the issue is addressed.

So, I have these two patches in my perf/core branch, with Fixes tags
that will make them get to the stable kernels, ok?


From f54ef0e7342efb77205b2faaacbcb81cdd31f064 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 26 Oct 2018 15:55:23 -0300
Subject: [PATCH 1/2] perf top: Allow disabling the overwrite mode

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

From 5af190cac4ec10c53f1a934e7bbd30da7e616b22 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Mon, 29 Oct 2018 09:47:00 -0300
Subject: [PATCH 2/2] perf top: Do not use overwrite mode by default

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
Link: https://lkml.kernel.org/n/tip-f19zd2uyfimkeon4vt6kzucq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-top.txt | 11 ++++++++---
 tools/perf/builtin-top.c              |  9 ++++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

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
index 214fad747b04..0891656da6ef 100644
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
-- 
2.14.4

