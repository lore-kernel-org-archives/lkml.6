Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeECEgp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 00:36:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44768 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751940AbeECEgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 00:36:10 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <gregkh@linuxfoundation.org>, <luto@amacapital.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH RFC v2 net-next 3/4] bpfilter: add iptable get/set parsing
Date: Wed, 2 May 2018 21:36:03 -0700
Message-ID: <20180503043604.1604587-4-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180503043604.1604587-1-ast@kernel.org>
References: <20180503043604.1604587-1-ast@kernel.org>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-03_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>

parse iptable binary blobs into bpfilter internal data structures
bpfilter.ko only passing the [gs]etsockopt commands from kernel to umh
All parsing is done inside umh

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/uapi/linux/bpfilter.h | 179 ++++++++++++++++++++++++++++++++++++++++++
 net/bpfilter/Makefile         |   2 +-
 net/bpfilter/bpfilter_mod.h   |  96 ++++++++++++++++++++++
 net/bpfilter/ctor.c           |  80 +++++++++++++++++++
 net/bpfilter/init.c           |  33 ++++++++
 net/bpfilter/main.c           |  51 ++++++++++++
 net/bpfilter/sockopt.c        | 153 ++++++++++++++++++++++++++++++++++++
 net/bpfilter/tables.c         |  70 +++++++++++++++++
 net/bpfilter/targets.c        |  51 ++++++++++++
 net/bpfilter/tgts.c           |  25 ++++++
 10 files changed, 739 insertions(+), 1 deletion(-)
 create mode 100644 net/bpfilter/bpfilter_mod.h
 create mode 100644 net/bpfilter/ctor.c
 create mode 100644 net/bpfilter/init.c
 create mode 100644 net/bpfilter/sockopt.c
 create mode 100644 net/bpfilter/tables.c
 create mode 100644 net/bpfilter/targets.c
 create mode 100644 net/bpfilter/tgts.c

diff --git a/include/uapi/linux/bpfilter.h b/include/uapi/linux/bpfilter.h
index 2ec3cc99ea4c..38d54e9947a1 100644
--- a/include/uapi/linux/bpfilter.h
+++ b/include/uapi/linux/bpfilter.h
@@ -18,4 +18,183 @@ enum {
 	BPFILTER_IPT_GET_MAX,
 };
 
