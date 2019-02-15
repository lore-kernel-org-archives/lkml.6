Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C19C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0706B222DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MEwviDYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfBOV4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:56:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56960 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726684AbfBOV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:56:51 -0500
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FLrsAV026196
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:56:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=mqLBSoJ66jOcPSYOpkXhTMHY+dy1towy/qR9nQMTfaE=;
 b=MEwviDYJapD3OYiza9nRejxIk+4Av02I9J4Tlf50pASSFUypkf1fbs09zSiyj/NuHFQG
 zISeSAToCj8nDWCQLFN98o9CSSxHXEDvPYqEmOBzf2NEVV0q7skqu/3b2xUT4IXoQS56
 teJWnzjuuYVL+LY6jcHNkecVkQFqGXHvqmo= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2qp4p006uu-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 13:56:51 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Fri, 15 Feb 2019 13:54:14 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id CAC7F62E20EE; Fri, 15 Feb 2019 13:54:11 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <peterz@infradead.org>, <acme@redhat.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v3 perf,bpf 07/11] perf, bpf: save btf in a rbtree in perf_env
Date:   Fri, 15 Feb 2019 13:53:50 -0800
Message-ID: <20190215215354.3114006-8-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215215354.3114006-1-songliubraving@fb.com>
References: <20190215215354.3114006-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_15:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btf contains information necessary to annotate bpf programs. This patch
saves btf for bpf programs loaded in the system.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 24 ++++++++++++++
 tools/perf/util/bpf-event.h |  7 ++++
 tools/perf/util/env.c       | 65 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/env.h       |  4 +++
 4 files changed, 100 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 13313a3e6c4d..52507435c464 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -34,6 +34,29 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 	return 0;
 }
 
+static int perf_env__fetch_btf(struct perf_env *env,
+			       u32 btf_id,
+			       struct btf *btf)
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
@@ -113,6 +136,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_session *session,
 			goto out;
 		}
 		has_btf = true;
+		perf_env__fetch_btf(env, info->btf_id, btf);
 	}
 
 	/* Synthesize PERF_RECORD_KSYMBOL */
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index fad932f7404f..b9ec394dc7c7 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -16,6 +16,13 @@ struct bpf_prog_info_node {
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
index 026ca2182d50..f5556d2f4063 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -63,6 +63,57 @@ struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 	return node;
 }
 
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node)
+{
+	struct rb_node *parent = NULL;
+	__u32 btf_id = btf_node->id;
+	struct btf_node *node;
+	struct rb_node **p;
+
+	down_write(&env->bpf_progs.bpf_info_lock);
+	p = &env->bpf_progs.btfs.rb_node;
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
+			goto out;
+		}
+	}
+
+	rb_link_node(&btf_node->rb_node, parent, p);
+	rb_insert_color(&btf_node->rb_node, &env->bpf_progs.btfs);
+out:
+	up_write(&env->bpf_progs.bpf_info_lock);
+}
+
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id)
+{
+	struct btf_node *node = NULL;
+	struct rb_node *n;
+
+	down_read(&env->bpf_progs.bpf_info_lock);
+	n = env->bpf_progs.btfs.rb_node;
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
+	up_read(&env->bpf_progs.bpf_info_lock);
+	return node;
+}
+
 /* purge data in bpf_prog_infos tree */
 static void perf_env__purge_bpf(struct perf_env *env)
 {
@@ -82,6 +133,19 @@ static void perf_env__purge_bpf(struct perf_env *env)
 		rb_erase_init(&node->rb_node, root);
 		free(node);
 	}
+
+	root = &env->bpf_progs.btfs;
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
 	up_write(&env->bpf_progs.bpf_info_lock);
 }
 
@@ -119,6 +183,7 @@ void perf_env__exit(struct perf_env *env)
 static void init_bpf_rb_trees(struct perf_env *env)
 {
 	env->bpf_progs.bpf_prog_infos = RB_ROOT;
+	env->bpf_progs.btfs = RB_ROOT;
 	init_rwsem(&env->bpf_progs.bpf_info_lock);
 }
 
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d0c53fe6d431..b3ce7813b1a0 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -74,10 +74,12 @@ struct perf_env {
 	struct {
 		struct rw_semaphore	bpf_info_lock;
 		struct rb_root		bpf_prog_infos;
+		struct rb_root		btfs;
 	} bpf_progs;
 };
 
 struct bpf_prog_info_node;
+struct btf_node;
 
 extern struct perf_env perf_env;
 
@@ -97,4 +99,6 @@ void perf_env__insert_bpf_prog_info(struct perf_env *env,
 				    struct bpf_prog_info_node *info_node);
 struct bpf_prog_info_node *perf_env__find_bpf_prog_info(struct perf_env *env,
 							__u32 prog_id);
+void perf_env__insert_btf(struct perf_env *env, struct btf_node *btf_node);
+struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 #endif /* __PERF_ENV_H */
-- 
2.17.1

