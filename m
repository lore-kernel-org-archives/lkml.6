Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeDFJ5A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 05:57:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDFJ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 05:56:59 -0400
Date: Fri, 6 Apr 2018 11:56:56 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: arch/arm/kernel/setup.c fails to compile for NOMMU
Message-ID: <20180406095656.GJ8286@dhcp22.suse.cz>
References: <20170818112402.GB18499@dhcp22.suse.cz>
 <20170824161741.GX20805@n2100.armlinux.org.uk>
 <20170825064540.GB25498@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825064540.GB25498@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-08-17 08:45:40, Michal Hocko wrote:
> On Thu 24-08-17 17:17:41, Russell King - ARM Linux wrote:
> > On Fri, Aug 18, 2017 at 01:24:02PM +0200, Michal Hocko wrote:
> > > Hi Russel,
> > > I have a battery of configs for compile testing and for some time I've
> > > been seeing the following compilation error with nommu config (attached)
> > > 
> > > arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> > > arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> > > use in this function)
> > >              crash_size, SECTION_SIZE);
> > > 
> > > I didn't get to look what is going on here, maybe my config is just too
> > > artificial but the primary reason is that SECTION_SIZE is not defined in
> > > pgtable-nommu.h. To be honest I am not familiar with nommu very much and
> > > it smells like the whole reserve_crashkernel doesn't really make any
> > > sense on those configs. Could you have a look what is the best fix
> > > please?
> > 
> > Hi,
> > 
> > I suspect that mach-netx has never been tested in nommu configurations
> > (ditto for many of the older platforms, which pre-date merging nommu
> > support.)
> > 
> > Maybe the best solution is to make these old platforms depend on MMU.
> > 
> > However, I'm wondering whether kexec makes sense for !MMU - that's
> > probably something that hasn't been tested and doesn't actually work.
> > So maybe another approach would be to make kexec depend on MMU for
> > ARM - but I'm afraid I don't really know.
> 
> Yeah, I've disabled KEXEC in my testing config. All I do care about is
> to test nommu specific code paths in MM code.
> 
> > I only have very limited nommu experience.
> 
> me too
> 
> So what would you say about the following?

It's been some time and it seems this has fallen between cracks. Is this
worth puruing or I should just forget about it and drop it on the floor?
> ---
> From 2707f3bf00181bbc9dcf6a1f287eb7369141e955 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 25 Aug 2017 08:40:09 +0200
> Subject: [PATCH] arm: make kexec depend on MMU
> 
> arm nommu config with KEXEC enabled doesn't compile
> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> use in this function)
>              crash_size, SECTION_SIZE);
> 
> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
> over one year without anybody noticing. I have only noticed beause of
> my testing nommu config which somehow gained CONFIG_KEXEC without
> an intention. This suggests that nobody is actually using KEXEC
> on nommu ARM configs. It is even a question whether kexec works with
> nommu.
> 
> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
> there will be probably more things to take care.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3f4aa9179337..c8603195d7fc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -2003,6 +2003,7 @@ config KEXEC
>  	bool "Kexec system call (EXPERIMENTAL)"
>  	depends on (!SMP || PM_SLEEP_SMP)
>  	depends on !CPU_V7M
> +	depends on MMU
>  	select KEXEC_CORE
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
> -- 
> 2.13.2
> 
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
