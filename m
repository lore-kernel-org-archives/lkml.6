Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2682D20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G6IfcdFt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2682D20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbeLMAnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:43:02 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:47416 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbeLMAnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:43:02 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBD0eDVW008401
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:43:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=toYWGMdEaKlULS1VfM+kwvQ4g8gEokiemAyYxH0AZXA=;
 b=G6IfcdFtHRfqQ8XkXeDudB6/bUgW1bEhdHkyUw40AfK8ReGO+vHmie4aVAXlGpCyISEw
 wMp6d/AFFXcC3DxnNia1FcqLy3Ww66w1XKLPTzxuyomz5JnB1DsChs/+IS+oCPPp1AHX
 ZUdAtw811sKhyd3R6KbzbX9XvJRw8US0EhE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2pba37rm28-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:43:01 -0800
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 12 Dec 2018 16:43:00 -0800
Received: by dev003.prn2.facebook.com (Postfix, from userid 572441)
        id 8A7493644C3E; Wed, 12 Dec 2018 16:42:58 -0800 (PST)
Smtp-Origin-Hostprefix: dev
From:   Matt Mullins <mmullins@fb.com>
Smtp-Origin-Hostname: dev003.prn2.facebook.com
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <netdev@vger.kernel.org>
CC:     <kernel-team@fb.com>, Matt Mullins <mmullins@fb.com>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next v2] bpf: support raw tracepoints in modules
Date:   Wed, 12 Dec 2018 16:42:37 -0800
Message-ID: <20181213004237.3888568-1-mmullins@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Distributions build drivers as modules, including network and filesystem
drivers which export numerous tracepoints.  This enables
bpf(BPF_RAW_TRACEPOINT_OPEN) to attach to those tracepoints.

Signed-off-by: Matt Mullins <mmullins@fb.com>
---
v1->v2:
  * avoid taking the mutex in bpf_event_notify when op is neither COMING nor
    GOING.
  * check that kzalloc actually succeeded

I didn't try to check list_empty before taking the mutex since I want to avoid
races between bpf_event_notify and bpf_get_raw_tracepoint.  Additionally,
list_for_each_entry_safe is not strictly necessary upon MODULE_STATE_GOING, but
Alexei suggested I use it to protect against fragility if the subsequent break;
eventually disappears.

 include/linux/module.h       |  4 ++
 include/linux/trace_events.h |  8 ++-
 kernel/bpf/syscall.c         | 11 ++--
 kernel/module.c              |  5 ++
 kernel/trace/bpf_trace.c     | 99 +++++++++++++++++++++++++++++++++++-
 5 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index fce6b4335e36..5f147dd5e709 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -432,6 +432,10 @@ struct module {
 	unsigned int num_tracepoints;
 	tracepoint_ptr_t *tracepoints_ptrs;
 #endif
+#ifdef CONFIG_BPF_EVENTS
+	unsigned int num_bpf_raw_events;
+	struct bpf_raw_event_map *bpf_raw_events;
+#endif
 #ifdef HAVE_JUMP_LABEL
 	struct jump_entry *jump_entries;
 	unsigned int num_jump_entries;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 4130a5497d40..8a62731673f7 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -471,7 +471,8 @@ void perf_event_detach_bpf_prog(struct perf_event *event);
 int perf_event_query_prog_array(struct perf_event *event, void __user *info);
 int bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
 int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf_prog *prog);
-struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name);
+struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name);
+void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
@@ -502,10 +503,13 @@ static inline int bpf_probe_unregister(struct bpf_raw_event_map *btp, struct bpf
 {
 	return -EOPNOTSUPP;
 }
-static inline struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name)
+static inline struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 {
 	return NULL;
 }
+static inline void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
+{
+}
 static inline int bpf_get_perf_event_info(const struct perf_event *event,
 					  u32 *prog_id, u32 *fd_type,
 					  const char **buf, u64 *probe_offset,
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 70fb11106fc2..754370e3155e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1609,6 +1609,7 @@ static int bpf_raw_tracepoint_release(struct inode *inode, struct file *filp)
 		bpf_probe_unregister(raw_tp->btp, raw_tp->prog);
 		bpf_prog_put(raw_tp->prog);
 	}
+	bpf_put_raw_tracepoint(raw_tp->btp);
 	kfree(raw_tp);
 	return 0;
 }
@@ -1634,13 +1635,15 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 		return -EFAULT;
 	tp_name[sizeof(tp_name) - 1] = 0;
 
-	btp = bpf_find_raw_tracepoint(tp_name);
+	btp = bpf_get_raw_tracepoint(tp_name);
 	if (!btp)
 		return -ENOENT;
 
 	raw_tp = kzalloc(sizeof(*raw_tp), GFP_USER);
