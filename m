Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE973C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5002084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfAVKWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:22:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfAVKWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:22:39 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0MAM47x2907842
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 22 Jan 2019 02:22:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0MAM4DD2907839;
        Tue, 22 Jan 2019 02:22:04 -0800
Date:   Tue, 22 Jan 2019 02:22:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-7b612e291a5affb12b9d0b87332c71bcbe9c5db4@git.kernel.org>
Cc:     daniel@iogearbox.net, ast@kernel.org, songliubraving@fb.com,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com
Reply-To: ast@kernel.org, songliubraving@fb.com, tglx@linutronix.de,
          daniel@iogearbox.net, hpa@zytor.com, mingo@kernel.org,
          acme@redhat.com, peterz@infradead.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190117161521.1341602-8-songliubraving@fb.com>
References: <20190117161521.1341602-8-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Synthesize PERF_RECORD_* for loaded BPF
 programs
Git-Commit-ID: 7b612e291a5affb12b9d0b87332c71bcbe9c5db4
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

Commit-ID:  7b612e291a5affb12b9d0b87332c71bcbe9c5db4
Gitweb:     https://git.kernel.org/tip/7b612e291a5affb12b9d0b87332c71bcbe9c5db4
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Thu, 17 Jan 2019 08:15:19 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 21 Jan 2019 17:36:39 -0300

perf tools: Synthesize PERF_RECORD_* for loaded BPF programs

This patch synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for
BPF programs loaded before perf-record. This is achieved by gathering
information about all BPF programs via sys_bpf.

Committer notes:

Fix the build on some older systems such as amazonlinux:1 where it was
breaking with:

  util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
  util/bpf-event.c:52:9: error: missing initializer for field 'type' of 'struct bpf_prog_info' [-Werror=missing-field-initializers]
    struct bpf_prog_info info = {};
           ^
  In file included from /git/linux/tools/lib/bpf/bpf.h:26:0,
                   from util/bpf-event.c:3:
  /git/linux/tools/include/uapi/linux/bpf.h:2699:8: note: 'type' declared here
    __u32 type;
          ^
  cc1: all warnings being treated as errors

Further fix on a centos:6 system:

  cc1: warnings being treated as errors
  util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
  util/bpf-event.c:50: error: 'func_info_rec_size' may be used uninitialized in this function

The compiler is wrong, but to silence it, initialize that variable to
zero.

One more fix, this time for debian:experimental-x-mips, x-mips64 and
x-mipsel:

  util/bpf-event.c: In function 'perf_event__synthesize_one_bpf_prog':
  util/bpf-event.c:93:16: error: implicit declaration of function 'calloc' [-Werror=implicit-function-declaration]
     func_infos = calloc(sub_prog_cnt, func_info_rec_size);
                  ^~~~~~
  util/bpf-event.c:93:16: error: incompatible implicit declaration of built-in function 'calloc' [-Werror]
  util/bpf-event.c:93:16: note: include '<stdlib.h>' or provide a declaration of 'calloc'

Add the missing header.

