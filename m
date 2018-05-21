Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqQjd139WH2Am2ojNZnqygYLpPFS6Pu4q4YHrZFDxfsCKG3SRHRQ2r6L57wQj7/o46qGyir
ARC-Seal: i=1; a=rsa-sha256; t=1526937626; cv=none;
        d=google.com; s=arc-20160816;
        b=C96Z9luPKulliG8JNfVUw3A8hzn5HjRu6PoOo08GWPUZDn6z+8L47VdMF0BgxpbLJA
         GpFOI28YrnyBJulTzoS1U66HG2ErWpOmT2siTThv+49O/JPHva0B6o7SgnxvlM8RqC/T
         eXBVtJ0nJEmB4s8UQC4DldwIj15xCiPOeXA9Fg/MB9lpWO6gH+tVkj+bJVkDyqpPYVg6
         RGpweBwhDoX/UUAM9Rmi7/wSy9uaXPHxHblHh68iqPpVYQyRBAWoM5ZjpPuU7+yE/Tfx
         nkLMOSXfdCxH7qd+1wKLMX4jExCJDHWF6OwC4zx7gM5jaudjqSNWwZKfumm+TF3lpJAj
         Mn3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=+UQdvFSfWgviE9oiCstVmaP+CpH6ugMAIVP07xcwb6s=;
        b=upqJT8IOfZQOFTI4kwPQgpZ/YHTasD2oQkKkK0uCV5uHPBPSEmhV7e3N4iue9lWZnv
         xtSJlXNAjBh+5r1It+L8b/YaU7QHVjSOHpTqK9qRQm2JJMzCImgl5FFtn5WxWYecs9bj
         NIsfKpEnD2oOmlWbF2KzJ2M2JFu5PJuJDQpCpRMIt5XuJxwfhT1q85hs04HxDnequvcO
         UxSzvjqk/p/kkQcnopZ2D80+hkm/eiqT7Zy3DqSJcpusPMfNkOwop91Fm10vMvSqB+bs
         O8BkYP7nDDq0Db2nLLRRQ0GdlUIU+RKyyf/oIl0wBb6Iyq625GwnL980TL7cAjzfeShj
         kcpg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wiV1mph4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wiV1mph4;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 61/95] prctl: Add speculation control prctls
Date: Mon, 21 May 2018 23:11:51 +0200
Message-Id: <20180521210458.964299077@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109861377173650?=
X-GMAIL-MSGID: =?utf-8?q?1601110149206025046?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/userspace-api/index.rst     |    1 
 Documentation/userspace-api/spec_ctrl.rst |   86 ++++++++++++++++++++++++++++++
 include/linux/nospec.h                    |    5 +
 include/uapi/linux/prctl.h                |   11 +++
 kernel/sys.c                              |   22 +++++++
 5 files changed, 125 insertions(+)
 create mode 100644 Documentation/userspace-api/spec_ctrl.rst

--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -19,6 +19,7 @@ place where this information is gathered
    no_new_privs
    seccomp_filter
    unshare
+   spec_ctrl
 
 .. only::  subproject and html
 
--- /dev/null
+++ b/Documentation/userspace-api/spec_ctrl.rst
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
@@ -198,4 +198,15 @@ struct prctl_mm_map {
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
@@ -61,6 +61,8 @@
 #include <linux/uidgid.h>
 #include <linux/cred.h>
 
+#include <linux/nospec.h>
+
 #include <linux/kmsg_dump.h>
 /* Move somewhere else to avoid recompiling? */
 #include <generated/utsrelease.h>
@@ -2184,6 +2186,16 @@ static int propagate_has_child_subreaper
 	return 1;
 }
 
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
@@ -2386,6 +2398,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
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
