Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752582AbeDXT1l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:27:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752395AbeDXT1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:27:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8027F21774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 24 Apr 2018 16:27:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Josh Hunt <johunt@akamai.com>
Cc: Andi Kleen <ak@linux.intel.com>, Pekka Enberg <penberg@cs.helsinki.fi>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] perf tools: allow map files to specify DSO
Message-ID: <20180424192731.GC4427@kernel.org>
References: <1524595749-26688-1-git-send-email-johunt@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524595749-26688-1-git-send-email-johunt@akamai.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 24, 2018 at 02:49:09PM -0400, Josh Hunt escreveu:
> Add the ability to specify a DSO in the /tmp/perf-<PID>.map file.
> The DSO should be the first line in the file and readable by the
> running user. If a valid DSO is found all other contents of the
> file will be ignored. This allows things like callchain unwinding
> with DWARF to work.

Pekka, Andi, Stephane, do you guys see any problems with this?

If this flies, tools/perf/Documentation/jit-interface.txt needs
updating.

- Arnaldo
 
> Suggested-by: Wang Nan <wangnan0@huawei.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> 
> ---
> We have an application which uses huge pages for its text section, but
> still needs the ability to do callchain unwinding with DWARF. We use
> the perf-<PID>.map file setup to do symbol resolution and that works
> great, but callchain unwinding fails.
> 
> A few months ago I mentioned this to Wang Nan and he suggested a way
> around this problem could be to specify the path of the DSO in the map
> file. The attached patch is my initial hack at this. Running with this
> patch I can now get full callchain unwinding with DWARF.
> 
> FWIW LBR + map file works with callchains, but unfortunately there are
> some cases where we still need DWARF.
> 
> I was hoping to get feedback on whether this is the right way to solve
> this problem, and if not what should I do to get this working? If the
> idea is OK I will clean this up and resubmit an official patch. Current
> patch is against 4.14 stable.
> 
> Thanks!
> ---
>  tools/perf/util/map.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 4e7bd2750122..98d6af2c854d 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -143,12 +143,37 @@ void map__init(struct map *map, enum map_type type,
>  	RB_CLEAR_NODE(&map->rb_node);
>  	map->groups   = NULL;
>  	map->erange_warned = false;
>  	refcount_set(&map->refcnt, 1);
>  }
>  
> +static bool replace_anon(char *mapfilename)
> +{
> +	FILE *file = NULL;
> +	bool ret = false;
> +
> +	file = fopen(mapfilename, "r");
> +	if (file != NULL) {
> +		char *line;
> +		size_t line_len, linesz=0;
> +
> +		line_len = getline(&line, &linesz, file);
> +		if (line_len > 0) {
> +			line[--line_len] = '\0';
> +			if (!access(line, R_OK)) {
> +				strlcpy(mapfilename, line, line_len+1);
> +				ret = true;
> +			}
> +			free(line);
> +		}
> +		fclose(file);
> +	}
> +
> +	return ret;
> +}
> +
>  struct map *map__new(struct machine *machine, u64 start, u64 len,
>  		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
>  		     u64 ino_gen, u32 prot, u32 flags, char *filename,
>  		     enum map_type type, struct thread *thread)
>  {
>  	struct map *map = malloc(sizeof(*map));
> @@ -174,12 +199,19 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>  		nsi = nsinfo__get(thread->nsinfo);
>  
>  		if ((anon || no_dso) && nsi && type == MAP__FUNCTION) {
>  			snprintf(newfilename, sizeof(newfilename),
>  				 "/tmp/perf-%d.map", nsi->pid);
>  			filename = newfilename;
> +			/*
> +			 * Check to see if map file references DSO to use, if so, use it.
> +			 */
> +			if (anon && replace_anon(newfilename)) {
> +				anon = 0;
> +				filename = newfilename;
> +			}
>  		}
>  
>  		if (android) {
>  			if (replace_android_lib(filename, newfilename))
>  				filename = newfilename;
>  		}
> -- 
> 1.9.1
