Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbeDEPRR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751936AbeDEPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:14 -0400
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
Subject: [PATCH 8/9] libbpf: Add support to attach buildid to program load
Date: Thu,  5 Apr 2018 17:16:44 +0200
Message-Id: <20180405151645.19130-9-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to retrieve buildid from elf's "buildid"
section and passing it through to the load_program
function to kernel bpf syscall.

Fixing perf use of the bpf_load_program function and
linking in the vsprintf.o into bpftool to have the
scnprintf function in.

Link: http://lkml.kernel.org/n/tip-2pafwtzbyosmf9ftuf0udn54@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/Makefile |  5 ++++-
 tools/lib/bpf/bpf.c        |  6 ++++--
 tools/lib/bpf/bpf.h        |  5 +++--
 tools/lib/bpf/libbpf.c     | 46 ++++++++++++++++++++++++++++++++++++++++------
 tools/perf/tests/bpf.c     |  9 ++++++++-
 5 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 4e69782c4a79..9ac11ea5de1c 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -75,11 +75,14 @@ include $(wildcard $(OUTPUT)*.d)
 all: $(OUTPUT)bpftool
 
 SRCS = $(wildcard *.c)
-OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
+OBJS = $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o $(OUTPUT)vsprintf.o
 
 $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
 	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
 
+$(OUTPUT)vsprintf.o: $(srctree)/tools/lib/vsprintf.c
+	$(QUIET_CC)$(COMPILE.c) -MMD -o $@ $<
+
 $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
 	$(QUIET_LINK)$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index acbb3f8b3bec..8e384db5bbbd 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -168,6 +168,7 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 	attr.log_size = 0;
 	attr.log_level = 0;
 	attr.kern_version = load_attr->kern_version;
+	attr.kern_buildid = ptr_to_u64(load_attr->buildid);
 	memcpy(attr.prog_name, load_attr->name,
 	       min(name_len, BPF_OBJ_NAME_LEN - 1));
 
@@ -185,8 +186,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 
 int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t insns_cnt, const char *license,
