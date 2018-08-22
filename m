Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC92C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4AC214DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XVm80Tbv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4AC214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeHVMcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:32:33 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48482 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbeHVMcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2MlIghxPQNJMxSSvYcJQ6trD5NkfV7M80jjYoTVNm1k=; b=XVm80Tbv0ALcd0XUwYMtmRmWR
        3QXLNvlPIBBwbxoKRPeugLbDxPOWJ0qp8cBMXWy4k8SIu2HQl7kEL2ikye5jMZxJJu8K/RtFVcvUY
        Nu9W5GMNJFDe7i5ESrjoV1PDaZnr7g46L7JRq0NzhAZA3uP2A0oHRxcFxQAdbU0FVdrMmyh9zU7OT
        mNFWL2/P/B+QJYv6QmxqRdguMfTMAxWpYEt0AeIjC6Mv0CdfKeSdFWs81aQNa5hJpCx8J/TH1neeP
        OCQRkcYDoGFifXylADdq3j30/SFYpJnPkuG/5t/A17O1qIW3HOPAQFSx6HdDCd6/TdCE4JtFtSQL7
        7w0vdWaDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsP7p-0007D0-AZ; Wed, 22 Aug 2018 09:08:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF2622025D75D; Wed, 22 Aug 2018 11:08:23 +0200 (CEST)
Date:   Wed, 22 Aug 2018 11:08:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+1f56df64bfb3c29dde6f@syzkaller.appspotmail.com>
Cc:     dvhart@infradead.org, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: general protection fault in finish_task_switch (2)
Message-ID: <20180822090823.GT24124@hirez.programming.kicks-ass.net>
References: <00000000000035c2ed057315bf85@google.com>
 <0000000000006e87360573f8b328@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006e87360573f8b328@google.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 02:28:02PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following crash on:
> 
> HEAD commit:    778a33959a8a Merge tag 'please-pull-noboot' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14a5385a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=214e4990bd49329f
> dashboard link: https://syzkaller.appspot.com/bug?extid=1f56df64bfb3c29dde6f
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> userspace arch: i386
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=13ffa561400000

FWIW the lack of whitespace between "repro:" and the URL makes it hard
to copy paste.

> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10023961400000


> RIP: 0010:__fire_sched_in_preempt_notifiers kernel/sched/core.c:2481

That repro thing does something dodgy with KVM, which then corrupts the
premption notifier thing. I'm sufficiently KVM clueless to not really
know where to start looking though..
