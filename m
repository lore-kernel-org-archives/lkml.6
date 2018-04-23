Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeDWS71 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 14:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932085AbeDWS70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 14:59:26 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8015321782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 23 Apr 2018 15:59:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, jolsa@redhat.com, acme@redhat.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de, pombredanne@nexb.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH v2 3/3] perf/buildid-cache: Support --purge-all option
Message-ID: <20180423185923.GB3788@kernel.org>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180417041346.5617-4-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417041346.5617-4-ravi.bangoria@linux.vnet.ibm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 17, 2018 at 09:43:46AM +0530, Ravi Bangoria escreveu:
> User can remove files from cache using --remove/--purge options
> but both needs list of files as an argument. It's not convenient
> when you want to flush out entire cache. Add an option to purge
> all files from cache.
> 
> Ex,
>   # perf buildid-cache -l
>     8a86ef73e44067bca52cc3f6cd3e5446c783391c /tmp/a.out
>     ebe71fdcf4b366518cc154d570a33cd461a51c36 /tmp/a.out.1
>   # perf buildid-cache -P -v
>     Removing /tmp/a.out (8a86ef73e44067bca52cc3f6cd3e5446c783391c): Ok
>     Removing /tmp/a.out.1 (ebe71fdcf4b366518cc154d570a33cd461a51c36): Ok
>     Purged all: Ok
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
> index fd0a08661b42..d11226f76fbc 100644
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

err may be used uninitialized, and debian:7 complains with:

  CC       /tmp/build/perf/util/ctype.o
builtin-buildid-cache.c: In function 'cmd_buildid_cache':
builtin-buildid-cache.c:267:2: error: 'err' may be used uninitialized in this function [-Werror=uninitialized]
builtin-buildid-cache.c:247:6: note: 'err' was declared here
  MKDIR    /tmp/build/perf/util/
cc1: all warnings being treated as errors
  CC       /tmp/build/perf/util/db-export.o
mv: cannot stat `/tmp/build/perf/.builtin-buildid-cache.o.tmp': No such file or directory
make[3]: *** [/tmp/build/perf/builtin-buildid-cache.o] Error 1
make[3]: *** Waiting for unfinished jobs....


I'm initializing it to zero.

- Arnaldo
