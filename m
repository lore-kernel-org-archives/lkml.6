Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755326AbeE0L1z (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 07:27:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755142AbeE0L1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 07:27:52 -0400
Date: Sun, 27 May 2018 13:28:42 +0200
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
Subject: [PATCH bpf 1/2] bpf: fix alignment of netns_dev/netns_ino fields in
 bpf_{map,prog}_info
Message-ID: <20180527112842.GA18204@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent introduction of netns_dev/netns_ino to bpf_map_info/bpf_prog info
has broken compat, as offsets of these fields are different in 32-bit
and 64-bit ABIs.  One fix (other than implementing compat support in
syscall in order to handle this discrepancy) is to use __aligned_u64
instead of __u64 for these fields.

Reported-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 52775b33bb507 ("bpf: offload: report device information about
offloaded maps")
Fixes: 675fc275a3a2d ("bpf: offload: report device information for
offloaded programs")

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 include/uapi/linux/bpf.h       | 8 ++++----
 tools/include/uapi/linux/bpf.h | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c5ec897..903010a 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1017,8 +1017,8 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u64 netns_dev;
-	__u64 netns_ino;
+	__aligned_u64 netns_dev;
+	__aligned_u64 netns_ino;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
@@ -1030,8 +1030,8 @@ struct bpf_map_info {
 	__u32 map_flags;
 	char  name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u64 netns_dev;
-	__u64 netns_ino;
+	__aligned_u64 netns_dev;
+	__aligned_u64 netns_ino;
 } __attribute__((aligned(8)));
 
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c5ec897..903010a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1017,8 +1017,8 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u64 netns_dev;
-	__u64 netns_ino;
+	__aligned_u64 netns_dev;
+	__aligned_u64 netns_ino;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
@@ -1030,8 +1030,8 @@ struct bpf_map_info {
 	__u32 map_flags;
 	char  name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
-	__u64 netns_dev;
-	__u64 netns_ino;
+	__aligned_u64 netns_dev;
+	__aligned_u64 netns_ino;
 } __attribute__((aligned(8)));
 
 /* User bpf_sock_addr struct to access socket fields and sockaddr struct passed
-- 
2.1.4
