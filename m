Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752595AbeCLJnz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:43:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932425AbeCLJng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:36 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 13/13] perf samples: Add syscall-count.c object
Date: Mon, 12 Mar 2018 10:43:13 +0100
Message-Id: <20180312094313.18738-14-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding syscall-count.c sample, that generates
syscall entry calls, like:

  $ perf bpf -c samples/syscall-counts.c
  LLVM: dumping samples/syscall-counts.o

  $ sudo perf bpf -e samples/syscall-counts.o -a
  BEGIN
  ^CEND
                comm            value
             firefox              182
       Socket Thread                8
     InotifyEventThr               26
     xmonad-x86_64-l              405
                perf            45122
     VoiceProcessThr               12
         JS Watchdog               14
     Chrome_~dThread              657
     Softwar~cThread              474
      Gecko_IOThread              489
         stalonetray                8
                mutt              410
                Xorg              956
               xchat               37
           nm-applet               14
        xscreensaver              170
               Timer             1205
      NetworkManager               25
        rtkit-daemon                4
     webrtc_audio_mo               24
         Web Content             6889
     IPDL Background              474
           JS Helper              221
             gkrellm              434
               xterm              528
         InputThread              793

Link: http://lkml.kernel.org/n/tip-9jsy0nnm8khn6e60fmwn4ei7@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/samples/syscall-counts.c | 61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 tools/perf/samples/syscall-counts.c

diff --git a/tools/perf/samples/syscall-counts.c b/tools/perf/samples/syscall-counts.c
new file mode 100644
index 000000000000..e6de6c9fdb85
--- /dev/null
+++ b/tools/perf/samples/syscall-counts.c
@@ -0,0 +1,61 @@
+#include <uapi/linux/bpf.h>
+#include <bpf-helpers.h>
+#include <bpf-userfuncs.h>
+
+#define TASK_COMM_LEN 16
+
+char _license[] SEC("license") = "GPL";
+int _version SEC("version") = LINUX_VERSION_CODE;
+
+struct key_t {
+	char comm[TASK_COMM_LEN];
+};
+
+struct bpf_map_def SEC("maps") counts_map = {
+	.type = BPF_MAP_TYPE_HASH,
+	.key_size = sizeof(struct key_t),
+	.value_size = sizeof(u64),
+	.max_entries = 100,
+};
+
+SEC("raw_syscalls:sys_enter")
+int func(void *ctx)
+{
+	u64 *val, one = 1;
+	struct key_t key;
+	char comm[TASK_COMM_LEN];
+
+	bpf_get_current_comm(&key.comm, sizeof(comm));
+
+	val = bpf_map_lookup_elem(&counts_map, &key);
+	if (val)
+		(*val)++;
+	else
+		bpf_map_update_elem(&counts_map, &key, &one, BPF_NOEXIST);
+
+	return 0;
+}
+
+int BEGIN(void)
+{
+	print("BEGIN\n");
+	return 0;
+}
+
+void END(void)
+{
+	struct key_t key = {}, next_key;
+	u64 value;
+	int i = 0;
+
+	print("END\n");
+	print("\n              comm            value\n");
+
+	while (bpfu_map_get_next_key(&counts_map, &key, &next_key) == 0) {
+                if (bpfu_map_lookup_elem(&counts_map, &next_key, &value))
+			continue;
+
+		print("%18s %16lu\n", next_key.comm, value);
+                key = next_key;
+        }
+}
-- 
2.13.6
