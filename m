Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968143AbeE2WRo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:17:44 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39991 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967583AbeE2WRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:17:34 -0400
X-Google-Smtp-Source: ADUXVKKYakg15UFfbF51T32OjedNJerp7wCWu5o0lBiwH3EUhpRZ0iTNiyiRhol04jI1yP9CW2lo1g==
From: Thomas Garnier <thgarnie@google.com>
To: kernel-hardening@lists.openwall.com
Cc: Thomas Garnier <thgarnie@google.com>,
        Skip Frederic Weisbecker <frederic@kernel.org>,
        Skip Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Skip Kees Cook <keescook@chromium.org>,
        Skip Michael Forney <forney@google.com>,
        Skip Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/27] compiler: Option to add PROVIDE_HIDDEN replacement for weak symbols
Date: Tue, 29 May 2018 15:15:17 -0700
Message-Id: <20180529221625.33541-17-thgarnie@google.com>
X-Mailer: git-send-email 2.17.0.921.gf22659ad46-goog
In-Reply-To: <20180529221625.33541-1-thgarnie@google.com>
References: <20180529221625.33541-1-thgarnie@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an option to have a PROVIDE_HIDDEN (linker script) entry for
each weak symbol. This option solves an error in x86_64 where the linker
optimizes PIE generated code to be non-PIE because --emit-relocs was used
instead of -pie (to reduce dynamic relocations).

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 init/Kconfig            |  7 +++++++
 scripts/link-vmlinux.sh | 14 ++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index f16247675f84..20e2bf2ae4b4 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1954,6 +1954,13 @@ config ASN1
 	  inform it as to what tags are to be expected in a stream and what
 	  functions to call on what tags.
 
+config WEAK_PROVIDE_HIDDEN
+	bool
+	help
+	  Generate linker script PROVIDE_HIDDEN entries for all weak symbols. It
+	  allows to prevent non-PIE code being replaced by the linker if the
+	  emit-relocs option is used instead of PIE (useful for x86_64 PIE).
+
 source "kernel/Kconfig.locks"
 
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 4bf811c09f59..f5d31119b9d7 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -142,6 +142,17 @@ kallsyms()
 	${CC} ${aflags} -c -o ${2} ${afile}
 }
 
+gen_weak_provide_hidden()
+{
+        if [ -n "${CONFIG_WEAK_PROVIDE_HIDDEN}" ]; then
+                local pattern="s/^\s\+ w \(\w\+\)$/PROVIDE_HIDDEN(\1 = .);/gp"
+                echo -e "SECTIONS {\n. = _end;" > .tmp_vmlinux_hiddenld
+                ${NM} ${1} | sed -n "${pattern}" >> .tmp_vmlinux_hiddenld
+                echo "}" >> .tmp_vmlinux_hiddenld
+                LDFLAGS_vmlinux="${LDFLAGS_vmlinux} -T .tmp_vmlinux_hiddenld"
+        fi
+}
+
 # Create map file with all symbols from ${1}
 # See mksymap for additional details
 mksysmap()
@@ -226,6 +237,9 @@ modpost_link vmlinux.o
 # modpost vmlinux.o to check for section mismatches
 ${MAKE} -f "${srctree}/scripts/Makefile.modpost" vmlinux.o
 
+# Generate weak linker script
+gen_weak_provide_hidden vmlinux.o
+
 kallsymso=""
 kallsyms_vmlinux=""
 if [ -n "${CONFIG_KALLSYMS}" ]; then
-- 
2.17.0.921.gf22659ad46-goog
