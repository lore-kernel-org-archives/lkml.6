Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966343AbeEJPh6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966093AbeEJPh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:37:56 -0400
Date: Fri, 11 May 2018 00:37:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: acme@kernel.org, jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf buildid-cache: Warn --purge-all failures
Message-Id: <20180511003752.7790aac3b7967f454fdd0c7f@kernel.org>
In-Reply-To: <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
References: <20180510102808.5fcc479ccda0dd0eb08b7383@kernel.org>
        <20180510043651.12189-1-ravi.bangoria@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 May 2018 10:06:51 +0530
Ravi Bangoria <ravi.bangoria@linux.ibm.com> wrote:

> Warn perf buildid-cache --purge-all failures in non verbose mode.
> Ex,
> 
>   $ sudo chown root:root /home/ravi/.debug -R
>   $ sudo chmod 700 /home/ravi/.debug/ -R
>   $ ./perf buildid-cache -P
>     Couldn't remove some caches. Error: Permission denied.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> ---
>  tools/perf/builtin-buildid-cache.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
> index 7a7403913b57..ef6b3cc8d57d 100644
> --- a/tools/perf/builtin-buildid-cache.c
> +++ b/tools/perf/builtin-buildid-cache.c
> @@ -488,8 +488,12 @@ int cmd_buildid_cache(int argc, const char **argv)
>  		}
>  	}
>  
> -	if (purge_all)
> -		ret = build_id_cache__purge_all();
> +	if (purge_all) {
> +		if (build_id_cache__purge_all()) {
> +			pr_warning("Couldn't remove some caches. Error: %s.\n",
> +				str_error_r(errno, sbuf, sizeof(sbuf)));
> +		}
> +	}
>  
>  	if (missing_filename)
>  		ret = build_id_cache__fprintf_missing(session, stdout);
> -- 
> 2.14.3
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
