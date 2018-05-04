Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeEDPkj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 11:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbeEDPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 11:40:38 -0400
Date: Fri, 4 May 2018 11:40:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michal Suchanek <msuchanek@suse.de>
Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        Gargi Sharma <gs051095@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init/main.c: simplify repair_env_string
Message-ID: <20180504114035.111ad8f7@gandalf.local.home>
In-Reply-To: <20171215213317.3151-1-msuchanek@suse.de>
References: <151075904367.14434.5164139208561977016.stgit@hbathini.in.ibm.com>
        <20171215213317.3151-1-msuchanek@suse.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Cleaning out my INBOX, I stumbled across this old patch.

On Fri, 15 Dec 2017 22:33:17 +0100
Michal Suchanek <msuchanek@suse.de> wrote:

> Quoting characters are now removed from the parameter so value always
> follows directly after the NUL terminating parameter name.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  init/main.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> Since the previous "[PATCH v9 3/8] lib/cmdline.c: add backslash support to
> kernel commandline parsing" adds the memmove in lib/cmdline.c it is now
> superfluous in init/main.c

I don't believe the above patches were ever applied. Were they?

-- Steve

> 
> diff --git a/init/main.c b/init/main.c
> index 1f5fdedbb293..1e5b1dc940d9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -244,15 +244,10 @@ static int __init repair_env_string(char *param, char *val,
>  				    const char *unused, void *arg)
>  {
>  	if (val) {
> -		/* param=val or param="val"? */
> -		if (val == param+strlen(param)+1)
> -			val[-1] = '=';
> -		else if (val == param+strlen(param)+2) {
> -			val[-2] = '=';
> -			memmove(val-1, val, strlen(val)+1);
> -			val--;
> -		} else
> -			BUG();
> +		int parm_len = strlen(param);
> +
> +		param[parm_len] = '=';
> +		BUG_ON(val != param + parm_len + 1);
>  	}
>  	return 0;
>  }
