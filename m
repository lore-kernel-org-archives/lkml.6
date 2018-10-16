Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3D2C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4055D2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4055D2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbeJQBBV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:01:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbeJQBBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:01:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745A72089E;
        Tue, 16 Oct 2018 17:09:58 +0000 (UTC)
Date:   Tue, 16 Oct 2018 13:09:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org (open list),
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] selftests/ftrace: Use colored output when available
Message-ID: <20181016130956.2be3b984@gandalf.local.home>
In-Reply-To: <20181016170220.31156-1-daniel.diaz@linaro.org>
References: <20181016170220.31156-1-daniel.diaz@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Masami,

Does this fix the issues you reported?

-- Steve

On Tue, 16 Oct 2018 12:02:20 -0500
Daniel Díaz <daniel.diaz@linaro.org> wrote:

> If test is being directly executed (with stdout opened on the
> terminal) and the terminal capabilities indicate enough
> colors, then use the existing scheme of green, red, and blue
> to show when tests pass, fail or end in a different way.
> 
> When running the tests redirecting the stdout, for instance,
> to a file, then colors are not shown, thus producing a more
> readable output.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 29 +++++++++++++++++------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index 4946b2edfcff..d987bbec675f 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -152,6 +152,21 @@ else
>    date > $LOG_FILE
>  fi
>  
> +# Define text colors
> +# Check available colors on the terminal, if any
> +ncolors=`tput colors 2>/dev/null`
> +color_reset=
> +color_red=
> +color_green=
> +color_blue=
> +# If stdout exists and number of colors is eight or more, use them
> +if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
> +  color_reset="\e[0m"
> +  color_red="\e[31m"
> +  color_green="\e[32m"
> +  color_blue="\e[34m"
> +fi
> +
>  prlog() { # messages
>    [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE
>  }
> @@ -195,37 +210,37 @@ test_on_instance() { # testfile
>  eval_result() { # sigval
>    case $1 in
>      $PASS)
> -      prlog "	[\e[32mPASS\e[30m]"
> +      prlog "	[${color_green}PASS${color_reset}]"
>        PASSED_CASES="$PASSED_CASES $CASENO"
>        return 0
>      ;;
>      $FAIL)
> -      prlog "	[\e[31mFAIL\e[30m]"
> +      prlog "	[${color_red}FAIL${color_reset}]"
>        FAILED_CASES="$FAILED_CASES $CASENO"
>        return 1 # this is a bug.
>      ;;
>      $UNRESOLVED)
> -      prlog "	[\e[34mUNRESOLVED\e[30m]"
> +      prlog "	[${color_blue}UNRESOLVED${color_reset}]"
>        UNRESOLVED_CASES="$UNRESOLVED_CASES $CASENO"
>        return 1 # this is a kind of bug.. something happened.
>      ;;
>      $UNTESTED)
> -      prlog "	[\e[34mUNTESTED\e[30m]"
> +      prlog "	[${color_blue}UNTESTED${color_reset}]"
>        UNTESTED_CASES="$UNTESTED_CASES $CASENO"
>        return 0
>      ;;
>      $UNSUPPORTED)
> -      prlog "	[\e[34mUNSUPPORTED\e[30m]"
> +      prlog "	[${color_blue}UNSUPPORTED${color_reset}]"
>        UNSUPPORTED_CASES="$UNSUPPORTED_CASES $CASENO"
>        return $UNSUPPORTED_RESULT # depends on use case
>      ;;
>      $XFAIL)
> -      prlog "	[\e[31mXFAIL\e[30m]"
> +      prlog "	[${color_red}XFAIL${color_reset}]"
>        XFAILED_CASES="$XFAILED_CASES $CASENO"
>        return 0
>      ;;
>      *)
> -      prlog "	[\e[34mUNDEFINED\e[30m]"
> +      prlog "	[${color_blue}UNDEFINED${color_reset}]"
>        UNDEFINED_CASES="$UNDEFINED_CASES $CASENO"
>        return 1 # this must be a test bug
>      ;;

