Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeBLBzb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:55:31 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:40986 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeBLBza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:55:30 -0500
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 12 Feb 2018 10:55:27 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: changbin.du@intel.com
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] perf ftrace: Fix the buffer size in
 __write_tracing_file
Message-ID: <20180212015527.GE31513@sejong>
References: <1518077600-19615-1-git-send-email-changbin.du@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518077600-19615-1-git-send-email-changbin.du@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 08, 2018 at 04:13:20PM +0800, changbin.du@intel.com wrote:
> From: Changbin Du <changbin.du@intel.com>
> 
> The terminal character '\0' should take into account into size of the
> string buffer. Without this fix, the '--graph-funcs', '--nograph-funcs'
> and '--trace-funcs' options didn't work as expected when the <func>
> doesn't exist. If usersapce writes a non-terminated string, the kernel
> side will always return success but actually no filter applied.
> 
> As discussed before, the kernel now support '\0' to mark the end of string:
> https://lkml.org/lkml/2018/1/16/116
> 
> After this fix in userspace, the perf will report correct error state. Also
> let it print an error if reset_tracing_files() fails.

But what about old kernels?  IIRC there was an error with this change.

Thanks,
Namhyung


> 
> The problem:
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
> Signed-off-by: Changbin Du <changbin.du@intel.com>
> ---
>  tools/perf/builtin-ftrace.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 25a42ac..a87e9b3 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -69,7 +69,7 @@ static int __write_tracing_file(const char *name, const char *val, bool append)
>  {
>  	char *file;
>  	int fd, ret = -1;
> -	ssize_t size = strlen(val);
> +	ssize_t size = strlen(val) + 1;
>  	int flags = O_WRONLY;
>  	char errbuf[512];
>  
> @@ -280,8 +280,10 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
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
