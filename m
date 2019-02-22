Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 480E82077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550874834;
	bh=4UEYN2wZ5gn5ZieIRiW0Qys21spNlzU0IAEyvf/f4nQ=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=NMHLtOmwbxohQLEETU3I6HHwGxxqwsdX9y2fMgmfg5UjPcaAG0j8tHLoo6XVQuFkZ
	 DOGqwMoFyBLvmFT1KSQmAuNEyMHgqTFY+TZ/0E6cK6GJtrgaCkxLw3RdDt78vIG9Ki
	 AJZ2kHdskqWF3N33IZ5rvlpRDojzP/83Df0KUDVs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfBVWdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:33:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:59738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfBVWdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:33:52 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26FA02075A;
        Fri, 22 Feb 2019 22:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550874831;
        bh=4UEYN2wZ5gn5ZieIRiW0Qys21spNlzU0IAEyvf/f4nQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=icySqi3ffxc1SGwtcC/U7X2JbLC4vhTfE+XT0baLHfp3ovBIyG5mKIHOYjUxZ4L1Z
         l6MNioU+NvFJJc+f4ojm90m+kfzCEJHzAowvRNPKdLngcTD3ZmCMHDMxJq0lLqu08j
         NA3KuiXZCLAbAg0XhkExMzD1p+jf8GskoSZ6JPIk=
Subject: Re: [RESEND PATCH v2 1/2] selftests/ftrace: Replace echo -e with
 printf
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, mhiramat@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Juerg Haefliger <juergh@canonical.com>, shuah <shuah@kernel.org>
References: <20190222091021.10178-1-juergh@canonical.com>
 <20190222205351.743-1-juergh@canonical.com>
 <20190222205351.743-2-juergh@canonical.com>
From:   shuah <shuah@kernel.org>
Message-ID: <93621fe0-c098-ac00-f780-043be5925917@kernel.org>
Date:   Fri, 22 Feb 2019 15:33:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190222205351.743-2-juergh@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 1:53 PM, Juerg Haefliger wrote:
> echo -e is not POSIX. Depending on what /bin/sh is, we can get
> incorrect output like:
> $ -e -n [1] Basic trace file check
> $ -e 	[PASS]
> 
> Fix that by using printf instead.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> ---
>   tools/testing/selftests/ftrace/ftracetest | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
> index fc755e1b50f1..20c9c0ad8682 100755
> --- a/tools/testing/selftests/ftrace/ftracetest
> +++ b/tools/testing/selftests/ftrace/ftracetest
> @@ -173,8 +173,13 @@ strip_esc() {
>   }
>   
>   prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  newline="\n"
> +  if [ "$1" = "-n" ] ; then
> +    newline=
> +    shift
> +  fi
> +  printf "$*$newline"
> +  [ "$LOG_FILE" ] && printf "$*$newline" | strip_esc >> $LOG_FILE
>   }
>   catlog() { #file
>     cat $1
> 

This patch applied to linux-kselftest next which is at 5.0rc6
I queued this for 5.1-rc1.

thanks,
-- Shuah
