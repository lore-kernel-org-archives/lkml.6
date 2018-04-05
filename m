Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752051AbeDEPRh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34532 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeDEPRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:16 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 9/9] perf tools: The buildid usage in example eBPF program
Date: Thu,  5 Apr 2018 17:16:45 +0200
Message-Id: <20180405151645.19130-10-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bpf-samples/bpf-stdout-example.c demonstrates how to put the
buildid data into eBPF program.

Link: http://lkml.kernel.org/n/tip-dq97ddil7h3qbvphbbo8p08c@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/bpf-samples/bpf-stdout-example.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/perf/bpf-samples/bpf-stdout-example.c

diff --git a/tools/perf/bpf-samples/bpf-stdout-example.c b/tools/perf/bpf-samples/bpf-stdout-example.c
new file mode 100644
index 000000000000..60783442bd5c
--- /dev/null
+++ b/tools/perf/bpf-samples/bpf-stdout-example.c
@@ -0,0 +1,42 @@
+#include <uapi/linux/bpf.h>
+#include <linux/buildid.h>
+
+#define SEC(NAME) __attribute__((section(NAME), used))
+
+char _license[] SEC("license") = "GPL";
+int _version    SEC("version") = LINUX_VERSION_CODE;
+char _buildid[] SEC("buildid") = LINUX_BUILDID_DATA;
+
+static unsigned long long (*bpf_get_smp_processor_id)(void) =
+	(void *) BPF_FUNC_get_smp_processor_id;
+static int (*bpf_perf_event_output)(void *ctx, void *map,
+                                    unsigned long long flags, void *data,
+                                    int size) =
+        (void *) BPF_FUNC_perf_event_output;
+
+struct bpf_map_def {
+        unsigned int type;
+        unsigned int key_size;
+        unsigned int value_size;
+        unsigned int max_entries;
+        unsigned int map_flags;
+        unsigned int inner_map_idx;
+        unsigned int numa_node;
+};
+
+struct bpf_map_def SEC("maps") __bpf_stdout__ = {
+	.type		= BPF_MAP_TYPE_PERF_EVENT_ARRAY,
+	.key_size	= sizeof(int),
+	.value_size	= sizeof(u32),
+	.max_entries	= __NR_CPUS__,
+};
+
+SEC("probe=sys_read")
+int func(void *ctx)
+{
+	char output_str[] = "Raise a BPF event!";
+
+	bpf_perf_event_output(ctx, &__bpf_stdout__, bpf_get_smp_processor_id(),
+			      &output_str, sizeof(output_str));
+	return 0;
+}
-- 
2.13.6
