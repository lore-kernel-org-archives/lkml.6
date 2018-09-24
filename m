Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C092ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31452214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 18:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31452214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733177AbeIYAKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 20:10:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbeIYAKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 20:10:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05E2A30E4EB3;
        Mon, 24 Sep 2018 18:07:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.97])
        by smtp.corp.redhat.com (Postfix) with SMTP id A1BAC53C28;
        Mon, 24 Sep 2018 18:07:18 +0000 (UTC)
Date:   Mon, 24 Sep 2018 20:07:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH v2] tools/lib/traceevent: Replace str_error_r() with an
 open coded implementation
Message-ID: <20180924180717.GD22809@krava>
References: <20180921152037.1e23c7f4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921152037.1e23c7f4@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 24 Sep 2018 18:07:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 03:20:37PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> While working on having PowerTop use libtracevent as a shared object
> library, Tzvetomir hit "str_error_r not defined". This was added by commit
> c3cec9e68f12d ("tools lib traceevent: Use str_error_r()") because
> strerror_r() has two definitions, where one is GNU specific, and the other
> is XSI complient. The strerror_r() is in a wrapper str_error_r() to keep the
> code from having to worry about which compiler is being used.
> 
> The problem is that str_error_r() is external to libtraceevent, and not part
> of the library. If it is used as a shared object then the tools using it
> will need to define that function. I do not want that function defined in
> libtraceevent itself, as it is out of scope for that library.
> 
> As there's only a single instance of this call, I replaced it with an open
> coded algorithm that just uses strerror() and strncpy() to place the error
> message in the given buffer. We don't need to worry about the errors that
> strerror_r() returns. If the buffer isn't big enough, we simply truncate it.
> 
> Reported-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
> 
> Changes from v1:
> 
>  - Account for buflen being zero (do nothing).
> 
>  tools/lib/traceevent/event-parse.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
> index 7980fc6c3bac..ba7570646d2c 100644
> --- a/tools/lib/traceevent/event-parse.c
> +++ b/tools/lib/traceevent/event-parse.c
> @@ -18,7 +18,6 @@
>  #include <errno.h>
>  #include <stdint.h>
>  #include <limits.h>
> -#include <linux/string.h>
>  #include <linux/time64.h>
>  
>  #include <netinet/in.h>
> @@ -6215,7 +6214,12 @@ int tep_strerror(struct tep_handle *pevent __maybe_unused,
>  	const char *msg;
>  
>  	if (errnum >= 0) {
> -		str_error_r(errnum, buf, buflen);
> +		const char *error_str = strerror(errnum);
> +
> +		if (buflen > 0) {
> +			strncpy(buf, error_str, buflen);
> +			buf[buflen - 1] = 0;
> +		}
>  		return 0;
>  	}
>  
> -- 
> 2.13.6
> 
