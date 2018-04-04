Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752986AbeDDFad (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:30:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeDDFab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:30:31 -0400
Date: Tue, 3 Apr 2018 22:30:10 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-6b416ebcc32c5753214d53c18ac5719c93bc340e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, kan.liang@intel.com, ak@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, acme@redhat.com,
        yao.jin@intel.com, peterz@infradead.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, acme@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        kan.liang@intel.com, mingo@kernel.org, ak@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, yao.jin@intel.com
In-Reply-To: <1522402036-22915-2-git-send-email-yao.jin@linux.intel.com>
References: <1522402036-22915-2-git-send-email-yao.jin@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include: Add config.h header file
Git-Commit-ID: 6b416ebcc32c5753214d53c18ac5719c93bc340e
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

Commit-ID:  6b416ebcc32c5753214d53c18ac5719c93bc340e
Gitweb:     https://git.kernel.org/tip/6b416ebcc32c5753214d53c18ac5719c93bc340e
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 30 Mar 2018 17:27:11 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 2 Apr 2018 13:31:38 -0300

tools include: Add config.h header file

Adding IS_BUILTIN macro and its dependencies into tools world.

It's taken from kernel's include/linux/kconfig.h, which can't be taken
completely due to its kconfig dependencies.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1522402036-22915-2-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/tools/config.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/include/tools/config.h b/tools/include/tools/config.h
new file mode 100644
index 000000000000..08ade7df8132
--- /dev/null
+++ b/tools/include/tools/config.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_CONFIG_H
+#define _TOOLS_CONFIG_H
+
+/* Subset of include/linux/kconfig.h */
+
+#define __ARG_PLACEHOLDER_1 0,
+#define __take_second_arg(__ignored, val, ...) val
+
+/*
+ * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
+ * these only work with boolean and tristate options.
+ */
+
+/*
+ * Getting something that works in C and CPP for an arg that may or may
+ * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
+ * we match on the placeholder define, insert the "0," for arg1 and generate
+ * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
+ * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
+ * the last step cherry picks the 2nd arg, we get a zero.
+ */
+#define __is_defined(x)			___is_defined(x)
+#define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
+#define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
+
+/*
+ * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
+ * otherwise. For boolean options, this is equivalent to
+ * IS_ENABLED(CONFIG_FOO).
+ */
+#define IS_BUILTIN(option) __is_defined(option)
+
+#endif /* _TOOLS_CONFIG_H */
