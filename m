Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755351AbeE0L2A (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 07:28:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755142AbeE0L16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 07:27:58 -0400
Date: Sun, 27 May 2018 13:28:47 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Lawrence Brakmo <brakmo@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH bpf 2/2] bpf: enforce usage of __aligned_u64 in the UAPI
 header
Message-ID: <20180527112847.GA18311@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use __aligned_u64 instead of __u64 everywhere in the UAPI header,
similarly to v4.17-rc1~94^2~58^2 "RDMA: Change all uapi headers to use
__aligned_u64 instead of __u64".

This commit doesn't change structure layouts, but imposes additional
alignment requirements on struct bpf_stack_build_id, struct
bpf_sock_ops, struct bpf_perf_event_value, and struct
bpf_raw_tracepoint_args; of them only struct bpf_sock_ops and struct
bpf_perf_event_value have 64-bit fields that were present in a released
kernel without this additional alignment requirement (bytes_received
and bytes_acked were added to struct bpf_sock_ops in commit
v4.16-rc1~123^2~33^2~5^2~4, struct bpf_perf_event_value was added
in commit v4.15-rc1~84^2~532^2~3).

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/bpf.h       | 22 +++++++++++-----------
 tools/include/uapi/linux/bpf.h | 22 +++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 903010a..174e99a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -259,8 +259,8 @@ struct bpf_stack_build_id {
 	__s32		status;
 	unsigned char	build_id[BPF_BUILD_ID_SIZE];
 	union {
-		__u64	offset;
-		__u64	ip;
+		__aligned_u64	offset;
+		__aligned_u64	ip;
 	};
 };
 
@@ -288,7 +288,7 @@ union bpf_attr {
 			__aligned_u64 value;
 			__aligned_u64 next_key;
 		};
-		__u64		flags;
+		__aligned_u64	flags;
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
@@ -360,7 +360,7 @@ union bpf_attr {
 	} query;
 
 	struct {
-		__u64 name;
+		__aligned_u64 name;
 		__u32 prog_fd;
 	} raw_tracepoint;
 } __attribute__((aligned(8)));
@@ -1011,7 +1011,7 @@ struct bpf_prog_info {
 	__u32 xlated_prog_len;
 	__aligned_u64 jited_prog_insns;
 	__aligned_u64 xlated_prog_insns;
-	__u64 load_time;	/* ns since boottime */
+	__aligned_u64 load_time;	/* ns since boottime */
 	__u32 created_by_uid;
 	__u32 nr_map_ids;
 	__aligned_u64 map_ids;
@@ -1101,8 +1101,8 @@ struct bpf_sock_ops {
 	__u32 lost_out;
 	__u32 sacked_out;
 	__u32 sk_txhash;
-	__u64 bytes_received;
-	__u64 bytes_acked;
+	__aligned_u64 bytes_received;
+	__aligned_u64 bytes_acked;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
@@ -1189,9 +1189,9 @@ enum {
 #define TCP_BPF_SNDCWND_CLAMP	1002	/* Set sndcwnd_clamp */
 
 struct bpf_perf_event_value {
-	__u64 counter;
-	__u64 enabled;
-	__u64 running;
+	__aligned_u64 counter;
+	__aligned_u64 enabled;
+	__aligned_u64 running;
 };
 
 #define BPF_DEVCG_ACC_MKNOD	(1ULL << 0)
@@ -1209,7 +1209,7 @@ struct bpf_cgroup_dev_ctx {
 };
 
 struct bpf_raw_tracepoint_args {
-	__u64 args[0];
+	__aligned_u64 args[0];
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 903010a..174e99a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -259,8 +259,8 @@ struct bpf_stack_build_id {
 	__s32		status;
 	unsigned char	build_id[BPF_BUILD_ID_SIZE];
 	union {
-		__u64	offset;
-		__u64	ip;
+		__aligned_u64	offset;
+		__aligned_u64	ip;
 	};
 };
 
@@ -288,7 +288,7 @@ union bpf_attr {
 			__aligned_u64 value;
 			__aligned_u64 next_key;
 		};
-		__u64		flags;
+		__aligned_u64	flags;
 	};
 
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
@@ -360,7 +360,7 @@ union bpf_attr {
 	} query;
 
 	struct {
-		__u64 name;
+		__aligned_u64 name;
 		__u32 prog_fd;
 	} raw_tracepoint;
 } __attribute__((aligned(8)));
@@ -1011,7 +1011,7 @@ struct bpf_prog_info {
 	__u32 xlated_prog_len;
 	__aligned_u64 jited_prog_insns;
 	__aligned_u64 xlated_prog_insns;
-	__u64 load_time;	/* ns since boottime */
+	__aligned_u64 load_time;	/* ns since boottime */
 	__u32 created_by_uid;
 	__u32 nr_map_ids;
 	__aligned_u64 map_ids;
@@ -1101,8 +1101,8 @@ struct bpf_sock_ops {
 	__u32 lost_out;
 	__u32 sacked_out;
 	__u32 sk_txhash;
-	__u64 bytes_received;
-	__u64 bytes_acked;
+	__aligned_u64 bytes_received;
+	__aligned_u64 bytes_acked;
 };
 
 /* Definitions for bpf_sock_ops_cb_flags */
@@ -1189,9 +1189,9 @@ enum {
 #define TCP_BPF_SNDCWND_CLAMP	1002	/* Set sndcwnd_clamp */
 
 struct bpf_perf_event_value {
-	__u64 counter;
-	__u64 enabled;
-	__u64 running;
+	__aligned_u64 counter;
+	__aligned_u64 enabled;
+	__aligned_u64 running;
 };
 
 #define BPF_DEVCG_ACC_MKNOD	(1ULL << 0)
@@ -1209,7 +1209,7 @@ struct bpf_cgroup_dev_ctx {
 };
 
 struct bpf_raw_tracepoint_args {
-	__u64 args[0];
+	__aligned_u64 args[0];
 };
 
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.1.4
