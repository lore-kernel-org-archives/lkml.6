Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D574C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281902083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VOB8gsBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 281902083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeJZFyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:54:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37264 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeJZFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zhxl+oPjnB64hSK5plNHqGaPZlJgpBelFJ6taYSu7Go=; b=VOB8gsBAuPUw+n+flb4K3typH
        +1vC8XvIZl/fBs2AbdOYFsNkd1OFmlIo1lYBvZP5D3ROjoM7oJMF9Lyc4prTvWyx9kZTaAa7ipL6f
        wy6hlPhDJAoen7ORdHADLsu88FtpBk8kRIqSiMPFspohkgkltxDK+lbbvbRotgJ0/S+Jw=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57582)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFn3A-0001GC-Nd; Thu, 25 Oct 2018 22:20:16 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFn34-0003AV-Mb; Thu, 25 Oct 2018 22:20:11 +0100
Date:   Thu, 25 Oct 2018 22:20:06 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        ebiederm@xmission.com, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS
 disabled
Message-ID: <20181025212006.GE30658@n2100.armlinux.org.uk>
References: <20181025180957.7900-1-f.fainelli@gmail.com>
 <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:00:09AM +0530, Souptick Joarder wrote:
> On Thu, Oct 25, 2018 at 11:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Some software such as perf makes unconditional use of the special
> > [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> > enabled in the kernel.
> >
> > Facilitate the debugging of such situations by printing a debug message
> > to the kernel log showing the task name and the faulting address.
> >
> > Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >  arch/arm/mm/fault.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index f4ea4c62c613..f17471fbc1c4 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >                 show_regs(regs);
> >         }
> >  #endif
> > +#ifndef CONFIG_KUSER_HELPERS
> 
> Just have one doubt, if the condition is "#ifdef CONFIG_KUSER_HELPER"
> as commit message suggests the scenario is valid when CONFIG_KUSER_HELPER
> is enabled ? No ?
> 
> > +       if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
> > +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
> > +                      tsk->comm, addr);
> > +#endif

The idea is to print a message when we get a SEGV _and_ the faulting
address is in the vectors page _and_ CONFIG_KUSER_HELPERS is _not_ set
(which makes the page inaccessible.)  The message points users to
enable it and/or why the application has failed.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
