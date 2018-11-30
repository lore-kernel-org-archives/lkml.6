Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5203C2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5203C2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLACb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbeLACb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:31:56 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8724C20868;
        Fri, 30 Nov 2018 15:22:15 +0000 (UTC)
Date:   Fri, 30 Nov 2018 10:22:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, keescook@chromium.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] tracing: instruct KCOV not to track tracing files
Message-ID: <20181130102214.21e1f8f6@gandalf.local.home>
In-Reply-To: <20181130150935.27493-1-anders.roxell@linaro.org>
References: <20181130150935.27493-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 16:09:35 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> When we have KCOV enabled and running ftrace startup tests we end up in
> a softlockup. Kcov and ftrace tracing each other makes it really slow:
> 
> [  275.141388] Testing tracer wakeup_dl:  PASSED
> [  304.738345] Testing tracer function_graph:
> [  716.236822] watchdog: BUG: soft lockup - CPU#0 stuck for 21s! [ksoftirqd/0:9]
> 
> Rework so that we don't let KCOV look at tracing files. Could probably
> be more selective here, but in in general letting KCOV and ftrace check
> each isn't the best idea.
> 
> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f81dadbc7c4a..c7c73b976103 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -6,6 +6,11 @@ ifdef CONFIG_FUNCTION_TRACER
>  ORIG_CFLAGS := $(KBUILD_CFLAGS)
>  KBUILD_CFLAGS = $(subst $(CC_FLAGS_FTRACE),,$(ORIG_CFLAGS))
>  
> +# If instrumentation of this dir is enabled, the function tracer gets really
> +# slow. Probably could be more selective here, but note that files related
> +# to tracing.shouldn't be traced anyway.
> +KCOV_INSTRUMENT		:= n
> +

The entire directory is also set to not be traced by function tracing,
which also is a bit overkill, as there's functions in this directory
that can (and probably should) be.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  ifdef CONFIG_FTRACE_SELFTEST
>  # selftest needs instrumentation
>  CFLAGS_trace_selftest_dynamic.o = $(CC_FLAGS_FTRACE)