-	if (!raw_tp)
-		return -ENOMEM;
+	if (!raw_tp) {
+		err = -ENOMEM;
+		goto out_put_btp;
+	}
 	raw_tp->btp = btp;
 
 	prog = bpf_prog_get_type(attr->raw_tracepoint.prog_fd,
@@ -1668,6 +1671,8 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
 	bpf_prog_put(prog);
 out_free_tp:
 	kfree(raw_tp);
+out_put_btp:
+	bpf_put_raw_tracepoint(btp);
 	return err;
 }
 
diff --git a/kernel/module.c b/kernel/module.c
index 49a405891587..06ec68f08387 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3093,6 +3093,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					     sizeof(*mod->tracepoints_ptrs),
 					     &mod->num_tracepoints);
 #endif
+#ifdef CONFIG_BPF_EVENTS
+	mod->bpf_raw_events = section_objs(info, "__bpf_raw_tp_map",
+					   sizeof(*mod->bpf_raw_events),
+					   &mod->num_bpf_raw_events);
+#endif
 #ifdef HAVE_JUMP_LABEL
 	mod->jump_entries = section_objs(info, "__jump_table",
 					sizeof(*mod->jump_entries),
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 9864a35c8bb5..9ddb6fddb4e0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,43 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+#ifdef CONFIG_MODULES
+struct bpf_trace_module {
+	struct module *module;
+	struct list_head list;
+};
+
+static LIST_HEAD(bpf_trace_modules);
+static DEFINE_MUTEX(bpf_module_mutex);
+
+static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
+{
+	struct bpf_raw_event_map *btp, *ret = NULL;
+	struct bpf_trace_module *btm;
+	unsigned int i;
+
+	mutex_lock(&bpf_module_mutex);
+	list_for_each_entry(btm, &bpf_trace_modules, list) {
+		for (i = 0; i < btm->module->num_bpf_raw_events; ++i) {
+			btp = &btm->module->bpf_raw_events[i];
+			if (!strcmp(btp->tp->name, name)) {
+				if (try_module_get(btm->module))
+					ret = btp;
+				goto out;
+			}
+		}
+	}
+out:
+	mutex_unlock(&bpf_module_mutex);
+	return ret;
+}
+#else
+static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const char *name)
+{
+	return NULL;
+}
+#endif /* CONFIG_MODULES */
+
 u64 bpf_get_stackid(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 u64 bpf_get_stack(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
 
@@ -1076,7 +1113,7 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 extern struct bpf_raw_event_map __start__bpf_raw_tp[];
 extern struct bpf_raw_event_map __stop__bpf_raw_tp[];
 
-struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name)
+struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 {
 	struct bpf_raw_event_map *btp = __start__bpf_raw_tp;
 
@@ -1084,7 +1121,16 @@ struct bpf_raw_event_map *bpf_find_raw_tracepoint(const char *name)
 		if (!strcmp(btp->tp->name, name))
 			return btp;
 	}
-	return NULL;
+
+	return bpf_get_raw_tracepoint_module(name);
+}
+
+void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
+{
+	struct module *mod = __module_address((unsigned long)btp);
+
+	if (mod)
+		module_put(mod);
 }
 
 static __always_inline
@@ -1222,3 +1268,52 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 
 	return err;
 }
+
+#ifdef CONFIG_MODULES
+int bpf_event_notify(struct notifier_block *nb, unsigned long op, void *module)
+{
+	struct bpf_trace_module *btm, *tmp;
+	struct module *mod = module;
+
+	if (mod->num_bpf_raw_events == 0 ||
+	    (op != MODULE_STATE_COMING && op != MODULE_STATE_GOING))
+		return 0;
+
+	mutex_lock(&bpf_module_mutex);
+
+	switch (op) {
+	case MODULE_STATE_COMING:
+		btm = kzalloc(sizeof(*btm), GFP_KERNEL);
+		if (btm) {
+			btm->module = module;
+			list_add(&btm->list, &bpf_trace_modules);
+		}
+		break;
+	case MODULE_STATE_GOING:
+		list_for_each_entry_safe(btm, tmp, &bpf_trace_modules, list) {
+			if (btm->module == module) {
+				list_del(&btm->list);
+				kfree(btm);
+				break;
+			}
+		}
+		break;
+	}
+
+	mutex_unlock(&bpf_module_mutex);
+
+	return 0;
+}
+
+static struct notifier_block bpf_module_nb = {
+	.notifier_call = bpf_event_notify,
+};
+
+int __init bpf_event_init(void)
+{
+	register_module_notifier(&bpf_module_nb);
+	return 0;
+}
+
+fs_initcall(bpf_event_init);
+#endif /* CONFIG_MODULES */
-- 
2.17.1

