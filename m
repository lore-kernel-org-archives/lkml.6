Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB052082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QR+rWB+D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB052082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeK0KlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:41:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49998 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0KlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GUbnCnnhjig4J8VPdnxxELFcsOt0eSkIkXoezSXhUi0=; b=QR+rWB+DIYMeUW7ZNIXY9lEMK
        /4YcdQfz0d1yUj6wZzZVD29tgOTseMCFhrPxb5gaozv6JIfqV87BoY8UPgok9GeFyNqvH4M54Stif
        klZYGPfRtxxuUrfNV3dA6UWsd4RgDL4yV8Tt++FPM2tnf/QSOnRWTYJepWT+x/wkQQ0PA=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39426)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gRQYo-0003gE-Ee; Mon, 26 Nov 2018 23:45:02 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gRQYk-0004Ff-U0; Mon, 26 Nov 2018 23:44:59 +0000
Date:   Mon, 26 Nov 2018 23:44:56 +0000
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
Message-ID: <20181126234456.GB30658@n2100.armlinux.org.uk>
References: <20181126225335.10477-1-rafael.tinoco@linaro.org>
 <20181126233303.GZ30658@n2100.armlinux.org.uk>
 <20181126234111.GA30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126234111.GA30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:41:11PM +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 26, 2018 at 11:33:03PM +0000, Russell King - ARM Linux wrote:
> > On Mon, Nov 26, 2018 at 08:53:35PM -0200, Rafael David Tinoco wrote:
> > > Right now, only way for task->thread_info->syscall to be updated is if
> > > if _TIF_SYSCALL_WORK is set in current's task thread_info->flags
> > > (similar to what has_syscall_work() checks for arm64).
> > > 
> > > This means that "->syscall" will only be updated if we are tracing the
> > > syscalls through ptrace, for example. This is NOT the same behavior as
> > > arm64, when pt_regs->syscallno is updated in the beginning of svc0
> > > handler for *every* syscall entry.
> > 
> > So when was it decided that the syscall number will always be required
> > (we need it to know how far back this has to be backported).
> 
> PS, I rather object to the fact that the required behaviour seems to
> change, arch maintainers aren't told about it until... some test is
> created at some random point in the future which then fails.
> 
> Surely there's a better way to communicate changes in requirements
> than discovery-by-random-bug-report ?

Final comment for tonight - the commit introducing /proc/*/syscall says:

    This adds /proc/PID/syscall and /proc/PID/task/TID/syscall magic files.
    These use task_current_syscall() to show the task's current system call
    number and argument registers, stack pointer and PC.  For a task blocked
    but not in a syscall, the file shows "-1" in place of the syscall number,
    followed by only the SP and PC.  For a task that's not blocked, it shows
    "running".

Please validate that a blocked task does indeed show -1 with your patch
applied.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
