Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C650C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05D72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N1esrmTT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfAROwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:52:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbfAROwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mVUzNLXcpo+LrsfKgiU8Ef+j4LmOp60YjCO25YJ9aXA=; b=N1esrmTTEjDH6NcjlyFo2mLxe
        7WMh7pjwVpIWt8TRhimS3yuAXmb2K+BXpfE8Pbt6bODCyxnc+e+rfpD00MIRQqAc3LxwxMyW0gk3c
        1FfcRlQaEOgsc8x+AG6aXFupmn+x/E65CQG7/J5zgJMO1zNhpl3EhXxzCyeiZdmgNQMpryU2zN//D
        LJ/o3yVlJpTF0pLu+J4a7idTuZRXsZl3Rc/7z1ZIaRRYSpLcBZPT+6gOW6sI3pGtgs5zavpVs/ihY
        AVb9truybfyuQgMF3O+jFz+ytxeUOwN/MDbDAwaOrN4lVjruGDBCrM5c0wscwMvSuKpopN2kDLqmi
        5SccNXmDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gkVVf-0007sB-QK; Fri, 18 Jan 2019 14:52:39 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 80FE520289CC4; Fri, 18 Jan 2019 15:52:37 +0100 (CET)
Date:   Fri, 18 Jan 2019 15:52:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: [PATCH/RFC] Make perf_event_open() propagate errors for use in
 bpf_perf_event_open()
Message-ID: <20190118145237.GD27931@hirez.programming.kicks-ass.net>
References: <20190111155538.GX22483@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111155538.GX22483@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:55:38PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi Peter,
> 
> 	bpf_perf_event_open() already returns a value, but if
> perf_event_output's output_begin (mostly perf_output_begin) fails,
> the only way to know about that is looking before/after the rb->lost,
> right?
> 
> 	For ring buffer users that is ok, we'll get a PERF_RECORD_LOST,
> etc, but for BPF programs it would be convenient to get that -ENOSPC and
> do some fallback, whatever makes sense, like in my augmented_syscalls
> stuff for 'perf trace', i.e. don't augment it (i.e. push stuff at the
> end of the normal payload), just don't filter the
> raw_syscalls:sys_enter, 'perf trace' will get the enter syscall enter
> event without the pointer dereference at the end, etc, warn the user but
> don't lose a syscall in the strace-like output.	
> 
> 	What do you think? Am I missing something? Probably ;-)

Seems ok to do this.
