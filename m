Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400BC282DB
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A6920823
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 15:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549207840;
	bh=RUB84vuwA38Jb+bV2M4WSh69A1Xz+23scq/6JjbDM0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OCoZmW6JmXl3z7L8e7vL4s6gq/f8fObfxks+ly2t7Z31C2OFF8lADxGJHTER2iGjq
	 b0uSKvCzF59IZf1SdLHhxvTW3oPMK1DbaQ9atLGFg+Y9Eck63vMvQxkot0rtTRkyC5
	 MjLClfFnYfjtgcnwWeXPkXFxIfSQG8g72b7wz0KM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbfBCPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 10:30:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbfBCPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 10:30:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D700680F6B;
        Sun,  3 Feb 2019 15:30:34 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-46.brq.redhat.com [10.40.204.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBB3E5C238;
        Sun,  3 Feb 2019 15:30:31 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 04/14] perf data: Add global path holder
Date:   Sun,  3 Feb 2019 16:30:08 +0100
Message-Id: <20190203153018.9650-5-jolsa@kernel.org>
In-Reply-To: <20190203153018.9650-1-jolsa@kernel.org>
References: <20190203153018.9650-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Sun, 03 Feb 2019 15:30:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding path to the struct perf_data. It will keep the
configured path for the data (const char*). The path
is struct perf_data_file is now dynamically allocated
(duped) from it.

This scheme is useful/used in following patches where
struct perf_data::path holds the directory path.

Link: http://lkml.kernel.org/n/tip-ww4tdzfaub4vlv9xxkxvwx9q@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-annotate.c      |  4 +--
 tools/perf/builtin-buildid-cache.c |  4 +--
 tools/perf/builtin-buildid-list.c  |  8 +++---
 tools/perf/builtin-c2c.c           |  4 +--
 tools/perf/builtin-diff.c          | 12 ++++-----
 tools/perf/builtin-evlist.c        |  4 +--
 tools/perf/builtin-inject.c        | 10 +++-----
 tools/perf/builtin-kmem.c          |  2 +-
 tools/perf/builtin-kvm.c           |  8 +++---
 tools/perf/builtin-lock.c          |  8 +++---
 tools/perf/builtin-mem.c           |  8 +++---
 tools/perf/builtin-record.c        |  6 ++---
 tools/perf/builtin-report.c        |  6 ++---
 tools/perf/builtin-sched.c         | 16 +++++-------
 tools/perf/builtin-script.c        | 12 ++++-----
 tools/perf/builtin-stat.c          |  6 ++---
 tools/perf/builtin-timechart.c     |  8 +++---
 tools/perf/builtin-trace.c         |  8 +++---
 tools/perf/util/data-convert-bt.c  |  2 +-
 tools/perf/util/data.c             | 39 +++++++++++++++++++++---------
 tools/perf/util/data.h             |  3 ++-
 21 files changed, 86 insertions(+), 92 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 7f3c3fea67b4..67f9d9ffacfb 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -441,7 +441,7 @@ static int __cmd_annotate(struct perf_annotate *ann)
 	}
 
 	if (total_nr_samples == 0) {
-		ui__error("The %s file has no samples!\n", session->data->file.path);
+		ui__error("The %s data has no samples!\n", session->data->path);
 		goto out;
 	}
 
@@ -578,7 +578,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (quiet)
 		perf_quiet_option();
 
-	data.file.path = input_name;
+	data.path = input_name;
 
 	annotate.session = perf_session__new(&data, false, &annotate.tool);
 	if (annotate.session == NULL)
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 115110a4796a..10457b10e568 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -416,8 +416,8 @@ int cmd_buildid_cache(int argc, const char **argv)
 		nsi = nsinfo__new(ns_id);
 
 	if (missing_filename) {
-		data.file.path = missing_filename;
-		data.force     = force;
+		data.path  = missing_filename;
+		data.force = force;
 
 		session = perf_session__new(&data, false, NULL);
 		if (session == NULL)
diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index 78abbe8d9d5f..f403e19488b5 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -52,11 +52,9 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = force,
 	};
 
 	symbol__elf_init();
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b2bf117881f1..cc13b87584b8 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2750,8 +2750,8 @@ static int perf_c2c__report(int argc, const char **argv)
 	if (!input_name || !strlen(input_name))
 		input_name = "perf.data";
 
-	data.file.path = input_name;
-	data.force     = symbol_conf.force;
+	data.path  = input_name;
+	data.force = symbol_conf.force;
 
 	err = setup_display(display);
 	if (err)
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 751e1971456b..58fe0e88215c 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -708,7 +708,7 @@ static void data__fprintf(void)
 
 	data__for_each_file(i, d)
 		fprintf(stdout, "#  [%d] %s %s\n",
-			d->idx, d->data.file.path,
+			d->idx, d->data.path,
 			!d->idx ? "(Baseline)" : "");
 
 	fprintf(stdout, "#\n");
