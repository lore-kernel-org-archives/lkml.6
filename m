Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB47DC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5964820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5964820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbeLMB0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:34770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbeLMB0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:26:43 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B5A20851;
        Thu, 13 Dec 2018 01:26:41 +0000 (UTC)
Date:   Wed, 12 Dec 2018 20:26:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Eugene Syromyatnikov <esyr@redhat.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf: Allow to block process in syscall tracepoints
Message-ID: <20181212202639.1978ec88@vmware.local.home>
In-Reply-To: <20181213003938.GD24195@altlinux.org>
References: <20181206081028.GE4234@hirez.programming.kicks-ass.net>
        <20181206083400.GA13675@hirez.programming.kicks-ass.net>
        <20181206131946.2c47f556@vmware.local.home>
        <20181207085839.GC2237@hirez.programming.kicks-ass.net>
        <20181207072701.5bc564c7@vmware.local.home>
        <20181207151105.GB5289@hirez.programming.kicks-ass.net>
        <20181207151433.20bf0399@vmware.local.home>
        <20181208104423.GE5289@hirez.programming.kicks-ass.net>
        <20181208123805.1c158665@vmware.local.home>
        <20181210101818.GJ5289@hirez.programming.kicks-ass.net>
        <20181213003938.GD24195@altlinux.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 03:39:38 +0300
"Dmitry V. Levin" <ldv@altlinux.org> wrote:

> btw, I didn't ask for the implementation to be ugly.
> You don't have to introduce polling into the kernel if you don't want to,
> userspace is perfectly capable of invoking wait4(2) in a loop.
> Just block the tracee, notify the tracer, and let it pick up the pieces.

Note, there's been some discussion offlist to only have perf set a flag
when it dropped an event and have the ptrace code do the heavy lifting
of blocking the task and waking it back up. I think that would be a
cleaner solution and wont muck with perf as badly.

-- Steve
