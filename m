Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753948AbeDPJ1k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbeDPJ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:27:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41342170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Mon, 16 Apr 2018 18:27:35 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: acme@redhat.com, mhiramat@kernel.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH 3/3] perf/buildid-cache: Support --purge-all option
Message-Id: <20180416182735.4399e94b3c7e6d190ec7dc3e@kernel.org>
In-Reply-To: <20180409110633.20767-4-ravi.bangoria@linux.vnet.ibm.com>
References: <20180409110633.20767-1-ravi.bangoria@linux.vnet.ibm.com>
        <20180409110633.20767-4-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Apr 2018 16:36:33 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> User can remove files from cache using --remove/--purge options
> but both needs list of files as an argument. It's not convenient
> when you want to flush out entire cache. Add an option to purge
> all files from cache.
> 
> Ex,
>   # perf buildid-cache -l
>     /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c)
>     /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36)
>   # perf buildid-cache -P -v
>     Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
>     Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
>     Purged all: Ok

Hmm, for purging all caches will be done by

$ rm -rf ~/.debug

Are there any difference?

Thanks,

> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  tools/perf/Documentation/perf-buildid-cache.txt |  3 +++
>  tools/perf/builtin-buildid-cache.c              | 36 ++++++++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
> index 3f285ba6e1f9..f6de0952ff3c 100644
> --- a/tools/perf/Documentation/perf-buildid-cache.txt
> +++ b/tools/perf/Documentation/perf-buildid-cache.txt
> @@ -48,6 +48,9 @@ OPTIONS
>  --purge=::
>          Purge all cached binaries including older caches which have specified
>  	path from the cache.
> +-P::
> +--purge-all::
> +	Purge all cached binaries. This will flush out entire cache.
>  -M::
>  --missing=::
>  	List missing build ids in the cache for the specified file.
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index 50db05bd0cc6..3b4373cabd49 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -240,6 +240,34 @@ static int build_id_cache__purge_path(const char *pathname, struct nsinfo *nsi)
>  	return err;
>  }
>  
> +static int build_id_cache__purge_all(void)
> +{
> +	struct strlist *list;
> +	struct str_node *pos;
> +	int err;
> +	char *buf;
> +
> +	list = build_id_cache__list_all(false);
> +	if (!list) {
> +		pr_debug("Failed to get buildids: -%d\n", errno);
> +		return -EINVAL;
> +	}
> +
> +	strlist__for_each_entry(pos, list) {
> +		buf = build_id_cache__origname(pos->s);
> +		err = build_id_cache__remove_s(pos->s);
> +		pr_debug("Removing %s (%s): %s\n", buf, pos->s,
> +			 err ? "FAIL" : "Ok");
> +		free(buf);
> +		if (err)
> +			break;
> +	}
> +	strlist__delete(list);
> +
> +	pr_debug("Purged all: %s\n", err ? "FAIL" : "Ok");
> +	return err;
> +}
> +
>  static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
>  {
>  	char filename[PATH_MAX];
> @@ -326,6 +354,7 @@ int cmd_buildid_cache(int argc, const char **argv)
>  	bool force = false;
>  	bool list_files = false;
>  	bool opts_flag = false;
> +	bool purge_all = false;
>  	char const *add_name_list_str = NULL,
>  		   *remove_name_list_str = NULL,
>  		   *purge_name_list_str = NULL,
> @@ -349,6 +378,7 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		    "file(s) to remove"),
>  	OPT_STRING('p', "purge", &purge_name_list_str, "file list",
>  		    "file(s) to remove (remove old caches too)"),
> +	OPT_BOOLEAN('P', "purge-all", &purge_all, "purge all cached files"),
>  	OPT_BOOLEAN('l', "list", &list_files, "list all cached files"),
>  	OPT_STRING('M', "missing", &missing_filename, "file",
>  		   "to find missing build ids in the cache"),
> @@ -369,7 +399,8 @@ int cmd_buildid_cache(int argc, const char **argv)
>  
>  	opts_flag = add_name_list_str || kcore_filename ||
>  		remove_name_list_str || purge_name_list_str ||
> -		missing_filename || update_name_list_str;
> +		missing_filename || update_name_list_str ||
> +		purge_all;
>  
>  	if (argc || !(list_files || opts_flag))
>  		usage_with_options(buildid_cache_usage, buildid_cache_options);
> @@ -455,6 +486,9 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		}
>  	}
>  
> +	if (purge_all)
> +		ret = build_id_cache__purge_all();
> +
>  	if (missing_filename)
>  		ret = build_id_cache__fprintf_missing(session, stdout);
>  
> -- 
> 2.14.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
