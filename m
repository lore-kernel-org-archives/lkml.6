Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeDPQwV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeDPQwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:52:19 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6846C21789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 16 Apr 2018 13:52:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>, hpa@zytor.com,
        Namhyung Kim <namhyung@kernel.org>, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [PATCH 1/3] perf: Return proper values for user stack errors
Message-ID: <20180416165215.GA3202@kernel.org>
References: <20180415092352.12403-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180415092352.12403-1-jolsa@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 15, 2018 at 11:23:50AM +0200, Jiri Olsa escreveu:
> Return immediately when we find issue in the user
> stack checks. The error value could get overwritten
> by following check for PERF_SAMPLE_REGS_INTR.

Applied, together with a:

Cc: Stephane Eranian <eranian@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Fixes: 60e2364e60e8 ("perf: Add ability to sample machine state on interrupt")
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index fc1c330c6bd6..4d997bc064d2 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10191,9 +10191,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
>  		 * __u16 sample size limit.
>  		 */
>  		if (attr->sample_stack_user >= USHRT_MAX)
> -			ret = -EINVAL;
> +			return -EINVAL;
>  		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
> -			ret = -EINVAL;
> +			return -EINVAL;
>  	}
>  
>  	if (!attr->sample_max_stack)
> -- 
> 2.13.6
