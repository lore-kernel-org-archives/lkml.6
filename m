Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeCZQvf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751782AbeCZQve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:51:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6F82172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 26 Mar 2018 12:51:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: fix stddev calculation in function profiler
 (again)
Message-ID: <20180326125131.15fba249@gandalf.local.home>
In-Reply-To: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
References: <f208c5c360f1e86327b0adbb879d61f4779e8ddd.1521908409.git.mschiffer@universe-factory.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2018 17:26:38 +0100
Matthias Schiffer <mschiffer@universe-factory.net> wrote:

> @@ -905,8 +898,20 @@ static void profile_graph_return(struct ftrace_graph_ret *trace)
>  
>  	rec = ftrace_find_profiled_func(stat, trace->func);
>  	if (rec) {
> +		unsigned long long avg, delta1, delta2;
> +
>  		rec->time += calltime;
> -		rec->time_squared += calltime * calltime;
> +
> +		/* Apply Welford's method */
> +		delta1 = calltime - rec->avg;
> +
> +		avg = rec->time;
> +		do_div(avg, rec->counter);

Can you find a way not to do a divide in every function call?

-- Steve

> +		rec->avg = avg;
> +
> +		delta2 = calltime - rec->avg;
> +
> +		rec->stddev += delta1 * delta2;
>  	}
>  
>   out:
