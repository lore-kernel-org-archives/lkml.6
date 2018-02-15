Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968137AbeBOM37 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 07:29:59 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967946AbeBOM0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 07:26:44 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 4/9] perf tools: Move kernel mmap name into struct machine
Date: Thu, 15 Feb 2018 13:26:30 +0100
Message-Id: <20180215122635.24029-5-jolsa@kernel.org>
In-Reply-To: <20180215122635.24029-1-jolsa@kernel.org>
References: <20180215122635.24029-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It simplifies and centralizes the code. The kernel mmap
name is set for machine type, which we know from the
beginning, so there's no reason to generate it every time
we need it.

Link: http://lkml.kernel.org/n/tip-2fx7kxxdc5zcm6990cq2mday@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 10 +++----
 tools/perf/util/event.c    |  5 +---
 tools/perf/util/machine.c  | 67 +++++++++++++++++++++++-----------------------
 tools/perf/util/machine.h  |  3 +--
 tools/perf/util/symbol.c   |  3 +--
 5 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 7f8553630c4d..537eadd81914 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -316,7 +316,6 @@ static int machine__write_buildid_table(struct machine *machine,
 					struct feat_fd *fd)
 {
 	int err = 0;
-	char nm[PATH_MAX];
 	struct dso *pos;
 	u16 kmisc = PERF_RECORD_MISC_KERNEL,
 	    umisc = PERF_RECORD_MISC_USER;
@@ -338,9 +337,8 @@ static int machine__write_buildid_table(struct machine *machine,
 			name = pos->short_name;
 			name_len = pos->short_name_len;
 		} else if (dso__is_kcore(pos)) {
-			machine__mmap_name(machine, nm, sizeof(nm));
-			name = nm;
-			name_len = strlen(nm);
+			name = machine->mmap_name;
+			name_len = strlen(name);
 		} else {
 			name = pos->long_name;
 			name_len = pos->long_name_len;
@@ -813,12 +811,10 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
 	bool is_kallsyms = dso__is_kallsyms(dso);
 	bool is_vdso = dso__is_vdso(dso);
 	const char *name = dso->long_name;
-	char nm[PATH_MAX];
 
 	if (dso__is_kcore(dso)) {
 		is_kallsyms = true;
-		machine__mmap_name(machine, nm, sizeof(nm));
-		name = nm;
+		name = machine->mmap_name;
 	}
 	return build_id_cache__add_b(dso->build_id, sizeof(dso->build_id), name,
 				     dso->nsinfo, is_kallsyms, is_vdso);
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 44e603c27944..4644e751a3e3 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -894,8 +894,6 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 				       struct machine *machine)
 {
 	size_t size;
-	const char *mmap_name;
-	char name_buff[PATH_MAX];
 	struct map *map = machine__kernel_map(machine);
 	struct kmap *kmap;
 	int err;
@@ -918,7 +916,6 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 		return -1;
 	}
 
-	mmap_name = machine__mmap_name(machine, name_buff, sizeof(name_buff));
 	if (machine__is_host(machine)) {
 		/*
 		 * kernel uses PERF_RECORD_MISC_USER for user space maps,
@@ -931,7 +928,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 
 	kmap = map__kmap(map);
 	size = snprintf(event->mmap.filename, sizeof(event->mmap.filename),
-			"%s%s", mmap_name, kmap->ref_reloc_sym->name) + 1;
+			"%s%s", machine->mmap_name, kmap->ref_reloc_sym->name) + 1;
 	size = PERF_ALIGN(size, sizeof(u64));
 	event->mmap.header.type = PERF_RECORD_MMAP;
 	event->mmap.header.size = (sizeof(event->mmap) -
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index c976384f9022..b1f1961b13f4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -48,6 +48,27 @@ static void machine__threads_init(struct machine *machine)
 	}
 }
 
+static int machine__set_mmap_name(struct machine *machine)
+{
+	if (machine__is_host(machine)) {
+		if (symbol_conf.vmlinux_name)
+			machine->mmap_name = strdup(symbol_conf.vmlinux_name);
+		else
+			machine->mmap_name = strdup("[kernel.kallsyms]");
+	} else if (machine__is_default_guest(machine)) {
+		if (symbol_conf.default_guest_vmlinux_name)
+			machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
+		else
+			machine->mmap_name = strdup("[guest.kernel.kallsyms]");
+	} else {
+		if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
+			 machine->pid) < 0)
+			machine->mmap_name = NULL;
+	}
+
+	return machine->mmap_name ? 0 : -ENOMEM;
+}
+
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 {
 	int err = -ENOMEM;
@@ -75,6 +96,9 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	if (machine->root_dir == NULL)
 		return -ENOMEM;
 
+	if (machine__set_mmap_name(machine))
+		goto out;
+
 	if (pid != HOST_KERNEL_ID) {
 		struct thread *thread = machine__findnew_thread(machine, -1,
 								pid);
@@ -92,8 +116,10 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	err = 0;
 
 out:
-	if (err)
+	if (err) {
 		zfree(&machine->root_dir);
+		zfree(&machine->mmap_name);
+	}
 	return 0;
 }
 
@@ -186,6 +212,7 @@ void machine__exit(struct machine *machine)
 	dsos__exit(&machine->dsos);
 	machine__exit_vdso(machine);
 	zfree(&machine->root_dir);
+	zfree(&machine->mmap_name);
 	zfree(&machine->current_tid);
 
 	for (i = 0; i < THREADS__TABLE_SIZE; i++) {
@@ -328,20 +355,6 @@ void machines__process_guests(struct machines *machines,
 	}
 }
 
-char *machine__mmap_name(struct machine *machine, char *bf, size_t size)
-{
-	if (machine__is_host(machine))
-		snprintf(bf, size, "[%s]", "kernel.kallsyms");
-	else if (machine__is_default_guest(machine))
-		snprintf(bf, size, "[%s]", "guest.kernel.kallsyms");
-	else {
-		snprintf(bf, size, "[%s.%d]", "guest.kernel.kallsyms",
-			 machine->pid);
-	}
-
-	return bf;
-}
-
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size)
 {
 	struct rb_node *node;
@@ -777,25 +790,13 @@ size_t machine__fprintf(struct machine *machine, FILE *fp)
 
 static struct dso *machine__get_kernel(struct machine *machine)
 {
-	const char *vmlinux_name = NULL;
+	const char *vmlinux_name = machine->mmap_name;
 	struct dso *kernel;
 
 	if (machine__is_host(machine)) {
-		vmlinux_name = symbol_conf.vmlinux_name;
-		if (!vmlinux_name)
-			vmlinux_name = DSO__NAME_KALLSYMS;
-
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[kernel]", DSO_TYPE_KERNEL);
 	} else {
-		char bf[PATH_MAX];
-
-		if (machine__is_default_guest(machine))
-			vmlinux_name = symbol_conf.default_guest_vmlinux_name;
-		if (!vmlinux_name)
-			vmlinux_name = machine__mmap_name(machine, bf,
-							  sizeof(bf));
-
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[guest.kernel]",
 						 DSO_TYPE_GUEST_KERNEL);
@@ -1295,7 +1296,6 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 					      union perf_event *event)
 {
 	struct map *map;
-	char kmmap_prefix[PATH_MAX];
 	enum dso_kernel_type kernel_type;
 	bool is_kernel_mmap;
 
@@ -1303,15 +1303,14 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	if (machine__uses_kcore(machine))
 		return 0;
 
-	machine__mmap_name(machine, kmmap_prefix, sizeof(kmmap_prefix));
 	if (machine__is_host(machine))
 		kernel_type = DSO_TYPE_KERNEL;
 	else
 		kernel_type = DSO_TYPE_GUEST_KERNEL;
 
 	is_kernel_mmap = memcmp(event->mmap.filename,
-				kmmap_prefix,
-				strlen(kmmap_prefix) - 1) == 0;
+				machine->mmap_name,
+				strlen(machine->mmap_name) - 1) == 0;
 	if (event->mmap.filename[0] == '/' ||
 	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
 		map = machine__findnew_module_map(machine, event->mmap.start,
@@ -1322,7 +1321,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		map->end = map->start + event->mmap.len;
 	} else if (is_kernel_mmap) {
 		const char *symbol_name = (event->mmap.filename +
-				strlen(kmmap_prefix));
+				strlen(machine->mmap_name));
 		/*
 		 * Should be there already, from the build-id table in
 		 * the header.
@@ -1363,7 +1362,7 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		up_read(&machine->dsos.lock);
 
 		if (kernel == NULL)
-			kernel = machine__findnew_dso(machine, kmmap_prefix);
+			kernel = machine__findnew_dso(machine, machine->mmap_name);
 		if (kernel == NULL)
 			goto out_problem;
 
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index 5ce860b64c74..cb0a20f3a96b 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -43,6 +43,7 @@ struct machine {
 	bool		  comm_exec;
 	bool		  kptr_restrict_warned;
 	char		  *root_dir;
+	char		  *mmap_name;
 	struct threads    threads[THREADS__TABLE_SIZE];
 	struct vdso_info  *vdso_info;
 	struct perf_env   *env;
@@ -142,8 +143,6 @@ struct machine *machines__find(struct machines *machines, pid_t pid);
 struct machine *machines__findnew(struct machines *machines, pid_t pid);
 
 void machines__set_id_hdr_size(struct machines *machines, u16 id_hdr_size);
-char *machine__mmap_name(struct machine *machine, char *bf, size_t size);
-
 void machines__set_comm_exec(struct machines *machines, bool comm_exec);
 
 struct machine *machine__new_host(void);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index e366e3060e6b..a1a312d99f30 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1958,8 +1958,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 		pr_debug("Using %s for symbols\n", kallsyms_filename);
 	if (err > 0 && !dso__is_kcore(dso)) {
 		dso->binary_type = DSO_BINARY_TYPE__GUEST_KALLSYMS;
-		machine__mmap_name(machine, path, sizeof(path));
-		dso__set_long_name(dso, strdup(path), true);
+		dso__set_long_name(dso, machine->mmap_name, false);
 		map__fixup_start(map);
 		map__fixup_end(map);
 	}
-- 
2.13.6
