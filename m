Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeCLJoR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:44:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37256 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932415AbeCLJnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:33 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 11/13] perf bpf: Add helper header files
Date: Mon, 12 Mar 2018 10:43:11 +0100
Message-Id: <20180312094313.18738-12-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding following header files with defines for kernel
and user space ebpf calls:

  bpf-helpers.h
  bpf-userfuncs.h
  bpf-userapi.h

Link: http://lkml.kernel.org/n/tip-sku9te4ouxg6svjtloh2nwdq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf-helpers.h   | 246 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-userapi.h   |  11 ++
 tools/perf/util/bpf-userfuncs.h |  19 ++++
 3 files changed, 276 insertions(+)
 create mode 100644 tools/perf/util/bpf-helpers.h
 create mode 100644 tools/perf/util/bpf-userapi.h
 create mode 100644 tools/perf/util/bpf-userfuncs.h

diff --git a/tools/perf/util/bpf-helpers.h b/tools/perf/util/bpf-helpers.h
new file mode 100644
index 000000000000..5ec52420e906
--- /dev/null
+++ b/tools/perf/util/bpf-helpers.h
@@ -0,0 +1,246 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __BPF_HELPERS_H
+#define __BPF_HELPERS_H
+
+#include "bpf-userfuncs.h"
+
+/*
+ * helper macro to place programs, maps, license in
+ * different sections in elf_bpf file. Section names
+ * are interpreted by elf_bpf loader
+ */
+#define SEC(NAME) __attribute__((section(NAME), used))
+
+/* helper functions called from eBPF programs written in C */
+static void *(*bpf_map_lookup_elem)(void *map, void *key) =
+	(void *) BPF_FUNC_map_lookup_elem;
+static int (*bpf_map_update_elem)(void *map, void *key, void *value,
+				  unsigned long long flags) =
+	(void *) BPF_FUNC_map_update_elem;
+static int (*bpf_map_delete_elem)(void *map, void *key) =
+	(void *) BPF_FUNC_map_delete_elem;
+static int (*bpf_probe_read)(void *dst, int size, void *unsafe_ptr) =
+	(void *) BPF_FUNC_probe_read;
+static unsigned long long (*bpf_ktime_get_ns)(void) =
+	(void *) BPF_FUNC_ktime_get_ns;
+static int (*bpf_trace_printk)(const char *fmt, int fmt_size, ...) =
+	(void *) BPF_FUNC_trace_printk;
+static void (*bpf_tail_call)(void *ctx, void *map, int index) =
+	(void *) BPF_FUNC_tail_call;
+static unsigned long long (*bpf_get_smp_processor_id)(void) =
+	(void *) BPF_FUNC_get_smp_processor_id;
+static unsigned long long (*bpf_get_current_pid_tgid)(void) =
+	(void *) BPF_FUNC_get_current_pid_tgid;
+static unsigned long long (*bpf_get_current_uid_gid)(void) =
+	(void *) BPF_FUNC_get_current_uid_gid;
+static int (*bpf_get_current_comm)(void *buf, int buf_size) =
+	(void *) BPF_FUNC_get_current_comm;
+static unsigned long long (*bpf_perf_event_read)(void *map,
+						 unsigned long long flags) =
+	(void *) BPF_FUNC_perf_event_read;
+static int (*bpf_clone_redirect)(void *ctx, int ifindex, int flags) =
+	(void *) BPF_FUNC_clone_redirect;
+static int (*bpf_redirect)(int ifindex, int flags) =
+	(void *) BPF_FUNC_redirect;
+static int (*bpf_redirect_map)(void *map, int key, int flags) =
+	(void *) BPF_FUNC_redirect_map;
+static int (*bpf_perf_event_output)(void *ctx, void *map,
+				    unsigned long long flags, void *data,
+				    int size) =
+	(void *) BPF_FUNC_perf_event_output;
+static int (*bpf_get_stackid)(void *ctx, void *map, int flags) =
+	(void *) BPF_FUNC_get_stackid;
+static int (*bpf_probe_write_user)(void *dst, void *src, int size) =
+	(void *) BPF_FUNC_probe_write_user;
+static int (*bpf_current_task_under_cgroup)(void *map, int index) =
+	(void *) BPF_FUNC_current_task_under_cgroup;
+static int (*bpf_skb_get_tunnel_key)(void *ctx, void *key, int size, int flags) =
+	(void *) BPF_FUNC_skb_get_tunnel_key;
+static int (*bpf_skb_set_tunnel_key)(void *ctx, void *key, int size, int flags) =
+	(void *) BPF_FUNC_skb_set_tunnel_key;
+static int (*bpf_skb_get_tunnel_opt)(void *ctx, void *md, int size) =
+	(void *) BPF_FUNC_skb_get_tunnel_opt;
+static int (*bpf_skb_set_tunnel_opt)(void *ctx, void *md, int size) =
+	(void *) BPF_FUNC_skb_set_tunnel_opt;
+static unsigned long long (*bpf_get_prandom_u32)(void) =
+	(void *) BPF_FUNC_get_prandom_u32;
+static int (*bpf_xdp_adjust_head)(void *ctx, int offset) =
+	(void *) BPF_FUNC_xdp_adjust_head;
+static int (*bpf_xdp_adjust_meta)(void *ctx, int offset) =
+	(void *) BPF_FUNC_xdp_adjust_meta;
+static int (*bpf_setsockopt)(void *ctx, int level, int optname, void *optval,
+			     int optlen) =
+	(void *) BPF_FUNC_setsockopt;
+static int (*bpf_getsockopt)(void *ctx, int level, int optname, void *optval,
+			     int optlen) =
+	(void *) BPF_FUNC_getsockopt;
+static int (*bpf_sock_ops_cb_flags_set)(void *ctx, int flags) =
+	(void *) BPF_FUNC_sock_ops_cb_flags_set;
+static int (*bpf_sk_redirect_map)(void *ctx, void *map, int key, int flags) =
+	(void *) BPF_FUNC_sk_redirect_map;
+static int (*bpf_sock_map_update)(void *map, void *key, void *value,
+				  unsigned long long flags) =
+	(void *) BPF_FUNC_sock_map_update;
+static int (*bpf_perf_event_read_value)(void *map, unsigned long long flags,
+					void *buf, unsigned int buf_size) =
+	(void *) BPF_FUNC_perf_event_read_value;
+static int (*bpf_perf_prog_read_value)(void *ctx, void *buf,
+				       unsigned int buf_size) =
+	(void *) BPF_FUNC_perf_prog_read_value;
+static int (*bpf_override_return)(void *ctx, unsigned long rc) =
+	(void *) BPF_FUNC_override_return;
+
+/*
+ * llvm builtin functions that eBPF C program may use to
+ * emit BPF_LD_ABS and BPF_LD_IND instructions
+ */
+struct sk_buff;
+unsigned long long load_byte(void *skb,
+			     unsigned long long off) asm("llvm.bpf.load.byte");
+unsigned long long load_half(void *skb,
+			     unsigned long long off) asm("llvm.bpf.load.half");
+unsigned long long load_word(void *skb,
+			     unsigned long long off) asm("llvm.bpf.load.word");
+
+/*
+ * a helper structure used by eBPF C program
+ * to describe map attributes to elf_bpf loader
+ */
+struct bpf_map_def {
+	unsigned int type;
+	unsigned int key_size;
+	unsigned int value_size;
+	unsigned int max_entries;
+	unsigned int map_flags;
+	unsigned int inner_map_idx;
+	unsigned int numa_node;
+};
+
+static int (*bpf_skb_load_bytes)(void *ctx, int off, void *to, int len) =
+	(void *) BPF_FUNC_skb_load_bytes;
+static int (*bpf_skb_store_bytes)(void *ctx, int off, void *from, int len, int flags) =
+	(void *) BPF_FUNC_skb_store_bytes;
+static int (*bpf_l3_csum_replace)(void *ctx, int off, int from, int to, int flags) =
+	(void *) BPF_FUNC_l3_csum_replace;
+static int (*bpf_l4_csum_replace)(void *ctx, int off, int from, int to, int flags) =
+	(void *) BPF_FUNC_l4_csum_replace;
+static int (*bpf_skb_under_cgroup)(void *ctx, void *map, int index) =
+	(void *) BPF_FUNC_skb_under_cgroup;
+static int (*bpf_skb_change_head)(void *, int len, int flags) =
+	(void *) BPF_FUNC_skb_change_head;
+
+/* Fall back to what the compiler says */
+#ifndef bpf_target_defined
+#if defined(__x86_64__)
+	#define bpf_target_x86
+#elif defined(__s390x__)
+	#define bpf_target_s930x
+#elif defined(__aarch64__)
+	#define bpf_target_arm64
+#elif defined(__mips__)
+	#define bpf_target_mips
+#elif defined(__powerpc__)
+	#define bpf_target_powerpc
+#elif defined(__sparc__)
+	#define bpf_target_sparc
+#endif
+#endif
+
+#if defined(bpf_target_x86)
+
+#define PT_REGS_PARM1(x) ((x)->di)
+#define PT_REGS_PARM2(x) ((x)->si)
+#define PT_REGS_PARM3(x) ((x)->dx)
+#define PT_REGS_PARM4(x) ((x)->cx)
+#define PT_REGS_PARM5(x) ((x)->r8)
+#define PT_REGS_RET(x) ((x)->sp)
+#define PT_REGS_FP(x) ((x)->bp)
+#define PT_REGS_RC(x) ((x)->ax)
+#define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->ip)
+
+#elif defined(bpf_target_s390x)
+
+#define PT_REGS_PARM1(x) ((x)->gprs[2])
+#define PT_REGS_PARM2(x) ((x)->gprs[3])
+#define PT_REGS_PARM3(x) ((x)->gprs[4])
+#define PT_REGS_PARM4(x) ((x)->gprs[5])
+#define PT_REGS_PARM5(x) ((x)->gprs[6])
+#define PT_REGS_RET(x) ((x)->gprs[14])
+#define PT_REGS_FP(x) ((x)->gprs[11]) /* Works only with CONFIG_FRAME_POINTER */
+#define PT_REGS_RC(x) ((x)->gprs[2])
+#define PT_REGS_SP(x) ((x)->gprs[15])
+#define PT_REGS_IP(x) ((x)->psw.addr)
+
+#elif defined(bpf_target_arm64)
+
+#define PT_REGS_PARM1(x) ((x)->regs[0])
+#define PT_REGS_PARM2(x) ((x)->regs[1])
+#define PT_REGS_PARM3(x) ((x)->regs[2])
+#define PT_REGS_PARM4(x) ((x)->regs[3])
+#define PT_REGS_PARM5(x) ((x)->regs[4])
+#define PT_REGS_RET(x) ((x)->regs[30])
+#define PT_REGS_FP(x) ((x)->regs[29]) /* Works only with CONFIG_FRAME_POINTER */
+#define PT_REGS_RC(x) ((x)->regs[0])
+#define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->pc)
+
+#elif defined(bpf_target_mips)
+
+#define PT_REGS_PARM1(x) ((x)->regs[4])
+#define PT_REGS_PARM2(x) ((x)->regs[5])
+#define PT_REGS_PARM3(x) ((x)->regs[6])
+#define PT_REGS_PARM4(x) ((x)->regs[7])
+#define PT_REGS_PARM5(x) ((x)->regs[8])
+#define PT_REGS_RET(x) ((x)->regs[31])
+#define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with CONFIG_FRAME_POINTER */
+#define PT_REGS_RC(x) ((x)->regs[1])
+#define PT_REGS_SP(x) ((x)->regs[29])
+#define PT_REGS_IP(x) ((x)->cp0_epc)
+
+#elif defined(bpf_target_powerpc)
+
+#define PT_REGS_PARM1(x) ((x)->gpr[3])
+#define PT_REGS_PARM2(x) ((x)->gpr[4])
+#define PT_REGS_PARM3(x) ((x)->gpr[5])
+#define PT_REGS_PARM4(x) ((x)->gpr[6])
+#define PT_REGS_PARM5(x) ((x)->gpr[7])
+#define PT_REGS_RC(x) ((x)->gpr[3])
+#define PT_REGS_SP(x) ((x)->sp)
+#define PT_REGS_IP(x) ((x)->nip)
+
+#elif defined(bpf_target_sparc)
+
+#define PT_REGS_PARM1(x) ((x)->u_regs[UREG_I0])
+#define PT_REGS_PARM2(x) ((x)->u_regs[UREG_I1])
+#define PT_REGS_PARM3(x) ((x)->u_regs[UREG_I2])
+#define PT_REGS_PARM4(x) ((x)->u_regs[UREG_I3])
+#define PT_REGS_PARM5(x) ((x)->u_regs[UREG_I4])
+#define PT_REGS_RET(x) ((x)->u_regs[UREG_I7])
+#define PT_REGS_RC(x) ((x)->u_regs[UREG_I0])
+#define PT_REGS_SP(x) ((x)->u_regs[UREG_FP])
+
+/* Should this also be a bpf_target check for the sparc case? */
+#if defined(__arch64__)
+#define PT_REGS_IP(x) ((x)->tpc)
+#else
+#define PT_REGS_IP(x) ((x)->pc)
+#endif
+
+#endif
+
+#ifdef bpf_target_powerpc
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = (ctx)->link; })
+#define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
+#elif bpf_target_sparc
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)		({ (ip) = PT_REGS_RET(ctx); })
+#define BPF_KRETPROBE_READ_RET_IP		BPF_KPROBE_READ_RET_IP
+#else
+#define BPF_KPROBE_READ_RET_IP(ip, ctx)		({				\
+		bpf_probe_read(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
+#define BPF_KRETPROBE_READ_RET_IP(ip, ctx)	({				\
+		bpf_probe_read(&(ip), sizeof(ip),				\
+				(void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+#endif
+
+#endif
diff --git a/tools/perf/util/bpf-userapi.h b/tools/perf/util/bpf-userapi.h
new file mode 100644
index 000000000000..63f2b4c13a5c
--- /dev/null
+++ b/tools/perf/util/bpf-userapi.h
@@ -0,0 +1,11 @@
+#ifndef __BPF_USERAPI_H
+#define __BPF_USERAPI_H
+
+enum {
+	BPF_FUNC_USER_START			= 10000,
+	BPF_FUNC_USER_print			= BPF_FUNC_USER_START,
+	BPF_FUNC_USER_bpf_map_get_next_key,
+	BPF_FUNC_USER_bpf_map_lookup_elem,
+};
+
+#endif /* __BPF_USERFUNCS_H */
diff --git a/tools/perf/util/bpf-userfuncs.h b/tools/perf/util/bpf-userfuncs.h
new file mode 100644
index 000000000000..e920420237ee
--- /dev/null
+++ b/tools/perf/util/bpf-userfuncs.h
@@ -0,0 +1,19 @@
+#ifndef __BPF_USERFUNCS_H
+#define __BPF_USERFUNCS_H
+
+#include <bpf-userapi.h>
+
+static int (*bpfu_print)(const char *fmt, ...) =
+	(void *) BPF_FUNC_USER_print;
+static int (*bpfu_map_get_next_key)(void *map, void *key, void *value) =
+	(void *) BPF_FUNC_USER_bpf_map_get_next_key;
+static int (*bpfu_map_lookup_elem)(void *map, void *key, void *value) =
+	(void *) BPF_FUNC_USER_bpf_map_lookup_elem;
+
+#define print(fmt, ...)                                  \
+({                                                       \
+	char ____fmt[] = fmt;                            \
+	bpfu_print(____fmt, ##__VA_ARGS__);              \
+})
+
+#endif /* __BPF_USERFUNCS_H */
-- 
2.13.6