+enum {
+	BPFILTER_XT_TABLE_MAXNAMELEN = 32,
+};
+
+enum {
+	BPFILTER_NF_DROP = 0,
+	BPFILTER_NF_ACCEPT = 1,
+	BPFILTER_NF_STOLEN = 2,
+	BPFILTER_NF_QUEUE = 3,
+	BPFILTER_NF_REPEAT = 4,
+	BPFILTER_NF_STOP = 5,
+	BPFILTER_NF_MAX_VERDICT = BPFILTER_NF_STOP,
+};
+
+enum {
+	BPFILTER_INET_HOOK_PRE_ROUTING	= 0,
+	BPFILTER_INET_HOOK_LOCAL_IN	= 1,
+	BPFILTER_INET_HOOK_FORWARD	= 2,
+	BPFILTER_INET_HOOK_LOCAL_OUT	= 3,
+	BPFILTER_INET_HOOK_POST_ROUTING	= 4,
+	BPFILTER_INET_HOOK_MAX,
+};
+
+enum {
+	BPFILTER_PROTO_UNSPEC	= 0,
+	BPFILTER_PROTO_INET	= 1,
+	BPFILTER_PROTO_IPV4	= 2,
+	BPFILTER_PROTO_ARP	= 3,
+	BPFILTER_PROTO_NETDEV	= 5,
+	BPFILTER_PROTO_BRIDGE	= 7,
+	BPFILTER_PROTO_IPV6	= 10,
+	BPFILTER_PROTO_DECNET	= 12,
+	BPFILTER_PROTO_NUMPROTO,
+};
+
+#ifndef INT_MAX
+#define INT_MAX		((int)(~0U>>1))
+#endif
+#ifndef INT_MIN
+#define INT_MIN         (-INT_MAX - 1)
+#endif
+
+enum {
+	BPFILTER_IP_PRI_FIRST			= INT_MIN,
+	BPFILTER_IP_PRI_CONNTRACK_DEFRAG	= -400,
+	BPFILTER_IP_PRI_RAW			= -300,
+	BPFILTER_IP_PRI_SELINUX_FIRST		= -225,
+	BPFILTER_IP_PRI_CONNTRACK		= -200,
+	BPFILTER_IP_PRI_MANGLE			= -150,
+	BPFILTER_IP_PRI_NAT_DST			= -100,
+	BPFILTER_IP_PRI_FILTER			= 0,
+	BPFILTER_IP_PRI_SECURITY		= 50,
+	BPFILTER_IP_PRI_NAT_SRC			= 100,
+	BPFILTER_IP_PRI_SELINUX_LAST		= 225,
+	BPFILTER_IP_PRI_CONNTRACK_HELPER	= 300,
+	BPFILTER_IP_PRI_CONNTRACK_CONFIRM	= INT_MAX,
+	BPFILTER_IP_PRI_LAST			= INT_MAX,
+};
+
+#define BPFILTER_FUNCTION_MAXNAMELEN	30
+#define BPFILTER_EXTENSION_MAXNAMELEN	29
+#define BPFILTER_TABLE_MAXNAMELEN	32
+
+struct bpfilter_match;
+struct bpfilter_entry_match {
+	union {
+		struct {
+			__u16		match_size;
+			char		name[BPFILTER_EXTENSION_MAXNAMELEN];
+			__u8		revision;
+		} user;
+		struct {
+			__u16			match_size;
+			struct bpfilter_match	*match;
+		} kernel;
+		__u16		match_size;
+	} u;
+	unsigned char	data[0];
+};
+
+struct bpfilter_target;
+struct bpfilter_entry_target {
+	union {
+		struct {
+			__u16		target_size;
+			char		name[BPFILTER_EXTENSION_MAXNAMELEN];
+			__u8		revision;
+		} user;
+		struct {
+			__u16			target_size;
+			struct bpfilter_target	*target;
+		} kernel;
+		__u16		target_size;
+	} u;
+	unsigned char	data[0];
+};
+
+struct bpfilter_standard_target {
+	struct bpfilter_entry_target	target;
+	int				verdict;
+};
+
+struct bpfilter_error_target {
+	struct bpfilter_entry_target	target;
+	char				error_name[BPFILTER_FUNCTION_MAXNAMELEN];
+};
+
+#define __ALIGN_KERNEL(x, a)            __ALIGN_KERNEL_MASK(x, (typeof(x))(a) - 1)
+#define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
+
+#define BPFILTER_ALIGN(__X)	\
+	__ALIGN_KERNEL(__X, __alignof__(__u64))
+
+#define BPFILTER_TARGET_INIT(__name, __size)			\
+{								\
+	.target.u.user = {					\
+		.target_size	= BPFILTER_ALIGN(__size),	\
+		.name		= (__name),			\
+	},							\
+}
+#define BPFILTER_STANDARD_TARGET	""
+#define BPFILTER_ERROR_TARGET		"ERROR"
+
+struct bpfilter_xt_counters {
+	__u64	packet_cnt;
+	__u64	byte_cnt;
+};
+
+struct bpfilter_ipt_ip {
+	__u32	src;
+	__u32	dst;
+	__u32	src_mask;
+	__u32	dst_mask;
+	char	in_iface[IFNAMSIZ];
+	char	out_iface[IFNAMSIZ];
+	__u8	in_iface_mask[IFNAMSIZ];
+	__u8	out_iface_mask[IFNAMSIZ];
+	__u16	protocol;
+	__u8	flags;
+	__u8	inv_flags;
+};
+
+struct bpfilter_ipt_entry {
+	struct bpfilter_ipt_ip		ip;
+	__u32				bfcache;
+	__u16				target_offset;
+	__u16				next_offset;
+	__u32				camefrom;
+	struct bpfilter_xt_counters	cntrs;
+	__u8				elems[0];
+};
+
+struct bpfilter_ipt_get_info {
+	char				name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32				valid_hooks;
+	__u32				hook_entry[BPFILTER_INET_HOOK_MAX];
+	__u32				underflow[BPFILTER_INET_HOOK_MAX];
+	__u32				num_entries;
+	__u32				size;
+};
+
+struct bpfilter_ipt_get_entries {
+	char				name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32				size;
+	struct bpfilter_ipt_entry	entries[0];
+};
+
+struct bpfilter_ipt_replace {
+	char				name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	__u32				valid_hooks;
+	__u32				num_entries;
+	__u32				size;
+	__u32				hook_entry[BPFILTER_INET_HOOK_MAX];
+	__u32				underflow[BPFILTER_INET_HOOK_MAX];
+	__u32				num_counters;
+	struct bpfilter_xt_counters	*cntrs;
+	struct bpfilter_ipt_entry	entries[0];
+};
+
 #endif /* _UAPI_LINUX_BPFILTER_H */
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 897eedae523e..bec6181de995 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -4,7 +4,7 @@
 #
 
 hostprogs-y := bpfilter_umh
