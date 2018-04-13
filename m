Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753920AbeDMMzW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:55:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44198 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750940AbeDMMzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:55:20 -0400
Date: Fri, 13 Apr 2018 14:55:15 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH 2/3] perf/buildid-cache: Support --list option
Message-ID: <20180413125515.GE28241@krava>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409110633.20767-3-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 04:36:32PM +0530, Ravi Bangoria wrote:
> Perf buildid-cache allows to add/remove files into cache but there
> is no option to list all cached files. Add --list option to list
> all _valid_ cached files.
> 
> Ex,
>   # perf buildid-cache --add /tmp/a.out
>   # perf buildid-cache -l
>     /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)

could you please make them displayed the same way as in perf buildid-list

[jolsa@krava perf]$ ./perf buildid-list
8b581c1243ade7d7b0f535add0b89405c89dd170 [kernel.kallsyms]
050d0ac0b68aebdcace1290ed4007442ecaef562 /usr/lib64/libc-2.25.so
ac4597b8b29cc9b89a3afbac37332a5d954ee6a4 /usr/lib64/libpthread-2.25.so

thanks,
jirka

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/perf/Documentation/perf-buildid-cache.txt |  4 ++-
>  tools/perf/builtin-buildid-cache.c              | 41 +++++++++++++++++++++++--
>  2 files changed, 41 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
> index 73c2650bd0db..3f285ba6e1f9 100644
> --- a/tools/perf/Documentation/perf-buildid-cache.txt
> +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> @@ -59,7 +59,9 @@ OPTIONS
>  	exactly same build-id, that is replaced by new one. It can be used
>  	to update kallsyms and kernel dso to vmlinux in order to support
>  	annotation.
> -
> +-l::
> +--list::
> +	List all valid binaries from cache.
>  -v::
>  --verbose::
>  	Be more verbose.
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index 41db2cba77eb..50db05bd0cc6 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -25,6 +25,7 @@
>  #include "util/session.h"
>  #include "util/symbol.h"
>  #include "util/time-utils.h"
> +#include "util/probe-file.h"
>  
>  static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
>  {
> @@ -297,6 +298,25 @@ static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
>  	return err;
>  }
>  
> +static void build_id_cache__show_all(void)
> +{
> +	struct strlist *bidlist;
> +	struct str_node *nd;
> +	char *buf;
> +
> +	bidlist = build_id_cache__list_all(true);
> +	if (!bidlist) {
> +		pr_debug("Failed to get buildids: -%d\n", errno);
> +		return;
> +	}
> +	strlist__for_each_entry(nd, bidlist) {
> +		buf = build_id_cache__origname(nd->s);
> +		printf("%s (%s)\n", buf, nd->s);
> +		free(buf);
> +	}
> +	strlist__delete(bidlist);
> +}
> +
>  int cmd_buildid_cache(int argc, const char **argv)
>  {
>  	struct strlist *list;
> @@ -304,6 +324,8 @@ int cmd_buildid_cache(int argc, const char **argv)
>  	int ret = 0;
>  	int ns_id = -1;
>  	bool force = false;
> +	bool list_files = false;
> +	bool opts_flag = false;
>  	char const *add_name_list_str = NULL,
>  		   *remove_name_list_str = NULL,
>  		   *purge_name_list_str = NULL,
> @@ -327,6 +349,7 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		    "file(s) to remove"),
>  	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
>  		    "file(s) to remove (remove old caches too)"),
> +	OPT_BOOLEAN('l', "list", &list_files, "list all cached files"),
>  	OPT_STRING('M', "missing", &missing_filename, "file",
>  		   "to find missing build ids in the cache"),
>  	OPT_BOOLEAN('f', "force", &force, "don't complain, do it"),
> @@ -344,11 +367,18 @@ int cmd_buildid_cache(int argc, const char **argv)
>  	argc = parse_options(argc, argv, buildid_cache_options,
>  			     buildid_cache_usage, 0);
>  
> -	if (argc || (!add_name_list_str && !kcore_filename &&
> -		     !remove_name_list_str && !purge_name_list_str &&
> -		     !missing_filename && !update_name_list_str))
> +	opts_flag = add_name_list_str || kcore_filename ||
> +		remove_name_list_str || purge_name_list_str ||
> +		missing_filename || update_name_list_str;
> +
> +	if (argc || !(list_files || opts_flag))
>  		usage_with_options(buildid_cache_usage, buildid_cache_options);
>  
> +	/* -l is exclusive. It can not be used with other options. */
> +	if (list_files && opts_flag)
> +		usage_with_options_msg(buildid_cache_usage,
> +			buildid_cache_options, "-l is exclusive.\n");
> +
>  	if (ns_id > 0)
>  		nsi = nsinfo__new(ns_id);
>  
> @@ -366,6 +396,11 @@ int cmd_buildid_cache(int argc, const char **argv)
>  
>  	setup_pager();
>  
> +	if (list_files) {
> +		build_id_cache__show_all();
> +		goto out;
> +	}
> +
>  	if (add_name_list_str) {
>  		list = strlist__new(add_name_list_str, NULL);
>  		if (list) {
> -- 
> 2.14.3
> 
