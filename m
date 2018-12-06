Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76174C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3652420661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dEli7pH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3652420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbeLFIKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:10:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:46310 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeLFIKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RuSKxDTa8+Z9jYfBiTGZgYMi8wq+m7YLY9Nx1eKCr4c=; b=dEli7pH+L6UYZSWsQ/A/wwWZJ
        2Z3Ex8wHFiwUa8NFskQZIVQ/im8Nm+VziwkhK6ZMGpIqvFOP0InxEOI/gzNrS0OZl0K0kUKVL31hZ
        PRbyzRaNHuVJA0ydqeMtPwlzLs6oKhx9y5cEU5f2K5Zil4w8qpfunwF1gOfiUt0ctYHS7S/qujim4
        U2QCZkAkzxlLYa6ewKL4pYw0ZH08MQp8AU+j9PNcGkwsJzNAVKNcBIR3xrSpnenXxSb5hH1OhqOM0
        7W2+Dgu8WLYaBgzYlF0YIu7eBg+1i+VQYA8W1ve+1E2SdWVN5a0Cy1+o59AhHZgjr9/93pQHekuRW
        Szv2MiZ5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUojv-0004tr-Qk; Thu, 06 Dec 2018 08:10:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 435B82029F4C1; Thu,  6 Dec 2018 09:10:28 +0100 (CET)
Date:   Thu, 6 Dec 2018 09:10:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181206081028.GE4234@hirez.programming.kicks-ass.net>
References: <20181205160509.1168-1-jolsa@kernel.org>
 <20181205160509.1168-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205160509.1168-2-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:05:02PM +0100, Jiri Olsa wrote:
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
> +
> +	current->perf_blocked = false;
> +}

I don't understand this.. why are we using schedule_timeout() and all
that?
