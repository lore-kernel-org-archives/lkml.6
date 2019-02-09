Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FACC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D444821A4C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZDHZCL5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfBIBRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:17:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37170 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbfBIBRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:17:15 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x191AI70018801
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:17:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jegVyObA6tLFbHCCP8Nkf4ZVix5zo7fJqTjdfbo0CGU=;
 b=ZDHZCL5FTgZxT2f6HZVYGm0XIjnZxkIW/stp5+e/2/ZnbDUOp7cWQIHUjTfT0Cdwc0J5
 +mXTzBF71Vhu2QJBXZsQ7vmc88lguA+zaEN+B4rGrfz3yqTLDdzVr6Zi2hptbKg2Sp0r
 PoiEgHwx2EJfejbo5GNFtKwXF20cIaNK3rw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qhkntg794-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:17:12 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 8 Feb 2019 17:17:10 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id DE9E762E2A0A; Fri,  8 Feb 2019 17:17:08 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Date:   Fri, 8 Feb 2019 17:17:01 -0800
Message-ID: <20190209011705.2160185-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209011705.2160185-1-songliubraving@fb.com>
References: <20190209011705.2160185-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-09_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_prog_info contains information necessary to annotate bpf programs.
This patch saves bpf_prog_info for bpf programs loaded in the system.

perf-record saves bpf_prog_info information as headers to perf.data.
A new header type HEADER_BPF_PROG_INFO is introduced for this data.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |   2 +-
 tools/perf/builtin-top.c    |   2 +-
 tools/perf/util/bpf-event.c |  39 ++++++++---
 tools/perf/util/bpf-event.h |  15 +++-
 tools/perf/util/env.c       |  83 ++++++++++++++++++++++
 tools/perf/util/env.h       |   9 +++
 tools/perf/util/header.c    | 134 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |   1 +
 8 files changed, 271 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 88ea11d57c6f..2355e0a9eda0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1083,7 +1083,7 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
-	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
+	err = perf_event__synthesize_bpf_events(session, process_synthesized_event,
 						machine, opts);
 	if (err < 0)
 		pr_warning("Couldn't synthesize bpf events.\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5a486d4de56e..27d8d42e0a4d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1216,7 +1216,7 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
-	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
 						&top->record_opts);
 	if (ret < 0)
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index e6dfb95029e5..ead599bc4f4e 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <stdlib.h>
-#include <bpf/bpf.h>
-#include <bpf/btf.h>
-#include <bpf/libbpf.h>
-#include <linux/btf.h>
 #include <linux/err.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
 #include "machine.h"
+#include "env.h"
+#include "session.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -42,7 +40,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
  *   -1 for failures;
  *   -2 for lack of kernel support.
  */
-static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       perf_event__handler_t process,
 					       struct machine *machine,
 					       int fd,
@@ -52,17 +50,29 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
 	struct bpf_event *bpf_event = &event->bpf_event;
 	struct bpf_prog_info_linear *info_linear;
+	struct perf_tool *tool = session->tool;
+	struct bpf_prog_info_node *info_node;
 	struct bpf_prog_info *info;
 	struct btf *btf = NULL;
 	bool has_btf = false;
+	struct perf_env *env;
 	u32 sub_prog_cnt, i;
 	int err = 0;
 	u64 arrays;
 
+	/*
+	 * for perf-record and perf-report use header.env;
+	 * otherwise, use global perf_env.
+	 */
+	env = session->data ? &session->header.env : &perf_env;
+
 	arrays = 1UL << BPF_PROG_INFO_JITED_KSYMS;
 	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
 	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
 	arrays |= 1UL << BPF_PROG_INFO_PROG_TAGS;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_INSNS;
+	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
+	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
 
 	info_linear = bpf_program__get_prog_info_linear(fd, arrays);
 	if (IS_ERR_OR_NULL(info_linear)) {
@@ -151,8 +161,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 						     machine, process);
 	}
 
