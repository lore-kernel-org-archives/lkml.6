Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC1AC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6662177B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 01:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="T1OGAs0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBIBV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 20:21:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52526 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfBIBVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 20:21:53 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x191HJl2004473
        for <linux-kernel@vger.kernel.org>; Fri, 8 Feb 2019 17:21:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=FVqr74Z0uKkQ4EX5ecCRzwgO/a9dVmWAyYahWSmrzuc=;
 b=T1OGAs0Su4Ic7FbYGxehqMpbpyNYUDdt5HVqTQURYMmwwARRbNNdcOXEtR+DLQ7dABqS
 HNvhC+VjjlXm97nzdUlDrtLdtf5dY1nqexIG155sf3XbH0Y4j/SEBuiLOpsc4/xxo8w+
 DUOljNlsT6um/OH0Nj/KQXLUfLUCxWbFjiw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2qhke089ax-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 17:21:52 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 8 Feb 2019 17:21:50 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id C635162E2A00; Fri,  8 Feb 2019 17:21:47 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 6/9] perf, bpf: save btf in a rbtree in perf_env
Date:   Fri, 8 Feb 2019 17:21:39 -0800
Message-ID: <20190209012142.2177204-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
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

btf contains information necessary to annotate bpf programs. This patch
saves btf for bpf programs loaded in the system.

perf-record saves btf information as headers to perf.data. A new header
type HEADER_BTF is introduced for this data.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 22 +++++++++
 tools/perf/util/bpf-event.h |  7 +++
 tools/perf/util/env.c       | 65 ++++++++++++++++++++++++
 tools/perf/util/env.h       |  3 ++
 tools/perf/util/header.c    | 99 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/header.h    |  1 +
 6 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index ead599bc4f4e..37a5b8134e00 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -30,6 +30,27 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int perf_fetch_btf(struct perf_env *env, u32 btf_id, struct btf *btf)
+{
+	struct btf_node *node;
+	u32 data_size;
+	const void *data;
+
+	data = btf__get_raw_data(btf, &data_size);
+
+	node = malloc(data_size + sizeof(struct btf_node));
+
+	if (!node)
+		return -1;
+
+	node->id = btf_id;
+	node->data_size = data_size;
+	memcpy(node->data, data, data_size);
+
+	perf_env__insert_btf(env, node);
+	return 0;
+}
+
 /*
  * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
  * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
@@ -109,6 +130,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			goto out;
 		}
 		has_btf = true;
+		perf_fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 11e6730b6105..60ce24e4e5c6 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -20,6 +20,13 @@ struct bpf_prog_info_node {
 	struct rb_node			rb_node;
 };
 
+struct btf_node {
+	struct rb_node	rb_node;
+	u32		id;
+	u32		data_size;
+	char		data[];
+};
+
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 665b6fe3c7b2..6f9e3d4b94bc 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -61,6 +61,57 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	struct rb_node *parent = NULL;
+	__u32 btf_id = btf_node->id;
+	struct btf_node *node;
+	struct rb_node **p;
+
+	down_write(&env->bpf_info_lock);
+	p = &env->btfs.rb_node;
+
+	while (*p != NULL) {
+		parent = *p;
+		node = rb_entry(parent, struct btf_node, rb_node);
+		if (btf_id < node->id) {
+			p = &(*p)->rb_left;
+		} else if (btf_id > node->id) {
+			p = &(*p)->rb_right;
+		} else {
+			pr_debug("duplicated btf %u\n", btf_id);
+			up_write(&env->bpf_info_lock);
+			return;
+		}
+	}
+
+	rb_link_node(&btf_node->rb_node, parent, p);
+	rb_insert_color(&btf_node->rb_node, &env->btfs);
+	up_write(&env->bpf_info_lock);
+}
+
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_info_lock);
+	n = env->btfs.rb_node;
+
+	while (n) {
+		node = rb_entry(n, struct btf_node, rb_node);
+		if (btf_id < node->id)
+			n = n->rb_left;
+		else if (btf_id > node->id)
+			n = n->rb_right;
+		else
+			break;
+	}
+
+	up_read(&env->bpf_info_lock);
+	return node;
+}
+
 /* purge data in bpf_prog_infos tree */
 static void purge_bpf_info(struct perf_env *env)
 {
@@ -80,6 +131,19 @@ static void purge_bpf_info(struct perf_env *env)
 		rb_erase_init(&node->rb_node, root);
 		free(node);
 	}
