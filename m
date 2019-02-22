Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0F3C00319
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488EF20836
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KZCcXjc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfBVALA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:11:00 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55598 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfBVAK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZBm3CwC0uJNrN1aySShBbnrLHsHFM8GMl9qchGQd49E=; b=KZCcXjc/iQehzGWkIdc+Yrsnc
        /L3oFRHDyVhVkmcQrIh6W+S4mrQk5+CVYw/xDcoGUmcX6d150IXG9vDu8XKsdeswv5GSnBNXoM0nz
        odCt2tgOqZD5d3A0XRa4LUED8x/iMN18x1hmL2hrSl+uS3U9z9Aa3Fn0jWijpJmG+jsfXf6opdELJ
        tNGqsnEXlU7/jtYkwnCCtOpygbxYJzGmv22KkEoIWwxFLRVy6Wv3sbtROhXqL6yZoaRoEs3x0L371
        0+969IAtoAISQrlBLBgdlvS5HxepLY+M5fUkV5rE1aqmK5kg//clmQa2usDHdIT3tpBVtW+HwFZtI
        tAbWP/viQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51326)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gwyQR-0006RA-SL; Fri, 22 Feb 2019 00:10:50 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gwyQM-0001ip-JE; Fri, 22 Feb 2019 00:10:42 +0000
Date:   Fri, 22 Feb 2019 00:10:42 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        William Cohen <wcohen@redhat.com>,
        stable <stable@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lttng <lttng@reliableembeddedsystems.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: BUG: optimized kprobes illegal instructions in v4.19 stable
 kernels
Message-ID: <20190222001042.hm6j5h4hmfpwarzr@shell.armlinux.org.uk>
References: <342740659.2887.1549307721609.JavaMail.zimbra@efficios.com>
 <CAGXu5jJYbc0xhQGqS6L43o_1tOdWmL=rhRmu_L8qT4-tOheHPw@mail.gmail.com>
 <20190206134115.baba291e33022a2f6b6ae5f8@kernel.org>
 <20190218122631.GE30260@kroah.com>
 <843587666.153.1550501735273.JavaMail.zimbra@efficios.com>
 <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1829800918.4014.1550779377803.JavaMail.zimbra@efficios.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 03:02:57PM -0500, Mathieu Desnoyers wrote:
> Hi Arnd, Russell, Linus,
> 
> Can we ensure the arm32 kprobes fix I submitted gets upstream before 5.0 final ?
> It takes care of an illegal instruction issue with optimized kprobes on arm32.
> 
> Here is the current state of default kprobes configuration on arm32:
> using them will trigger illegal instruction OOPS on v5.0-rc7, 4.19.24,
> v4.14.102.
> 
> My fix is in "accepted" state in the arm patch tracking system:
> 
> https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
> 
> Should I send it directly to Linus as well ?

Accepted means it's in my tree pending to be sent to Linus.  It should
now be in mainline.  Have you checked?

> 
> Thanks,
> 
> Mathieu
> 
> ----- On Feb 18, 2019, at 9:55 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
> > ----- On Feb 18, 2019, at 7:26 AM, Greg Kroah-Hartman gregkh@linuxfoundation.org
> > wrote:
> > 
> >> On Wed, Feb 06, 2019 at 01:41:15PM +0900, Masami Hiramatsu wrote:
> >>> On Tue, 5 Feb 2019 15:06:10 +0000
> >>> Kees Cook <keescook@chromium.org> wrote:
> >>> 
> >>> > On Mon, Feb 4, 2019 at 7:15 PM Mathieu Desnoyers
> >>> > <mathieu.desnoyers@efficios.com> wrote:
> >>> > >
> >>> > > Hi,
> >>> > >
> >>> > > I notice this commit as a possible culprit of the illegal instructions my lttng
> >>> > > users are noticing on arm32 when using kprobes on a v4.19.13 Linux kernel
> >>> > > in a Yocto environment [1]. They were able to reproduce the issue with perf
> >>> > > as well.
> >>> > >
> >>> > > commit e46daee53bb50bde38805f1823a182979724c229
> >>> > > Author: Kees Cook <keescook@chromium.org>
> >>> > > Date:   Tue Oct 30 22:12:56 2018 +0100
> >>> > >
> >>> > >     ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE
> >>> > >
> >>> > > I *think* the intent there was to do
> >>> > >
> >>> > > -       memcpy(code, &optprobe_template_entry,
> >>> > > +       memcpy(code, (unsigned long *)&optprobe_template_entry,
> >>> > >
> >>> > > But if you look at the commit, the "&" seems to have been stripped away,
> >>> > > which happens to change the behavior significantly.
> >>> > 
> >>> > Yeah, this was a typo on my part. :(
> >>> 
> >>> Ah, I thought it had been fixed as same as x86.
> >>> On x86, all optprobe_template_* are defined as kprobe_opcode_t [],
> >>> but on arm, it still be kprobe_opcode_t.
> >>> 
> >>> Hmm, but I think we should use kprobe_opcode_t [] or char[] as asm/sections.h
> >>> does.
> >>> OK, I'll prepare for the change.
> >> 
> >> Did this ever get fixed in Linus's tree?  If so, what is the git commit
> >> id, I can't seem to find anything...
> > 
> > It seems to still be in the arm patch tracking system:
> > 
> > https://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=8834/1
> > 
> > If I understand its status correctly, it is applied to the arm tree, but
> > perhaps it has not been pulled by Linus yet ? The code is still broken
> > in Linus' master.
> > 
> > It would be important to get this arm kprobes fix upstream before 5.0
> > final.
> > 
> > Thanks,
> > 
> > Mathieu
> > 
> > 
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
