Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935741AbeCHLeT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:34:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46293 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeCHLeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:34:17 -0500
Date: Thu, 8 Mar 2018 03:33:54 -0800
From: tip-bot for Jan Kiszka <tipbot@zytor.com>
Message-ID: <tip-63338a38db955cb4e0352c11b78732157c78d30b@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        bhelgaas@google.com, mark.rutland@arm.com, jan.kiszka@siemens.com,
        hpa@zytor.com, robh+dt@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, jgross@suse.com
Reply-To: jgross@suse.com, tglx@linutronix.de, mingo@kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com, mark.rutland@arm.com,
        jan.kiszka@siemens.com, hpa@zytor.com
In-Reply-To: <dae9fe0c6e63141c28ca90492fa5712b4c33ffb5.1520408357.git.jan.kiszka@siemens.com>
References: <dae9fe0c6e63141c28ca90492fa5712b4c33ffb5.1520408357.git.jan.kiszka@siemens.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] jailhouse: Provide detection for non-x86 systems
Git-Commit-ID: 63338a38db955cb4e0352c11b78732157c78d30b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  63338a38db955cb4e0352c11b78732157c78d30b
Gitweb:     https://git.kernel.org/tip/63338a38db955cb4e0352c11b78732157c78d30b
Author:     Jan Kiszka <jan.kiszka@siemens.com>
AuthorDate: Wed, 7 Mar 2018 08:39:12 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 12:30:37 +0100

jailhouse: Provide detection for non-x86 systems

Implement jailhouse_paravirt() via device tree probing on architectures
!= x86. Will be used by the PCI core.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Cc: jailhouse-dev@googlegroups.com
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-pci@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lkml.kernel.org/r/dae9fe0c6e63141c28ca90492fa5712b4c33ffb5.1520408357.git.jan.kiszka@siemens.com

---
 Documentation/devicetree/bindings/jailhouse.txt |  8 ++++++++
 arch/x86/include/asm/jailhouse_para.h           |  2 +-
 include/linux/hypervisor.h                      | 17 +++++++++++++++--
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/jailhouse.txt b/Documentation/devicetree/bindings/jailhouse.txt
new file mode 100644
index 000000000000..2901c25ff340
--- /dev/null
+++ b/Documentation/devicetree/bindings/jailhouse.txt
@@ -0,0 +1,8 @@
+Jailhouse non-root cell device tree bindings
+--------------------------------------------
+
+When running in a non-root Jailhouse cell (partition), the device tree of this
+platform shall have a top-level "hypervisor" node with the following
+properties:
+
+- compatible = "jailhouse,cell"
diff --git a/arch/x86/include/asm/jailhouse_para.h b/arch/x86/include/asm/jailhouse_para.h
index 875b54376689..b885a961a150 100644
--- a/arch/x86/include/asm/jailhouse_para.h
+++ b/arch/x86/include/asm/jailhouse_para.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL2.0 */
 
 /*
- * Jailhouse paravirt_ops implementation
+ * Jailhouse paravirt detection
  *
  * Copyright (c) Siemens AG, 2015-2017
  *
diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
index b19563f9a8eb..fc08b433c856 100644
--- a/include/linux/hypervisor.h
+++ b/include/linux/hypervisor.h
@@ -8,15 +8,28 @@
  */
 
 #ifdef CONFIG_X86
+
+#include <asm/jailhouse_para.h>
 #include <asm/x86_init.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 	x86_platform.hyper.pin_vcpu(cpu);
 }
-#else
+
+#else /* !CONFIG_X86 */
+
+#include <linux/of.h>
+
 static inline void hypervisor_pin_vcpu(int cpu)
 {
 }
-#endif
+
+static inline bool jailhouse_paravirt(void)
+{
+	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
+}
+
+#endif /* !CONFIG_X86 */
 
 #endif /* __LINUX_HYPEVISOR_H */
