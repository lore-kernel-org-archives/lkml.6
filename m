Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84909C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BE520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 14:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I1RlrjI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42BE520663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbeK0Bod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 20:44:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:38084 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeK0Bod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 20:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tJDoSTdmerAi+AU8XyQvIDTGN4XEhb9pHsS9xMEDTcM=; b=I1RlrjI1YrF2lWelWgXKRZGJM
        04eBLTNb5g1K+CZ6OZ5HyTmyB751SQFXqb7QdIyrt44X2hpy1IGIkxbkfegHDhQuH6ffdYCatHkTs
        jtzjFtipbZYzXU7jfhs1j7E3CQd/MIRr+MvIcSnMN7Cbcj8zcjBszJaE771q1wZs5hCL3De37W9rN
        KH10ldKBR8ttqT/NKdulXqAWUBWTFq27q8meLOQXisSchQLzo8T7x3OSsnQOWg3J9MSJYtWk16iro
        wJgvqnOk53d+WmZmCGNX7rboFu0FTA+mr9RBEhZuzd3ARXsGrhG5nORnl6ns+IVAwW8CqYf+MzPhE
        29rGMZDNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRID8-00014g-Tm; Mon, 26 Nov 2018 14:50:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 465102029FD58; Mon, 26 Nov 2018 15:50:04 +0100 (CET)
Date:   Mon, 26 Nov 2018 15:50:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "acme@kernel.org" <acme@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH perf,bpf 0/5] reveal invisible bpf programs
Message-ID: <20181126145004.GO2113@hirez.programming.kicks-ass.net>
References: <20181121195502.3259930-1-songliubraving@fb.com>
 <20181122093219.GK2131@hirez.programming.kicks-ass.net>
 <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71189F83-A09F-4A03-95EC-694D37FD7675@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 06:13:32PM +0000, Song Liu wrote:
> Hi Peter,
> 
> > On Nov 22, 2018, at 1:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Wed, Nov 21, 2018 at 11:54:57AM -0800, Song Liu wrote:
> >> Changes RFC -> PATCH v1:
> >> 
> >> 1. In perf-record, poll vip events in a separate thread;
> >> 2. Add tag to bpf prog name;
> >> 3. Small refactorings.
> >> 
> >> Original cover letter (with minor revisions):
> >> 
> >> This is to follow up Alexei's early effort to show bpf programs

> >> In this version, PERF_RECORD_BPF_EVENT is introduced to send real time BPF
> >> load/unload events to user space. In user space, perf-record is modified
> >> to listen to these events (through a dedicated ring buffer) and generate
> >> detailed information about the program (struct bpf_prog_info_event). Then,
> >> perf-report translates these events into proper symbols.
> >> 
> >> With this set, perf-report will show bpf program as:
> >> 
> >>   18.49%     0.16%  test  [kernel.vmlinux]    [k] ksys_write
> >>   18.01%     0.47%  test  [kernel.vmlinux]    [k] vfs_write
> >>   17.02%     0.40%  test  bpf_prog            [k] bpf_prog_07367f7ba80df72b_
> >>   16.97%     0.10%  test  [kernel.vmlinux]    [k] __vfs_write
> >>   16.86%     0.12%  test  [kernel.vmlinux]    [k] comm_write
> >>   16.67%     0.39%  test  [kernel.vmlinux]    [k] bpf_probe_read
> >> 
> >> Note that, the program name is still work in progress, it will be cleaner
> >> with function types in BTF.
> >> 
> >> Please share your comments on this.
> > 
> > So I see:
> > 
> >  kernel/bpf/core.c:void bpf_prog_kallsyms_add(struct bpf_prog *fp)
> > 
> > which should already provide basic symbol information for extant eBPF
> > programs, right?
> 
> Right, if the BPF program is still loaded when perf-report runs, symbols 
> are available. 

Good, that is not something that was clear. The Changelog seems to imply
we need this new stuff in order to observe symbols.

> > And (AFAIK) perf uses /proc/kcore for annotate on the current running
> > kernel (if not, it really should, given alternatives, jump_labels and
> > all other other self-modifying code).
> > 
> > So this fancy new stuff is only for the case where your profile spans
> > eBPF load/unload events (which should be relatively rare in the normal
> > case, right), or when you want source annotated asm output (I normally
> > don't bother with that).
> 
> This patch set adds two pieces of information:
> 1. At the beginning of perf-record, save info of existing BPF programs;
> 2. Gather information of BPF programs load/unload during perf-record. 
> 
> (1) is all in user space. It is necessary to show symbols of BPF program
> that are unloaded _after_ perf-record. (2) needs PERF_RECORD_BPF_EVENT 
> from the ring buffer. It covers BPF program loaded during perf-record 
> (perf record -- bpf_test). 

I'm saying that if you given them symbols; most people won't need any of
that ever.

And just tracking kallsyms is _much_ cheaper than either 1 or 2. Alexei
was talking fairly big amounts of data per BPF prog. Dumping and saving
that sounds like pointless overhead for 99% of the users.

> > That is; I would really like this fancy stuff to be an optional extra
> > that is typically not needed.
> > 
> > Does that make sense?
> 
> (1) above is always enabled with this set. I added option no-bpf-events 
> to disable (2). I guess you prefer the (2) is disabled by default, and 
> enabled with an option?

I'm saying neither should be default enabled. Instead we should do
recording and tracking by default.

That gets people symbol information on BPF stuff, which is likely all
they ever need.

If they then decide they need more, then and only then can they enable
the fancy pants bpf-synchronous-syscall nonsense thingy. And like I said
before; I don't bother with source annotated asm output for
perf-annotate.

And if the bpf prog is still loaded, kcore should contain the raw jitted
asm just fine; you again don't need the bpf syscall stuff.


Now, I'm not saying this patch set is useless; but I'm saying most
people should not need this, and it is massive overkill for the needs of
most people.
