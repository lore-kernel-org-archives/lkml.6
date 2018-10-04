Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46856C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C9E2083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="esi3OnSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C9E2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJDXnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:43:33 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40278 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbeJDXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/5D44jJ+Gabb8x0xtlJxCZbOknPqaRI2Fm3Qbi9RYao=; b=esi3OnSsphK4E7LjwTu9ZhQjr
        oFYo9BH4hfLyYdDENbpSTPfuMQxljgmyFoGwM/YtmdGTtzJkHV4ktlU5RM4bsHRjG9rTAV3GcnVEJ
        ESg/GMehzB6cSiPfoAoQizgn77dfrwovE6Tpfp158YK9czFV0gGNQGcZm/+EksZxYCLEQ=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:52068)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g86oS-0007ie-KP; Thu, 04 Oct 2018 17:49:20 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g86oN-0006Sx-DP; Thu, 04 Oct 2018 17:49:15 +0100
Date:   Thu, 4 Oct 2018 17:49:12 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] reboot: Make restart_handler_list a blocking notifier
 chain.
Message-ID: <20181004164911.GD30658@n2100.armlinux.org.uk>
References: <20181004162339.19493-1-nicolas.cavallari@green-communications.fr>
 <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004162339.19493-2-nicolas.cavallari@green-communications.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 06:23:38PM +0200, Nicolas Cavallari wrote:
> Many users of restart_handlers are sleeping in their callbacks.  Some
> are doing infinite loops or calling driver code that may sleep or
> perform operation on slow busses, like i2c.
> 
> This is not allowed in an atomic notifier chain, which is what
> restart_handler_list currently is, so use a blocking notifier chain
> instead.

This isn't going to work.

For example, sysrq processing (which can happen in IRQ context) calls
emergency_restart() for the reboot sysrq.  That calls through to
machine_restart(), which then calls do_kernel_restart().

If do_kernel_restart() sleeps, then we're trying to sleep in IRQ
context, and that's a no no.  I'm afraid you can't just add an irq
enable and change the notifier list to be atomic - and, as you're
making the change in generic code, this affects everyone, not just the
architecture that happens to be in front of you (so if it were merged,
you're likely to get a lot of bug reports!)

It gets worse, because (eg) a panic() or IRQ can happen with any locks
held - and if the I2C device's locks are held when one of those events
happen, you have a deadlock situation (hence you won't reboot!)

I suppose a good first step would be for us to have our own
machine_emergency_restart() on ARM, to separate the atomic paths
from the non-atomic paths, so that those who need to talk to an I2C,
that can happen from the non-atomic path (which means things like
/sbin/reboot will work) but other stuff (eg, restart on panic, sysrq,
soft-watchdog) will fail.

This issue as come up recently surrounding PMIC issues, but the
discussions there appear to have completely dried up...

However, my conclusion is that having an I2C driver deal with reboot
is possible for the process-induced reboot cases, but it's never going
to work reliably for the emergency case.

If you want the emergency case to work, then you need to work out some
way to talk on the I2C bus without involving any locks and with the I2C
bus possibly mid-transfer - which is not an easy problem to solve.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
