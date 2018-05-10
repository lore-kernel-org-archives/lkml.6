Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964814AbeEJNCC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 09:02:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934380AbeEJNCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 09:02:01 -0400
Date: Thu, 10 May 2018 15:01:57 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH RFC 01/19] kallsyms: Simplify update_iter_mod()
Message-ID: <20180510130157.GA22679@krava>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
 <1525866228-30321-2-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525866228-30321-2-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2018 at 02:43:30PM +0300, Adrian Hunter wrote:
> Simplify logic in update_iter_mod().
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  kernel/kallsyms.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index a23e21ada81b..eda4b0222dab 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -510,23 +510,15 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
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

hum, should that be iter->pos_mod_end >= pos ?


> -	}
>  
> -	if (!get_ksymbol_mod(iter)) {
> -		if (!get_ksymbol_ftrace_mod(iter))
> -			return get_ksymbol_bpf(iter);
> -	}
> +	if ((!iter->pos_ftrace_mod_end || iter->pos_ftrace_mod_end > pos) &&
> +	    get_ksymbol_ftrace_mod(iter))

same here? iter->pos_ftrace_mod_end >= pos

jirka

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