+
+	root = &env->btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		rb_erase_init(&node->rb_node, root);
+		free(node);
+	}
+
 	up_write(&env->bpf_info_lock);
 }
 
@@ -117,6 +181,7 @@ void perf_env__exit(struct perf_env *env)
 static void init_bpf_rb_trees(struct perf_env *env)
 {
 	env->bpf_prog_infos = RB_ROOT;
+	env->btfs = RB_ROOT;
 	init_rwsem(&env->bpf_info_lock);
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 5894a177b7cf..40b6e9413c22 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -69,6 +69,7 @@ struct perf_env {
 	u64                     clockid_res_ns;
 	struct rw_semaphore	bpf_info_lock;
 	struct rb_root		bpf_prog_infos;
+	struct rb_root		btfs;
 };
 
 extern struct perf_env perf_env;
@@ -89,4 +90,6 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 2ae76a9d06f6..3f1562afe8e5 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1125,6 +1125,45 @@ static int write_bpf_prog_info(struct feat_fd *ff,
 	return ret;
 }
 
+static int write_btf(struct feat_fd *ff,
+		     struct perf_evlist *evlist __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+	u32 count = 0;
+	int ret;
+
+	down_read(&env->bpf_info_lock);
+
+	root = &env->btfs;
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
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		ret = do_write(ff, node,
+			       sizeof(struct btf_node) + node->data_size);
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
@@ -1628,6 +1667,28 @@ static void print_bpf_prog_info(struct feat_fd *ff, FILE *fp)
 	up_read(&env->bpf_info_lock);
 }
 
+static void print_btf(struct feat_fd *ff, FILE *fp)
+{
+	struct perf_env *env = &ff->ph->env;
+	struct rb_root *root;
+	struct rb_node *next;
+
+	down_read(&env->bpf_info_lock);
+
+	root = &env->btfs;
+	next = rb_first(root);
+
+	while (next) {
+		struct btf_node *node;
+
+		node = rb_entry(next, struct btf_node, rb_node);
+		next = rb_next(&node->rb_node);
+		fprintf(fp, "# bpf_prog_info of id %u\n", node->id);
+	}
+
+	up_read(&env->bpf_info_lock);
+}
+
 static void free_event_desc(struct perf_evsel *events)
 {
 	struct perf_evsel *evsel;
@@ -2723,6 +2784,41 @@ static int process_bpf_prog_info(struct feat_fd *ff,
 	return err;
 }
 
+static int process_btf(struct feat_fd *ff, void *data __maybe_unused)
+{
+	struct perf_env *env = &ff->ph->env;
+	u32 count, i;
+
+	if (do_read_u32(ff, &count))
+		return -1;
+
+	down_write(&env->bpf_info_lock);
+
+	for (i = 0; i < count; ++i) {
+		struct btf_node btf_node;
+		struct btf_node *node;
+
+		if (__do_read(ff, &btf_node, sizeof(struct btf_node)))
+			return -1;
+
+		node = malloc(sizeof(struct btf_node) + btf_node.data_size);
+		if (!node)
+			return -1;
+
+		node->id = btf_node.id;
+		node->data_size = btf_node.data_size;
+
+		if (__do_read(ff, node->data, btf_node.data_size)) {
+			free(node);
+			return -1;
+		}
+		perf_env__insert_btf(env, node);
+	}
+
+	up_write(&env->bpf_info_lock);
+	return 0;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2783,7 +2879,8 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
 	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 	FEAT_OPR(CLOCKID,       clockid,        false),
-	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false)
+	FEAT_OPR(BPF_PROG_INFO, bpf_prog_info,  false),
+	FEAT_OPR(BTF,           btf,            false)
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 0785c91b4c3a..ba51d8e43c53 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -40,6 +40,7 @@ enum {
 	HEADER_MEM_TOPOLOGY,
 	HEADER_CLOCKID,
 	HEADER_BPF_PROG_INFO,
+	HEADER_BTF,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.17.1

