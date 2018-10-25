Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6533820665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="E90e7H9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6533820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeJZCho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:37:44 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35032 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeJZCho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GwsqNua+xTDpjypJkvu2C56Zrs1eRyQsXhYdECGkBoQ=; b=E90e7H9RPo2zdIHw497QB0p5c
        70vNfrkMcZN+QJS8udGbK+Ab/u0QGbnR8Xc05zUtYS7o5F7bIpFb8F28OKjwmosZTKWrO7jHez7ac
        16H9K3y+g7Ysrr2D3lK0pSg5V6JKSP/pQrxDMq9yVNIs0GvPk/USv62xN0OuMda1pL+HU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39746)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFjyr-0000VS-Fr; Thu, 25 Oct 2018 19:03:37 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFjyo-0001Ly-9v; Thu, 25 Oct 2018 19:03:34 +0100
Date:   Thu, 25 Oct 2018 19:03:32 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, l.stach@pengutronix.de
Subject: Re: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
Message-ID: <20181025180332.GD30658@n2100.armlinux.org.uk>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com>
 <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
 <20181025173242.GC30658@n2100.armlinux.org.uk>
 <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f5b6e7-4d3e-dd8f-4028-0ee370b11722@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:53:12AM -0700, Florian Fainelli wrote:
> Something like this below? It does not have to be an alternative
> solution, I would find it useful for perf to make sure the vectors page
> is present in the virtual address space by having an explicit test. perf
> maintains, what do you think?

Yep, I'd swap the two tests merely because the check for 'sig' will be
slightly cheaper than the mask-and-test of addr, but it probably doesn't
make that much difference.

> 
> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> index f4ea4c62c613..b045b48d368d 100644
> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned
> long addr,
>                 show_regs(regs);
>         }
>  #endif
> +#ifndef CONFIG_KUSER_HELPERS
> +       if (((addr & PAGE_MASK) == 0xffff0000) && (sig == SIGSEGV))
> +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at
> 0x%08lx\n",
> +                      tsk->comm, addr);
> +#endif
> 
>         tsk->thread.address = addr;
>         tsk->thread.error_code = fsr;
> 
> 
> > 
> > BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
> > updated.
> > 
> 
> 
> -- 
> Florian

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
