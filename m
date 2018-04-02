Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeDBQrn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 12:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeDBQrm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 12:47:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2862520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 2 Apr 2018 13:47:38 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 4/6] perf version: Print the compiled-in status of
 libraries
Message-ID: <20180402164738.GA23295@kernel.org>
References: <1522402036-22915-1-git-send-email-yao.jin@linux.intel.com>
 <1522402036-22915-5-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522402036-22915-5-git-send-email-yao.jin@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 30, 2018 at 05:27:14PM +0800, Jin Yao escreveu:
> This patch checks the values passed by CFLAGS (-DHAVE_XXX) and then
> print the status of libraries.
> 
> For example, if HAVE_DWARF_SUPPORT is defined, that means the
> library "dwarf" is compiled-in. The patch will print the status
> "on" for this library otherwise it print the status "OFF".
> 
> A new option '--build-options' created for 'perf version' supports
> the printing of library status.
> 
> For example:
> 
> $ ./perf version --build-options
>     or
>   ./perf --version --build-options
>     or
>   ./perf -v --build-options
> 
> perf version 4.13.rc5.g6727c5
>                  dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
>     dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
>                  glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
>                   gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
>               libaudit: [ OFF ]  # HAVE_LIBAUDIT_SUPPORT

Ok, while testing this I noticed the above, which may be distracting,
i.e. on x86-64 and s/390 not having libaudit means nothing, it is not
needed for anything.

It is only needed for architectures where HAVE_SYSCALL_TABLE is not
defined, that, btw, is not listed here, so I suggest that we stop
printing this "libaudit [ OFF ]" line if HAVE_SYSCALL_TABLE is
available, and also add a line for HAVE_SYSCALL_TABLE.

Anyways, this can be done on top of this series, but please do a grep
looking for other HAVE_* to fix, and we need to rename
HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT...

- Arnaldo

>                 libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
>                 libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
>                libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
> numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
>                libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
>              libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
>               libslang: [ on  ]  # HAVE_SLANG_SUPPORT
>              libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
>              libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
>     libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
>                   zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
>                   lzma: [ on  ]  # HAVE_LZMA_SUPPORT
>              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
>                    bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
> 
> v4:
> ---
> 1. Also print the macro name. That would make it easier
>    to grep around in the source looking for where code
>    related a particular features is located.
> 
> 2. Update since HAVE_DWARF_GETLOCATIONS is renamed to
>    HAVE_DWARF_GETLOCATIONS_SUPPORT
> 
> v3:
> ---
> Remove following unnecessary help message.
> 
> 1. [ on  ]: library is compiled-in
>    [ OFF ]: library is disabled in make configuration
>             OR library is not installed in build environment
> 
> 2. Create '--build-options' option.
> 
> 3. Use standard option parsing API 'parse_options'.
> 
> v2:
> ---
> 1. Use IS_BUILTIN macro to replace #ifdef/#endif block.
> 
> 2. Print color for on/OFF.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-version.c | 82 +++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 81 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> index 37019c5..2abe391 100644
> --- a/tools/perf/builtin-version.c
> +++ b/tools/perf/builtin-version.c
> @@ -1,11 +1,91 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "builtin.h"
>  #include "perf.h"
> +#include "color.h"
>  #include <linux/compiler.h>
> +#include <tools/config.h>
>  #include <stdio.h>
> +#include <string.h>
> +#include <subcmd/parse-options.h>
>  
> -int cmd_version(int argc __maybe_unused, const char **argv __maybe_unused)
> +int version_verbose;
> +
> +struct version {
> +	bool	build_options;
> +};
> +
> +static struct version version;
> +
> +static struct option version_options[] = {
> +	OPT_BOOLEAN(0, "build-options", &version.build_options,
> +		    "display the build options"),
> +};
> +
> +static const char * const version_usage[] = {
> +	"perf version [<options>]",
> +	NULL
> +};
> +
> +static void on_off_print(const char *status)
> +{
> +	printf("[ ");
> +
> +	if (!strcmp(status, "OFF"))
> +		color_fprintf(stdout, PERF_COLOR_RED, "%-3s", status);
> +	else
> +		color_fprintf(stdout, PERF_COLOR_GREEN, "%-3s", status);
> +
> +	printf(" ]");
> +}
> +
> +static void status_print(const char *name, const char *macro,
> +			 const char *status)
>  {
> +	printf("%22s: ", name);
> +	on_off_print(status);
> +	printf("  # %s\n", macro);
> +}
> +
> +#define STATUS(__d, __m)				\
> +do {							\
> +	if (IS_BUILTIN(__d))				\
> +		status_print(#__m, #__d, "on");		\
> +	else						\
> +		status_print(#__m, #__d, "OFF");	\
> +} while (0)
> +
> +static void library_status(void)
> +{
> +	STATUS(HAVE_DWARF_SUPPORT, dwarf);
> +	STATUS(HAVE_DWARF_GETLOCATIONS_SUPPORT, dwarf_getlocations);
> +	STATUS(HAVE_GLIBC_SUPPORT, glibc);
> +	STATUS(HAVE_GTK2_SUPPORT, gtk2);
> +	STATUS(HAVE_LIBAUDIT_SUPPORT, libaudit);
> +	STATUS(HAVE_LIBBFD_SUPPORT, libbfd);
> +	STATUS(HAVE_LIBELF_SUPPORT, libelf);
> +	STATUS(HAVE_LIBNUMA_SUPPORT, libnuma);
> +	STATUS(HAVE_LIBNUMA_SUPPORT, numa_num_possible_cpus);
> +	STATUS(HAVE_LIBPERL_SUPPORT, libperl);
> +	STATUS(HAVE_LIBPYTHON_SUPPORT, libpython);
> +	STATUS(HAVE_SLANG_SUPPORT, libslang);
> +	STATUS(HAVE_LIBCRYPTO_SUPPORT, libcrypto);
> +	STATUS(HAVE_LIBUNWIND_SUPPORT, libunwind);
> +	STATUS(HAVE_DWARF_SUPPORT, libdw-dwarf-unwind);
> +	STATUS(HAVE_ZLIB_SUPPORT, zlib);
> +	STATUS(HAVE_LZMA_SUPPORT, lzma);
> +	STATUS(HAVE_AUXTRACE_SUPPORT, get_cpuid);
> +	STATUS(HAVE_LIBBPF_SUPPORT, bpf);
> +}
> +
> +int cmd_version(int argc, const char **argv)
> +{
> +	argc = parse_options(argc, argv, version_options, version_usage,
> +			     PARSE_OPT_STOP_AT_NON_OPTION);
> +
>  	printf("perf version %s\n", perf_version_string);
> +
> +	if (version.build_options || version_verbose == 1)
> +		library_status();
> +
>  	return 0;
>  }
> -- 
> 2.7.4
