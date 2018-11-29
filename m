Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5DB20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C5DB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbeK3Dik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbeK3Dij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:38:39 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 450D820863;
        Thu, 29 Nov 2018 16:32:42 +0000 (UTC)
Date:   Thu, 29 Nov 2018 11:32:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org,
        Daniel =?UTF-8?B?RMOt?= =?UTF-8?B?YXo=?= 
        <daniel.diaz@linaro.org>
Subject: Re: [PATCH] sefltests/ftrace: Use /bin/echo for output with options
Message-ID: <20181129113240.163cbfa9@gandalf.local.home>
In-Reply-To: <154350406317.4422.7595059658374071660.stgit@devbox>
References: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
        <154350406317.4422.7595059658374071660.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 00:07:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Use /bin/echo for console output with options like non
> newline (-n) and/or backslash escape (-e).
> 
> Tom Zanussi reported that when he tested ftracetest, it
> shows "-e" and "-n" options on the console, since a system
> which uses dash as the alias of /bin/sh, uses dash built-in
> echo command which doesn't accept "-e".
> 
> To avoid this issue, use /bin/echo instead of echo for
> the output with options.
> 
> Fixes: 8f381ac4d321 ("selftests/ftrace: Add color to the PASS / FAIL results")
> Link: http://lkml.kernel.org/r/cover.1542221862.git.tom.zanussi@linux.intel.com
> Reported-by: Tom Zanussi <zanussi@kernel.org>
> Suggested-by: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 75244db70331..ba670b452bdb 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -173,8 +173,8 @@ strip_esc() {
>  }
>  
>  prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  /bin/echo -e "$@"
> +  [ "$LOG_FILE" ] && /bin/echo -e "$@" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
>    cat $1

I'm fine with this change but I wonder if we should have a $ECHO that
is defined to something that can be overwritten if need be.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
