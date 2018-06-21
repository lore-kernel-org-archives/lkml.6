Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30417C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E260A21CCE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 20:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E260A21CCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933493AbeFUUvm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 16:51:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34596 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933443AbeFUUvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 16:51:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CFBF120834; Thu, 21 Jun 2018 22:51:38 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 99C52206A0;
        Thu, 21 Jun 2018 22:51:38 +0200 (CEST)
Date:   Thu, 21 Jun 2018 22:51:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: generic: allow not building DTB in
Message-ID: <20180621205139.GM7737@piout.net>
References: <20180425211607.2645-1-alexandre.belloni@bootlin.com>
 <20180425211607.2645-2-alexandre.belloni@bootlin.com>
 <20180620220807.GD22606@jamesdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620220807.GD22606@jamesdev>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2018 23:08:08+0100, James Hogan wrote:
> On Wed, Apr 25, 2018 at 11:16:07PM +0200, Alexandre Belloni wrote:
> > Allow not building any DTB in the generic kernel so it gets smaller. This
> > is necessary for ocelot because it can be built as a legacy platform that
> > needs a built-in DTB and it can also handle a separate DTB once it is
> > updated with a more modern bootloader. In the latter case, it is preferable
> > to not include any DTB in the kernel image so it is smaller.
> 
> Since bootloaders can modify DTs before passing them to the kernel (e.g.
> to add cmdline args or memory nodes), that would seem to make it
> impossible to have a kernel supporting both legacy bootloader, and a
> u-boot which might do that DT tweaking.
> 
> Or perhaps its not important for this platform.
> 

It is still possible to generate a FIT image containing a kernel with a
built in DTB and a separate DTB:

> > diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> > index 5e9fce076ab6..3d3554c13710 100644
> > --- a/arch/mips/Makefile
> > +++ b/arch/mips/Makefile
> > @@ -404,7 +404,7 @@ endif
> >  CLEAN_FILES += vmlinux.32 vmlinux.64
> >  
> >  # device-trees
> > -core-$(CONFIG_BUILTIN_DTB) += arch/mips/boot/dts/
> > +core-y += arch/mips/boot/dts/
> 
> Won't that result in DTBs being built unnecessarily on other platforms
> which support BUILTIN_DTB but don't have it enabled?
> 
> I suppose the alternative is another Kconfig symbol for when building of
> DTBs is needed, selected by BUILTIN_DTB and MIPS_GENERIC.
> 
Does it matter? On arm all the DTBs for selected platforms are always
built. It is not adding much to the build time.

IIRC, without that change, it is not possible to build any dtb without
having CONFIG_BUILTIN_DTB set.

> > diff --git a/arch/mips/generic/Kconfig b/arch/mips/generic/Kconfig
> > index 6564f18b2012..012f283f99c4 100644
> > --- a/arch/mips/generic/Kconfig
> > +++ b/arch/mips/generic/Kconfig
> > @@ -3,6 +3,7 @@ if MIPS_GENERIC
> >  
> >  config LEGACY_BOARDS
> >  	bool
> > +	select BUILTIN_DTB
> >  	help
> >  	  Select this from your board if the board must use a legacy, non-UHI,
> >  	  boot protocol. This will cause the kernel to scan through the list of
> > diff --git a/arch/mips/generic/vmlinux.its.S b/arch/mips/generic/vmlinux.its.S
> > index 1a08438fd893..9c954f2ae561 100644
> > --- a/arch/mips/generic/vmlinux.its.S
> > +++ b/arch/mips/generic/vmlinux.its.S
> > @@ -21,6 +21,7 @@
> >  		};
> >  	};
> >  
> > +#if IS_ENABLED(CONFIG_BUILTIN_DTB)
> 
> An #ifdef would do, but no matter if it works. Though shouldn't that be
> if !IS_ENABLED (or #ifndef)?
> 

No, that is exactly the configuration I need to remove when no DTB has
been built in the kernel. In that case, it doesn't make sense to provide
a configuration using only the kernel.

> A comment would be great here too to mention why its helpful.
> 





-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
