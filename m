Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeEUM3Z (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:29:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752247AbeEUM3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:29:23 -0400
Date: Mon, 21 May 2018 14:30:14 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: [PATCH 2/3] bpf: add ability to configure BPF JIT hardening via
 boot-time parameter
Message-ID: <20180521123014.GA19753@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces two configuration options,
BPF_JIT_HARDEN_BOOTPARAM and BPF_JIT_HARDEN_BOOTPARAM_VALUE, that allow
configuring the initial value of net.core.bpf_jit_harden sysctl knob,
which is useful for enforcing JIT hardening during the early boot.

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 10 +++++++++
 init/Kconfig                                    | 29 +++++++++++++++++++++++++
 kernel/bpf/core.c                               | 17 +++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index aa8e831..5adc6d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -442,6 +442,16 @@
 	bert_disable	[ACPI]
 			Disable BERT OS support on buggy BIOSes.
 
+	bpf_jit_harden=
+			Format: { "0" | "1" | "2" }
+			Sets initial value of net.core.bpf_jit_harden
+			sysctl knob.
+			0 - JIT hardening is disabled.
+			1 - JIT hardening is enabled for unprivileged users
+			    only.
+			2 - JIT hardening is enabled for all users.
+			Default value is set via kernel config option.
+
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
 	bttv.radio=	Most important insmod options are available as
 			kernel args too.
diff --git a/init/Kconfig b/init/Kconfig
index 1403a3e..b661497 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1435,6 +1435,35 @@ config UNPRIVILEGED_BPF_BOOTPARAM_VALUE
 
 	  If you are unsure how to answer this question, answer 0.
 
+config BPF_JIT_HARDEN_BOOTPARAM
+	bool "BPF JIT harden boot parameter"
+	default n
+	help
+	  This option adds a kernel parameter 'bpf_jit_harden' that allows
+	  configuring default state of the net.core.bpf_jit_harden sysctl knob.
+	  If this option is selected, the default value of the
+	  net.core.bpf_jit_harden sysctl knob can be set on the kernel command
+	  line.  The purpose of this option is to allow enabling BPF JIT
+	  hardening for the BPF programs created during the early boot.
+
+	  If you are unsure how to answer this question, answer N.
+
+config BPF_JIT_HARDEN_BOOTPARAM_VALUE
+	int "BPF JIT harden boot parameter default value"
+	depends on BPF_JIT_HARDEN_BOOTPARAM
+	range 0 2
+	default 0
+	help
+	  This option sets the default value for the kernel parameter
+	  'bpf_jit_enabled' that configures default value of the
+	  net.core.bpf_jit_harden sysctl knob at boot.  If this option is set to
+	  0 (zero), the net.core.bpf_jit_harden will default to 0, which will
+	  lead to no hardening at bootup.  If this option is set to 1 (one),
+	  hardening will be applied only to unprivileged users only.  If this
+	  option is set to 2 (two), JIT hardening will be enabled for all users.
+
+	  If you are unsure how to answer this question, answer 0.
+
 config USERFAULTFD
 	bool "Enable userfaultfd() system call"
 	select ANON_INODES
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 2194c6a..9edb7a8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -32,6 +32,7 @@
 #include <linux/kallsyms.h>
 #include <linux/rcupdate.h>
 #include <linux/perf_event.h>
+#include <linux/init.h>
 
 #include <asm/unaligned.h>
 
@@ -303,7 +304,23 @@ struct bpf_prog *bpf_patch_insn_single(struct bpf_prog *prog, u32 off,
 #ifdef CONFIG_BPF_JIT
 /* All BPF JIT sysctl knobs here. */
 int bpf_jit_enable   __read_mostly = IS_BUILTIN(CONFIG_BPF_JIT_ALWAYS_ON);
+
+#ifdef CONFIG_BPF_JIT_HARDEN_BOOTPARAM
+int bpf_jit_harden   __read_mostly = CONFIG_BPF_JIT_HARDEN_BOOTPARAM_VALUE;
+
+static int __init bpf_jit_harden_setup(char *str)
+{
+	unsigned long value;
+
+	if (!kstrtoul(str, 0, &value))
+		bpf_jit_harden = min(value, 2UL);
+	return 1;
+}
+__setup("bpf_jit_harden=", bpf_jit_harden_setup);
+#else /* !CONFIG_BPF_JIT_HARDEN_BOOTPARAM */
 int bpf_jit_harden   __read_mostly;
+#endif /* CONFIG_BPF_JIT_HARDEN_BOOTPARAM */
+
 int bpf_jit_kallsyms __read_mostly;
 
 static __always_inline void
-- 
2.1.4
