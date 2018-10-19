Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88874ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FBD52064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 08:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WfUULVAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FBD52064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJSQZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 12:25:09 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33472 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbeJSQZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 12:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+wZQ7WnRYCRNys5iRNzlZ/Mhvj3rYoFR8TG01tdeZbg=; b=WfUULVAZUx60aYl0V1eLv1S0K
        mX7WFcdUEFGdympKRWgxptSWvsex7Oqg1Kuofw9ar3eRiV3d3CpcJLcrI6NbzOsIQNFPKbRwvavzv
        VDP4YTiYutBPB4vSnIfGeo2hupSu7YtS9Ue6FFOWRViZfo5ABWCxx1RElPWnxxziQubzx1/xHljIB
        a9cX1kkxWErIF23+pYdaNL/GwUQKqJYqxumX0V9oCvbeLemmJ8liSxnzOxNIh3i+v61QrGORwJHxv
        WXzQ7RraIG1/cYesJpwBPl+rtdOP3MxJroE9DP8wbpvu3LSmAd1XUU6WyjUNGqhevQEuzueux12A1
        KJX5zHE+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gDQ0i-0003Hk-BJ; Fri, 19 Oct 2018 08:19:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA9C72029856B; Fri, 19 Oct 2018 10:19:54 +0200 (CEST)
Date:   Fri, 19 Oct 2018 10:19:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [RFC PATCH 1/5] x86: introduce preemption disable prefix
Message-ID: <20181019081954.GA3121@hirez.programming.kicks-ass.net>
References: <20181018005420.82993-1-namit@vmware.com>
 <20181018005420.82993-2-namit@vmware.com>
 <D247AB7C-2890-49CE-B102-163E5B368FC2@amacapital.net>
 <07255D2B-0243-4254-B62A-37050C44207E@vmware.com>
 <CALCETrXEG8OrMpB3VBS9RF41O_MwtPmXBazkdSGE0ohZmXDcBw@mail.gmail.com>
 <925F22EA-F8CB-4194-B96B-378409ED7918@vmware.com>
 <2626124E-7344-42F3-AD07-0BB34D62A9EE@amacapital.net>
 <6F1FD9DA-5E86-42A2-8EAF-05F5D70FE2EF@vmware.com>
 <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWjeqMs7Z6auStk9VGT9vAn+U5REGE+=TBv1Yh4kmOF3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 09:29:39PM -0700, Andy Lutomirski wrote:

> > Another example is __BPF_PROG_RUN_ARRAY(), which also uses
> > preempt_enable_no_resched().
> 
> Alexei, I think this code is just wrong. Do you know why it uses
> preempt_enable_no_resched()?

Yes, that's a straight up bug.

It looks like I need to go fix up abuse again :/

> Oleg, the code in kernel/signal.c:
> 
>                 preempt_disable();
>                 read_unlock(&tasklist_lock);
>                 preempt_enable_no_resched();
>                 freezable_schedule();
> 

The purpose here is to avoid back-to-back schedule() calls, and this
pattern is one of the few correct uses of preempt_enable_no_resched().

Suppose we got a preemption while holding the read_lock(), then when
we'd do read_unlock(), we'd drop preempt_count to 0 and reschedule, then
when we get back we instantly call into schedule _again_.

What this code does, is it increments preempt_count such that
read_unlock() doesn't hit 0 and doesn't call schedule, then we lower it
to 0 without a call to schedule() and then call schedule() explicitly.