@@ -779,14 +779,14 @@ static int __cmd_diff(void)
 	data__for_each_file(i, d) {
 		d->session = perf_session__new(&d->data, false, &tool);
 		if (!d->session) {
-			pr_err("Failed to open %s\n", d->data.file.path);
+			pr_err("Failed to open %s\n", d->data.path);
 			ret = -1;
 			goto out_delete;
 		}
 
 		ret = perf_session__process_events(d->session);
 		if (ret) {
-			pr_err("Failed to process %s\n", d->data.file.path);
+			pr_err("Failed to process %s\n", d->data.path);
 			goto out_delete;
 		}
 
@@ -1289,9 +1289,9 @@ static int data_init(int argc, const char **argv)
 	data__for_each_file(i, d) {
 		struct perf_data *data = &d->data;
 
-		data->file.path = use_default ? defaults[i] : argv[i];
-		data->mode      = PERF_DATA_MODE_READ,
-		data->force     = force,
+		data->path  = use_default ? defaults[i] : argv[i];
+		data->mode  = PERF_DATA_MODE_READ,
+		data->force = force,
 
 		d->idx  = i;
 	}
diff --git a/tools/perf/builtin-evlist.c b/tools/perf/builtin-evlist.c
index e06e822ce634..6e4f63b0da4a 100644
--- a/tools/perf/builtin-evlist.c
+++ b/tools/perf/builtin-evlist.c
@@ -23,9 +23,7 @@ static int __cmd_evlist(const char *file_name, struct perf_attr_details *details
 	struct perf_session *session;
 	struct perf_evsel *pos;
 	struct perf_data data = {
-		.file      = {
-			.path = file_name,
-		},
+		.path      = file_name,
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = details->force,
 	};
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 9bb1f35d5cb7..24086b7f1b14 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -770,10 +770,8 @@ int cmd_inject(int argc, const char **argv)
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
 		.output = {
-			.file      = {
-				.path = "-",
-			},
-			.mode      = PERF_DATA_MODE_WRITE,
+			.path = "-",
+			.mode = PERF_DATA_MODE_WRITE,
 		},
 	};
 	struct perf_data data = {
@@ -786,7 +784,7 @@ int cmd_inject(int argc, const char **argv)
 			    "Inject build-ids into the output stream"),
 		OPT_STRING('i', "input", &inject.input_name, "file",
 			   "input file name"),
-		OPT_STRING('o', "output", &inject.output.file.path, "file",
+		OPT_STRING('o', "output", &inject.output.path, "file",
 			   "output file name"),
 		OPT_BOOLEAN('s', "sched-stat", &inject.sched_stat,
 			    "Merge sched-stat and sched-switch for getting events "
@@ -834,7 +832,7 @@ int cmd_inject(int argc, const char **argv)
 
 	inject.tool.ordered_events = inject.sched_stat;
 
-	data.file.path = inject.input_name;
+	data.path = inject.input_name;
 	inject.session = perf_session__new(&data, true, &inject.tool);
 	if (inject.session == NULL)
 		return -1;
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index b80ec0883537..fa520f4b8095 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1949,7 +1949,7 @@ int cmd_kmem(int argc, const char **argv)
 		return __cmd_record(argc, argv);
 	}
 
-	data.file.path = input_name;
+	data.path = input_name;
 
 	kmem_session = session = perf_session__new(&data, false, &perf_kmem);
 	if (session == NULL)
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 3d4cbc4e87c7..dbb6f737a3e2 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1080,11 +1080,9 @@ static int read_events(struct perf_kvm_stat *kvm)
 		.ordered_events		= true,
 	};
 	struct perf_data file = {
-		.file      = {
-			.path = kvm->file_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = kvm->force,
+		.path  = kvm->file_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = kvm->force,
 	};
 
 	kvm->tool = eops;
diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 6e0189df2b3b..b9810a8d350a 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -866,11 +866,9 @@ static int __cmd_report(bool display_info)
 		.ordered_events	 = true,
 	};
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = force,
 	};
 
 	session = perf_session__new(&data, false, &eops);
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index ba7e8d87dec3..f45c8b502f63 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -239,11 +239,9 @@ static int process_sample_event(struct perf_tool *tool,
 static int report_raw_events(struct perf_mem *mem)
 {
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = mem->force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = mem->force,
 	};
 	int ret;
 	struct perf_session *session = perf_session__new(&data, false,
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 1ed48b488b50..fa21efb8bc74 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -917,7 +917,7 @@ record__switch_output(struct record *rec, bool at_exit)
 
 	if (!quiet)
 		fprintf(stderr, "[ perf record: Dump %s.%s ]\n",
-			data->file.path, timestamp);
+			data->path, timestamp);
 
 	/* Output tracking events */
 	if (!at_exit) {
@@ -1460,7 +1460,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 		fprintf(stderr,	"[ perf record: Captured and wrote %.3f MB %s%s%s ]\n",
 			perf_data__size(data) / 1024.0 / 1024.0,
-			data->file.path, postfix, samples);
+			data->path, postfix, samples);
 	}
 
 out_delete_session:
