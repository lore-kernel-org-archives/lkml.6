Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984F5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504BB21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfBSUBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:01:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:8764 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfBSUBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:01:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918118"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:01:02 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 09/10] perf header: Add die information in cpu topology
Date:   Tue, 19 Feb 2019 12:00:10 -0800
Message-Id: <1550606411-5313-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With the new CPUID.1F, a new level type of processor topology, 'die', is
introduced. The 'die' information in cpu topology should be added in
perf header.

To be compatible with old perf.data, the patch checks the section size
before reading the die information. It never reads data crossing the
section boundary.
Because the new info is added at the end of the cpu_topology section,
the old perf tool ignores the extra data.

The new perf tool with the patch may be used on legacy kernel. Add a
new function check_x86_die_exists() to check if die topology
information is supported by kernel. The function only check X86 and
CPU 0. Assuming other CPUs have same topology.

A similar way for core and socket is used to support die id and sibling
dies string.

Add a new function in cpumap.c to fetch die id information.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf.data-file-format.txt |   9 +-
 tools/perf/util/cpumap.c                           |   7 +
 tools/perf/util/cpumap.h                           |   1 +
 tools/perf/util/env.c                              |   1 +
 tools/perf/util/env.h                              |   3 +
 tools/perf/util/header.c                           | 185 +++++++++++++++++++--
 6 files changed, 187 insertions(+), 19 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index dfb218f..d2ec58d 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -154,7 +154,7 @@ struct {
 
 String lists defining the core and CPU threads topology.
 The string lists are followed by a variable length array
-which contains core_id and socket_id of each cpu.
+which contains core_id, die_id (for x86) and socket_id of each cpu.
 The number of entries can be determined by the size of the
 section minus the sizes of both string lists.
 
@@ -163,14 +163,19 @@ struct {
        struct perf_header_string_list threads; /* Variable length */
        struct {
 	      uint32_t core_id;
+	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
 };
 
 Example:
-	sibling cores   : 0-3
+	sibling cores   : 0-8
+	sibling dies	: 0-3
+	sibling dies	: 4-7
 	sibling threads : 0-1
 	sibling threads : 2-3
+	sibling threads : 4-5
+	sibling threads : 6-7
 
 	HEADER_NUMA_TOPOLOGY = 14,
 
diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 383674f..b84fcd4 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -373,6 +373,13 @@ int cpu_map__build_map(struct cpu_map *cpus, struct cpu_map **res,
 	return 0;
 }
 
+int cpu_map__get_die_id(int cpu)
+{
+	int value, ret = cpu__get_topology_int(cpu, "die_id", &value);
+
+	return ret ?: value;
+}
+
 int cpu_map__get_core_id(int cpu)
 {
 	int value, ret = cpu__get_topology_int(cpu, "core_id", &value);
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index ed8999d..4d66f67 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -25,6 +25,7 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size);
 size_t cpu_map__fprintf(struct cpu_map *map, FILE *fp);
 int cpu_map__get_socket_id(int cpu);
 int cpu_map__get_socket(struct cpu_map *map, int idx, void *data);
+int cpu_map__get_die_id(int cpu);
 int cpu_map__get_core_id(int cpu);
 int cpu_map__get_core(struct cpu_map *map, int idx, void *data);
 int cpu_map__build_socket_map(struct cpu_map *cpus, struct cpu_map **sockp);
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 4c23779..4d576e5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -87,6 +87,7 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	for (cpu = 0; cpu < nr_cpus; ++cpu) {
 		env->cpu[cpu].core_id	= cpu_map__get_core_id(cpu);
 		env->cpu[cpu].socket_id	= cpu_map__get_socket_id(cpu);
+		env->cpu[cpu].die_id	= cpu_map__get_die_id(cpu);
 	}
 
 	env->nr_cpus_avail = nr_cpus;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355..b6e6741 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -7,6 +7,7 @@
 
 struct cpu_topology_map {
 	int	socket_id;
+	int	die_id;
 	int	core_id;
 };
 
@@ -47,6 +48,7 @@ struct perf_env {
 
 	int			nr_cmdline;
 	int			nr_sibling_cores;
+	int			nr_sibling_dies;
 	int			nr_sibling_threads;
 	int			nr_numa_nodes;
 	int			nr_memory_nodes;
@@ -55,6 +57,7 @@ struct perf_env {
 	char			*cmdline;
 	const char		**cmdline_argv;
 	char			*sibling_cores;
+	char			*sibling_dies;
 	char			*sibling_threads;
 	char			*pmu_mappings;
 	struct cpu_topology_map	*cpu;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index dec6d21..11637ca 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -557,20 +557,43 @@ static int write_cmdline(struct feat_fd *ff,
 	return 0;
 }
 
+#define DIE_SIBLINGS_LIST \
+	"/sys/devices/system/cpu/cpu0/topology/die_siblings_list"
+
+static bool check_x86_die_exists(void)
+{
+	struct utsname uts;
+
+	if (uname(&uts) < 0)
+		return false;
+
+	if (strncmp(uts.machine, "x86_64", 6))
+		return false;
+
+	if (access(DIE_SIBLINGS_LIST, F_OK) == -1)
+		return false;
+
+	return true;
+}
+
 #define CORE_SIB_FMT \
 	"/sys/devices/system/cpu/cpu%d/topology/core_siblings_list"
+#define DIE_SIB_FMT \
+	"/sys/devices/system/cpu/cpu%d/topology/die_siblings_list"
 #define THRD_SIB_FMT \
 	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 
 struct cpu_topo {
 	u32 cpu_nr;
 	u32 core_sib;
+	u32 die_sib;
 	u32 thread_sib;
 	char **core_siblings;
+	char **die_siblings;
 	char **thread_siblings;
 };
 
-static int build_cpu_topo(struct cpu_topo *tp, int cpu)
+static int build_cpu_topo(struct cpu_topo *tp, int cpu, bool has_die)
 {
 	FILE *fp;
 	char filename[MAXPATHLEN];
@@ -583,12 +606,12 @@ static int build_cpu_topo(struct cpu_topo *tp, int cpu)
 	sprintf(filename, CORE_SIB_FMT, cpu);
 	fp = fopen(filename, "r");
 	if (!fp)
-		goto try_threads;
+		goto try_dies;
 
 	sret = getline(&buf, &len, fp);
 	fclose(fp);
 	if (sret <= 0)
-		goto try_threads;
+		goto try_dies;
 
 	p = strchr(buf, '\n');
 	if (p)
@@ -606,6 +629,34 @@ static int build_cpu_topo(struct cpu_topo *tp, int cpu)
 	}
 	ret = 0;
 
+try_dies:
+	if (has_die) {
+		sprintf(filename, DIE_SIB_FMT, cpu);
+		fp = fopen(filename, "r");
+		if (!fp)
+			goto try_threads;
+
+		sret = getline(&buf, &len, fp);
+		fclose(fp);
+		if (sret <= 0)
+			goto try_threads;
+
+		p = strchr(buf, '\n');
+		if (p)
+			*p = '\0';
+
+		for (i = 0; i < tp->die_sib; i++) {
+			if (!strcmp(buf, tp->die_siblings[i]))
+				break;
+		}
+		if (i == tp->die_sib) {
+			tp->die_siblings[i] = buf;
+			tp->die_sib++;
+			buf = NULL;
+			len = 0;
+		}
+		ret = 0;
+	}
 try_threads:
 	sprintf(filename, THRD_SIB_FMT, cpu);
 	fp = fopen(filename, "r");
@@ -636,7 +687,7 @@ static int build_cpu_topo(struct cpu_topo *tp, int cpu)
 	return ret;
 }
 
-static void free_cpu_topo(struct cpu_topo *tp)
+static void free_cpu_topo(struct cpu_topo *tp, bool has_die)
 {
 	u32 i;
 
@@ -646,17 +697,22 @@ static void free_cpu_topo(struct cpu_topo *tp)
 	for (i = 0 ; i < tp->core_sib; i++)
 		zfree(&tp->core_siblings[i]);
 
+	if (has_die) {
+		for (i = 0 ; i < tp->die_sib; i++)
+			zfree(&tp->die_siblings[i]);
+	}
+
 	for (i = 0 ; i < tp->thread_sib; i++)
 		zfree(&tp->thread_siblings[i]);
 
 	free(tp);
 }
 
-static struct cpu_topo *build_cpu_topology(void)
+static struct cpu_topo *build_cpu_topology(bool has_die)
 {
 	struct cpu_topo *tp = NULL;
 	void *addr;
-	u32 nr, i;
+	u32 nr, i, nr_addr;
 	size_t sz;
 	long ncpus;
 	int ret = -1;
@@ -674,7 +730,11 @@ static struct cpu_topo *build_cpu_topology(void)
 	nr = (u32)(ncpus & UINT_MAX);
 
 	sz = nr * sizeof(char *);
-	addr = calloc(1, sizeof(*tp) + 2 * sz);
+	if (has_die)
+		nr_addr = 3;
+	else
+		nr_addr = 2;
+	addr = calloc(1, sizeof(*tp) + nr_addr * sz);
 	if (!addr)
 		goto out_free;
 
@@ -683,13 +743,17 @@ static struct cpu_topo *build_cpu_topology(void)
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
+	if (has_die) {
+		tp->die_siblings = addr;
+		addr += sz;
+	}
 	tp->thread_siblings = addr;
 
 	for (i = 0; i < nr; i++) {
 		if (!cpu_map__has(map, i))
 			continue;
 
-		ret = build_cpu_topo(tp, i);
+		ret = build_cpu_topo(tp, i, has_die);
 		if (ret < 0)
 			break;
 	}
@@ -697,7 +761,7 @@ static struct cpu_topo *build_cpu_topology(void)
 out_free:
 	cpu_map__put(map);
 	if (ret) {
-		free_cpu_topo(tp);
+		free_cpu_topo(tp, has_die);
 		tp = NULL;
 	}
 	return tp;
@@ -709,8 +773,11 @@ static int write_cpu_topology(struct feat_fd *ff,
 	struct cpu_topo *tp;
 	u32 i;
 	int ret, j;
+	bool has_die;
+
+	has_die = check_x86_die_exists();
 
-	tp = build_cpu_topology();
+	tp = build_cpu_topology(has_die);
 	if (!tp)
 		return -1;
 
@@ -747,8 +814,28 @@ static int write_cpu_topology(struct feat_fd *ff,
 		if (ret < 0)
 			return ret;
 	}
+
+	if (!has_die)
+		goto done;
+
+	ret = do_write(ff, &tp->die_sib, sizeof(tp->die_sib));
+	if (ret < 0)
+		goto done;
+
+	for (i = 0; i < tp->die_sib; i++) {
+		ret = do_write_string(ff, tp->die_siblings[i]);
+		if (ret < 0)
+			goto done;
+	}
+
+	for (j = 0; j < perf_env.nr_cpus_avail; j++) {
+		ret = do_write(ff, &perf_env.cpu[j].die_id,
+			       sizeof(perf_env.cpu[j].die_id));
+		if (ret < 0)
+			return ret;
+	}
 done:
-	free_cpu_topo(tp);
+	free_cpu_topo(tp, has_die);
 	return ret;
 }
 
@@ -1523,6 +1610,8 @@ static void print_cmdline(struct feat_fd *ff, FILE *fp)
 	fputc('\n', fp);
 }
 
+static bool has_die;
+
 static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 {
 	struct perf_header *ph = ff->ph;
@@ -1538,6 +1627,16 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 		str += strlen(str) + 1;
 	}
 
+	if (has_die) {
+		nr = ph->env.nr_sibling_dies;
+		str = ph->env.sibling_dies;
+
+		for (i = 0; i < nr; i++) {
+			fprintf(fp, "# sibling dies   : %s\n", str);
+			str += strlen(str) + 1;
+		}
+	}
+
 	nr = ph->env.nr_sibling_threads;
 	str = ph->env.sibling_threads;
 
@@ -1546,12 +1645,28 @@ static void print_cpu_topology(struct feat_fd *ff, FILE *fp)
 		str += strlen(str) + 1;
 	}
 
-	if (ph->env.cpu != NULL) {
-		for (i = 0; i < cpu_nr; i++)
-			fprintf(fp, "# CPU %d: Core ID %d, Socket ID %d\n", i,
-				ph->env.cpu[i].core_id, ph->env.cpu[i].socket_id);
-	} else
-		fprintf(fp, "# Core ID and Socket ID information is not available\n");
+	if (has_die) {
+		if (ph->env.cpu != NULL) {
+			for (i = 0; i < cpu_nr; i++)
+				fprintf(fp, "# CPU %d: Core ID %d, "
+					    "Die ID %d, Socket ID %d\n",
+					    i, ph->env.cpu[i].core_id,
+					    ph->env.cpu[i].die_id,
+					    ph->env.cpu[i].socket_id);
+		} else
+			fprintf(fp, "# Core ID, Die ID and Socket ID "
+				    "information is not available\n");
+	} else {
+		if (ph->env.cpu != NULL) {
+			for (i = 0; i < cpu_nr; i++)
+				fprintf(fp, "# CPU %d: Core ID %d, "
+					    "Socket ID %d\n",
+					    i, ph->env.cpu[i].core_id,
+					    ph->env.cpu[i].socket_id);
+		} else
+			fprintf(fp, "# Core ID and Socket ID "
+				    "information is not available\n");
+	}
 }
 
 static void print_clockid(struct feat_fd *ff, FILE *fp)
@@ -2245,6 +2360,7 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 			goto free_cpu;
 
 		ph->env.cpu[i].core_id = nr;
+		size += sizeof(u32);
 
 		if (do_read_u32(ff, &nr))
 			goto free_cpu;
@@ -2256,7 +2372,42 @@ static int process_cpu_topology(struct feat_fd *ff, void *data __maybe_unused)
 		}
 
 		ph->env.cpu[i].socket_id = nr;
+		size += sizeof(u32);
+	}
+
+	/*
+	 * The header may be from old perf,
+	 * which doesn't include die information.
+	 */
+	if (ff->size <= size)
+		return 0;
+
+	if (do_read_u32(ff, &nr))
+		return -1;
+
+	ph->env.nr_sibling_dies = nr;
+	size += sizeof(u32);
+
+	for (i = 0; i < nr; i++) {
+		str = do_read_string(ff);
+		if (!str)
+			goto error;
+
+		/* include a NULL character at the end */
+		if (strbuf_add(&sb, str, strlen(str) + 1) < 0)
+			goto error;
+		size += string_size(str);
+		free(str);
+	}
+	ph->env.sibling_dies = strbuf_detach(&sb, NULL);
+
+	for (i = 0; i < (u32)cpu_nr; i++) {
+		if (do_read_u32(ff, &nr))
+			goto free_cpu;
+
+		ph->env.cpu[i].die_id = nr;
 	}
+	has_die = true;
 
 	return 0;
 
-- 
2.7.4

