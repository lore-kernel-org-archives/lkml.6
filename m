Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1D8C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA452086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 18:33:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA452086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeLLSdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 13:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727910AbeLLSdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 13:33:23 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 793642084E;
        Wed, 12 Dec 2018 18:33:22 +0000 (UTC)
Date:   Wed, 12 Dec 2018 13:33:20 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "acme@kernel.org" <acme@kernel.org>
Subject: Re: [PATCH v3 perf, bpf-next 1/4] perf, bpf: Introduce
 PERF_RECORD_BPF_EVENT
Message-ID: <20181212133320.75d5cad8@gandalf.local.home>
In-Reply-To: <20181212180553.GC5289@hirez.programming.kicks-ass.net>
References: <20181211233351.4036381-1-songliubraving@fb.com>
        <20181211233351.4036381-2-songliubraving@fb.com>
        <20181212131549.GZ5289@hirez.programming.kicks-ass.net>
        <C6E2C200-4C86-4EE0-97FA-228C0E0629B1@fb.com>
        <20181212180553.GC5289@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2018 19:05:53 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Dec 12, 2018 at 05:09:17PM +0000, Song Liu wrote:
> > > And while this tracks the bpf kallsyms, it does not do all kallsyms.
> > > 
> > > .... Oooh, I see the problem, everybody is doing their own custom
> > > kallsym_{add,del}() thing, instead of having that in generic code :-(
> > > 
> > > This, for example, doesn't track module load/unload nor ftrace
> > > trampolines, even though both affect kallsyms.  
> > 
> > I think we can use PERF_RECORD_MMAP(or MMAP2) for module load/unload. 
> > That could be separate sets of patches.   
> 
> So I would actually like to move bpf_lock/bpf_kallsyms/bpf_tree +
> bpf_prog_kallsyms_*() + __bpf_address_lookup() into kernel/kallsyms.c
> and also have ftrace use that.
> 
> Because currently the ftrace stuff is otherwise invisible.
> 
> A generic kallsym register/unregister for any JIT.

That's if it needs to look up the symbols that were recorded when init
was unloaded.

The ftrace kallsyms is used to save the function names of init code
that was freed, but may have been recorded. With out the ftrace
kallsyms the functions traced at init time would just show up as hex
addresses (not very useful).

I'm not sure how BPF would need those symbols unless they were executed
during init (module or core) and needed to see what the symbols use to
be).

-- Steve