@@ -1846,7 +1846,7 @@ static struct option __record_options[] = {
 	OPT_STRING('C', "cpu", &record.opts.target.cpu_list, "cpu",
 		    "list of cpus to monitor"),
 	OPT_U64('c', "count", &record.opts.user_interval, "event period to sample"),
-	OPT_STRING('o', "output", &record.data.file.path, "file",
+	OPT_STRING('o', "output", &record.data.path, "file",
 		    "output file name"),
 	OPT_BOOLEAN_SET('i', "no-inherit", &record.opts.no_inherit,
 			&record.opts.no_inherit_set,
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index a007ea9a3874..15a0de2fe31b 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -882,7 +882,7 @@ static int __cmd_report(struct report *rep)
 		rep->nr_entries += evsel__hists(pos)->nr_entries;
 
 	if (rep->nr_entries == 0) {
-		ui__error("The %s file has no samples!\n", data->file.path);
+		ui__error("The %s data has no samples!\n", data->path);
 		return 0;
 	}
 
@@ -1190,8 +1190,8 @@ int cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
-	data.file.path = input_name;
-	data.force     = symbol_conf.force;
+	data.path  = input_name;
+	data.force = symbol_conf.force;
 
 repeat:
 	session = perf_session__new(&data, false, &report.tool);
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 640558e9352e..275f2d92a7bf 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1785,11 +1785,9 @@ static int perf_sched__read_events(struct perf_sched *sched)
 	};
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = sched->force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = sched->force,
 	};
 	int rc = -1;
 
@@ -2958,11 +2956,9 @@ static int perf_sched__timehist(struct perf_sched *sched)
 		{ "sched:sched_migrate_task", timehist_migrate_task_event, },
 	};
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = sched->force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = sched->force,
 	};
 
 	struct perf_session *session;
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8d5fe092525c..9101c8812262 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2943,10 +2943,8 @@ int find_scripts(char **scripts_array, char **scripts_path_array)
 	DIR *scripts_dir, *lang_dir;
 	struct perf_session *session;
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
+		.path = input_name,
+		.mode = PERF_DATA_MODE_READ,
 	};
 	char *temp;
 	int i = 0;
@@ -3419,8 +3417,8 @@ int cmd_script(int argc, const char **argv)
 	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	data.file.path = input_name;
-	data.force     = symbol_conf.force;
+	data.path  = input_name;
+	data.force = symbol_conf.force;
 
 	if (argc > 1 && !strncmp(argv[0], "rec", strlen("rec"))) {
 		rec_script_path = get_script_path(argv[1], RECORD_SUFFIX);
@@ -3646,7 +3644,7 @@ int cmd_script(int argc, const char **argv)
 			goto out_delete;
 		}
 
