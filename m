Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDBP2G (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:28:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751315AbeDBP2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:28:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D1C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 2 Apr 2018 11:28:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: avoid string overflow
Message-ID: <20180402112803.0f1498c2@gandalf.local.home>
In-Reply-To: <20180328140920.2842153-1-arnd@arndb.de>
References: <20180328140920.2842153-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Mar 2018 16:09:10 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> 'err' is used as a NUL-terminated string, but using strncpy() with the length
> equal to the buffer size may result in lack of the termination:
> 
> kernel/trace/trace_events_hist.c: In function 'hist_err_event':
> kernel/trace/trace_events_hist.c:396:3: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>    strncpy(err, var, MAX_FILTER_STR_VAL);
> 
> This changes it to use the safer strscpy() instead.
> 
> Fixes: f404da6e1d46 ("tracing: Add 'last error' error facility for hist triggers")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks! I pulled this in and will push it to git after testing has
succeeded.

-- Steve

> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 4f027642ceef..8357f36d7a1e 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
>  	else if (system)
>  		snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
>  	else
> -		strncpy(err, var, MAX_FILTER_STR_VAL);
> +		strscpy(err, var, MAX_FILTER_STR_VAL);
>  
>  	hist_err(str, err);
>  }
