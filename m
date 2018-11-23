Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96419C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FC4206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ChE1aOwP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FC4206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409991AbeKWXtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:49:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:51536 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403770AbeKWXtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VL25vORFTeHZUcCzk/wuEFEnw9fP7ySRQ0GnRrJNbY8=; b=ChE1aOwP2+gPg+3hzhHUNhKuR
        o098paic2ib3I66ohG5pv6wJxDnpqCS3mgtsYWLasr8oJ4Z+qjKOQgbD9aH1PYFMV+cDujLyz1mkg
        FVQiGqzKjH9mkSSLnEghOxpQ7SId2ka5FL9tsvDZrNSCUj+SSXH43BqCHez7haG4Igsus=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39588)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gQB8i-00086C-9Z; Fri, 23 Nov 2018 13:04:56 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gQB8e-0007BM-VM; Fri, 23 Nov 2018 13:04:53 +0000
Date:   Fri, 23 Nov 2018 13:04:51 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     hpa@zytor.com, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>
Subject: Re: Sleeping in user_access section
Message-ID: <20181123130451.GS30658@n2100.armlinux.org.uk>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
 <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
 <20181123105034.GQ30658@n2100.armlinux.org.uk>
 <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44297716-74aa-1f14-67be-3594b5244b74@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:57:31AM +0000, Julien Thierry wrote:
> 
> 
> On 23/11/18 10:50, Russell King - ARM Linux wrote:
> >On Fri, Nov 23, 2018 at 01:57:12AM -0800, hpa@zytor.com wrote:
> >>You should never call a sleeping function from a user_access section.
> >>It is intended for very limited regions.
> >
> >So, what happens if the "unsafe" user access causes a page fault that
> >ends up sleeping?
> >
> 
> Thanks for pointing that out.
> 
> On the arm64 side, PAN state is saved in spsr and (if PAN feature is enabled
> in SCTLR) PAN bit gets set (disabling the user accesses). For software PAN
> we follow the same behaviour on exception entry. So upon exception we
> implicitly exit user_access mode and then re-enter it when returning from
> the exception.
> 
> On x86, the EFLAGS.AC bit is also saved upon exception and I think it is
> cleared upon exception entry so there is implicit exit from the user_access
> mode when taking exception/interrupt.
> 
> This however is just how those two architectures happen to behave and
> doesn't seem to be specified as part of the user_access API...
> 
> Which is why I'd like to clarify the semantics of user_access region wrt
> sleeping functions.

Explicitly calling a sleeping function may not be recommended, but
it's a rather fundamental fact of the Linux kernel that if we want
to access userspace, we must be either prepared to sleep, or fail
the access and return an error.

Looking at kernel/exit.c and kernel/compat.c, I see no sign of any
retry mechanism in the current call sites, so any failed user access
would return an error to userspace - which is not the behaviour that
userspace would expect.

It's possible that, when user_access_begin() et.al. are implemented,
access_ok() also comes with the requirement to make sure that the
userspace pages are accessible, but even _that_ would be racy,
because there's no way to pin the pages, so another thread/CPU could
page those user pages back out... leading to a fault.

So, realistically, with how user_access_begin()..user_access_end()
is currently being used, an architecture fundamentally has to be
prepared for threads to sleep within that section of code through
the action of the page fault handling.  I can't see any other
realistic possibility here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
