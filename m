Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B56C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD02020831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD02020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405008AbeKVRrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:47:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389674AbeKVRrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:47:52 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM78rmJ3691449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:08:53 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM78r6w3691446;
        Wed, 21 Nov 2018 23:08:53 -0800
Date:   Wed, 21 Nov 2018 23:08:53 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yjzhak8asumz9e9hts2dgplp@git.kernel.org>
Cc:     yhs@fb.com, mingo@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, daniel@iogearbox.net, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, wangnan0@huawei.com,
        hpa@zytor.com, jolsa@kernel.org, ast@kernel.org,
        ecree@solarflare.com, kafai@fb.com, dsahern@gmail.com
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          ecree@solarflare.com, ast@kernel.org, wangnan0@huawei.com,
          hpa@zytor.com, acme@redhat.com, dsahern@gmail.com, kafai@fb.com,
          mingo@kernel.org, tglx@linutronix.de, yhs@fb.com,
          namhyung@kernel.org, adrian.hunter@intel.com,
          daniel@iogearbox.net
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Reduce the hardcoded .max_entries for
 pid_maps
Git-Commit-ID: 0f7c2de5dd3f5c0ed9603e4ccfb6a3ddc55f46df
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0f7c2de5dd3f5c0ed9603e4ccfb6a3ddc55f46df
Gitweb:     https://git.kernel.org/tip/0f7c2de5dd3f5c0ed9603e4ccfb6a3ddc55f46df
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 7 Nov 2018 14:49:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:32 -0300

perf bpf: Reduce the hardcoded .max_entries for pid_maps

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