-bpfilter_umh-objs := main.o
+bpfilter_umh-objs := main.o tgts.o targets.o tables.o init.o ctor.o sockopt.o
 HOSTCFLAGS += -I. -Itools/include/
 
 # a bit of elf magic to convert bpfilter_umh binary into a binary blob
diff --git a/net/bpfilter/bpfilter_mod.h b/net/bpfilter/bpfilter_mod.h
new file mode 100644
index 000000000000..f0de41b20793
--- /dev/null
+++ b/net/bpfilter/bpfilter_mod.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_BPFILTER_INTERNAL_H
+#define _LINUX_BPFILTER_INTERNAL_H
+
+#include "include/uapi/linux/bpfilter.h"
+#include <linux/list.h>
+
+struct bpfilter_table {
+	struct hlist_node	hash;
+	u32			valid_hooks;
+	struct			bpfilter_table_info *info;
+	int			hold;
+	u8			family;
+	int			priority;
+	const char		name[BPFILTER_XT_TABLE_MAXNAMELEN];
+};
+
+struct bpfilter_table_info {
+	unsigned int		size;
+	u32			num_entries;
+	unsigned int		initial_entries;
+	unsigned int		hook_entry[BPFILTER_INET_HOOK_MAX];
+	unsigned int		underflow[BPFILTER_INET_HOOK_MAX];
+	unsigned int		stacksize;
+	void			***jumpstack;
+	unsigned char		entries[0] __aligned(8);
+};
+
+struct bpfilter_table *bpfilter_table_get_by_name(const char *name, int name_len);
+void bpfilter_table_put(struct bpfilter_table *tbl);
+int bpfilter_table_add(struct bpfilter_table *tbl);
+
+struct bpfilter_ipt_standard {
+	struct bpfilter_ipt_entry	entry;
+	struct bpfilter_standard_target	target;
+};
+
+struct bpfilter_ipt_error {
+	struct bpfilter_ipt_entry	entry;
+	struct bpfilter_error_target	target;
+};
+
+#define BPFILTER_IPT_ENTRY_INIT(__sz) 				\
+{								\
+	.target_offset = sizeof(struct bpfilter_ipt_entry),	\
+	.next_offset = (__sz),					\
+}
+
+#define BPFILTER_IPT_STANDARD_INIT(__verdict) 					\
+{										\
+	.entry = BPFILTER_IPT_ENTRY_INIT(sizeof(struct bpfilter_ipt_standard)),	\
+	.target = BPFILTER_TARGET_INIT(BPFILTER_STANDARD_TARGET,		\
+				       sizeof(struct bpfilter_standard_target)),\
+	.target.verdict = -(__verdict) - 1,					\
+}
+
+#define BPFILTER_IPT_ERROR_INIT							\
+{										\
+	.entry = BPFILTER_IPT_ENTRY_INIT(sizeof(struct bpfilter_ipt_error)),	\
+	.target = BPFILTER_TARGET_INIT(BPFILTER_ERROR_TARGET,			\
+				       sizeof(struct bpfilter_error_target)),	\
+	.target.error_name = "ERROR",						\
+}
+
+struct bpfilter_target {
+	struct list_head	all_target_list;
+	const char		name[BPFILTER_EXTENSION_MAXNAMELEN];
+	unsigned int		size;
+	int			hold;
+	u16			family;
+	u8			rev;
+};
+
+struct bpfilter_target *bpfilter_target_get_by_name(const char *name);
+void bpfilter_target_put(struct bpfilter_target *tgt);
+int bpfilter_target_add(struct bpfilter_target *tgt);
+
+struct bpfilter_table_info *bpfilter_ipv4_table_ctor(struct bpfilter_table *tbl);
+int bpfilter_ipv4_register_targets(void);
+void bpfilter_tables_init(void);
+int bpfilter_get_info(void *addr, int len);
+int bpfilter_get_entries(void *cmd, int len);
+int bpfilter_ipv4_init(void);
+
+int copy_from_user(void *dst, void *addr, int len);
+int copy_to_user(void *addr, const void *src, int len);
+#define put_user(x, ptr) \
+({ \
+	__typeof__(*(ptr)) __x = (x); \
+	copy_to_user(ptr, &__x, sizeof(*(ptr))); \
+})
+extern int pid;
+extern int debug_fd;
+#define ENOTSUPP        524
+
+#endif
diff --git a/net/bpfilter/ctor.c b/net/bpfilter/ctor.c
new file mode 100644
index 000000000000..efb7feef3c42
--- /dev/null
+++ b/net/bpfilter/ctor.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include <linux/bitops.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include "bpfilter_mod.h"
+
+unsigned int __sw_hweight32(unsigned int w)
+{
+	w -= (w >> 1) & 0x55555555;
+	w =  (w & 0x33333333) + ((w >> 2) & 0x33333333);
+	w =  (w + (w >> 4)) & 0x0f0f0f0f;
+	return (w * 0x01010101) >> 24;
+}
+
+struct bpfilter_table_info *bpfilter_ipv4_table_ctor(struct bpfilter_table *tbl)
+{
+	unsigned int num_hooks = hweight32(tbl->valid_hooks);
+	struct bpfilter_ipt_standard *tgts;
+	struct bpfilter_table_info *info;
+	struct bpfilter_ipt_error *term;
+	unsigned int mask, offset, h, i;
+	unsigned int size, alloc_size;
+
+	size  = sizeof(struct bpfilter_ipt_standard) * num_hooks;
+	size += sizeof(struct bpfilter_ipt_error);
+
+	alloc_size = size + sizeof(struct bpfilter_table_info);
+
+	info = malloc(alloc_size);
+	if (!info)
+		return NULL;
+
+	info->num_entries = num_hooks + 1;
+	info->size = size;
+
+	tgts = (struct bpfilter_ipt_standard *) (info + 1);
+	term = (struct bpfilter_ipt_error *) (tgts + num_hooks);
+
+	mask = tbl->valid_hooks;
+	offset = 0;
+	h = 0;
+	i = 0;
+	dprintf(debug_fd, "mask %x num_hooks %d\n", mask, num_hooks);
+	while (mask) {
+		struct bpfilter_ipt_standard *t;
+
+		if (!(mask & 1))
+			goto next;
+
+		info->hook_entry[h] = offset;
+		info->underflow[h] = offset;
+		t = &tgts[i++];
+		*t = (struct bpfilter_ipt_standard)
+			BPFILTER_IPT_STANDARD_INIT(BPFILTER_NF_ACCEPT);
+		t->target.target.u.kernel.target =
+			bpfilter_target_get_by_name(t->target.target.u.user.name);
+		dprintf(debug_fd, "user.name %s\n", t->target.target.u.user.name);
+		if (!t->target.target.u.kernel.target)
+			goto out_fail;
+
+		offset += sizeof(struct bpfilter_ipt_standard);
+	next:
+		mask >>= 1;
+		h++;
+	}
+	*term = (struct bpfilter_ipt_error) BPFILTER_IPT_ERROR_INIT;
+	term->target.target.u.kernel.target =
+		bpfilter_target_get_by_name(term->target.target.u.user.name);
+	dprintf(debug_fd, "user.name %s\n", term->target.target.u.user.name);
+	if (!term->target.target.u.kernel.target)
+		goto out_fail;
+
+	dprintf(debug_fd, "info %p\n", info);
+	return info;
+
+out_fail:
+	free(info);
+	return NULL;
+}
diff --git a/net/bpfilter/init.c b/net/bpfilter/init.c
new file mode 100644
index 000000000000..699f3f623189
--- /dev/null
+++ b/net/bpfilter/init.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include <errno.h>
+#include "bpfilter_mod.h"
+
+static struct bpfilter_table filter_table_ipv4 = {
+	.name		= "filter",
+	.valid_hooks	= ((1<<BPFILTER_INET_HOOK_LOCAL_IN) |
+			   (1<<BPFILTER_INET_HOOK_FORWARD) |
+			   (1<<BPFILTER_INET_HOOK_LOCAL_OUT)),
+	.family		= BPFILTER_PROTO_IPV4,
+	.priority	= BPFILTER_IP_PRI_FILTER,
+};
+
+int bpfilter_ipv4_init(void)
+{
+	struct bpfilter_table *t = &filter_table_ipv4;
+	struct bpfilter_table_info *info;
+	int err;
+
+	err = bpfilter_ipv4_register_targets();
+	if (err)
+		return err;
+
+	info = bpfilter_ipv4_table_ctor(t);
+	if (!info)
+		return -ENOMEM;
+
+	t->info = info;
+
+	return bpfilter_table_add(&filter_table_ipv4);
+}
+
diff --git a/net/bpfilter/main.c b/net/bpfilter/main.c
index 81bbc1684896..e0273ca201ad 100644
--- a/net/bpfilter/main.c
+++ b/net/bpfilter/main.c
@@ -8,13 +8,52 @@
 #include <unistd.h>
 #include "include/uapi/linux/bpf.h"
 #include <asm/unistd.h>
