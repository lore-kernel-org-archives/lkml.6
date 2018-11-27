Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78457C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E63B21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bzWbqT6J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E63B21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbeK0VyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:54:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57750 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbeK0VyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MxYiCzVt/FhorUWOmxeQ2pTQEgyDcHOGa+63bpz66Q0=; b=bzWbqT6JYd1DjysobM6mucFgh
        ZKISozLGdqCWM/pzH/B6IimOWBQ1E4iUuDnrGk2Juwmm43Jt8jbsVYGy8yvJsMONlE1Y71fV0XSxw
        vyYh8iQWh3vycpAH/MJBv/k23xk5pPtLH97E3CyVPZeFP8QtpJcyao3nx1xYOED0CCCIw=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:34242)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gRb2X-0006T5-Bv; Tue, 27 Nov 2018 10:56:25 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gRb2U-0002XP-AV; Tue, 27 Nov 2018 10:56:22 +0000
Date:   Tue, 27 Nov 2018 10:56:20 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Timothy E Baldwin <T.E.Baldwin99@members.leeds.ac.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: always update thread_info->syscall
Message-ID: <20181127105620.GD30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
 <20181126234456.GB30658@n2100.armlinux.org.uk>
 <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad23e3dc-eee0-f9af-2f12-bfd7a14cd546@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 08:30:32AM -0200, Rafael David Tinoco wrote:
> On 11/26/18 9:44 PM, Russell King - ARM Linux wrote:
> >On Mon, Nov 26, 2018 at 11:41:11PM +0000, Russell King - ARM Linux wrote:
> >>On Mon, Nov 26, 2018 at 11:33:03PM +0000, Russell King - ARM Linux wrote:
> >>>On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> >>>>Right now, only way for task->thread_info->syscall to be updated is if
> >>>>if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> >>>>(similar to what has_syscall_work() checks for arm64).
> >>>>
> >>>>This means that "->syscall" will only be updated if we are tracing the
> >>>>syscalls through ptrace, for example. This is NOT the same behavior as
> >>>>arm64, when pt_regs->syscallno is updated in the beginning of svc0
> >>>>handler for *every* syscall entry.
> >>>
> >>>So when was it decided that the syscall number will always be required
> >>>(we need it to know how far back this has to be backported).
> >>
> >>PS, I rather object to the fact that the required behaviour seems to
> >>change, arch maintainers aren't told about it until... some test is
> >>created at some random point in the future which then fails.
> >>
> >>Surely there's a better way to communicate changes in requirements
> >>than discovery-by-random-bug-report ?
> >
> >Final comment for tonight - the commit introducing /proc/*/syscall says:
> >
> >     This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
> >     These use task_current_syscall() to show the task's current system call
> >     number and argument registers, stack pointer and PC.  For a task blocked
> >     but not in a syscall, the file shows "-1" in place of the syscall number,
> >     followed by only the SP and PC.  For a task that's not blocked, it shows
> >     "running".
> >
> >Please validate that a blocked task does indeed show -1 with your patch
> >applied.
> 
> Will do. This is done in an upper level (collect_syscall <-
> task_current_syscall <- proc_pid_syscall):
> 
> 	if (!try_get_task_stack(target)) {
> 		/* Task has no stack, so the task isn't in a syscall. */
> 		*sp = *pc = 0;
> 		*callno = -1;
> 		return 0;
> 	}
> 
> I think only missing part for arm was that one, but will confirm, after
> fixing usage of "r7" for obtaining "scno". Will send a v2 in this thread.

There's another question - what's the expected behaviour when we
restart a syscall using the restartblock mechanism?  Is the syscall
number expected to be __NR_restart_syscall or the original syscall
number?

I can't find anywhere that this detail is specified (damn the lack
of API documentation - I'm tempted to say that we won't implement
this until it gets documented properly, and that test can continue
failing until such time that happens.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