-		     __u32 kern_version, char *log_buf,
-		     size_t log_buf_sz)
+		     __u32 kern_version, const char *buildid,
+		     char *log_buf, size_t log_buf_sz)
 {
 	struct bpf_load_program_attr load_attr;
 
@@ -198,6 +199,7 @@ int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
 	load_attr.kern_version = kern_version;
+	load_attr.buildid = buildid;
 
 	return bpf_load_program_xattr(&load_attr, log_buf, log_buf_sz);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 39f6a0d64a3b..b5ffb178ebdd 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -49,6 +49,7 @@ struct bpf_load_program_attr {
 	size_t insns_cnt;
 	const char *license;
 	__u32 kern_version;
+	const char *buildid;
 };
 
 /* Recommend log buffer size */
@@ -57,8 +58,8 @@ int bpf_load_program_xattr(const struct bpf_load_program_attr *load_attr,
 			   char *log_buf, size_t log_buf_sz);
 int bpf_load_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t insns_cnt, const char *license,
-		     __u32 kern_version, char *log_buf,
-		     size_t log_buf_sz);
+		     __u32 kern_version, const char *buildid,
+		     char *log_buf, size_t log_buf_sz);
 int bpf_verify_program(enum bpf_prog_type type, const struct bpf_insn *insns,
 		       size_t insns_cnt, int strict_alignment,
 		       const char *license, __u32 kern_version,
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5922443063f0..421f2c2e0ebe 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -220,6 +220,7 @@ static LIST_HEAD(bpf_objects_list);
 
 struct bpf_object {
 	char license[64];
+	char buildid[64];
 	u32 kern_version;
 
 	struct bpf_program *programs;
@@ -599,6 +600,32 @@ bpf_object__init_kversion(struct bpf_object *obj,
 	return 0;
 }
 
+static void buildid_scnprint(char *buf, int n, char *buildid, int size)
+{
+	int i, ret = 0;
+
+	for (i = 0; i < size; i++) {
+		ret += scnprintf(buf + ret, n - ret, "%x",
+				 (unsigned char) buildid[i]);
+	}
+}
+
+static int
+bpf_object__init_buildid(struct bpf_object *obj,
+			 void *data, size_t size)
+{
+	char buf[64];
+
+	if (size > sizeof(obj->buildid))
+		return -LIBBPF_ERRNO__FORMAT;
+
+	memcpy(&obj->buildid, data, size);
+
+	buildid_scnprint(buf, 64, obj->buildid, size);
+	pr_debug("kernel buildid of %s is: %s\n", obj->path, buf);
+	return 0;
+}
+
 static int compare_bpf_map(const void *_a, const void *_b)
 {
 	const struct bpf_map *a = _a;
@@ -817,6 +844,10 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			err = bpf_object__init_kversion(obj,
 							data->d_buf,
 							data->d_size);
+		else if (strcmp(name, "buildid") == 0)
+			err = bpf_object__init_buildid(obj,
+						       data->d_buf,
+						       data->d_size);
 		else if (strcmp(name, "maps") == 0)
 			obj->efile.maps_shndx = idx;
 		else if (sh.sh_type == SHT_SYMTAB) {
@@ -1166,7 +1197,7 @@ static int bpf_object__collect_reloc(struct bpf_object *obj)
 static int
 load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	     const char *name, struct bpf_insn *insns, int insns_cnt,
-	     char *license, u32 kern_version, int *pfd)
+	     char *license, u32 kern_version, const char *buildid, int *pfd)
 {
 	struct bpf_load_program_attr load_attr;
 	char *log_buf;
@@ -1180,6 +1211,7 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 	load_attr.insns_cnt = insns_cnt;
 	load_attr.license = license;
 	load_attr.kern_version = kern_version;
+	load_attr.buildid = buildid;
 
 	if (!load_attr.insns || !load_attr.insns_cnt)
 		return -EINVAL;
@@ -1189,7 +1221,6 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 		pr_warning("Alloc log buffer for bpf loader error, continue without log\n");
 
 	ret = bpf_load_program_xattr(&load_attr, log_buf, BPF_LOG_BUF_SIZE);
-
 	if (ret >= 0) {
 		*pfd = ret;
 		ret = 0;
@@ -1234,7 +1265,8 @@ load_program(enum bpf_prog_type type, enum bpf_attach_type expected_attach_type,
 
 static int
 bpf_program__load(struct bpf_program *prog,
-		  char *license, u32 kern_version)
+		  char *license, u32 kern_version,
+		  const char *buildid)
 {
 	int err = 0, fd, i;
 
@@ -1261,7 +1293,7 @@ bpf_program__load(struct bpf_program *prog,
 		}
 		err = load_program(prog->type, prog->expected_attach_type,
 				   prog->name, prog->insns, prog->insns_cnt,
-				   license, kern_version, &fd);
+				   license, kern_version, buildid, &fd);
 		if (!err)
 			prog->instances.fds[0] = fd;
 		goto out;
@@ -1292,7 +1324,8 @@ bpf_program__load(struct bpf_program *prog,
 		err = load_program(prog->type, prog->expected_attach_type,
 				   prog->name, result.new_insn_ptr,
 				   result.new_insn_cnt,
-				   license, kern_version, &fd);
+				   license, kern_version,
+				   buildid, &fd);
 
 		if (err) {
 			pr_warning("Loading the %dth instance of program '%s' failed\n",
@@ -1324,7 +1357,8 @@ bpf_object__load_progs(struct bpf_object *obj)
 			continue;
 		err = bpf_program__load(&obj->programs[i],
 					obj->license,
-					obj->kern_version);
+					obj->kern_version,
+					obj->buildid);
 		if (err)
 			return err;
 	}
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 79b54f8ddebf..2a738b7b743a 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -298,6 +298,7 @@ static int check_env(void)
 	int err;
 	unsigned int kver_int;
 	char license[] = "GPL";
+	char buildid[64];
 
 	struct bpf_insn insns[] = {
 		BPF_MOV64_IMM(BPF_REG_0, 1),
@@ -310,9 +311,15 @@ static int check_env(void)
 		return err;
 	}
 
+	err = fetch_kernel_buildid(buildid, sizeof(buildid));
+	if (err) {
+		pr_debug("Unable to get kernel buildid\n");
+		return err;
+	}
+
 	err = bpf_load_program(BPF_PROG_TYPE_KPROBE, insns,
 			       sizeof(insns) / sizeof(insns[0]),
-			       license, kver_int, NULL, 0);
+			       license, kver_int, buildid, NULL, 0);
 	if (err < 0) {
 		pr_err("Missing basic BPF support, skip this test: %s\n",
 		       strerror(errno));
-- 
2.13.6