-	/* Synthesize PERF_RECORD_BPF_EVENT */
 	if (opts->bpf_event) {
+		/* Synthesize PERF_RECORD_BPF_EVENT */
 		*bpf_event = (struct bpf_event){
 			.header = {
 				.type = PERF_RECORD_BPF_EVENT,
@@ -165,6 +175,19 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 		memcpy(bpf_event->tag, info->tag, BPF_TAG_SIZE);
 		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
 		event->header.size += machine->id_hdr_size;
+
+		/* save bpf_prog_info to env */
+		info_node = malloc(sizeof(struct bpf_prog_info_node));
+		if (info_node) {
+			info_node->info_linear = info_linear;
+			perf_env__insert_bpf_prog_info(env, info_node);
+			info_linear = NULL;
+		}
+
+		/*
+		 * process after saving bpf_prog_info to env, so that
+		 * required information is ready for look up
+		 */
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -175,7 +198,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	return err ? -1 : 0;
 }
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
@@ -209,7 +232,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			continue;
 		}
 
-		err = perf_event__synthesize_one_bpf_prog(tool, process,
+		err = perf_event__synthesize_one_bpf_prog(session, process,
 							  machine, fd,
 							  event, opts);
 		close(fd);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 7890067e1a37..11e6730b6105 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -3,19 +3,28 @@
 #define __PERF_BPF_EVENT_H
 
 #include <linux/compiler.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+#include <linux/btf.h>
+#include <linux/rbtree.h>
 #include "event.h"
 
 struct machine;
 union perf_event;
 struct perf_sample;
-struct perf_tool;
 struct record_opts;
 
+struct bpf_prog_info_node {
+	struct bpf_prog_info_linear	*info_linear;
+	struct rb_node			rb_node;
+};
+
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts);
@@ -27,7 +36,7 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
 						    perf_event__handler_t process __maybe_unused,
 						    struct machine *machine __maybe_unused,
 						    struct record_opts *opts __maybe_unused)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c23779e271a..665b6fe3c7b2 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -8,10 +8,86 @@
 
 struct perf_env perf_env;
 
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node)
+{
+	__u32 prog_id = info_node->info_linear->info.id;
+	struct bpf_prog_info_node *node;
+	struct rb_node *parent = NULL;
+	struct rb_node **p;
+
+	down_write(&env->bpf_info_lock);
+	p = &env->bpf_prog_infos.rb_node;
+
+	while (*p != NULL) {
+		parent = *p;
+		node = rb_entry(parent, struct bpf_prog_info_node, rb_node);
+		if (prog_id < node->info_linear->info.id) {
+			p = &(*p)->rb_left;
+		} else if (prog_id > node->info_linear->info.id) {
+			p = &(*p)->rb_right;
+		} else {
+			pr_debug("duplicated bpf prog info %u\n", prog_id);
+			up_write(&env->bpf_info_lock);
+			return;
+		}
+	}
+
+	rb_link_node(&info_node->rb_node, parent, p);
+	rb_insert_color(&info_node->rb_node, &env->bpf_prog_infos);
+	up_write(&env->bpf_info_lock);
+}
+
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id)
+{
+	struct bpf_prog_info_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_info_lock);
+	n = env->bpf_prog_infos.rb_node;
+
+	while (n) {
+		node = rb_entry(n, struct bpf_prog_info_node, rb_node);
+		if (prog_id < node->info_linear->info.id)
+			n = n->rb_left;
+		else if (prog_id > node->info_linear->info.id)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	up_read(&env->bpf_info_lock);
+	return node;
+}
+
+/* purge data in bpf_prog_infos tree */
+static void purge_bpf_info(struct perf_env *env)
+{
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_write(&env->bpf_info_lock);
+
+	root = &env->bpf_prog_infos;
+	next = rb_first(root);
+
+	while (next) {
+		struct bpf_prog_info_node *node;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		rb_erase_init(&node->rb_node, root);
+		free(node);
+	}
+	up_write(&env->bpf_info_lock);
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
 
+	purge_bpf_info(env);
 	zfree(&env->hostname);
 	zfree(&env->os_release);
 	zfree(&env->version);
@@ -38,6 +114,12 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->memory_nodes);
 }
 
+static void init_bpf_rb_trees(struct perf_env *env)
+{
+	env->bpf_prog_infos = RB_ROOT;
+	init_rwsem(&env->bpf_info_lock);
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
@@ -59,6 +141,7 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 
 	env->nr_cmdline = argc;
 
+	init_bpf_rb_trees(env);
 	return 0;
 out_free:
 	zfree(&env->cmdline_argv);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..5894a177b7cf 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -3,7 +3,10 @@
 #define __PERF_ENV_H
 
 #include <linux/types.h>
+#include <linux/rbtree.h>
 #include "cpumap.h"
+#include "rwsem.h"
+#include "bpf-event.h"
 
 struct cpu_topology_map {
 	int	socket_id;
@@ -64,6 +67,8 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
+	struct rw_semaphore	bpf_info_lock;
+	struct rb_root		bpf_prog_infos;
 };
 
 extern struct perf_env perf_env;
@@ -80,4 +85,8 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node);
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d218c31c..2ae76a9d06f6 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1080,6 +1080,51 @@ static int write_clockid(struct feat_fd *ff,
 			sizeof(ff->ph->env.clockid_res_ns));
 }
 
