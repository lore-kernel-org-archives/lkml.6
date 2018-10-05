Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486C020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jre2XVUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeJEPhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:37:36 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:50904 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeJEPhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3r9KFTIQLF//pmAjbrxEs8pGFdt8KvdWHJDhX4+KD6A=; b=jre2XVULW3olTmlVzPO9UR/VF
        kAy0+VPNujkxnObNXTlFpeLsDPzGrFmeDEkuNuPojB3dWwTTPYXsNbK3z07EQE3Li8aMyLL2QfPP4
        AbDNhldQWMJOjqTgAHJ9BchuIeAhNBQM5Nv43MZsnxaleJa3ewZX5856ijY4bMbfpSeY4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:44561)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g8LeG-00032G-MK; Fri, 05 Oct 2018 09:39:48 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g8LeD-0006zL-Kg; Fri, 05 Oct 2018 09:39:45 +0100
Date:   Fri, 5 Oct 2018 09:39:44 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier
 chain.
Message-ID: <20181005083944.GF30658@n2100.armlinux.org.uk>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
 <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
 <20181004164911.GD30658@n2100.armlinux.org.uk>
 <211e71a4-57ce-2383-c74f-dfbfa053e4b7@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <211e71a4-57ce-2383-c74f-dfbfa053e4b7@green-communications.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 10:27:48AM +0200, Nicolas Cavallari wrote:
> On 04/10/2018 18:49, Russell King - ARM Linux wrote:
> > This isn't going to work.
> > 
> > For example, sysrq processing (which can happen in IRQ context) calls
> > emergency_restart() for the reboot sysrq.  That calls through to
> > machine_restart(), which then calls do_kernel_restart().
> >
> > If do_kernel_restart() sleeps, then we're trying to sleep in IRQ
> > context, and that's a no no.  I'm afraid you can't just add an irq
> > enable and change the notifier list to be atomic - and, as you're
> > making the change in generic code, this affects everyone, not just the
> > architecture that happens to be in front of you (so if it were merged,
> > you're likely to get a lot of bug reports!)
> 
> I don't get it.
> 
> Many implementations of machine_restart() sleeps or do an infinite loop.
> Almost half of the restart_handler users sleeps or do an infinite loop.

Infinite loops are not a problem when shutting down or rebooting -
they're only "infinite" in the sense that control never returns but
that is the case anyway when the restart or shutdown takes effect.

> I understand that sleeping in IRQ context is bad, but the kernel does it
> anyway. And it seems nobody have noticed any problem with this.

That is incorrect - there are reports of this failing as I mentioned
in my email.

Also note that there is a big difference between sleeping in atomic
context (iow, sleeping with spinlocks held, attempting to sleep with
IRQs disabled) and sleeping in IRQ context (iow, sleeping in an
interrupt handler).  You can "work around" the former with your code,
but in doing so you end up _breaking_ the latter case for every
situation.

I've pointed out some of the issues that make it unreliable in my
initial email (quoted below).

> > It gets worse, because (eg) a panic() or IRQ can happen with any locks
> > held - and if the I2C device's locks are held when one of those events
> > happen, you have a deadlock situation (hence you won't reboot!)
> > 
> > I suppose a good first step would be for us to have our own
> > machine_emergency_restart() on ARM, to separate the atomic paths
> > from the non-atomic paths, so that those who need to talk to an I2C,
> > that can happen from the non-atomic path (which means things like
> > /sbin/reboot will work) but other stuff (eg, restart on panic, sysrq,
> > soft-watchdog) will fail.
> 
> That would fix my use case, but not the existing code ?

There is no fix possible for a blocking I2C transfer in IRQ context,
it will always be unreliable for the reasons I've explained above.

All those existing cases where drivers are doing I2C transfers using
the I2C host driver for power down or restart are broken and
unreliable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
