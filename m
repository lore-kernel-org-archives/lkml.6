Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrGIgBNbrH9GsGw0p31v0/YUGdfnjqxLpAQxgWgADFeX6u7Oo92Ywm0YNoyLA88Cj5n7uQi
ARC-Seal: i=1; a=rsa-sha256; t=1526937921; cv=none;
        d=google.com; s=arc-20160816;
        b=OSDXTRPvVGahr16j46NPczliru/UcQEuCZo7MF0UtQ8+oUGVcUpJojF4r8mZt/LbSK
         Ep1jUYSFc9rYsQMa3dZ+h9rNJ1CEPdWgIzhENZ5IUNk5vSTaL8Gb2SXgJmVjd2gZ1ofR
         WVLqdn7MUgQgXzSECEPl3w2JisDZp23ZCJdPlSEe6OFOJe9J6//yjmoeKcrBH+4sxeKk
         fGrvEPAIWopd286Vl6ZVq7BbmDWueJ2E9HFdibew9fmhV59O3862d7LsBcMDISGazgzh
         wVFlYD2AACdEgBaUNDgrkmDurbk+jE6E7OV5oYx/8Elfagc8OW/o8vVP0RXi6cdUe+/b
         yJyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=UAO8sapI+DfQNY4BAy1CbzFO9eGDTfgQltsKTq8Zgi8=;
        b=D8nyB0sfgLNt+SUBOmhXQM2/hhP5TmiVvm6KjGoPNGlur6wvz5Ynw+HK4YRth9ob77
         mfvDV1PSLRkoXXCIMpzblmjPSzKk6mKOpQZq76qECjYTqSSOH+A87tcAua0YbdS+qOp5
         0DwQiDjmRu2mEwFWwPu11yHNTnMR1WNz6nZJP6fsZzcBiEKTGakxvMIbWPQCFXGup1Xh
         6Nd+1YLLaskurn2/MT6iq40uATTw5w+YF2DP4ZQ/zvVVnZRylVY1r5kWk8cRJzxcfWLs
         5JoutAPZtmxrb4jYHfN6RAFbqjSp3OU6u80a3wm7zGLhxGI0mTocYQkSshzK7urhZVLU
         DIwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XNh7Jb9+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=XNh7Jb9+;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 075/110] prctl: Add speculation control prctls
Date: Mon, 21 May 2018 23:12:12 +0200
Message-Id: <20180521210512.767717174@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109861377173650?=
X-GMAIL-MSGID: =?utf-8?q?1601110457502571746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -207,4 +207,15 @@ struct prctl_mm_map {
 # define PR_SVE_VL_LEN_MASK		0xffff
 # define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
 
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
@@ -2190,6 +2192,16 @@ static int propagate_has_child_subreaper
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
@@ -2398,6 +2410,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 	case PR_SVE_GET_VL:
 		error = SVE_GET_VL();
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
