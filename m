Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeC0M4s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:56:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752394AbeC0M4r (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:56:47 -0400
Date: Tue, 27 Mar 2018 14:56:45 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
Message-ID: <20180327125645.GG3102@krava>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
 <20180326093925.GI6207@krava>
 <6496ab3e-47a4-69ac-76da-18f0b228581f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6496ab3e-47a4-69ac-76da-18f0b228581f@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 09:44:23AM +0800, Jin, Yao wrote:
> 
> 
> On 3/26/2018 5:39 PM, Jiri Olsa wrote:
> > On Tue, Mar 27, 2018 at 12:07:03AM +0800, Jin Yao wrote:
> > > This patch checks the values passed by CFLAGS (-DXXX) and then
> > > print the status of libraries.
> > > 
> > > For example, if HAVE_DWARF_SUPPORT is defined, that means the
> > > library "dwarf" is compiled-in. The patch will print the status
> > > "on" for this library.
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
> > >   tools/perf/builtin.h         |   1 +
> > >   2 files changed, 126 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> > > index 37019c5..90a0a7f 100644
> > > --- a/tools/perf/builtin-version.c
> > > +++ b/tools/perf/builtin-version.c
> > > @@ -9,3 +9,128 @@ int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
> > >   	printf("perf version %s\n", perf_version_string);
> > >   	return 0;
> > >   }
> > > +
> > > +static void status_print(const char *name, const char *status)
> > > +{
> > > +	printf("%22s: [ %3s ]\n", name, status);
> > > +}
> > > +
> > > +static void library_status(void)
> > > +{
> > > +#ifdef HAVE_DWARF_SUPPORT
> > > +	status_print("dwarf", "on");
> > > +#else
> > > +	status_print("dwarf", "off");
> > > +#endif
> > 
> > could this and all those below be in some generic macro?
> > 
> > #define STATUS(__d, __m)		\
> > #ifdef __d 				\
> > 	status_print(#__m, "on");	\
> > #else					\
> > 	status_print(#__m, "OFF");	\
> > #endif
> > 
> > STATUS(HAVE_DWARF_SUPPORT, dwarf)
> > 
> > 
> 
> Hi Jiri,
> 
> I have tried this macro definition, but unfortunately the compilation is
> failed.
> 
> error: '#' is not followed by a macro parameter
>  #define STATUS(__d, __m)  \
> 
> I just guess the '#' in #ifdef confuses the gcc. Looks we can't define
> #ifdef/#endif block in a macro.
> 

ah crap.. right ;-) how about we take the IS_BUILTIN thingie
from include/linux/kconfig.h and use it as in attached test
change.. it gives me:

	[jolsa@krava perf]$ ./perf version
	perf version 4.16.rc6.g1ee9a60
			 dwarf: [  on ]
			 krava: [ OFF ]

we could put those macros into tools/include/tools/config.h, Arnaldo?
together with the comments from kconfig.h that I cut out..

thanks,
jirka


---
diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
index 1fe458792cc1..b392f9e80fd0 100644
--- a/tools/perf/builtin-version.c
+++ b/tools/perf/builtin-version.c
@@ -6,8 +6,33 @@
 
 int version_verbose;
 
+
+#define __ARG_PLACEHOLDER_1 0,
+#define __take_second_arg(__ignored, val, ...) val
+
+#define __is_defined(x)                 ___is_defined(x)
+#define ___is_defined(val)              ____is_defined(__ARG_PLACEHOLDER_##val) 
+#define ____is_defined(arg1_or_junk)    __take_second_arg(arg1_or_junk 1, 0)
+
+#define IS_BUILTIN(option) __is_defined(option)
+
+
+static void status_print(const char *name, const char *status)
+{
+	printf("%22s: [ %3s ]\n", name, status);
+}
+
 int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
 {
 	printf("perf version %s\n", perf_version_string);
+
+#define STATUS(__d, __m)			\
+	if (IS_BUILTIN(__d))			\
+		status_print(#__m, "on");	\
+	else					\
+		status_print(#__m, "OFF");
+
+	STATUS(HAVE_DWARF_SUPPORT, dwarf)
+	STATUS(HAVE_KRAVA_SUPPORT, krava)
 	return 0;
 }
