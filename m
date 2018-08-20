Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358CC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B752170E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 15:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B752170E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeHTSsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 14:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbeHTSsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 14:48:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C093E2170E;
        Mon, 20 Aug 2018 15:32:14 +0000 (UTC)
Date:   Mon, 20 Aug 2018 11:32:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/32] tracing: Allow gcov profiling on only ftrace
 subsystem
Message-ID: <20180820113213.09497e0a@gandalf.local.home>
In-Reply-To: <153443697980.23257.9233992547183322108.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443697980.23257.9233992547183322108.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2018 01:29:39 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Add GCOV_PROFILE_FTRACE to allow gcov profiling
> on only files in ftrace subsystem. This kconfig
> flag will be used for checking kselftest/ftrace

Note, I haven't heard of "kconfig flag" as the terminology. Usually, we
just say "config" or "config option".

> coverage.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/Kconfig  |   13 +++++++++++++
>  kernel/trace/Makefile |    5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index fd6754b88f87..8decf6d8553a 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -774,6 +774,19 @@ config TRACING_EVENTS_GPIO
>  	help
>  	  Enable tracing events for gpio subsystem
>  
> +config GCOV_PROFILE_FTRACE
> +	bool "Enable GCOV profiling on ftrace subsystem"
> +	depends on GCOV_KERNEL
> +	help
> +	  Enable GCOV profiling on ftrace subsystem for checking
> +	  which functions/lines are tested.
> +
> +	  If unsure, say N.
> +
> +	  Note that on a kernel compiled with this flags, ftrace will be
> +	  significantly run slower. So do not enable it for production
> +	  kernel.


I would rewrite the above as:

	Note that on a kernel compiled with this config, ftrace will
	run significantly slower.

I think we can leave out the production sentence. It should be obvious
from the "significantly slower" part.

Other than that, it looks fine to me.

-- Steve

> +
>  endif # FTRACE
>  
>  endif # TRACING_SUPPORT
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 98d53b39a8ee..f81dadbc7c4a 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -23,6 +23,11 @@ ifdef CONFIG_TRACING_BRANCHES
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  endif
>  
> +# for GCOV coverage profiling
> +ifdef CONFIG_GCOV_PROFILE_FTRACE
> +GCOV_PROFILE := y
> +endif
> +
>  CFLAGS_trace_benchmark.o := -I$(src)
>  CFLAGS_trace_events_filter.o := -I$(src)
>  

