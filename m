Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5D1C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E53520815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfACLMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:12:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbfACLMJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:12:09 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C17E8234;
        Thu,  3 Jan 2019 11:12:08 +0000 (UTC)
Received: from krava (unknown [10.43.17.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id B860E5C223;
        Thu,  3 Jan 2019 11:12:06 +0000 (UTC)
Date:   Thu, 3 Jan 2019 12:12:05 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Fix endless wait for child process
Message-ID: <20190103111205.GA26933@krava>
References: <1546501245-4512-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546501245-4512-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 03 Jan 2019 11:12:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 03:40:45PM +0800, Jin Yao wrote:
> We hit a perf stat issue by using following script.
> 
>   #!/bin/bash
> 
>   sleep 1000 &
>   exec perf stat -a -e cycles -I1000 -- sleep 5
> 
> Since "perf stat" is launched by exec, so the "sleep 1000" would be
> the child process of "perf stat". The wait4() will not return because
> it's waiting for the child process "sleep 1000" to be end. So perf
> stat doesn't return even 5s passed.
> 
> This patch lets the perf stat return when the specified child process
> is end (in this case, specified child process is "sleep 5").
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/builtin-stat.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 1410d66..63a3afc 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -561,7 +561,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  					break;
>  			}
>  		}
> -		wait4(child_pid, &status, 0, &stat_config.ru_data);
> +		if (child_pid != -1)
> +			wait4(child_pid, &status, 0, &stat_config.ru_data);
>  
>  		if (workload_exec_errno) {
>  			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
> -- 
> 2.7.4
> 
