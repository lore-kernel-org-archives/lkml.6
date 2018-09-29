Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB25C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5AE206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5AE206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeI3EcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:32:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51524 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726176AbeI3ESU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:20 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000H6-MQ; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006px-Gj; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.879374454@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 014/131] prctl: Add speculation control prctls
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b617cfc858161140d69cc0b5cc211996b557a1c7 upstream.

Add two new prctls to control aspects of speculation related vulnerabilites
and their mitigations to provide finer grained control over performance
impacting mitigations.

PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
which is selected with arg2 of prctl(2). The return value uses bit 0-2 with
the following meaning:

Bit  Define           Description
0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
                      PR_SET_SPECULATION_CTRL
1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
                      disabled
2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
                      enabled

If all bits are 0 the CPU is not affected by the speculation misfeature.

If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
misfeature will fail.

PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
is selected by arg2 of prctl(2) per task. arg3 is used to hand in the
control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.

The common return values are:

EINVAL  prctl is not implemented by the architecture or the unused prctl()
        arguments are not 0
ENODEV  arg2 is selecting a not supported speculation misfeature

PR_SET_SPECULATION_CTRL has these additional return values:

ERANGE  arg3 is incorrect, i.e. it's not either PR_SPEC_ENABLE or PR_SPEC_DISABLE
ENXIO   prctl control of the selected speculation misfeature is disabled

The first supported controlable speculation misfeature is
PR_SPEC_STORE_BYPASS. Add the define so this can be shared between
architectures.

Based on an initial patch from Tim Chen and mostly rewritten.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
[bwh: Backported to 3.16:
 - Add the documentation directly under Documentation/ since there is
   no userspace-api subdirectory or reST index
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 Documentation/spec_ctrl.rst | 86 +++++++++++++++++++++++++++++++++++++
 include/linux/nospec.h      |  5 +++
 include/uapi/linux/prctl.h  | 11 +++++
 kernel/sys.c                | 22 ++++++++++
 4 files changed, 124 insertions(+)
 create mode 100644 Documentation/spec_ctrl.rst

--- /dev/null
+++ b/Documentation/spec_ctrl.rst
@@ -0,0 +1,86 @@
+===================
+Speculation Control
+===================
+
+Quite some CPUs have speculation related misfeatures which are in fact
+vulnerabilites causing data leaks in various forms even accross privilege
+domains.
+
+The kernel provides mitigation for such vulnerabilities in various
+forms. Some of these mitigations are compile time configurable and some on
+the kernel command line.
+
+There is also a class of mitigations which are very expensive, but they can
+be restricted to a certain set of processes or tasks in controlled
+environments. The mechanism to control these mitigations is via
+:manpage:`prctl(2)`.
+
+There are two prctl options which are related to this:
+
+ * PR_GET_SPECULATION_CTRL
+
+ * PR_SET_SPECULATION_CTRL
+
+PR_GET_SPECULATION_CTRL
+-----------------------
+
+PR_GET_SPECULATION_CTRL returns the state of the speculation misfeature
+which is selected with arg2 of prctl(2). The return value uses bits 0-2 with
+the following meaning:
+
+==== ================ ===================================================
+Bit  Define           Description
+==== ================ ===================================================
+0    PR_SPEC_PRCTL    Mitigation can be controlled per task by
+                      PR_SET_SPECULATION_CTRL
+1    PR_SPEC_ENABLE   The speculation feature is enabled, mitigation is
+                      disabled
+2    PR_SPEC_DISABLE  The speculation feature is disabled, mitigation is
+                      enabled
+==== ================ ===================================================
+
+If all bits are 0 the CPU is not affected by the speculation misfeature.
+
+If PR_SPEC_PRCTL is set, then the per task control of the mitigation is
+available. If not set, prctl(PR_SET_SPECULATION_CTRL) for the speculation
+misfeature will fail.
+
+PR_SET_SPECULATION_CTRL
+-----------------------
+PR_SET_SPECULATION_CTRL allows to control the speculation misfeature, which
+is selected by arg2 of :manpage:`prctl(2)` per task. arg3 is used to hand
+in the control value, i.e. either PR_SPEC_ENABLE or PR_SPEC_DISABLE.
+
+Common error codes
+------------------
+======= =================================================================
+Value   Meaning
+======= =================================================================
+EINVAL  The prctl is not implemented by the architecture or unused
+        prctl(2) arguments are not 0
+
+ENODEV  arg2 is selecting a not supported speculation misfeature
+======= =================================================================
+
+PR_SET_SPECULATION_CTRL error codes
+-----------------------------------
+======= =================================================================
+Value   Meaning
+======= =================================================================
+0       Success
+
+ERANGE  arg3 is incorrect, i.e. it's neither PR_SPEC_ENABLE nor
+        PR_SPEC_DISABLE
+
+ENXIO   Control of the selected speculation misfeature is not possible.
+        See PR_GET_SPECULATION_CTRL.
+======= =================================================================
+
+Speculation misfeature controls
+-------------------------------
+- PR_SPEC_STORE_BYPASS: Speculative Store Bypass
+
+  Invocations:
+   * prctl(PR_GET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, 0, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_ENABLE, 0, 0);
+   * prctl(PR_SET_SPECULATION_CTRL, PR_SPEC_STORE_BYPASS, PR_SPEC_DISABLE, 0, 0);
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -55,4 +55,9 @@ static inline unsigned long array_index_
 									\
 	(typeof(_i)) (_i & _mask);					\
 })
+
+/* Speculation control prctl */
+int arch_prctl_spec_ctrl_get(unsigned long which);
+int arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl);
+
 #endif /* _LINUX_NOSPEC_H */
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -152,4 +152,15 @@
 #define PR_SET_THP_DISABLE	41
 #define PR_GET_THP_DISABLE	42
 
+/* Per task speculation control */
+#define PR_GET_SPECULATION_CTRL		52
+#define PR_SET_SPECULATION_CTRL		53
+/* Speculation control variants */
+# define PR_SPEC_STORE_BYPASS		0
+/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
+# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_PRCTL			(1UL << 0)
+# define PR_SPEC_ENABLE			(1UL << 1)
+# define PR_SPEC_DISABLE		(1UL << 2)
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -53,6 +53,8 @@
 #include <linux/uidgid.h>
 #include <linux/cred.h>
 
+#include <linux/nospec.h>
+
 #include <linux/kmsg_dump.h>
 /* Move somewhere else to avoid recompiling? */
 #include <generated/utsrelease.h>
@@ -1832,6 +1834,16 @@ static int prctl_get_tid_address(struct
 }
 #endif
 
+int __weak arch_prctl_spec_ctrl_get(unsigned long which)
+{
+	return -EINVAL;
+}
+
+int __weak arch_prctl_spec_ctrl_set(unsigned long which, unsigned long ctrl)
+{
+	return -EINVAL;
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2010,6 +2022,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 			me->mm->def_flags &= ~VM_NOHUGEPAGE;
 		up_write(&me->mm->mmap_sem);
 		break;
+	case PR_GET_SPECULATION_CTRL:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_spec_ctrl_get(arg2);
+		break;
+	case PR_SET_SPECULATION_CTRL:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = arch_prctl_spec_ctrl_set(arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;

