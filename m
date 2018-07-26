Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667B2C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172612088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkH0ZX7a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172612088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeGZI7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728378AbeGZI7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:59:47 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DE9E20846;
        Thu, 26 Jul 2018 07:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532591052;
        bh=kBdywguMTd62VR+NSC2BOKbEq5R0Dkg5BFLFDsrW8HM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XkH0ZX7aDUjY8RpinUy6D8GY9z9ZGi/6Sj4A1NceB038ghpwTRTkM9Xcv5F6DjRQ2
         KSYalyVWlWswClhEOJYEIvSTPzAXWNRvNXxnA6Wckj645YUjCzOOQebkdZl6qaw/tY
         58C/vA5Eeh9Fcg9BtNn2rzopYqX15RUvKHLKSKg0=
Date:   Thu, 26 Jul 2018 16:44:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     rostedt@goodmis.org,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        peterz@infradead.org, mathieu.desnoyers@efficios.com,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org
Subject: Re: [PATCH v2 3/3] selftests/ftrace: Fix kprobe string testcase to
 not probe notrace function
Message-Id: <20180726164409.c4967698668b1816a8e9747c@kernel.org>
In-Reply-To: <153258446365.11602.5245508133014563916.stgit@devbox>
References: <153258437722.11602.12405835083073480618.stgit@devbox>
        <153258446365.11602.5245508133014563916.stgit@devbox>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 14:54:23 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix kprobe string argument testcase to not probe notrace
> function. Instead, it probes tracefs function which must
> be available with ftrace.

Oops, this must be sent to Shuah too.

Shuah, I think you can freely pick this patch to kselftest
branch, since this removes a dependency of notrace functions,
not depends on any new feature :)

Thank you,

> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++++++------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index a0002563e9ee..1ad70cdaf442 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -9,28 +9,22 @@ echo > kprobe_events
>  
>  case `uname -m` in
>  x86_64)
> -  ARG2=%si
> -  OFFS=8
> +  ARG1=%di
>  ;;
>  i[3456]86)
> -  ARG2=%cx
> -  OFFS=4
> +  ARG1=%ax
>  ;;
>  aarch64)
> -  ARG2=%x1
> -  OFFS=8
> +  ARG1=%x0
>  ;;
>  arm*)
> -  ARG2=%r1
> -  OFFS=4
> +  ARG1=%r0
>  ;;
>  ppc64*)
> -  ARG2=%r4
> -  OFFS=8
> +  ARG1=%r3
>  ;;
>  ppc*)
> -  ARG2=%r4
> -  OFFS=4
> +  ARG1=%r3
>  ;;
>  *)
>    echo "Please implement other architecture here"
> @@ -38,17 +32,17 @@ ppc*)
>  esac
>  
>  : "Test get argument (1)"
> -echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
> +echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
> -! echo test >> kprobe_events
> -tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
> +echo "p:test _do_fork" >> kprobe_events
> +grep -qe "testprobe.* arg1=\"test\"" trace
>  
>  echo 0 > events/kprobes/testprobe/enable
>  : "Test get argument (2)"
> -echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
> +echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
>  echo 1 > events/kprobes/testprobe/enable
> -! echo test1 test2 >> kprobe_events
> -tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
> +echo "p:test _do_fork" >> kprobe_events
> +grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
>  
>  echo 0 > events/enable
>  echo > kprobe_events
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
