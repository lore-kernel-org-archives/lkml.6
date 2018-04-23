Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754270AbeDWHAg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 03:00:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753263AbeDWG7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:59:30 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 1/3] bpf: Store license string for loaded program
Date: Mon, 23 Apr 2018 08:59:25 +0200
Message-Id: <20180423065927.23127-2-jolsa@kernel.org>
In-Reply-To: <20180423065927.23127-1-jolsa@kernel.org>
References: <20180423065927.23127-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Storing the license string provided loaded program,
so it can be provided back when dumping the loaded
programs info (added in following change).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h      | 1 +
 include/uapi/linux/bpf.h | 3 +++
 kernel/bpf/core.c        | 1 +
 kernel/bpf/syscall.c     | 7 ++++++-
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ee5275e7d4df..8530b791c1b0 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -274,6 +274,7 @@ struct bpf_prog_aux {
 	struct user_struct *user;
 	u64 load_time; /* ns since boottime */
 	char name[BPF_OBJ_NAME_LEN];
+	char *license;
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c8383a289f7b..b7298ee177e7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -239,6 +239,8 @@ enum bpf_attach_type {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+#define BPF_OBJ_LICENSE_LEN 128U
+
 /* Flags for accessing BPF object */
 #define BPF_F_RDONLY		(1U << 3)
 #define BPF_F_WRONLY		(1U << 4)
@@ -1039,6 +1041,7 @@ struct bpf_prog_info {
 	__u32 ifindex;
 	__u64 netns_dev;
 	__u64 netns_ino;
+	char license[BPF_OBJ_LICENSE_LEN];
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d315b393abdd..05352a928917 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -142,6 +142,7 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
 
 void __bpf_prog_free(struct bpf_prog *fp)
 {
+	kfree(fp->aux->license);
 	kfree(fp->aux);
 	vfree(fp);
 }
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fe23dc5a3ec4..a876af93147f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1265,7 +1265,7 @@ static int bpf_prog_load(union bpf_attr *attr)
 	enum bpf_prog_type type = attr->prog_type;
 	struct bpf_prog *prog;
 	int err;
-	char license[128];
+	char license[BPF_OBJ_LICENSE_LEN];
 	bool is_gpl;
 
 	if (CHECK_ATTR(BPF_PROG_LOAD))
@@ -1345,6 +1345,10 @@ static int bpf_prog_load(union bpf_attr *attr)
 	if (err)
 		goto free_prog;
 
+	prog->aux->license = kstrdup(license, GFP_KERNEL);
+	if (!prog->aux->license)
+		goto free_prog;
+
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr);
 	if (err < 0)
@@ -1917,6 +1921,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
+	strncpy(info.license, prog->aux->license, BPF_OBJ_LICENSE_LEN);
 
 	ulen = info.nr_map_ids;
 	info.nr_map_ids = prog->aux->used_map_cnt;
-- 
2.13.6
