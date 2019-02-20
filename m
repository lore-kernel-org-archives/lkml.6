Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B268C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9A2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfBTTth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:49:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfBTTtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:49:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 807062086A;
        Wed, 20 Feb 2019 19:49:35 +0000 (UTC)
Date:   Wed, 20 Feb 2019 14:49:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        Juerg Haefliger <juergh@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH] selftests/ftrace: Make the coloring POSIX compliant
Message-ID: <20190220144934.22c52092@gandalf.local.home>
In-Reply-To: <20190220161333.28109-1-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 17:13:33 +0100
Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> echo -e and \e are not POSIX. Depending on what /bin/sh is, we can get
> incorrect output like:

I'm curious to which shell this is.

> $ -e -n [1] Basic trace file check
> $ -e 	[PASS]
> 
> Fix that by using \033 instead of \e and printf.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index fc755e1b50f1..f200898e3e2c 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -161,10 +161,10 @@ color_green=
>  color_blue=
>  # If stdout exists and number of colors is eight or more, use them
>  if [ -t 1 -a "$ncolors" -ge 8 ]; then
> -  color_reset="\e[0m"
> -  color_red="\e[31m"
> -  color_green="\e[32m"
> -  color_blue="\e[34m"
> +  color_reset="\033[0m"
> +  color_red="\033[31m"
> +  color_green="\033[32m"
> +  color_blue="\033[34m"
>  fi
>  
>  strip_esc() {
> @@ -173,8 +173,13 @@ strip_esc() {
>  }
>  
>  prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  newline="\n"
> +  if [ "$1" = "-n" ] ; then
> +    newline=
> +    shift
> +  fi
> +  printf "$@$newline"
> +  [ "$LOG_FILE" ] && printf "$@$newline" | strip_esc >> $LOG_FILE
>  }
>  catlog() { #file
>    cat $1

This should probably be split into two patches, as they are two
different issues.

-- Steve
