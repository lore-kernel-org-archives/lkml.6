Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C88C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361792081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="cg9L5Jt6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361792081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeJ3VZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:25:11 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52438 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeJ3VZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TkVjTEM6kVQXzRB4RQ0hhkgzL0CICMKKvAtTiuu/UfA=; b=cg9L5Jt6jV9UAF39jA8zglY4L
        bMurzRHotS4QihR7a37Pw9LGmRKhxWGLvNQ+5Y4FHSNBSCmUcjXROWCU+Uui4+REDnNFIhDK0rGa6
        O8g2RCMwW9tm6RitL7hs6J7wE/IcPZhPu6PwTHTjEWXnFvw0OqXKXNPvKgw3XoA2cCTE4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:48311)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gHTAx-0001gx-79; Tue, 30 Oct 2018 12:31:15 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gHTAq-0005U9-F5; Tue, 30 Oct 2018 12:31:08 +0000
Date:   Tue, 30 Oct 2018 12:31:03 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>, tglx@linutronix.de,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net, nm@ti.com,
        linux-mips@linux-mips.org, dalias@libc.org,
        catalin.marinas@arm.com, vigneshr@ti.com,
        linux-aspeed@lists.ozlabs.org, linux-sh@vger.kernel.org,
        peterz@infradead.org, will.deacon@arm.com, mhocko@suse.com,
        paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org,
        marex@denx.de, sfr@canb.auug.org.au, ysato@users.sourceforge.jp,
        linux-hexagon@vger.kernel.org, x86@kernel.org,
        pombredanne@nexb.com, tony@atomide.com, mingo@redhat.com,
        joel@jms.id.au, linux-serial@vger.kernel.org,
        rolf.evers.fischer@aptiv.com, jhogan@kernel.org,
        asierra@xes-inc.com, linux-snps-arc@lists.infradead.org,
        dan.carpenter@oracle.com, ying.huang@intel.com, riel@surriel.com,
        frederic@kernel.org, jslaby@suse.com, paul.burton@mips.com,
        rppt@linux.vnet.ibm.com, bp@alien8.de, luto@kernel.org,
        andriy.shevchenko@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        andrew@aj.id.au, linux-kernel@vger.kernel.org, ralf@linux-mips.org,
        rkuo@codeaurora.org, Jisheng.Zhang@synaptics.com,
        vgupta@synopsys.com, benh@kernel.crashing.org, jk@ozlabs.org,
        mpe@ellerman.id.au, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
        kstewart@linuxfoundation.org
Subject: Re: [PATCH 0/7] serial: Finish kgdb on qcom_geni; fix many lockdep
 splats w/ kgdb
Message-ID: <20181030123103.GL30658@n2100.armlinux.org.uk>
References: <20181029180707.207546-1-dianders@chromium.org>
 <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030115628.eqtyqdugkpkxvyr2@holly.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 11:56:28AM +0000, Daniel Thompson wrote:
> On Mon, Oct 29, 2018 at 11:07:00AM -0700, Douglas Anderson wrote:
> > Looking back, this is pretty much two series squashed that could be
> > treated indepdently.  The first is a serial series and the second is a
> > kgdb series.
> 
> Indeed.
> 
> I couldn't work out the link between the first 5 patches and the last 2
> until I read this...
> 
> Is anything in the 01->05 patch set even related to kgdb? From the stack
> traces it looks to me like the lock dep warning would trigger for any
> sysrq. I think separating into two threads for v2 would be sensible.

I'm concerned about calling smp_call_function() from IRQ context with
IRQs disabled - that will block the ability of the _calling_ CPU to
process IPIs from other CPUs in the system.  If we have other CPUs
waiting on their IPIs to complete on _this_ CPU, we could end up
deadlocking while trying to grab the CSD lock.

This is the intention of warnings in smp_call_function*() - to catch
cases where deadlocks _can_ occur, but do not reliably show up.

The exceptions to the warning (disregarding oops_in_progress) are
chosen to allow IRQs-disabled calls when we're sure that the rest of
the system isn't going to be sending the calling CPU an IPI (eg,
because the CPU isn't marked online, and we only send IPIs to online
CPUs, or if we're still early in the kernel boot and hence have no
other CPUs running.)  The exception is oops_in_progress, which can
occur at any time - even with the current CPU already holding some
CSD locks (eg, oops while trying to send an IPI.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