Committer testing:

  # perf record --bpf-event sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.021 MB perf.data (7 samples) ]
  # perf report -D | grep PERF_RECORD_BPF_EVENT | nl
     1	0 0x4b10 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 13
     2	0 0x4c60 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 14
     3	0 0x4db0 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 15
     4	0 0x4f00 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 16
     5	0 0x5050 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 17
     6	0 0x51a0 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 18
     7	0 0x52f0 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 21
     8	0 0x5440 [0x18]: PERF_RECORD_BPF_EVENT bpf event with type 1, flags 0, id 22
  # bpftool prog
  13: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-19T09:09:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
  14: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-19T09:09:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 13,14
  15: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-19T09:09:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
  16: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-19T09:09:43-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 15,16
  17: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-19T09:09:44-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
  18: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-19T09:09:44-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 17,18
  21: cgroup_skb  tag 7be49e3934a125ba  gpl
	loaded_at 2019-01-19T09:09:45-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
  22: cgroup_skb  tag 2a142ef67aaad174  gpl
	loaded_at 2019-01-19T09:09:45-0300  uid 0
	xlated 296B  jited 229B  memlock 4096B  map_ids 21,22
  #

  # perf report -D | grep -B22 PERF_RECORD_KSYMBOL
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 ff 44 06 c0 ff ff ff ff  ......8..D......
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 37 62 65 34 39 65 33 39 33 34 61 31 32 35 62  _7be49e3934a125b
  .  0030:  61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  a...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  7b e4 9e 39 34 a1 25 ba 00 00 00 00 00 00 00 00  {..94.%.........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x49d8 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc00644ff len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 48 6d 06 c0 ff ff ff ff  ......8.Hm......
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 32 61 31 34 32 65 66 36 37 61 61 61 64 31 37  _2a142ef67aaad17
  .  0030:  34 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  4...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  2a 14 2e f6 7a aa d1 74 00 00 00 00 00 00 00 00  *...z..t........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x4b28 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0066d48 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 04 cf 03 c0 ff ff ff ff  ......8.........
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 37 62 65 34 39 65 33 39 33 34 61 31 32 35 62  _7be49e3934a125b
  .  0030:  61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  a...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  7b e4 9e 39 34 a1 25 ba 00 00 00 00 00 00 00 00  {..94.%.........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x4c78 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc003cf04 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 96 28 04 c0 ff ff ff ff  ......8..(......
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 32 61 31 34 32 65 66 36 37 61 61 61 64 31 37  _2a142ef67aaad17
  .  0030:  34 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  4...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  2a 14 2e f6 7a aa d1 74 00 00 00 00 00 00 00 00  *...z..t........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x4dc8 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0042896 len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 05 13 17 c0 ff ff ff ff  ......8.........
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 37 62 65 34 39 65 33 39 33 34 61 31 32 35 62  _7be49e3934a125b
  .  0030:  61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  a...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  7b e4 9e 39 34 a1 25 ba 00 00 00 00 00 00 00 00  {..94.%.........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x4f18 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0171305 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 0a 8c 23 c0 ff ff ff ff  ......8...#.....
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 32 61 31 34 32 65 66 36 37 61 61 61 64 31 37  _2a142ef67aaad17
  .  0030:  34 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  4...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  2a 14 2e f6 7a aa d1 74 00 00 00 00 00 00 00 00  *...z..t........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x5068 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0238c0a len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 2a a5 a4 c0 ff ff ff ff  ......8.*.......
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 37 62 65 34 39 65 33 39 33 34 61 31 32 35 62  _7be49e3934a125b
  .  0030:  61 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  a...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  7b e4 9e 39 34 a1 25 ba 00 00 00 00 00 00 00 00  {..94.%.........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x51b8 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0a4a52a len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
  --
  . ... raw event: size 312 bytes
  .  0000:  11 00 00 00 00 00 38 01 9b c9 a4 c0 ff ff ff ff  ......8.........
  .  0010:  e5 00 00 00 01 00 00 00 62 70 66 5f 70 72 6f 67  ........bpf_prog
  .  0020:  5f 32 61 31 34 32 65 66 36 37 61 61 61 64 31 37  _2a142ef67aaad17
  .  0030:  34 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  4...............
   <SNIP zeroes>
  .  0110:  00 00 00 00 00 00 00 00 21 00 00 00 00 00 00 00  ........!.......
  .  0120:  2a 14 2e f6 7a aa d1 74 00 00 00 00 00 00 00 00  *...z..t........
  .  0130:  00 00 00 00 00 00 00 00                          ........

  0 0x5308 [0x138]: PERF_RECORD_KSYMBOL ksymbol event with addr ffffffffc0a4c99b len 229 type 1 flags 0x0 name bpf_prog_2a142ef67aaad174

Signed-off-by: Song Liu <songliubraving@fb.com>
Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-8-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c |   6 ++
 tools/perf/util/bpf-event.c | 242 ++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/bpf-event.h |  16 +++
 3 files changed, 264 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index deaf9b902094..88ea11d57c6f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -41,6 +41,7 @@
 #include "util/perf-hooks.h"
 #include "util/time-utils.h"
 #include "util/units.h"
+#include "util/bpf-event.h"
 #include "asm/bug.h"
 
 #include <errno.h>
@@ -1082,6 +1083,11 @@ static int record__synthesize(struct record *rec, bool tail)
 		return err;
 	}
 
+	err = perf_event__synthesize_bpf_events(tool, process_synthesized_event,
+						machine, opts);
+	if (err < 0)
+		pr_warning("Couldn't synthesize bpf events.\n");
+
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
 					    1);
diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 87004706874f..01e1dc1bb7fb 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -1,10 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <stdlib.h>
 #include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <linux/btf.h>
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
 
+#define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
+
+static int snprintf_hex(char *buf, size_t size, unsigned char *data, size_t len)
+{
+	int ret = 0;
+	size_t i;
+
+	for (i = 0; i < len; i++)
+		ret += snprintf(buf + ret, size - ret, "%02x", data[i]);
+	return ret;
+}
+
 int machine__process_bpf_event(struct machine *machine __maybe_unused,
 			       union perf_event *event,
 			       struct perf_sample *sample __maybe_unused)
@@ -13,3 +28,230 @@ int machine__process_bpf_event(struct machine *machine __maybe_unused,
 		perf_event__fprintf_bpf_event(event, stdout);
 	return 0;
 }
+
+/*
+ * Synthesize PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT for one bpf
+ * program. One PERF_RECORD_BPF_EVENT is generated for the program. And
+ * one PERF_RECORD_KSYMBOL is generated for each sub program.
+ *
+ * Returns:
+ *    0 for success;
+ *   -1 for failures;
+ *   -2 for lack of kernel support.
+ */
+static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
+					       perf_event__handler_t process,
+					       struct machine *machine,
+					       int fd,
+					       union perf_event *event,
+					       struct record_opts *opts)
+{
+	struct ksymbol_event *ksymbol_event = &event->ksymbol_event;
+	struct bpf_event *bpf_event = &event->bpf_event;
+	u32 sub_prog_cnt, i, func_info_rec_size = 0;
+	u8 (*prog_tags)[BPF_TAG_SIZE] = NULL;
+	struct bpf_prog_info info = { .type = 0, };
+	u32 info_len = sizeof(info);
+	void *func_infos = NULL;
+	u64 *prog_addrs = NULL;
+	struct btf *btf = NULL;
+	u32 *prog_lens = NULL;
+	bool has_btf = false;
+	char errbuf[512];
+	int err = 0;
+
+	/* Call bpf_obj_get_info_by_fd() to get sizes of arrays */
+	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+
+	if (err) {
+		pr_debug("%s: failed to get BPF program info: %s, aborting\n",
+			 __func__, str_error_r(errno, errbuf, sizeof(errbuf)));
+		return -1;
+	}
+	if (info_len < offsetof(struct bpf_prog_info, prog_tags)) {
+		pr_debug("%s: the kernel is too old, aborting\n", __func__);
+		return -2;
+	}
+
+	/* number of ksyms, func_lengths, and tags should match */
+	sub_prog_cnt = info.nr_jited_ksyms;
+	if (sub_prog_cnt != info.nr_prog_tags ||
+	    sub_prog_cnt != info.nr_jited_func_lens)
+		return -1;
+
+	/* check BTF func info support */
+	if (info.btf_id && info.nr_func_info && info.func_info_rec_size) {
+		/* btf func info number should be same as sub_prog_cnt */
+		if (sub_prog_cnt != info.nr_func_info) {
+			pr_debug("%s: mismatch in BPF sub program count and BTF function info count, aborting\n", __func__);
+			return -1;
+		}
+		if (btf__get_from_id(info.btf_id, &btf)) {
+			pr_debug("%s: failed to get BTF of id %u, aborting\n", __func__, info.btf_id);
+			return -1;
+		}
+		func_info_rec_size = info.func_info_rec_size;
+		func_infos = calloc(sub_prog_cnt, func_info_rec_size);
+		if (!func_infos) {
+			pr_debug("%s: failed to allocate memory for func_infos, aborting\n", __func__);
+			return -1;
+		}
+		has_btf = true;
+	}
+
+	/*
+	 * We need address, length, and tag for each sub program.
+	 * Allocate memory and call bpf_obj_get_info_by_fd() again
+	 */
+	prog_addrs = calloc(sub_prog_cnt, sizeof(u64));
+	if (!prog_addrs) {
+		pr_debug("%s: failed to allocate memory for prog_addrs, aborting\n", __func__);
+		goto out;
+	}
+	prog_lens = calloc(sub_prog_cnt, sizeof(u32));
+	if (!prog_lens) {
+		pr_debug("%s: failed to allocate memory for prog_lens, aborting\n", __func__);
+		goto out;
+	}
+	prog_tags = calloc(sub_prog_cnt, BPF_TAG_SIZE);
+	if (!prog_tags) {
+		pr_debug("%s: failed to allocate memory for prog_tags, aborting\n", __func__);
+		goto out;
+	}
+
+	memset(&info, 0, sizeof(info));
+	info.nr_jited_ksyms = sub_prog_cnt;
+	info.nr_jited_func_lens = sub_prog_cnt;
+	info.nr_prog_tags = sub_prog_cnt;
+	info.jited_ksyms = ptr_to_u64(prog_addrs);
+	info.jited_func_lens = ptr_to_u64(prog_lens);
+	info.prog_tags = ptr_to_u64(prog_tags);
+	info_len = sizeof(info);
+	if (has_btf) {
+		info.nr_func_info = sub_prog_cnt;
+		info.func_info_rec_size = func_info_rec_size;
+		info.func_info = ptr_to_u64(func_infos);
+	}
+
+	err = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	if (err) {
+		pr_debug("%s: failed to get BPF program info, aborting\n", __func__);
+		goto out;
+	}
+
+	/* Synthesize PERF_RECORD_KSYMBOL */
+	for (i = 0; i < sub_prog_cnt; i++) {
+		const struct bpf_func_info *finfo;
+		const char *short_name = NULL;
+		const struct btf_type *t;
+		int name_len;
+
+		*ksymbol_event = (struct ksymbol_event){
+			.header = {
+				.type = PERF_RECORD_KSYMBOL,
+				.size = sizeof(struct ksymbol_event),
+			},
+			.addr = prog_addrs[i],
+			.len = prog_lens[i],
+			.ksym_type = PERF_RECORD_KSYMBOL_TYPE_BPF,
+			.flags = 0,
+		};
+		name_len = snprintf(ksymbol_event->name, KSYM_NAME_LEN,
+				    "bpf_prog_");
+		name_len += snprintf_hex(ksymbol_event->name + name_len,
+					 KSYM_NAME_LEN - name_len,
+					 prog_tags[i], BPF_TAG_SIZE);
+		if (has_btf) {
+			finfo = func_infos + i * info.func_info_rec_size;
+			t = btf__type_by_id(btf, finfo->type_id);
+			short_name = btf__name_by_offset(btf, t->name_off);
+		} else if (i == 0 && sub_prog_cnt == 1) {
+			/* no subprog */
+			if (info.name[0])
+				short_name = info.name;
+		} else
+			short_name = "F";
+		if (short_name)
+			name_len += snprintf(ksymbol_event->name + name_len,
+					     KSYM_NAME_LEN - name_len,
+					     "_%s", short_name);
+
+		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
+							 sizeof(u64));
+		err = perf_tool__process_synth_event(tool, event,
+						     machine, process);
+	}
+
+	/* Synthesize PERF_RECORD_BPF_EVENT */
+	if (opts->bpf_event) {
+		*bpf_event = (struct bpf_event){
+			.header = {
+				.type = PERF_RECORD_BPF_EVENT,
+				.size = sizeof(struct bpf_event),
+			},
+			.type = PERF_BPF_EVENT_PROG_LOAD,
+			.flags = 0,
+			.id = info.id,
+		};
+		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		err = perf_tool__process_synth_event(tool, event,
+						     machine, process);
+	}
+
+out:
+	free(prog_tags);
+	free(prog_lens);
+	free(prog_addrs);
+	free(func_infos);
+	free(btf);
+	return err ? -1 : 0;
+}
+
+int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+				      perf_event__handler_t process,
+				      struct machine *machine,
+				      struct record_opts *opts)
+{
+	union perf_event *event;
+	__u32 id = 0;
+	int err;
+	int fd;
+
+	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN);
+	if (!event)
+		return -1;
+	while (true) {
+		err = bpf_prog_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT) {
+				err = 0;
+				break;
+			}
+			pr_debug("%s: can't get next program: %s%s",
+				 __func__, strerror(errno),
+				 errno == EINVAL ? " -- kernel too old?" : "");
+			/* don't report error on old kernel */
+			err = (errno == EINVAL) ? 0 : -1;
+			break;
+		}
+		fd = bpf_prog_get_fd_by_id(id);
+		if (fd < 0) {
+			pr_debug("%s: failed to get fd for prog_id %u\n",
+				 __func__, id);
+			continue;
+		}
+
+		err = perf_event__synthesize_one_bpf_prog(tool, process,
+							  machine, fd,
+							  event, opts);
+		close(fd);
+		if (err) {
+			/* do not return error for old kernel */
+			if (err == -2)
+				err = 0;
+			break;
+		}
+	}
+	free(event);
+	return err;
+}
diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index da0dfc035fc6..7890067e1a37 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -3,14 +3,22 @@
 #define __PERF_BPF_EVENT_H
 
 #include <linux/compiler.h>
+#include "event.h"
 
 struct machine;
 union perf_event;
 struct perf_sample;
+struct perf_tool;
+struct record_opts;
 
 #ifdef HAVE_LIBBPF_SUPPORT
 int machine__process_bpf_event(struct machine *machine, union perf_event *event,
 			       struct perf_sample *sample);
+
+int perf_event__synthesize_bpf_events(struct perf_tool *tool,
+				      perf_event__handler_t process,
+				      struct machine *machine,
+				      struct record_opts *opts);
 #else
 static inline int machine__process_bpf_event(struct machine *machine __maybe_unused,
 					     union perf_event *event __maybe_unused,
@@ -18,5 +26,13 @@ static inline int machine__process_bpf_event(struct machine *machine __maybe_unu
 {
 	return 0;
 }
+
+static inline int perf_event__synthesize_bpf_events(struct perf_tool *tool __maybe_unused,
+						    perf_event__handler_t process __maybe_unused,
+						    struct machine *machine __maybe_unused,
+						    struct record_opts *opts __maybe_unused)
+{
+	return 0;
+}
 #endif // HAVE_LIBBPF_SUPPORT
 #endif
