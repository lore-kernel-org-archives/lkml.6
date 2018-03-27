Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeC0Nf5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 09:35:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47676 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752279AbeC0Nf4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 09:35:56 -0400
Date: Tue, 27 Mar 2018 15:35:53 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
Message-ID: <20180327133553.GH3102@krava>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
 <20180326093925.GI6207@krava>
 <6496ab3e-47a4-69ac-76da-18f0b228581f@linux.intel.com>
 <20180327125645.GG3102@krava>
 <4c2cc31c-3701-3c37-6c81-cb226bc71e17@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2cc31c-3701-3c37-6c81-cb226bc71e17@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 09:17:57PM +0800, Jin, Yao wrote:

SNIP

> > +#define IS_BUILTIN(option) __is_defined(option)
> > +
> > +
> > +static void status_print(const char *name, const char *status)
> > +{
> > +	printf("%22s: [ %3s ]\n", name, status);
> > +}
> > +
> >   int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
> >   {
> >   	printf("perf version %s\n", perf_version_string);
> > +
> > +#define STATUS(__d, __m)			\
> > +	if (IS_BUILTIN(__d))			\
> > +		status_print(#__m, "on");	\
> > +	else					\
> > +		status_print(#__m, "OFF");
> > +
> > +	STATUS(HAVE_DWARF_SUPPORT, dwarf)
> > +	STATUS(HAVE_KRAVA_SUPPORT, krava)
> >   	return 0;
> >   }
> > 
> 
> Hi Jiri,
> 
> It looks we need to copy the IS_BUILTIN and associated macro definitions to
> a common header file.
> 
> I guess you will post this patch if Arnaldo agree with this idea, right?
> 
> I plan to post v2 of this patch series after this 'IS_BUILTIN' patch gets
> merged.


please post patch below with your patchset
and feel free to change it if needed

thanks,
jirka


---
>From bdd36e208bde1576bba54679734174c9a2064822 Mon Sep 17 00:00:00 2001
From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Mar 2018 15:30:26 +0200
Subject: [PATCH] tools include: Add config.h header file

Adding IS_BUILTIN macro and its dependencies into
tools world.

It's taken from kernel's include/linux/kconfig.h,
which can't be taken completely due to its kconfig
dependencies.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/tools/config.h | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 tools/include/tools/config.h

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
-- 
2.13.6
