Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeCZJj3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 05:39:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54818 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750864AbeCZJj2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 05:39:28 -0400
Date: Mon, 26 Mar 2018 11:39:25 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH v1 2/3] perf version: Print the status of compiled-in
 libraries
Message-ID: <20180326093925.GI6207@krava>
References: <1522080424-12912-1-git-send-email-yao.jin@linux.intel.com>
 <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522080424-12912-3-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 12:07:03AM +0800, Jin Yao wrote:
> This patch checks the values passed by CFLAGS (-DXXX) and then
> print the status of libraries.
> 
> For example, if HAVE_DWARF_SUPPORT is defined, that means the
> library "dwarf" is compiled-in. The patch will print the status
> "on" for this library.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-version.c | 125 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin.h         |   1 +
>  2 files changed, 126 insertions(+)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 37019c5..90a0a7f 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -9,3 +9,128 @@ int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
>  	printf("perf version %s\n", perf_version_string);
>  	return 0;
>  }
> +
> +static void status_print(const char *name, const char *status)
> +{
> +	printf("%22s: [ %3s ]\n", name, status);
> +}
> +
> +static void library_status(void)
> +{
> +#ifdef HAVE_DWARF_SUPPORT
> +	status_print("dwarf", "on");
> +#else
> +	status_print("dwarf", "off");
> +#endif

could this and all those below be in some generic macro?

#define STATUS(__d, __m)		\
#ifdef __d 				\
	status_print(#__m, "on");	\
#else					\
	status_print(#__m, "OFF");	\
#endif

STATUS(HAVE_DWARF_SUPPORT, dwarf)


also please print the 'OFF' and use colors as in the build message

> +
> +#ifdef HAVE_DWARF_GETLOCATIONS
> +	status_print("dwarf_getlocations", "on");
> +#else
> +	status_print("dwarf_getlocations", "off");
> +#endif
> +
> +#ifdef NO_GLIBC
> +	status_print("glibc", "off");
> +#else
> +	status_print("glibc", "on");
> +#endif
> +
> +#ifdef HAVE_GTK2_SUPPORT
> +	status_print("gtk2", "on");
> +#else
> +	status_print("gtk2", "off");
> +#endif
> +

SNIP

> +}
> +
> +int cmd_version2(int argc, const char **argv)
> +{
> +	cmd_version(argc, argv);
> +	library_status();
> +	return 0;
> +}
> diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
> index 05745f3..c7508ee 100644
> --- a/tools/perf/builtin.h
> +++ b/tools/perf/builtin.h
> @@ -29,6 +29,7 @@ int cmd_timechart(int argc, const char **argv);
>  int cmd_top(int argc, const char **argv);
>  int cmd_script(int argc, const char **argv);
>  int cmd_version(int argc, const char **argv);
> +int cmd_version2(int argc, const char **argv);

please don't add new command for this, handle this in cmd_version

thanks,
jirka
