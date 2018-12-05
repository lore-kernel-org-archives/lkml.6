Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF3AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9724820879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9724820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeLERfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727429AbeLERfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:35:06 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12FB5206B7;
        Wed,  5 Dec 2018 17:35:06 +0000 (UTC)
Date:   Wed, 5 Dec 2018 12:35:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181205123503.4b8e0484@vmware.local.home>
In-Reply-To: <20181205160509.1168-2-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
        <20181205160509.1168-2-jolsa@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Dec 2018 17:05:02 +0100
Jiri Olsa <jolsa@kernel.org> wrote:

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 3b2490b81918..e55cf9169a03 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -60,6 +60,32 @@ static void do_audit_syscall_entry(struct pt_regs *regs, u32 arch)
>  	}
>  }
>  
> +static void trace_block_syscall(struct pt_regs *regs, bool enter)
> +{
> +	current->perf_blocked = true;
> +
> +	do {
> +		schedule_timeout(100 * HZ);
> +		current->perf_blocked_cnt = 0;
> +
> +		if (enter) {
> +			/* perf syscalls:* enter */
> +			perf_trace_syscall_enter(regs);
> +
> +			/* perf raw_syscalls:* enter */
> +			perf_trace_sys_enter(&event_sys_enter, regs, regs->orig_ax);
> +		} else {
> +			/* perf syscalls:* enter */
> +			perf_trace_syscall_exit(regs);
> +
> +			/* perf raw_syscalls:* enter */
> +			perf_trace_sys_exit(&event_sys_exit, regs, regs->ax);
> +		}
> +	} while (current->perf_blocked_cnt);

I was thinking, if the process reading the perf buffer dies, how do we
tell this task to continue on?

-- Steve

> +
> +	current->perf_blocked = false;
> +}
> +