+#include "bpfilter_mod.h"
 #include "msgfmt.h"
 
+extern long int syscall (long int __sysno, ...);
+
+static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
+			  unsigned int size)
+{
+	return syscall(321, cmd, attr, size);
+}
+
+int pid;
 int debug_fd;
 
+int copy_from_user(void *dst, void *addr, int len)
+{
+	struct iovec local;
+	struct iovec remote;
+
+	local.iov_base = dst;
+	local.iov_len = len;
+	remote.iov_base = addr;
+	remote.iov_len = len;
+	return process_vm_readv(pid, &local, 1, &remote, 1, 0) != len;
+}
+
+int copy_to_user(void *addr, const void *src, int len)
+{
+	struct iovec local;
+	struct iovec remote;
+
+	local.iov_base = (void *) src;
+	local.iov_len = len;
+	remote.iov_base = addr;
+	remote.iov_len = len;
+	return process_vm_writev(pid, &local, 1, &remote, 1, 0) != len;
+}
+
 static int handle_get_cmd(struct mbox_request *cmd)
 {
+	pid = cmd->pid;
 	switch (cmd->cmd) {
+	case BPFILTER_IPT_SO_GET_INFO:
+		return bpfilter_get_info((void *)(long)cmd->addr, cmd->len);
+	case BPFILTER_IPT_SO_GET_ENTRIES:
+		return bpfilter_get_entries((void *)(long)cmd->addr, cmd->len);
 	case 0:
 		return 0;
 	default:
@@ -25,11 +64,23 @@ static int handle_get_cmd(struct mbox_request *cmd)
 
 static int handle_set_cmd(struct mbox_request *cmd)
 {
+	pid = cmd->pid;
+	switch (cmd->cmd) {
+	case BPFILTER_IPT_SO_SET_REPLACE:
+		return bpfilter_set_replace((void *)(long)cmd->addr, cmd->len);
+	case BPFILTER_IPT_SO_SET_ADD_COUNTERS:
+		return bpfilter_set_add_counters((void *)(long)cmd->addr, cmd->len);
+	default:
+		break;
+	}
 	return -ENOPROTOOPT;
 }
 
 static void loop(void)
 {
+	bpfilter_tables_init();
+	bpfilter_ipv4_init();
+
 	while (1) {
 		struct mbox_request req;
 		struct mbox_reply reply;
diff --git a/net/bpfilter/sockopt.c b/net/bpfilter/sockopt.c
new file mode 100644
index 000000000000..43687daf51a3
--- /dev/null
+++ b/net/bpfilter/sockopt.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include <errno.h>
+#include <string.h>
+#include <stdio.h>
+#include "bpfilter_mod.h"
+
+static int fetch_name(void *addr, int len, char *name, int name_len)
+{
+	if (copy_from_user(name, addr, name_len))
+		return -EFAULT;
+
+	name[BPFILTER_XT_TABLE_MAXNAMELEN-1] = '\0';
+	return 0;
+}
+
+int bpfilter_get_info(void *addr, int len)
+{
+	char name[BPFILTER_XT_TABLE_MAXNAMELEN];
+	struct bpfilter_ipt_get_info resp;
+	struct bpfilter_table_info *info;
+	struct bpfilter_table *tbl;
+	int err;
+
+	if (len != sizeof(struct bpfilter_ipt_get_info))
+		return -EINVAL;
+
+	err = fetch_name(addr, len, name, sizeof(name));
+	if (err)
+		return err;
+
+	tbl = bpfilter_table_get_by_name(name, strlen(name));
+	if (!tbl)
+		return -ENOENT;
+
+	info = tbl->info;
+	if (!info) {
+		err = -ENOENT;
+		goto out_put;
+	}
+
+	memset(&resp, 0, sizeof(resp));
+	memcpy(resp.name, name, sizeof(resp.name));
+	resp.valid_hooks = tbl->valid_hooks;
+	memcpy(&resp.hook_entry, info->hook_entry, sizeof(resp.hook_entry));
+	memcpy(&resp.underflow, info->underflow, sizeof(resp.underflow));
+	resp.num_entries = info->num_entries;
+	resp.size = info->size;
+
+	err = 0;
+	if (copy_to_user(addr, &resp, len))
+		err = -EFAULT;
+out_put:
+	bpfilter_table_put(tbl);
+	return err;
+}
+
+static int copy_target(struct bpfilter_standard_target *ut,
+		       struct bpfilter_standard_target *kt)
+{
+	struct bpfilter_target *tgt;
+	int sz;
+
+
+	if (put_user(kt->target.u.target_size,
+		     &ut->target.u.target_size))
+		return -EFAULT;
+
+	tgt = kt->target.u.kernel.target;
+	if (copy_to_user(ut->target.u.user.name, tgt->name, strlen(tgt->name)))
+		return -EFAULT;
+
+	if (put_user(tgt->rev, &ut->target.u.user.revision))
+		return -EFAULT;
+
+	sz = tgt->size;
+	if (copy_to_user(ut->target.data, kt->target.data, sz))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int do_get_entries(void *up,
+			  struct bpfilter_table *tbl,
+			  struct bpfilter_table_info *info)
+{
+	unsigned int total_size = info->size;
+	const struct bpfilter_ipt_entry *ent;
+	unsigned int off;
+	void *base;
+
+	base = info->entries;
+
+	for (off = 0; off < total_size; off += ent->next_offset) {
+		struct bpfilter_xt_counters *cntrs;
+		struct bpfilter_standard_target *tgt;
+
+		ent = base + off;
+		if (copy_to_user(up + off, ent, sizeof(*ent)))
+			return -EFAULT;
+
+		/* XXX Just clear counters for now. XXX */
+		cntrs = up + off + offsetof(struct bpfilter_ipt_entry, cntrs);
+		if (put_user(0, &cntrs->packet_cnt) ||
+		    put_user(0, &cntrs->byte_cnt))
+			return -EINVAL;
+
+		tgt = (void *) ent + ent->target_offset;
+		dprintf(debug_fd, "target.verdict %d\n", tgt->verdict);
+		if (copy_target(up + off + ent->target_offset, tgt))
+			return -EFAULT;
+	}
+	return 0;
+}
+
+int bpfilter_get_entries(void *cmd, int len)
+{
+	struct bpfilter_ipt_get_entries *uptr = cmd;
+	struct bpfilter_ipt_get_entries req;
+	struct bpfilter_table_info *info;
+	struct bpfilter_table *tbl;
+	int err;
+
+	if (len < sizeof(struct bpfilter_ipt_get_entries))
+		return -EINVAL;
+
+	if (copy_from_user(&req, cmd, sizeof(req)))
+		return -EFAULT;
+
+	tbl = bpfilter_table_get_by_name(req.name, strlen(req.name));
+	if (!tbl)
+		return -ENOENT;
+
+	info = tbl->info;
+	if (!info) {
+		err = -ENOENT;
+		goto out_put;
+	}
+
+	if (info->size != req.size) {
+		err = -EINVAL;
+		goto out_put;
+	}
+
+	err = do_get_entries(uptr->entries, tbl, info);
+	dprintf(debug_fd, "do_get_entries %d req.size %d\n", err, req.size);
+
+out_put:
+	bpfilter_table_put(tbl);
+
+	return err;
+}
+
diff --git a/net/bpfilter/tables.c b/net/bpfilter/tables.c
new file mode 100644
index 000000000000..9a96599be634
--- /dev/null
+++ b/net/bpfilter/tables.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include <errno.h>
+#include <string.h>
+#include <linux/hashtable.h>
+#include "bpfilter_mod.h"
+
+static unsigned int full_name_hash(const void *salt, const char *name, unsigned int len)
+{
+	unsigned int hash = 0;
+	int i;
+
+	for (i = 0; i < len; i++)
+		hash ^= *(name + i);
+	return hash;
+}
+
+DEFINE_HASHTABLE(bpfilter_tables, 4);
+//DEFINE_MUTEX(bpfilter_table_mutex);
+
+struct bpfilter_table *bpfilter_table_get_by_name(const char *name, int name_len)
+{
+	unsigned int hval = full_name_hash(NULL, name, name_len);
+	struct bpfilter_table *tbl;
+
+//	mutex_lock(&bpfilter_table_mutex);
+	hash_for_each_possible(bpfilter_tables, tbl, hash, hval) {
+		if (!strcmp(name, tbl->name)) {
+			tbl->hold++;
+			goto out;
+		}
+	}
+	tbl = NULL;
+out:
+//	mutex_unlock(&bpfilter_table_mutex);
+	return tbl;
+}
+
+void bpfilter_table_put(struct bpfilter_table *tbl)
+{
+//	mutex_lock(&bpfilter_table_mutex);
+	tbl->hold--;
+//	mutex_unlock(&bpfilter_table_mutex);
+}
+
+int bpfilter_table_add(struct bpfilter_table *tbl)
+{
+	unsigned int hval = full_name_hash(NULL, tbl->name, strlen(tbl->name));
+	struct bpfilter_table *srch;
+
+//	mutex_lock(&bpfilter_table_mutex);
+	hash_for_each_possible(bpfilter_tables, srch, hash, hval) {
+		if (!strcmp(srch->name, tbl->name))
+			goto exists;
+	}
+	hash_add(bpfilter_tables, &tbl->hash, hval);
+//	mutex_unlock(&bpfilter_table_mutex);
+
+	return 0;
+
+exists:
+//	mutex_unlock(&bpfilter_table_mutex);
+	return -EEXIST;
+}
+
+void bpfilter_tables_init(void)
+{
+	hash_init(bpfilter_tables);
+}
+
diff --git a/net/bpfilter/targets.c b/net/bpfilter/targets.c
new file mode 100644
index 000000000000..4086ac82eaf5
--- /dev/null
+++ b/net/bpfilter/targets.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include <errno.h>
+#include <string.h>
+#include "bpfilter_mod.h"
+
+//DEFINE_MUTEX(bpfilter_target_mutex);
+static LIST_HEAD(bpfilter_targets);
+
+struct bpfilter_target *bpfilter_target_get_by_name(const char *name)
+{
+	struct bpfilter_target *tgt;
+
+//	mutex_lock(&bpfilter_target_mutex);
+	list_for_each_entry(tgt, &bpfilter_targets, all_target_list) {
+		if (!strcmp(tgt->name, name)) {
+			tgt->hold++;
+			goto out;
+		}
+	}
+	tgt = NULL;
+out:
+//	mutex_unlock(&bpfilter_target_mutex);
+	return tgt;
+}
+
+void bpfilter_target_put(struct bpfilter_target *tgt)
+{
+//	mutex_lock(&bpfilter_target_mutex);
+	tgt->hold--;
+//	mutex_unlock(&bpfilter_target_mutex);
+}
+
+int bpfilter_target_add(struct bpfilter_target *tgt)
+{
+	struct bpfilter_target *srch;
+
+//	mutex_lock(&bpfilter_target_mutex);
+	list_for_each_entry(srch, &bpfilter_targets, all_target_list) {
+		if (!strcmp(srch->name, tgt->name))
+			goto exists;
+	}
+	list_add_tail(&tgt->all_target_list, &bpfilter_targets);
+//	mutex_unlock(&bpfilter_target_mutex);
+	return 0;
+
+exists:
+//	mutex_unlock(&bpfilter_target_mutex);
+	return -EEXIST;
+}
+
diff --git a/net/bpfilter/tgts.c b/net/bpfilter/tgts.c
new file mode 100644
index 000000000000..eac5e8ac0b4b
--- /dev/null
+++ b/net/bpfilter/tgts.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <sys/socket.h>
+#include "bpfilter_mod.h"
+
+struct bpfilter_target std_tgt = {
+	.name = BPFILTER_STANDARD_TARGET,
+	.family = BPFILTER_PROTO_IPV4,
+	.size = sizeof(int),
+};
+
+struct bpfilter_target err_tgt = {
+	.name = BPFILTER_ERROR_TARGET,
+	.family = BPFILTER_PROTO_IPV4,
+	.size = BPFILTER_FUNCTION_MAXNAMELEN,
+};
+
+int bpfilter_ipv4_register_targets(void)
+{
+	int err = bpfilter_target_add(&std_tgt);
+
+	if (err)
+		return err;
+	return bpfilter_target_add(&err_tgt);
+}
+
-- 
2.9.5
