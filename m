Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C23C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC592145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC592145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbeLAC15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbeLAC15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 21:27:57 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 749ED20867;
        Fri, 30 Nov 2018 15:18:17 +0000 (UTC)
Date:   Fri, 30 Nov 2018 10:18:15 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     mingo@redhat.com, akpm@linux-foundation.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] kernel/trace: fix watchdog soft lockup
Message-ID: <20181130101815.75038642@gandalf.local.home>
In-Reply-To: <20181130145622.26334-1-anders.roxell@linaro.org>
References: <20181130145622.26334-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 15:56:22 +0100
Anders Roxell <anders.roxell@linaro.org> wrote:

> When building a allmodconfig kernel for arm64 and boot that in qemu,
> CONFIG_FTRACE_STARTUP_TEST gets enabled and that takes time so the
> watchdog expires and prints out a message like this:
> 'watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]'
> Depending on what the what test gets called from init_trace_selftests()
> it stays minutes in the loop.
> Rework so that function cond_resched() gets called in the
> init_trace_selftests loop.
> 

This looks fine to me. Should it be marked for stable, and pushed into
this release cycle, or wait till the next merge window?

-- Steve

> Co-developed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  kernel/trace/trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 5706599ed534..109becbc81ca 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1547,6 +1547,10 @@ static __init int init_trace_selftests(void)
>  	pr_info("Running postponed tracer tests:\n");
>  
>  	list_for_each_entry_safe(p, n, &postponed_selftests, list) {
> +		/* This loop can take minutes when sanitizers are enabled, so
> +		 * lets make sure we allow RCU processing.
> +		 */
> +		cond_resched();
>  		ret = run_tracer_selftest(p->type);
>  		/* If the test fails, then warn and remove from available_tracers */
>  		if (ret < 0) {

