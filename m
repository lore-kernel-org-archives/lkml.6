Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751423AbeBSF6U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 00:58:20 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:41646 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBSF6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 00:58:19 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 19 Feb 2018 14:58:16 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4] perf ftrace: Append an EOL when write tracing files
Message-ID: <20180219055816.GC1583@sejong>
References: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519007609-14551-1-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:33:29AM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> Before this change, the '--graph-funcs', '--nograph-funcs' and
> '--trace-funcs' options didn't work as expected when the <func> doesn't
> exist. Because the kernel side hid possible errors.
> 
> $ sudo ./perf ftrace -a --graph-depth 1 --graph-funcs abcdefg
>  0)   0.140 us    |  rcu_all_qs();
>  3)   0.304 us    |  mutex_unlock();
>  0)   0.153 us    |  find_vma();
>  3)   0.088 us    |  __fsnotify_parent();
>  0)   6.145 us    |  handle_mm_fault();
>  3)   0.089 us    |  fsnotify();
>  3)   0.161 us    |  __sb_end_write();
>  3)   0.710 us    |  SyS_close();
>  3)   7.848 us    |  exit_to_usermode_loop();
> 
> On above example, I specified function filter 'abcdefg' but all functions
> are enabled. The expected error is hidden.
> 
> The original fix is to make the kernel support '\0' as end of string:
> https://lkml.org/lkml/2018/1/16/116
> 
> But above fix cannot be compatible with old kernels. Then Namhyung Kim
> suggest adding a space after function name.
> 
> This patch will append an '\n' when write tracing file. After this fix,
> the perf will report correct error state. Also let it print an error if
> reset_tracing_files() fails.
> 
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Changbin Du <changbin.du@intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> 
> ---
> v4: check strdup() return. (Kim)
> v3: Took Kim's suggestion that add a space after function name.
> v2: Rebase.
> ---
>  tools/perf/builtin-ftrace.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 25a42ac..f42f228 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -72,6 +72,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  	ssize_t size = strlen(val);
>  	int flags = O_WRONLY;
>  	char errbuf[512];
> +	char *val_copy;
>  
>  	file = get_tracing_file(name);
>  	if (!file) {
> @@ -91,12 +92,23 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  		goto out;
>  	}
>  
> -	if (write(fd, val, size) == size)
> +	/*
> +	 * Copy the original value and append a '\n'. Without this,
> +	 * the kernel can hide possible errors.
> +	 */
> +	val_copy = strdup(val);
> +	if (!val_copy)
> +		goto out_close;
> +	val_copy[size] = '\n';
> +
> +	if (write(fd, val_copy, size + 1) == size + 1)
>  		ret = 0;
>  	else
>  		pr_debug("write '%s' to tracing/%s failed: %s\n",
>  			 val, name, str_error_r(errno, errbuf, sizeof(errbuf)));
>  
> +	free(val_copy);
> +out_close:
>  	close(fd);
>  out:
>  	put_tracing_file(file);
> @@ -280,8 +292,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
>  	signal(SIGCHLD, sig_handler);
>  	signal(SIGPIPE, sig_handler);
>  
> -	if (reset_tracing_files(ftrace) < 0)
> +	if (reset_tracing_files(ftrace) < 0) {
> +		pr_err("failed to reset ftrace\n");
>  		goto out;
> +	}
>  
>  	/* reset ftrace buffer */
>  	if (write_tracing_file("trace", "0") < 0)
> -- 
> 2.7.4
> 
