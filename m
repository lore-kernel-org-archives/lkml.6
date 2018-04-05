Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751950AbeDEPRO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:17:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34490 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeDEPRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:09 -0400
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
Subject: [PATCH 6/9] bpf: Add CONFIG_BPF_BUILDID_CHECK option
Date: Thu,  5 Apr 2018 17:16:42 +0200
Message-Id: <20180405151645.19130-7-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding CONFIG_BPF_BUILDID_CHECK option that forces kernel
to check on provided build id when loading eBPF program.
If the build id does not match the one in kernel the program
fails to load.

Adding new field into struct bpf_attr. The kern_buildid
points to the user memory that contains the buildid.

Kernel expose the notes section via sysfs, but there's
currently no other use for kernel's buildid, so I needed
to add new __init buildid_init function to parse it out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h |  2 ++
 init/Kconfig             |  9 ++++++
 kernel/bpf/syscall.c     | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 94 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index c5ec89732a8d..17d8d330e6c7 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -308,6 +308,8 @@ union bpf_attr {
 		 * (context accesses, allowed helpers, etc).
 		 */
 		__u32		expected_attach_type;
+		/* Checked when prog_type=kprobe and CONFIG_BPF_BUILDID_CHECK. */
+		__aligned_u64	kern_buildid;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
diff --git a/init/Kconfig b/init/Kconfig
index 572df24dda9b..6d32220de7e0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1406,6 +1406,15 @@ config BPF_JIT_ALWAYS_ON
 	  Enables BPF JIT and removes BPF interpreter to avoid
 	  speculative execution of BPF instructions by the interpreter
 
+config BPF_BUILDID_CHECK
+	bool "Check buildid for kprobe and tracepoint programs"
+	depends on BPF_SYSCALL
+	select BUILDID_H
+	default n
+	help
+	  Enables BPF program load code to check on kernel Build ID
+	  for kprobe programs.
+
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
 	select ANON_INODES
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 0244973ee544..d0b3bc0bd9e6 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1239,7 +1239,85 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 }
 
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD expected_attach_type
+#define	BPF_PROG_LOAD_LAST_FIELD kern_buildid
+
+#ifdef CONFIG_BPF_BUILDID_CHECK
+
+static struct {
+	const char *ptr;
+	int         size;
+} buildid;
+
+#define BUILDID_MAX 40
+
+static int __check_buildid(union bpf_attr *attr)
+{
+	char id[buildid.size];
+
+	/* copy buildid from user space */
+	if (strncpy_from_user(id, u64_to_user_ptr(attr->kern_buildid),
+			      buildid.size) < 0)
+		return -EFAULT;
+
+	return memcmp(id, buildid.ptr, buildid.size);
+}
+
+static int check_buildid(union bpf_attr *attr)
+{
+	return buildid.ptr ? __check_buildid(attr) : 0;
+}
+
+#define NT_ALIGN(n)	(((n) + 3) & ~3)
+#define NT_GNU_BUILD_ID	3
+
+extern const void __start_notes __weak;
+extern const void __stop_notes __weak;
+
+static int __init buildid_init(void)
+{
+	const void *ptr = &__start_notes;
+
+	while (ptr < &__stop_notes) {
+		const Elf64_Nhdr *nhdr = ptr;
+		size_t namesz = NT_ALIGN(nhdr->n_namesz),
+		       descsz = NT_ALIGN(nhdr->n_descsz);
+		const char *name;
+
+		ptr += sizeof(*nhdr);
+		name = ptr;
+		ptr += namesz;
+
+		if (nhdr->n_type != NT_GNU_BUILD_ID ||
+		    nhdr->n_namesz != sizeof("GNU") ||
+		    memcmp(name, "GNU", sizeof("GNU"))) {
+			ptr += descsz;
+			continue;
+		}
+
+		buildid.ptr = ptr;
+		buildid.size = descsz;
+		break;
+	}
+
+	/* Sanity checks on the parsed buildid. */
+	if (!buildid.ptr) {
+		pr_warn("bpf: GNU buildid not found, switching off the check\n");
+	} else if (buildid.size > 64) {
+		pr_warn("bpf: GNU buildid too long, switching off the check\n");
+		buildid.ptr = NULL;
+	}
+
+	return 0;
+}
+
+subsys_initcall(buildid_init);
+
+#else
+static int check_buildid(union bpf_attr *attr __maybe_unused)
+{
+	return 0;
+}
+#endif /* CONFIG_BPF_BUILDID_CHECK */
 
 static int bpf_prog_load(union bpf_attr *attr)
 {
@@ -1271,6 +1349,10 @@ static int bpf_prog_load(union bpf_attr *attr)
 	    attr->kern_version != LINUX_VERSION_CODE)
 		return -EINVAL;
 
+	if (type == BPF_PROG_TYPE_KPROBE &&
+	    check_buildid(attr))
+		return -EINVAL;
+
 	if (type != BPF_PROG_TYPE_SOCKET_FILTER &&
 	    type != BPF_PROG_TYPE_CGROUP_SKB &&
 	    !capable(CAP_SYS_ADMIN))
-- 
2.13.6
