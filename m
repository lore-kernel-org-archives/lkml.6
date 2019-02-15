Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9824FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5238C222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="npZE3iAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392703AbfBOVyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:54:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46044 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392713AbfBOVy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:54:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FLqwPn019066
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:54:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=h6MNHxbeDU9GIhTh8D080EgfW+8thxP9v7riCZ+CPls=;
 b=npZE3iAZ4pQQZENHvKbynYHHeUSCpLmmDOBMRrTZ9VHmdQF0Qr1q0kxc8jUt0QT1+1CQ
 r4UP+amimwaY42dQbyz36NoRgyRr85M3HgYB73NkVjdnE6u2gbv16e4Oa3D3YsC67oFm
 I8ZvipZQ6Lquv6SAXmj92ha8SxQHOyfEJOA= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qp5efg24r-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:54:29 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 15 Feb 2019 13:54:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 1281262E20EE; Fri, 15 Feb 2019 13:54:09 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 perf,bpf 05/11] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Date:   Fri, 15 Feb 2019 13:53:48 -0800
Message-ID: <20190215215354.3114006-6-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215215354.3114006-1-songliubraving@fb.com>
References: <20190215215354.3114006-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bpf_prog_info contains information necessary to annotate bpf programs.
This patch saves bpf_prog_info for bpf programs loaded in the system.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/builtin-top.c    |  2 +-
 tools/perf/util/bpf-event.c | 35 +++++++++++++--
 tools/perf/util/bpf-event.h | 11 +++--
 tools/perf/util/env.c       | 85 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h       | 17 ++++++++
 6 files changed, 143 insertions(+), 9 deletions(-)

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
index e6dfb95029e5..13313a3e6c4d 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -10,6 +10,8 @@
 #include "debug.h"
 #include "symbol.h"
 #include "machine.h"
+#include "env.h"
+#include "session.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -42,7 +44,7 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
  *   -1 for failures;
  *   -2 for lack of kernel support.
  */
-static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 					       perf_event__handler_t process,
 					       struct machine *machine,
 					       int fd,
@@ -52,17 +54,29 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
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
@@ -151,8 +165,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 						     machine, process);
 	}
 
-	/* Synthesize PERF_RECORD_BPF_EVENT */
 	if (opts->bpf_event) {
+		/* Synthesize PERF_RECORD_BPF_EVENT */
 		*bpf_event = (struct bpf_event){
 			.header = {
 				.type = PERF_RECORD_BPF_EVENT,
@@ -165,6 +179,19 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
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
@@ -175,7 +202,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 	return err ? -1 : 0;
 }
 
-int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+int perf_event__synthesize_bpf_events(struct perf_session *session,
 				      perf_event__handler_t process,
 				      struct machine *machine,
 				      struct record_opts *opts)
@@ -209,7 +236,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 			continue;
 		}
 
-		err = perf_event__synthesize_one_bpf_prog(tool, process,
+		err = perf_event__synthesize_one_bpf_prog(session, process,
 							  machine, fd,
 							  event, opts);
 		close(fd);
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 7890067e1a37..fad932f7404f 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -3,19 +3,24 @@
 #define __PERF_BPF_EVENT_H
 
 #include <linux/compiler.h>
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
@@ -27,7 +32,7 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 	return 0;
 }
 
-static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+static inline int perf_event__synthesize_bpf_events(struct perf_session *session __maybe_unused,
 						    perf_event__handler_t process __maybe_unused,
 						    struct machine *machine __maybe_unused,
 						    struct record_opts *opts __maybe_unused)
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c23779e271a..026ca2182d50 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -3,15 +3,93 @@
 #include "env.h"
 #include "sane_ctype.h"
 #include "util.h"
+#include "bpf-event.h"
 #include <errno.h>
 #include <sys/utsname.h>
+#include <bpf/libbpf.h>
 
 struct perf_env perf_env;
 
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node)
+{
+	__u32 prog_id = info_node->info_linear->info.id;
+	struct bpf_prog_info_node *node;
+	struct rb_node *parent = NULL;
+	struct rb_node **p;
+
+	down_write(&env->bpf_progs.bpf_info_lock);
+	p = &env->bpf_progs.bpf_prog_infos.rb_node;
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
+			goto out;
+		}
+	}
+
+	rb_link_node(&info_node->rb_node, parent, p);
+	rb_insert_color(&info_node->rb_node, &env->bpf_progs.bpf_prog_infos);
+out:
+	up_write(&env->bpf_progs.bpf_info_lock);
+}
+
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id)
+{
+	struct bpf_prog_info_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_progs.bpf_info_lock);
+	n = env->bpf_progs.bpf_prog_infos.rb_node;
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
+	up_read(&env->bpf_progs.bpf_info_lock);
+	return node;
+}
+
+/* purge data in bpf_prog_infos tree */
+static void perf_env__purge_bpf(struct perf_env *env)
+{
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_write(&env->bpf_progs.bpf_info_lock);
+
+	root = &env->bpf_progs.bpf_prog_infos;
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
+	up_write(&env->bpf_progs.bpf_info_lock);
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
 
+	perf_env__purge_bpf(env);
 	zfree(&env->hostname);
 	zfree(&env->os_release);
 	zfree(&env->version);
@@ -38,6 +116,12 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->memory_nodes);
 }
 
+static void init_bpf_rb_trees(struct perf_env *env)
+{
+	env->bpf_progs.bpf_prog_infos = RB_ROOT;
+	init_rwsem(&env->bpf_progs.bpf_info_lock);
+}
+
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 {
 	int i;
@@ -59,6 +143,7 @@ int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[])
 
 	env->nr_cmdline = argc;
 
+	init_bpf_rb_trees(env);
 	return 0;
 out_free:
 	zfree(&env->cmdline_argv);
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..d0c53fe6d431 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -3,7 +3,9 @@
 #define __PERF_ENV_H
 
 #include <linux/types.h>
+#include <linux/rbtree.h>
 #include "cpumap.h"
+#include "rwsem.h"
 
 struct cpu_topology_map {
 	int	socket_id;
@@ -64,8 +66,19 @@ struct perf_env {
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
 	u64                     clockid_res_ns;
+
+	/*
+	 * bpf_info_lock protects bpf rbtrees. This is needed because the
+	 * trees are accessed by different threads in perf-top
+	 */
+	struct {
+		struct rw_semaphore	bpf_info_lock;
+		struct rb_root		bpf_prog_infos;
+	} bpf_progs;
 };
 
+struct bpf_prog_info_node;
+
 extern struct perf_env perf_env;
 
 void perf_env__exit(struct perf_env *env);
@@ -80,4 +93,8 @@ const char *perf_env__arch(struct perf_env *env);
 const char *perf_env__raw_arch(struct perf_env *env);
 int perf_env__nr_cpus_avail(struct perf_env *env);
 
+void perf_env__insert_bpf_prog_info(struct perf_env *env,
+				    struct bpf_prog_info_node *info_node);
+struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
+							__u32 prog_id);
 #endif /* __PERF_ENV_H */
-- 
2.17.1

