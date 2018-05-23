Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932926AbeEWMSl (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 08:18:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932835AbeEWMRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 08:17:38 -0400
Date: Wed, 23 May 2018 14:18:27 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH bpf-next v2 1/3] bpf: add ability to configure unprivileged
 BPF via boot-time parameter
Message-ID: <20180523121827.GA31372@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two configuration options,
UNPRIVILEGED_BPF_BOOTPARAM and UNPRIVILEGED_BPF_BOOTPARAM_VALUE, that
allow configuring the initial value of kernel.unprivileged_bpf_disabled
sysctl knob, which is useful for the cases when disabling unprivileged
bpf() access during the early boot is desirable.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +++++++
 init/Kconfig                                    | 31 +++++++++++++++++++++++++
 kernel/bpf/syscall.c                            | 16 +++++++++++++
 3 files changed, 55 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 11fc28e..aa8e831 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4355,6 +4355,14 @@
 	unknown_nmi_panic
 			[X86] Cause panic on unknown NMI.
 
+	unprivileged_bpf_disabled=
+			Format: { "0" | "1" }
+			Sets initial value of kernel.unprivileged_bpf_disabled
+			sysctl knob.
+			0 - unprivileged bpf() syscall access enabled.
+			1 - unprivileged bpf() syscall access disabled.
+			Default value is set via kernel config option.
+
 	usbcore.authorized_default=
 			[USB] Default USB device authorization:
 			(default -1 = authorized except for wireless USB,
diff --git a/init/Kconfig b/init/Kconfig
index 480a4f2..1403a3e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1404,6 +1404,37 @@ config BPF_JIT_ALWAYS_ON
 	  Enables BPF JIT and removes BPF interpreter to avoid
 	  speculative execution of BPF instructions by the interpreter
 
+config UNPRIVILEGED_BPF_BOOTPARAM
+	bool "Unprivileged bpf() boot parameter"
+	depends on BPF_SYSCALL
+	default n
+	help
+	  This option adds a kernel parameter 'unprivileged_bpf_disabled'
+	  that allows configuring default state of the
+	  kernel.unprivileged_bpf_disabled sysctl knob.
+	  If this option is selected, unprivileged access to the bpf() syscall
+	  can be disabled with unprivileged_bpf_disabled=1 on the kernel command
+	  line.  The purpose of this option is to allow disabling unprivileged
+	  bpf() syscall access during the early boot.
+
+	  If you are unsure how to answer this question, answer N.
+
+config UNPRIVILEGED_BPF_BOOTPARAM_VALUE
+	int "Unprivileged bpf() boot parameter default value"
+	depends on UNPRIVILEGED_BPF_BOOTPARAM
+	range 0 1
+	default 0
+	help
+	  This option sets the default value for the kernel parameter
+	  'unprivileged_bpf_disabled', which allows disabling unprivileged bpf()
+	  syscall access at boot.  If this option is set to 0 (zero), the
+	  unprivileged bpf() boot kernel parameter will default to 0, allowing
+	  unprivileged bpf() syscall access at bootup.  If this option is
+	  set to 1 (one), the unprivileged bpf() kernel parameter will default
+	  to 1, disabling unprivileged bpf() syscall access at bootup.
+
+	  If you are unsure how to answer this question, answer 0.
+
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
 	select ANON_INODES
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index bfcde94..fdc5fd9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -29,6 +29,7 @@
 #include <linux/ctype.h>
 #include <linux/btf.h>
 #include <linux/nospec.h>
+#include <linux/init.h>
 
 #define IS_FD_ARRAY(map) ((map)->map_type == BPF_MAP_TYPE_PROG_ARRAY || \
 			   (map)->map_type == BPF_MAP_TYPE_PERF_EVENT_ARRAY || \
@@ -45,7 +46,22 @@ static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
 static DEFINE_SPINLOCK(map_idr_lock);
 
+#ifdef CONFIG_UNPRIVILEGED_BPF_BOOTPARAM
+int sysctl_unprivileged_bpf_disabled __read_mostly =
+	CONFIG_UNPRIVILEGED_BPF_BOOTPARAM_VALUE;
+
+static int __init unprivileged_bpf_setup(char *str)
+{
+	unsigned long disabled;
+
+	if (!kstrtoul(str, 0, &disabled))
+		sysctl_unprivileged_bpf_disabled = !!disabled;
+	return 1;
+}
+__setup("unprivileged_bpf_disabled=", unprivileged_bpf_setup);
+#else /* !CONFIG_UNPRIVILEGED_BPF_BOOTPARAM */
 int sysctl_unprivileged_bpf_disabled __read_mostly;
+#endif /* CONFIG_UNPRIVILEGED_BPF_BOOTPARAM */
 
 static const struct bpf_map_ops * const bpf_map_types[] = {
 #define BPF_PROG_TYPE(_id, _ops)
-- 
2.1.4
