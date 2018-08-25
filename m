Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C5C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E917A21567
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E917A21567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeHYFrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 01:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbeHYFrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 01:47:02 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F0921567;
        Sat, 25 Aug 2018 02:09:50 +0000 (UTC)
Date:   Fri, 24 Aug 2018 22:09:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/32] selftests/ftrace: Add wakeup_rt tracer
 testcase
Message-ID: <20180824220949.2c8ee9a6@vmware.local.home>
In-Reply-To: <153443777214.23257.14428652484801816908.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443777214.23257.14428652484801816908.stgit@devbox>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:42:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add a testcase for wakeup_rt tracer. This requires chrt
> command to test.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  .../selftests/ftrace/test.d/tracer/wakeup_rt.tc    |   25 ++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> new file mode 100644
> index 000000000000..3f279072ec2d
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/tracer/wakeup_rt.tc
> @@ -0,0 +1,25 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL2.0
> +# description: Test wakeup RT tracer
> +
> +if ! which nice ; then
> +  echo "chrt is not found. This test requires chrt command."
> +  exit_unresolved
> +fi
> +
> +if ! grep -wq "wakeup_rt" available_tracers ; then
> +  echo "wakeup_rt tracer is not supported"
> +  exit_unsupported
> +fi
> +
> +echo wakeup > current_tracer

I think you meant "echo wakeup_rt" ;-)

-- Steve

> +echo 1 > tracing_on
> +echo 0 > tracing_max_latency
> +
> +: "Wakeup a realtime task"
> +chrt -f 5 sleep 1
> +
> +echo 0 > tracing_on
> +grep "+ \[[[:digit:]]*\]" trace
> +grep "==> \[[[:digit:]]*\]" trace
> +

