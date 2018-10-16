Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A0C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52690205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILPRrYWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52690205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJPVyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:54:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39168 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJPVyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3l3A6OygduF1nH1H5Cn5NFNHaqJ5qCd53v7SN/pL1IE=; b=ILPRrYWAcDt/ksW5HqydbOjtw
        w/3sMJ4lmbOx+exFDL6KMwMTmIzWxYXje+Qc6K3oisf3Inmcyu6+Ph6GV8lpfmK7bv6GTfR3lLdIp
        aMpg8fKLc8sUxzljS2LQVrHcPMsKPlEcAUbyduHmgsJXWp6YD11SxiHHjHds1nlExcUdye6dNsFv2
        5fjshsMS8xwTYKc2l1z4CmmSp+quwn/k9CvQtDfytpKO70CAYOVleXXzifaUJCxDRKw4OOfGJ4aG7
        SESaRX31cv5VsmdZOYns7INMpMxszCYGvBtnWtSG5t7spa2S2QBumDmcaVhn38AqrDITKwO3J+7AJ
        M04Lo1m0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCPwS-0004UA-Ul; Tue, 16 Oct 2018 14:03:25 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9893F20295866; Tue, 16 Oct 2018 16:03:22 +0200 (CEST)
Date:   Tue, 16 Oct 2018 16:03:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+385468161961cee80c31@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        nstange@suse.de, syzkaller-bugs@googlegroups.com,
        Juri Lelli <juri.lelli@gmail.com>
Subject: Re: INFO: rcu detected stall in do_idle
Message-ID: <20181016140322.GB3121@hirez.programming.kicks-ass.net>
References: <000000000000a4ee200578172fde@google.com>
 <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1810161516430.7787@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:24:06PM +0200, Thomas Gleixner wrote:
> It does reproduce here but with a kworker stall. Looking at the reproducer:
> 
>   *(uint32_t*)0x20000000 = 0;
>   *(uint32_t*)0x20000004 = 6;
>   *(uint64_t*)0x20000008 = 0;
>   *(uint32_t*)0x20000010 = 0;
>   *(uint32_t*)0x20000014 = 0;
>   *(uint64_t*)0x20000018 = 0x9917;
>   *(uint64_t*)0x20000020 = 0xffff;
>   *(uint64_t*)0x20000028 = 0;
>   syscall(__NR_sched_setattr, 0, 0x20000000, 0);
> 
> which means:
> 
>   struct sched_attr {
>   	 .size		= 0,
> 	 .policy	= 6,
> 	 .flags		= 0,
> 	 .nice		= 0,
> 	 .priority	= 0,
> 	 .deadline	= 0x9917,
> 	 .runtime	= 0xffff,
> 	 .period	= 0,
>   }
> 
> policy 6 is SCHED_DEADLINE
> 
> That makes the thread hog the CPU and prevents all kind of stuff to run.
> 
> Peter, is that expected behaviour?

Sorta, just like FIFO-99 while(1);. Except we should be rejecting the
above configuration, because of the rule:

  runtime <= deadline <= period

Juri, where were we supposed to check that?