+static int write_bpf_prog_info(struct feat_fd *ff,
+			       struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	u32 count = 0;
+	int ret;
+
+	down_read(&env->bpf_info_lock);
+
+	root = &env->bpf_prog_infos;
+	next = rb_first(root);
+	while (next) {
+		++count;
+		next = rb_next(next);
+	}
+
+	ret = do_write(ff, &count, sizeof(count));
+
+	if (ret < 0)
+		goto out;
+
+	next = rb_first(root);
+	while (next) {
+		struct bpf_prog_info_node *node;
+		size_t len;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		len = sizeof(struct bpf_prog_info_linear) +
+			node->info_linear->data_len;
+
+		/* before writing to file, translate address to offset */
+		bpf_program__bpil_addr_to_offs(node->info_linear);
+		ret = do_write(ff, node->info_linear, len);
+		bpf_program__bpil_offs_to_addr(node->info_linear);
+		if (ret < 0)
+			goto out;
+	}
+out:
+	up_read(&env->bpf_info_lock);
+	return ret;
+}
+
 static int cpu_cache_level__sort(const void *a, const void *b)
 {
 	struct cpu_cache_level *cache_a = (struct cpu_cache_level *)a;
@@ -1560,6 +1605,29 @@ static void print_clockid(struct feat_fd *ff, FILE *fp)
 		ff->ph->env.clockid_res_ns * 1000);
 }
 
+static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_info_lock);
+
+	root = &env->bpf_prog_infos;
+	next = rb_first(root);
+
+	while (next) {
+		struct bpf_prog_info_node *node;
+
+		node = rb_entry(next, struct bpf_prog_info_node, rb_node);
+		next = rb_next(&node->rb_node);
+		fprintf(fp, "# bpf_prog_info of id %u\n",
+			node->info_linear->info.id);
+	}
+
+	up_read(&env->bpf_info_lock);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2592,6 +2660,69 @@ static int process_clockid(struct feat_fd *ff,
 	return 0;
 }
 
+static int process_bpf_prog_info(struct feat_fd *ff,
+				 void *data __maybe_unused)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_prog_info_node *info_node;
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+	int err = -1;
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_info_lock);
+
+	for (i = 0; i < count; ++i) {
+		u32 info_len, data_len;
+
+		info_linear = NULL;
+		info_node = NULL;
+		if (do_read_u32(ff, &info_len))
+			goto out;
+		if (do_read_u32(ff, &data_len))
+			goto out;
+
+		if (info_len > sizeof(struct bpf_prog_info)) {
+			pr_warning("detected invalid bpf_prog_info\n");
+			goto out;
+		}
+
+		info_linear = malloc(sizeof(struct bpf_prog_info_linear) +
+				     data_len);
+		if (!info_linear)
+			goto out;
+		info_linear->info_len = sizeof(struct bpf_prog_info);
+		info_linear->data_len = data_len;
+		if (do_read_u64(ff, (u64 *)(&info_linear->arrays)))
+			goto out;
+		if (__do_read(ff, &info_linear->info, info_len))
+			goto out;
+		if (info_len < sizeof(struct bpf_prog_info))
+			memset(((void *)(&info_linear->info)) + info_len, 0,
+			       sizeof(struct bpf_prog_info) - info_len);
+
+		if (__do_read(ff, info_linear->data, data_len))
+			goto out;
+		info_node = malloc(sizeof(struct bpf_prog_info_node));
+		if (!info_node)
+			goto out;
+
+		/* after reading from file, translate offset to address */
+		bpf_program__bpil_offs_to_addr(info_linear);
+		info_node->info_linear = info_linear;
+		perf_env__insert_bpf_prog_info(env, info_node);
+	}
+
+	return 0;
+out:
+	free(info_linear);
+	free(info_node);
+	up_write(&env->bpf_info_lock);
+	return err;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2651,7 +2782,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
-	FEAT_OPR(CLOCKID,       clockid,        false)
+	FEAT_OPR(CLOCKID,       clockid,        false),
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0d553ddca0a3..0785c91b4c3a 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -39,6 +39,7 @@ enum {
 	HEADER_SAMPLE_TIME,
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
+	HEADER_BPF_PROG_INFO,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

