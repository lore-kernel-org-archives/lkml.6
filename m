Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753858AbeC1OcX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 10:32:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:52188 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753609AbeC1OcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 10:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,371,1517904000";
   d="scan'208";a="41445922"
Message-ID: <1522247538.10197.3.camel@tzanussi-mobl.amr.corp.intel.com>
Subject: Re: [PATCH] tracing: avoid string overflow
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>, linux-kernel@vger.kernel.org
Date: Wed, 28 Mar 2018 09:32:18 -0500
In-Reply-To: <20180328140920.2842153-1-arnd@arndb.de>
References: <20180328140920.2842153-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Wed, 2018-03-28 at 16:09 +0200, Arnd Bergmann wrote:
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

Yes, thanks for finding this, and for the patch! 

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
