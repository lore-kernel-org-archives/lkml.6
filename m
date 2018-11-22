Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FDF20878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ysXiGzmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FDF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404396AbeKVOOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:34 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BE8D206BA;
        Thu, 22 Nov 2018 03:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857828;
        bh=U0awB4fHjBfs+8DDm+laT1LvfNEfNRTRLJgTTykhNYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ysXiGzmD27Zh/y7iExmodjr2JNnE2D3v3JNMi73B6Dy9F0n0p7dAPviPAi8vyOLQm
         HAIOl7Z5y0tngR7reTmTOUi2ctOWM0C7v8g5aC3qHAXYvXij6/Dbw+OQfsuk/vX1PN
         4E4On2RplKvSyFR/ToKdUzRwB4TDYVRG4Tx2ONNg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Edward Cree <ecree@solarflare.com>,
        Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Yonghong Song <yhs@fb.com>
Subject: [PATCH 15/28] perf bpf: Reduce the hardcoded .max_entries for pid_maps
Date:   Thu, 22 Nov 2018 00:35:58 -0300
Message-Id: <20181122033611.15890-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While working on augmented syscalls I got into this error:

  # trace -vv --filter-pids 2469,1663 -e tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  <SNIP>
  libbpf: map 0 is "__augmented_syscalls__"
  libbpf: map 1 is "__bpf_stdout__"
  libbpf: map 2 is "pids_filtered"
  libbpf: map 3 is "syscalls"
  libbpf: collecting relocating info for: '.text'
  libbpf: relo for 13 value 84 name 133
  libbpf: relocation: insn_idx=3
  libbpf: relocation: find map 3 (pids_filtered) for insn 3
  libbpf: collecting relocating info for: 'raw_syscalls:sys_enter'
  libbpf: relo for 8 value 0 name 0
  libbpf: relocation: insn_idx=1
  libbpf: relo for 8 value 0 name 0
  libbpf: relocation: insn_idx=3
  libbpf: relo for 9 value 28 name 178
  libbpf: relocation: insn_idx=36
  libbpf: relocation: find map 1 (__augmented_syscalls__) for insn 36
  libbpf: collecting relocating info for: 'raw_syscalls:sys_exit'
  libbpf: relo for 8 value 0 name 0
  libbpf: relocation: insn_idx=0
  libbpf: relo for 8 value 0 name 0
  libbpf: relocation: insn_idx=2
  bpf: config program 'raw_syscalls:sys_enter'
  bpf: config program 'raw_syscalls:sys_exit'
  libbpf: create map __bpf_stdout__: fd=3
  libbpf: create map __augmented_syscalls__: fd=4
  libbpf: create map syscalls: fd=5
  libbpf: create map pids_filtered: fd=6
  libbpf: added 13 insn from .text to prog raw_syscalls:sys_enter
  libbpf: added 13 insn from .text to prog raw_syscalls:sys_exit
  libbpf: load bpf program failed: Operation not permitted
  libbpf: failed to load program 'raw_syscalls:sys_exit'
  libbpf: failed to load object 'tools/perf/examples/bpf/augmented_raw_syscalls.c'
  bpf: load objects failed: err=-4009: (Incorrect kernel version)
  event syntax error: 'tools/perf/examples/bpf/augmented_raw_syscalls.c'
                       \___ Failed to load program for unknown reason

  (add -v to see detail)
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events

If I then try to use strace (perf trace'ing 'perf trace' needs some more work
before its possible) to get a bit more info I get:

  # strace -e bpf trace --filter-pids 2469,1663 -e tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=4, map_flags=0, inner_map_fd=0, map_name="__bpf_stdout__", map_ifindex=0}, 72) = 3
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=4, map_flags=0, inner_map_fd=0, map_name="__augmented_sys", map_ifindex=0}, 72) = 4
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=1, max_entries=500, map_flags=0, inner_map_fd=0, map_name="syscalls", map_ifindex=0}, 72) = 5
  bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=1, max_entries=512, map_flags=0, inner_map_fd=0, map_name="pids_filtered", map_ifindex=0}, 72) = 6
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=57, insns=0x1223f50, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(4, 18, 10), prog_flags=0, prog_name="sys_enter", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS}, 72) = 7
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=18, insns=0x1224120, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(4, 18, 10), prog_flags=0, prog_name="sys_exit", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS}, 72) = -1 EPERM (Operation not permitted)
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACEPOINT, insn_cnt=18, insns=0x1224120, license="GPL", log_level=1, log_size=262144, log_buf="", kern_version=KERNEL_VERSION(4, 18, 10), prog_flags=0, prog_name="sys_exit", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS}, 72) = -1 EPERM (Operation not permitted)
  bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_KPROBE, insn_cnt=18, insns=0x1224120, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(4, 18, 10), prog_flags=0, prog_name="sys_exit", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS}, 72) = -1 EPERM (Operation not permitted)
  event syntax error: 'tools/perf/examples/bpf/augmented_raw_syscalls.c'
                       \___ Failed to load program for unknown reason
  <SNIP similar output as without 'strace'>
  #

I managed to create the maps, etc, but then installing the "sys_exit" hook into
the "raw_syscalls:sys_exit" tracepoint somehow gets -EPERMed...

I then go and try reducing the size of this new table:

  +++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
  @@ -47,6 +47,17 @@ struct augmented_filename {
   #define SYS_OPEN 2
   #define SYS_OPENAT 257

  +struct syscall {
  +       bool    filtered;
  +};
  +
  +struct bpf_map SEC("maps") syscalls = {
  +       .type        = BPF_MAP_TYPE_ARRAY,
  +       .key_size    = sizeof(int),
  +       .value_size  = sizeof(struct syscall),
  +       .max_entries = 500,
  +};

And after reducing that .max_entries a tad, it works. So yeah, the "unknown
reason" should be related to the number of bytes all this is taking, reduce the
default for pid_map()s so that we can have a "syscalls" map with enough slots
for all syscalls in most arches. And take notes about this error message,
improve it :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Edward Cree <ecree@solarflare.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-yjzhak8asumz9e9hts2dgplp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/include/bpf/bpf.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/include/bpf/bpf.h b/tools/perf/include/bpf/bpf.h
index 04ecd425a237..bd5d7b4d7760 100644
--- a/tools/perf/include/bpf/bpf.h
+++ b/tools/perf/include/bpf/bpf.h
@@ -18,12 +18,20 @@ struct bpf_map {
         unsigned int numa_node;
 };
 
+/*
+ * FIXME: this should receive .max_entries as a parameter, as careful
+ *	  tuning of these limits is needed to avoid hitting limits that
+ *	  prevents other BPF constructs, such as tracepoint handlers,
+ *	  to get installed, with cryptic messages from libbpf, etc.
+ *	  For the current need, 'perf trace --filter-pids', 64 should
+ *	  be good enough, but this surely needs to be revisited.
+ */
 #define pid_map(name, value_type)		\
 struct bpf_map SEC("maps") name = {		\
 	.type	     = BPF_MAP_TYPE_HASH,	\
 	.key_size    = sizeof(pid_t),		\
 	.value_size  = sizeof(value_type),	\
-	.max_entries = 512,			\
+	.max_entries = 64,			\
 }
 
 static int (*bpf_map_update_elem)(struct bpf_map *map, void *key, void *value, u64 flags) = (void *)BPF_FUNC_map_update_elem;
-- 
2.14.5

