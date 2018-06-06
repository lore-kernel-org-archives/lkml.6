Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ueOLRjFh"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 823756070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752123AbeFFNNn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:13:43 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59650 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFNNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:13:37 -0400
Date: Wed, 6 Jun 2018 15:13:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, rostedt@goodmis.org,
        daniel@iogearbox.net
Subject: Re: [PATCH V4 1/3] kallsyms: Simplify update_iter_mod()
Message-ID: <20180606131302.GB12180@hirez.programming.kicks-ass.net>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528289651-4113-2-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:54:09PM +0300, Adrian Hunter wrote:
> The logic in update_iter_mod() is overcomplicated and gets worse every time
> another get_ksymbol_* function is added.
> 
> In preparation for adding another get_ksymbol_* function, simplify logic in
> update_iter_mod().
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>

Both Daniel and Steven touched this function last year, let's also Cc
them.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  kernel/kallsyms.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index a23e21ada81b..aa31aa07f2ef 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -506,27 +506,24 @@ static void reset_iter(struct kallsym_iter *iter, loff_t new_pos)
>  	}
>  }
>  
> +/*
> + * The end position (last + 1) of each additional kallsyms section is recorded
> + * in iter->pos_..._end as each section is added, and so can be used to
> + * determine which get_ksymbol_...() function to call next.
> + */
>  static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
>  {
>  	iter->pos = pos;
>  
> -	if (iter->pos_ftrace_mod_end > 0 &&
> -	    iter->pos_ftrace_mod_end < iter->pos)
> -		return get_ksymbol_bpf(iter);
> -
> -	if (iter->pos_mod_end > 0 &&
> -	    iter->pos_mod_end < iter->pos) {
> -		if (!get_ksymbol_ftrace_mod(iter))
> -			return get_ksymbol_bpf(iter);
> +	if ((!iter->pos_mod_end || iter->pos_mod_end > pos) &&
> +	    get_ksymbol_mod(iter))
>  		return 1;
> -	}
>  
> -	if (!get_ksymbol_mod(iter)) {
> -		if (!get_ksymbol_ftrace_mod(iter))
> -			return get_ksymbol_bpf(iter);
> -	}
> +	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
> +	    get_ksymbol_ftrace_mod(iter))
> +		return 1;
>  
> -	return 1;
> +	return get_ksymbol_bpf(iter);
>  }
>  
>  /* Returns false if pos at or past end of file. */
> -- 
> 1.9.1
> 
