Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeEGPR1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 11:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752036AbeEGPRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 11:17:24 -0400
Date: Mon, 7 May 2018 11:17:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Cc: mhiramat@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/24] selftests: ftrace: return Kselftest Skip code for
 skipped tests
Message-ID: <20180507111721.7f8a6b35@gandalf.local.home>
In-Reply-To: <20180505011328.32078-9-shuah@kernel.org>
References: <20180505011328.32078-1-shuah@kernel.org>
        <20180505011328.32078-9-shuah@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 May 2018 19:13:13 -0600
"Shuah Khan (Samsung OSG)" <shuah@kernel.org> wrote:

> When ftrace test is skipped because of unmet dependencies and/or
> unsupported configuration, it returns 0 which is treated as a pass
> by the Kselftest framework. This leads to false positive result even
> when the test could not be run.
> 
> Change it to return kselftest skip code when a test gets skipped to
> clearly report that the test could not be run.
> 
> Kselftest framework SKIP code is 4 and the framework prints appropriate
> messages to indicate that the test is skipped.
> 

I'm fine with this change, but I believe Masami and perhaps others
have scripts that expect zero return.

If anything, we probably need to have a way to override the ksft_skip
via a command line argument.

Masami?

-- Steve

> Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
> ---
>  tools/testing/selftests/ftrace/ftracetest | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index f9a9d424c980..b731c8cdcffb 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -23,6 +23,9 @@ echo "		            If <dir> is -, all logs output in console only"
>  exit $1
>  }
>  
> +# Kselftest framework requirement - SKIP code is 4.
> +ksft_skip=4
> +
>  errexit() { # message
>    echo "Error: $1" 1>&2
>    exit 1
> @@ -30,7 +33,8 @@ errexit() { # message
>  
>  # Ensuring user privilege
>  if [ `id -u` -ne 0 ]; then
> -  errexit "this must be run by root user"
> +  echo "Skipping: test must be run by root user"
> +  exit $ksft_skip
>  fi
>  
>  # Utilities
> @@ -249,7 +253,7 @@ trap 'SIG_RESULT=$UNTESTED' $SIG_UNTESTED
>  SIG_UNSUPPORTED=$((SIG_BASE + UNSUPPORTED))
>  exit_unsupported () {
>    kill -s $SIG_UNSUPPORTED $SIG_PID
> -  exit 0
> +  exit $ksft_skip
>  }
>  trap 'SIG_RESULT=$UNSUPPORTED' $SIG_UNSUPPORTED
>  
