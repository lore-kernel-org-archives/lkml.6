Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBFC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51AE2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 14:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51AE2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeLABy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeLABy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 20:54:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D01C20863;
        Fri, 30 Nov 2018 14:45:25 +0000 (UTC)
Date:   Fri, 30 Nov 2018 09:45:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        ldv@altlinux.org, esyr@redhat.com,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: Rough idea of implementing blocking perf calls for system call
 tracepoints
Message-ID: <20181130094523.1bc91052@gandalf.local.home>
In-Reply-To: <20181130140158.GD3617@krava>
References: <20181128134700.212ed035@gandalf.local.home>
        <20181128141808.4b047976@gandalf.local.home>
        <20181130104044.GB3617@krava>
        <20181130114809.GC3617@krava>
        <20181130140158.GD3617@krava>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 15:01:58 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> > or perhaps just tracepoints.. does not seem to make much
> > sense for he events  
> 
> actualy the syscalls seems to be enough for now ;-) I tried
> something and ended up with hack below

Actually, we *only* want to do syscalls. We really don't want to add
blocking to trace events. That would be a nightmare for deadlocks and
such.

I was thinking about adding a PTRACE feature that makes this part of
PTRACE. That is, we start this via PTRACE and let PTRACE signal the
tracer process when the tracee process blocks, and it can then wake up
the tracee process.

A tracer must have PTRACE permissions anyway. The goal of this is to
speed up syscall tracing.

-- Steve