-		input = open(data.file.path, O_RDONLY);	/* input_name */
+		input = open(data.path, O_RDONLY);	/* input_name */
 		if (input < 0) {
 			err = -errno;
 			perror("failed to open file");
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index bb24f9c17f9a..7b8f09b0b8bf 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1322,7 +1322,7 @@ static int __cmd_record(int argc, const char **argv)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (output_name)
-		data->file.path = output_name;
+		data->path = output_name;
 
 	if (stat_config.run_count != 1 || forever) {
 		pr_err("Cannot use -r option with perf stat record.\n");
@@ -1523,8 +1523,8 @@ static int __cmd_report(int argc, const char **argv)
 			input_name = "perf.data";
 	}
 
-	perf_stat.data.file.path = input_name;
-	perf_stat.data.mode      = PERF_DATA_MODE_READ;
+	perf_stat.data.path = input_name;
+	perf_stat.data.mode = PERF_DATA_MODE_READ;
 
 	session = perf_session__new(&perf_stat.data, false, &perf_stat.tool);
 	if (session == NULL)
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 775b99833e51..9b98687a27b9 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1602,11 +1602,9 @@ static int __cmd_timechart(struct timechart *tchart, const char *output_name)
 		{ "syscalls:sys_exit_select",		process_exit_poll },
 	};
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = tchart->force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = tchart->force,
 	};
 
 	struct perf_session *session = perf_session__new(&data, false,
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 81a44954d435..cd82142ccdd2 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3132,11 +3132,9 @@ static int trace__replay(struct trace *trace)
 		{ "probe:vfs_getname",	     trace__vfs_getname, },
 	};
 	struct perf_data data = {
-		.file      = {
-			.path = input_name,
-		},
-		.mode      = PERF_DATA_MODE_READ,
-		.force     = trace->force,
+		.path  = input_name,
+		.mode  = PERF_DATA_MODE_READ,
+		.force = trace->force,
 	};
 	struct perf_session *session;
 	struct perf_evsel *evsel;
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 2a36fab76994..ea742a254aa5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1650,7 +1650,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 
 	fprintf(stderr,
 		"[ perf data convert: Converted '%s' into CTF data '%s' ]\n",
-		data.file.path, path);
+		data.path, path);
 
 	fprintf(stderr,
 		"[ perf data convert: Converted and wrote %.3f MB (%" PRIu64 " samples",
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 09eceda17fc2..e16d06ed1100 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -19,11 +19,11 @@ static bool check_pipe(struct perf_data *data)
 	int fd = perf_data__is_read(data) ?
 		 STDIN_FILENO : STDOUT_FILENO;
 
-	if (!data->file.path) {
+	if (!data->path) {
 		if (!fstat(fd, &st) && S_ISFIFO(st.st_mode))
 			is_pipe = true;
 	} else {
-		if (!strcmp(data->file.path, "-"))
+		if (!strcmp(data->path, "-"))
 			is_pipe = true;
 	}
 
@@ -37,13 +37,13 @@ static int check_backup(struct perf_data *data)
 {
 	struct stat st;
 
-	if (!stat(data->file.path, &st) && st.st_size) {
+	if (!stat(data->path, &st) && st.st_size) {
 		/* TODO check errors properly */
 		char oldname[PATH_MAX];
 		snprintf(oldname, sizeof(oldname), "%s.old",
-			 data->file.path);
+			 data->path);
 		unlink(oldname);
-		rename(data->file.path, oldname);
+		rename(data->path, oldname);
 	}
 
 	return 0;
@@ -115,8 +115,22 @@ static int open_file(struct perf_data *data)
 	fd = perf_data__is_read(data) ?
 	     open_file_read(data) : open_file_write(data);
 
+	if (fd < 0) {
+		free(data->file.path);
+		return -1;
+	}
+
 	data->file.fd = fd;
-	return fd < 0 ? -1 : 0;
+	return 0;
+}
+
+static int open_file_dup(struct perf_data *data)
+{
+	data->file.path = strdup(data->path);
+	if (!data->file.path)
+		return -ENOMEM;
+
+	return open_file(data);
 }
 
 int perf_data__open(struct perf_data *data)
@@ -124,14 +138,15 @@ int perf_data__open(struct perf_data *data)
 	if (check_pipe(data))
 		return 0;
 
-	if (!data->file.path)
-		data->file.path = "perf.data";
+	if (!data->path)
+		data->path = "perf.data";
 
-	return open_file(data);
+	return open_file_dup(data);
 }
 
 void perf_data__close(struct perf_data *data)
 {
+	free(data->file.path);
 	close(data->file.fd);
 }
 
@@ -159,15 +174,15 @@ int perf_data__switch(struct perf_data *data,
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-	if (asprintf(&new_filepath, "%s.%s", data->file.path, postfix) < 0)
+	if (asprintf(&new_filepath, "%s.%s", data->path, postfix) < 0)
 		return -ENOMEM;
 
 	/*
 	 * Only fire a warning, don't return error, continue fill
 	 * original file.
 	 */
-	if (rename(data->file.path, new_filepath))
-		pr_warning("Failed to rename %s to %s\n", data->file.path, new_filepath);
+	if (rename(data->path, new_filepath))
+		pr_warning("Failed to rename %s to %s\n", data->path, new_filepath);
 
 	if (!at_exit) {
 		close(data->file.fd);
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 85f9c0dbf982..2bce28117ccf 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -10,12 +10,13 @@ enum perf_data_mode {
 };
 
 struct perf_data_file {
-	const char	*path;
+	char		*path;
 	int		 fd;
 	unsigned long	 size;
 };
 
 struct perf_data {
+	const char		*path;
 	struct perf_data_file	 file;
 	bool			 is_pipe;
 	bool			 force;
-- 
2.17.2

