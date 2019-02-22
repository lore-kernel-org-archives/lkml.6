Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEA0C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9772F20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBVPbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:31:45 -0500
Received: from bastet.se.axis.com ([195.60.68.11]:45368 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfBVPbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:31:35 -0500
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 08A4C1857B;
        Fri, 22 Feb 2019 16:31:33 +0100 (CET)
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 1jRqAnzON7ik; Fri, 22 Feb 2019 16:31:24 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
        by bastet.se.axis.com (Postfix) with ESMTPS id 9F46418688;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72F931E066;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6744D1E064;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder03.se.axis.com (Postfix) with ESMTP;
        Fri, 22 Feb 2019 16:31:22 +0100 (CET)
Received: from lnxartpec.se.axis.com (lnxartpec.se.axis.com [10.88.4.9])
        by seth.se.axis.com (Postfix) with ESMTP id 5A9C9312F;
        Fri, 22 Feb 2019 16:31:21 +0100 (CET)
Received: by lnxartpec.se.axis.com (Postfix, from userid 10564)
        id 5881F80DC0; Fri, 22 Feb 2019 16:31:21 +0100 (CET)
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vincent Whitchurch <rabinv@axis.com>
Subject: [PATCH v2 char-misc-next 7/7] samples: mic: Add sample VOP userspace
Date:   Fri, 22 Feb 2019 16:30:56 +0100
Message-Id: <20190222153056.18878-11-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190222153056.18878-1-vincent.whitchurch@axis.com>
References: <20190222153056.18878-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sample userspace program which can be used with the VOP framework
with vop-loopback and non-MIC hardware.

For example, the following commands can be used to test networking over
vop-loopback.  (IPv6 is used with zone indices to force traffic through
the interfaces instead of short-circuit delivery, since both interfaces
are on the same system.)

 # modprobe vop_loopback
 # ./vopd &

 Setup host interface:
 # ip a a dev mic0 scope link fe80::0
 # ip link set dev mic0 up

 Setup guest interface:
 # ip a a dev eth1 scope link fe80::1
 # ip link set dev eth1 up

 Ping from host to guest:
 # ping6 fe80::1%mic0

 Ping from guest to host:
 # ping6 fe80::0%eth1

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 samples/mic/mpssd/.gitignore |  1 +
 samples/mic/mpssd/Makefile   |  5 ++++-
 samples/mic/mpssd/vopd.c     | 25 +++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100644 samples/mic/mpssd/vopd.c

diff --git a/samples/mic/mpssd/.gitignore b/samples/mic/mpssd/.gitignore
index 8b7c72f07c92..34c001135abb 100644
--- a/samples/mic/mpssd/.gitignore
+++ b/samples/mic/mpssd/.gitignore
@@ -1 +1,2 @@
 mpssd
+vopd
diff --git a/samples/mic/mpssd/Makefile b/samples/mic/mpssd/Makefile
index bc94054dbe2b..b94b18de5a43 100644
--- a/samples/mic/mpssd/Makefile
+++ b/samples/mic/mpssd/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 
-PROGS := mpssd
+PROGS := mpssd vopd
 CC = $(CROSS_COMPILE)gcc
 CFLAGS := -I../../../usr/include -I../../../tools/include
 
@@ -17,6 +17,9 @@ all: $(PROGS)
 mpssd: mpssd.c sysfs.c vop.o
 	$(CC) $(CFLAGS) $^ -o $@ -lpthread
 
+vopd: vopd.c vop.o
+	$(CC) $(CFLAGS) $^ -o $@ -lpthread
+
 install:
 	install mpssd /usr/sbin/mpssd
 	install micctrl /usr/sbin/micctrl
diff --git a/samples/mic/mpssd/vopd.c b/samples/mic/mpssd/vopd.c
new file mode 100644
index 000000000000..48c1877fed28
--- /dev/null
+++ b/samples/mic/mpssd/vopd.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+
+#include "mpssd.h"
+
+void mpsslog(char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+	vprintf(format, args);
+	va_end(args);
+}
+
+int main(int argc, char *argv[])
+{
+	struct mic_info themic = {
+		.name = "mic",
+	};
+
+	serve_virtio(&themic, &themic);
+
+	return 0;
+}
-- 
2.20.0

