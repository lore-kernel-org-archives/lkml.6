Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeDMM4A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 08:56:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753331AbeDMMz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 08:55:59 -0400
Date: Fri, 13 Apr 2018 14:55:55 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH 2/3] perf/buildid-cache: Support --list option
Message-ID: <20180413125555.GF28241@krava>
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

SNIP

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

missing {} on multiline condition leg

jirka
