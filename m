Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeECQT2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 12:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751121AbeECQTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 12:19:23 -0400
Date: Thu, 3 May 2018 12:19:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Federico Vaga <federico.vaga@vaga.pv.it>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] trace-cmd:show: be picky on user argument 'cpu'
Message-ID: <20180503121921.588e3961@gandalf.local.home>
In-Reply-To: <20171206051212.15139-1-federico.vaga@vaga.pv.it>
References: <20171206051212.15139-1-federico.vaga@vaga.pv.it>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Dec 2017 06:12:12 +0100
Federico Vaga <federico.vaga@vaga.pv.it> wrote:

> Before this patch the following command worked without errors:
> 
>     trace-cmd show -c b
> 
> This command opens the CPU0 files. From `strace(1)`:
> 
>     openat(AT_FDCWD, "/sys/kernel/tracing/per_cpu/cpu0/trace", O_RDONLY) = 3

Thanks, I just applied it. Will push it out shortly.

-- Steve

> 
> Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> ---
>  trace-show.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/trace-show.c b/trace-show.c
> index f13db31..7d04012 100644
> --- a/trace-show.c
> +++ b/trace-show.c
> @@ -149,7 +149,14 @@ void trace_show(int argc, char **argv)
>  		file = "snapshot";
>  
>  	if (cpu) {
> -		snprintf(cpu_path, 128, "per_cpu/cpu%d/%s", atoi(cpu), file);
> +		char *endptr;
> +		long val;
> +
> +		errno = 0;
> +		val = strtol(cpu, &endptr, 0);
> +		if (errno || cpu == endptr)
> +			die("Invalid CPU index '%s'", cpu);
> +		snprintf(cpu_path, 128, "per_cpu/cpu%ld/%s", val, file);
>  		file = cpu_path;
>  	}
>  
