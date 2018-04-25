Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756070AbeDYRlS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 13:41:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755086AbeDYRlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 13:41:11 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 1/3] bpf: Add gpl_compatible flag to struct bpf_prog_info
Date: Wed, 25 Apr 2018 19:41:06 +0200
Message-Id: <20180425174108.6586-2-jolsa@kernel.org>
In-Reply-To: <20180425174108.6586-1-jolsa@kernel.org>
References: <20180425174108.6586-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding gpl_compatible flag to struct bpf_prog_info
so it can be dumped via bpf_prog_get_info_by_fd and
displayed via bpftool progs dump.

Alexei noticed 4-byte hole in struct bpf_prog_info,
so we put the u32 flags field in there, and we can
keep adding bit fields in there without breaking
user space.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h | 1 +
 kernel/bpf/syscall.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index e6679393b687..da8801860c7d 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1060,6 +1060,7 @@ struct bpf_prog_info {
 	__aligned_u64 map_ids;
 	char name[BPF_OBJ_NAME_LEN];
 	__u32 ifindex;
+	__u32 gpl_compatible:1;
 	__u64 netns_dev;
 	__u64 netns_ino;
 } __attribute__((aligned(8)));
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index fe23dc5a3ec4..7bb4ff1c770a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1914,6 +1914,7 @@ static int bpf_prog_get_info_by_fd(struct bpf_prog *prog,
 	info.load_time = prog->aux->load_time;
 	info.created_by_uid = from_kuid_munged(current_user_ns(),
 					       prog->aux->user->uid);
+	info.gpl_compatible = prog->gpl_compatible;
 
 	memcpy(info.tag, prog->tag, sizeof(prog->tag));
 	memcpy(info.name, prog->aux->name, sizeof(prog->aux->name));
-- 
2.13.6
