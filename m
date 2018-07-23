Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D369ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DAA420685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DAA420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbeGWNso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52024 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbeGWNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:43 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B338AC19;
        Mon, 23 Jul 2018 12:47:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 062/107] prctl: Add speculation control prctls
Date:   Mon, 23 Jul 2018 14:41:56 +0200
Message-Id: <20180723122416.196205162@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b617cfc858161140d69cc0b5cc211996b557a1c7 upstream

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
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 Documentation/spec_ctrl.txt |   86 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nospec.h      |    5 ++
 include/uapi/linux/prctl.h  |   11 +++++
 kernel/sys.c                |   20 ++++++++++
 4 files changed, 122 insertions(+)
 create mode 100644 Documentation/spec_ctrl.txt

--- /dev/null
+++ b/Documentation/spec_ctrl.txt
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
@@ -197,4 +197,15 @@ struct prctl_mm_map {
 # define PR_CAP_AMBIENT_LOWER		3
 # define PR_CAP_AMBIENT_CLEAR_ALL	4
 
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
@@ -2075,6 +2075,16 @@ static int prctl_get_tid_address(struct
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
@@ -2269,6 +2279,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_GET_FP_MODE:
 		error = GET_FP_MODE(me);
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


