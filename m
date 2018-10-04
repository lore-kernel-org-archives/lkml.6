Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2D3C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A1ED213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A1ED213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJDJtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:49:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42124 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727467AbeJDJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:49:23 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w942vxZK008539
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 19:57:59 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2mw8fs89dn-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 19:57:59 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.11) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 19:57:55 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)  id
 0B266760B56; Wed,  3 Oct 2018 19:57:50 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     "David S . Miller" <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <luto@amacapital.net>,
        <viro@zeniv.linux.org.uk>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 1/6] bpf: introduce BPF_PROG_TYPE_FILE_FILTER
Date:   Wed, 3 Oct 2018 19:57:45 -0700
Message-ID: <20181004025750.498303-2-ast@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181004025750.498303-1-ast@kernel.org>
References: <20181004025750.498303-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-04_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to networking sandboxing programs and cgroup-v2 based hooks
(BPF_CGROUP_INET_[INGRESS|EGRESS,] BPF_CGROUP_INET[4|6]_[BIND|CONNECT], etc)
introduce basic per-container sandboxing for file access via
new BPF_PROG_TYPE_FILE_FILTER program type that attaches after
security_file_open() LSM hook and works as additional file_open filter.
The new cgroup bpf hook is called BPF_CGROUP_FILE_OPEN.

Just like other cgroup-bpf programs new BPF_PROG_TYPE_FILE_FILTER type
is only available to root.

This program type has access to single argument 'struct bpf_file_info'
that contains standard sys_stat fields:
struct bpf_file_info {
        __u64 inode;
        __u32 dev_major;
        __u32 dev_minor;
        __u32 fs_magic;
        __u32 mnt_id;
        __u32 nlink;
        __u32 mode;     /* file mode S_ISDIR, S_ISLNK, 0755, etc */
        __u32 flags;    /* open flags O_RDWR, O_CREAT, etc */
};
Other file attributes can be added in the future to the end of this struct
without breaking bpf programs.

For debugging introduce bpf_get_file_path() helper that returns
NUL-terminated full path of the file. It should never be used for sandboxing.

Use cases:
- disallow certain FS types within containers (fs_magic == CGROUP2_SUPER_MAGIC)
- restrict permissions in particular mount (mnt_id == X && (flags & O_RDWR))
- disallow access to hard linked sensitive files (nlink > 1 && mode == 0700)
- disallow access to world writeable files (mode == 0..7)
- disallow access to given set of files (dev_major == X && dev_minor == Y && inode == Z)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf-cgroup.h |  10 +++
 include/linux/bpf_types.h  |   1 +
 include/uapi/linux/bpf.h   |  28 +++++-
 kernel/bpf/cgroup.c        | 171 +++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c       |   7 ++
 5 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 588dd5f0bd85..766f0223c222 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -109,6 +109,8 @@ int __cgroup_bpf_run_filter_sock_ops(struct sock *sk,
 int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum bpf_attach_type type);
 
+int __cgroup_bpf_file_filter(struct file *file, enum bpf_attach_type type);
+
 static inline enum bpf_cgroup_storage_type cgroup_storage_type(
 	struct bpf_map *map)
 {
@@ -253,6 +255,13 @@ int bpf_percpu_cgroup_storage_update(struct bpf_map *map, void *key,
 									      \
 	__ret;								      \
 })
+#define BPF_CGROUP_RUN_PROG_FILE_FILTER(file)				     \
+({									      \
+	int __ret = 0;							      \
+	if (cgroup_bpf_enabled)						      \
+		__ret = __cgroup_bpf_file_filter(file, BPF_CGROUP_FILE_OPEN); \
+	__ret;								      \
+})
 int cgroup_bpf_prog_attach(const union bpf_attr *attr,
 			   enum bpf_prog_type ptype, struct bpf_prog *prog);
 int cgroup_bpf_prog_detach(const union bpf_attr *attr,
@@ -321,6 +330,7 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_UDP6_SENDMSG_LOCK(sk, uaddr, t_ctx) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_SOCK_OPS(sock_ops) ({ 0; })
 #define BPF_CGROUP_RUN_PROG_DEVICE_CGROUP(type,major,minor,access) ({ 0; })
+#define BPF_CGROUP_RUN_PROG_FILE_FILTER(file) ({ 0; })
 
 #define for_each_cgroup_storage_type(stype) for (; false; )
 
diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
index 5432f4c9f50e..f182b2e37b94 100644
--- a/include/linux/bpf_types.h
+++ b/include/linux/bpf_types.h
@@ -33,6 +33,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_LIRC_MODE2, lirc_mode2)
 #ifdef CONFIG_INET
 BPF_PROG_TYPE(BPF_PROG_TYPE_SK_REUSEPORT, sk_reuseport)
 #endif
