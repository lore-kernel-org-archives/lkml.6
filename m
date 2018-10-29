Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF6C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF55420657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Sdnpcip+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF55420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbeJ3BdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:33:09 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39586 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbeJ3BdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1qHhjFLujOUK+2vmjbboZVuMFzL7yqG9KPUVIXe6d5A=; b=Sdnpcip+ZWyQYYhPTNMEEBgXC
        BJUo9Hfd4MKA9lqWKr78+W/Him2MhKrFPkuCrZK9LJMPlHcAuehXVwIrdZybr009iJbI26xr8MoUF
        X6jXDDX7YrWN41vIezIHyXWJ5iCGa0CQ9AcYUCSYm+vYWyZZS9qxu0S0ODsA2nE+gNLBU=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:39006)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gHAda-0005X1-6Y; Mon, 29 Oct 2018 16:43:34 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gHAdX-0003ES-Bb; Mon, 29 Oct 2018 16:43:31 +0000
Date:   Mon, 29 Oct 2018 16:43:29 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "jrdr.linux@gmail.com" <jrdr.linux@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: mm: fault: check ADFSR in case of abort
Message-ID: <20181029164329.GH30658@n2100.armlinux.org.uk>
References: <HE1PR0702MB37567D530C1C1D45949C164BFAF30@HE1PR0702MB3756.eurprd07.prod.outlook.com>
 <20181029155435.prz2htt4ktte7pxb@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029155435.prz2htt4ktte7pxb@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 03:54:36PM +0000, Mark Rutland wrote:
> On Mon, Oct 29, 2018 at 02:20:51PM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> > When running into situations like:
> > "Unhandled fault: synchronous external abort (0x210) at 0xXXX"
> > or
> > "Unhandled prefetch abort: synchronous external abort (0x210) at 0xXXX"
> > it is useful to know the content of ADFSR (Auxiliary Data Fault Status
> > Register) to indicate an ECC double-bit error in L1 or L2 cache.
> > 
> > Refer to:
> > Cortex-A15 Technical Reference Manual, Revision: r2p1
> > [6.4.8. Error Correction Code]
> > 
> > Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> > ---
> >  arch/arm/mm/fault.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> > index 3232afb6fdc0..5e240deb6ed6 100644
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -547,6 +547,22 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
> >  	fsr_info[nr].name = name;
> >  }
> >  
> > +/*
> > + * Check for ECC double-bit errors in Auxiliary Data Fault Status Register
> > + */
> > +static void check_adfsr_for_ecc(void)
> > +{
> > +	u32 adfsr = 0;
> > +
> > +	asm("mrc p15, 0, %0, c5, c1, 0" : "=r" (adfsr));
> > +
> > +	if (adfsr & (BIT(31) | BIT(23))) {
> > +		pr_alert("ADFSR status 0x%x indicates that an L1 or L2 cache\n"
> > +			 "ECC double-bit error occurred at some time.\n",
> > +			  adfsr);
> > +	}
> > +}
> > +
> >  /*
> >   * Dispatch a data abort to the relevant handler.
> >   */
> > @@ -559,6 +575,7 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
> >  	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
> >  		return;
> >  
> > +	check_adfsr_for_ecc();
> >  	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
> >  		inf->name, fsr, addr);
> >  	show_pte(current->mm, addr);
> > @@ -593,6 +610,7 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
> >  	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
> >  		return;
> >  
> > +	check_adfsr_for_ecc();
> >  	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
> >  		inf->name, ifsr, addr);
> 
> IIUC at this point the task is preemptible (and interruptible),

It may be preemptable, but isn't necessarily so.  It depends whether the
called FSR specific function enabled interrupts or not.

So, it would be better to read the ADFSR before calling the FSR specific
function to guarantee that we read the values that correspond with _this_
fault.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
