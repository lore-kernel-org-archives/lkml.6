Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeFECxp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 22:53:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751451AbeFECxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 22:53:44 -0400
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To: "David S . Miller" <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>, <arnd@arndb.de>,
        <yamada.masahiro@socionext.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH net-next] bpfilter: switch to CC from HOSTCC
Date: Mon, 4 Jun 2018 19:53:41 -0700
Message-ID: <20180605025341.3965492-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-05_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check that CC can build executables and use that compiler instead of HOSTCC

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Makefile               |  5 +++++
 net/Makefile           |  4 ++++
 net/bpfilter/Makefile  |  2 ++
 scripts/cc-can-link.sh | 11 +++++++++++
 4 files changed, 22 insertions(+)
 create mode 100755 scripts/cc-can-link.sh

diff --git a/Makefile b/Makefile
index 56ba070dfa09..62c110084fae 100644
--- a/Makefile
+++ b/Makefile
@@ -510,6 +510,11 @@ ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $
   KBUILD_AFLAGS += -DCC_HAVE_ASM_GOTO
 endif
 
+ifeq ($(call shell-cached,$(CONFIG_SHELL) $(srctree)/scripts/cc-can-link.sh $(CC)), y)
+  CC_CAN_LINK := y
+  export CC_CAN_LINK
+endif
+
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
diff --git a/net/Makefile b/net/Makefile
index bdaf53925acd..13ec0d5415c7 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -20,7 +20,11 @@ obj-$(CONFIG_TLS)		+= tls/
 obj-$(CONFIG_XFRM)		+= xfrm/
 obj-$(CONFIG_UNIX)		+= unix/
 obj-$(CONFIG_NET)		+= ipv6/
+ifneq ($(CC_CAN_LINK),y)
+$(warning CC cannot link executables. Skipping bpfilter.)
+else
 obj-$(CONFIG_BPFILTER)		+= bpfilter/
+endif
 obj-$(CONFIG_PACKET)		+= packet/
 obj-$(CONFIG_NET_KEY)		+= key/
 obj-$(CONFIG_BRIDGE)		+= bridge/
diff --git a/net/bpfilter/Makefile b/net/bpfilter/Makefile
index 3f3cb87c668f..aafa72001fcd 100644
--- a/net/bpfilter/Makefile
+++ b/net/bpfilter/Makefile
@@ -6,6 +6,8 @@
 hostprogs-y := bpfilter_umh
 bpfilter_umh-objs := main.o
 HOSTCFLAGS += -I. -Itools/include/ -Itools/include/uapi
+HOSTCC := $(CC)
+
 ifeq ($(CONFIG_BPFILTER_UMH), y)
 # builtin bpfilter_umh should be compiled with -static
 # since rootfs isn't mounted at the time of __init
diff --git a/scripts/cc-can-link.sh b/scripts/cc-can-link.sh
new file mode 100755
index 000000000000..208eb2825dab
--- /dev/null
+++ b/scripts/cc-can-link.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+cat << "END" | $@ -x c - -o /dev/null >/dev/null 2>&1 && echo "y"
+#include <stdio.h>
+int main(void)
+{
+	printf("");
+	return 0;
+}
+END
-- 
2.9.5