+BPF_PROG_TYPE(BPF_PROG_TYPE_FILE_FILTER, file_filter)
 
 BPF_MAP_TYPE(BPF_MAP_TYPE_ARRAY, array_map_ops)
 BPF_MAP_TYPE(BPF_MAP_TYPE_PERCPU_ARRAY, percpu_array_map_ops)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f9187b41dff6..c0df8dd99edc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -154,6 +154,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_LIRC_MODE2,
 	BPF_PROG_TYPE_SK_REUSEPORT,
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
+	BPF_PROG_TYPE_FILE_FILTER,
 };
 
 enum bpf_attach_type {
@@ -175,6 +176,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_UDP6_SENDMSG,
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
+	BPF_CGROUP_FILE_OPEN,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -2215,6 +2217,18 @@ union bpf_attr {
  *		pointer that was returned from bpf_sk_lookup_xxx\ ().
  *	Return
  *		0 on success, or a negative error in case of failure.
+ *
+ * int bpf_get_file_path(struct bpf_file_info *file, char *buf, u32 size_of_buf)
+ * 	Description
+ * 		Reconstruct the full path of *file* and store it into *buf* of
+ * 		*size_of_buf*. The *size_of_buf* must be strictly positive.
+ * 		On success, the helper makes sure that the *buf* is NUL-terminated.
+ * 		On failure, it is filled with string "(error)".
+ * 		This helper should only be used for debugging.
+ * 		'char *path' should never be used for permission checks.
+ * 	Return
+ * 		0 on success, or a negative error in case of failure.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -2303,7 +2317,8 @@ union bpf_attr {
 	FN(skb_ancestor_cgroup_id),	\
 	FN(sk_lookup_tcp),		\
 	FN(sk_lookup_udp),		\
-	FN(sk_release),
+	FN(sk_release),			\
+	FN(get_file_path),
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
  * function eBPF program intends to call
@@ -2896,4 +2911,15 @@ struct bpf_flow_keys {
 	};
 };
 
+struct bpf_file_info {
+	__u64 inode;
+	__u32 dev_major;
+	__u32 dev_minor;
+	__u32 fs_magic;
+	__u32 mnt_id;
+	__u32 nlink;
+	__u32 mode;	/* file mode S_ISDIR, S_ISLNK, 0755, etc */
+	__u32 flags;	/* open flags O_RDWR, O_CREAT, etc */
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 00f6ed2e4f9a..38d0b4aa83ea 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -15,6 +15,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf-cgroup.h>
 #include <net/sock.h>
+#include <../fs/mount.h>
 
 DEFINE_STATIC_KEY_FALSE(cgroup_bpf_enabled_key);
 EXPORT_SYMBOL(cgroup_bpf_enabled_key);
@@ -754,3 +755,173 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
 	.get_func_proto		= cgroup_dev_func_proto,
 	.is_valid_access	= cgroup_dev_is_valid_access,
 };
+
+int __cgroup_bpf_file_filter(struct file *file, enum bpf_attach_type type)
+{
+	struct cgroup *cgrp;
+	int ret;
+
+	rcu_read_lock();
+	cgrp = task_dfl_cgroup(current);
+	ret = BPF_PROG_RUN_ARRAY(cgrp->bpf.effective[type], file, BPF_PROG_RUN);
+	rcu_read_unlock();
+
+	return ret == 1 ? 0 : -EPERM;
+}
+EXPORT_SYMBOL(__cgroup_bpf_file_filter);
+
+BPF_CALL_3(bpf_get_file_path, struct file *, file, char *, buf, u64, size)
+{
+	char *p = file_path(file, buf, size);
+	int len;
+
+	if (IS_ERR(p)) {
+		strncpy(buf, "(error)", size);
+		return PTR_ERR(p);
+	}
+	len = buf + size - p;
+	memmove(buf, p, len);
+	memset(buf + len, 0, size - len);
+	return 0;
+}
+
+const struct bpf_func_proto bpf_get_file_path_proto = {
+	.func		= bpf_get_file_path,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_CTX,
+	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
+	.arg3_type	= ARG_CONST_SIZE,
+};
+
+static const struct bpf_func_proto *
+cgroup_file_filter_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
+{
+	switch (func_id) {
+	case BPF_FUNC_get_file_path:
+		return &bpf_get_file_path_proto;
+	default:
+		return cgroup_dev_func_proto(func_id, prog);
+	}
+}
+
+static bool cgroup_file_filter_is_valid_access(int off, int size,
+					       enum bpf_access_type type,
+					       const struct bpf_prog *prog,
+					       struct bpf_insn_access_aux *info)
+{
+	const int size_default = sizeof(__u32);
+
+	if (off < 0 || off + size > sizeof(struct bpf_file_info) ||
+	    off % size || type != BPF_READ)
+		return false;
+
+	switch (off) {
+	case offsetof(struct bpf_file_info, fs_magic):
+	case offsetof(struct bpf_file_info, mnt_id):
+	case offsetof(struct bpf_file_info, dev_major):
+	case offsetof(struct bpf_file_info, dev_minor):
+	case offsetof(struct bpf_file_info, nlink):
+	case offsetof(struct bpf_file_info, mode):
+	case offsetof(struct bpf_file_info, flags):
+		return size == size_default;
+
+	case offsetof(struct bpf_file_info, inode):
+		return size == sizeof(__u64);
+
+	default:
+		if (size != size_default)
+			return false;
+	}
+	return true;
+}
+
+#define LD_1(F) ({					\
+	typeof(F) val = 0;				\
+	*insn++ = BPF_LDX_MEM(BPF_SIZEOF(val),		\
+			      si->dst_reg, si->src_reg,	\
+			      ((size_t)&F));		\
+	*target_size = sizeof(val);			\
+	val;						\
+	})
+
+#define LD_n(F) ({					\
+	typeof(F) val = 0;				\
+	*insn++ = BPF_LDX_MEM(BPF_SIZEOF(val),		\
+			      si->dst_reg, si->dst_reg,	\
+			      ((size_t)&F));		\
+	*target_size = sizeof(val);			\
+	val;						\
+	})
+
+static u32 cgroup_file_filter_ctx_access(enum bpf_access_type type,
+					 const struct bpf_insn *si,
+					 struct bpf_insn *insn_buf,
+					 struct bpf_prog *prog,
+					 u32 *target_size)
+{
+	struct bpf_insn *insn = insn_buf;
+	struct file *file = NULL;
+	struct inode *inode;
+	struct super_block *sb;
+	struct mount *mnt;
+
+	switch (si->off) {
+	case offsetof(struct bpf_file_info, fs_magic):
+		/* dst = file->f_inode->i_sb->s_magic */
+		inode = LD_1(file->f_inode);
+		sb = LD_n(inode->i_sb);
+		LD_n(sb->s_magic);
+		break;
+	case offsetof(struct bpf_file_info, dev_major):
+		/* dst = file->f_inode->i_sb->s_dev */
+		inode = LD_1(file->f_inode);
+		sb = LD_n(inode->i_sb);
+		LD_n(sb->s_dev);
+		*insn++ = BPF_ALU32_IMM(BPF_RSH, si->dst_reg, MINORBITS);
+		break;
+	case offsetof(struct bpf_file_info, dev_minor):
+		/* dst = file->f_inode->i_sb->s_dev */
+		inode = LD_1(file->f_inode);
+		sb = LD_n(inode->i_sb);
+		LD_n(sb->s_dev);
+		*insn++ = BPF_ALU32_IMM(BPF_AND, si->dst_reg, MINORMASK);
+		break;
+	case offsetof(struct bpf_file_info, inode):
+		/* dst = file->f_inode->i_ino */
+		inode = LD_1(file->f_inode);
+		LD_n(inode->i_ino);
+		break;
+	case offsetof(struct bpf_file_info, mode):
+		/* dst = file->f_inode->i_mode */
+		inode = LD_1(file->f_inode);
+		LD_n(inode->i_mode);
+		break;
+	case offsetof(struct bpf_file_info, nlink):
+		/* dst = file->f_inode->i_nlink */
+		inode = LD_1(file->f_inode);
+		LD_n(inode->i_nlink);
+		break;
+	case offsetof(struct bpf_file_info, flags):
+		/* dst = file->f_flags */
+		LD_1(file->f_flags);
+		break;
+	case offsetof(struct bpf_file_info, mnt_id):
+		/* dst = real_mount(file->f_path.mnt)->mnt_id */
+		mnt = real_mount(LD_1(file->f_path.mnt));
+		LD_n(mnt->mnt_id);
+		break;
+	}
+	return insn - insn_buf;
+}
+#undef LD_1
+#undef LD_n
+
+const struct bpf_prog_ops file_filter_prog_ops = {
+};
+
+const struct bpf_verifier_ops file_filter_verifier_ops = {
+	.get_func_proto		= cgroup_file_filter_proto,
+	.is_valid_access	= cgroup_file_filter_is_valid_access,
+	.convert_ctx_access	= cgroup_file_filter_ctx_access
+};
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5742df21598c..7b0ffb8d7063 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1630,6 +1630,9 @@ static int bpf_prog_attach(const union bpf_attr *attr)
 	case BPF_FLOW_DISSECTOR:
 		ptype = BPF_PROG_TYPE_FLOW_DISSECTOR;
 		break;
+	case BPF_CGROUP_FILE_OPEN:
+		ptype = BPF_PROG_TYPE_FILE_FILTER;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1699,6 +1702,9 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_CGROUP_DEVICE:
 		ptype = BPF_PROG_TYPE_CGROUP_DEVICE;
 		break;
+	case BPF_CGROUP_FILE_OPEN:
+		ptype = BPF_PROG_TYPE_FILE_FILTER;
+		break;
 	case BPF_SK_MSG_VERDICT:
 		return sockmap_get_from_fd(attr, BPF_PROG_TYPE_SK_MSG, NULL);
 	case BPF_SK_SKB_STREAM_PARSER:
@@ -1741,6 +1747,7 @@ static int bpf_prog_query(const union bpf_attr *attr,
 	case BPF_CGROUP_UDP6_SENDMSG:
 	case BPF_CGROUP_SOCK_OPS:
 	case BPF_CGROUP_DEVICE:
+	case BPF_CGROUP_FILE_OPEN:
 		break;
 	case BPF_LIRC_MODE2:
 		return lirc_prog_query(attr, uattr);
-- 
2.17.1

