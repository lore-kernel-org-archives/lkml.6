Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5751C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7BE20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7BE20841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=isi.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeGaW3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:29:05 -0400
Received: from mail-c.ads.isi.edu ([128.9.180.198]:42258 "EHLO
        mail-c.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeGaW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:29:05 -0400
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="6779006"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-c.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 13:46:57 -0700
Date:   Tue, 31 Jul 2018 16:46:56 -0400
From:   Alexei Colin <acolin@isi.edu>
To:     Alex Bounine <alex.bou9@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180731204656.GC38497@guest228.east.isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
 <20180730225035.28365-7-acolin@isi.edu>
 <20180731084143.GA4680@arm.com>
 <d09cb4f5-768b-acd8-f9b1-d1d320a93564@gmail.com>
 <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2723578-f39d-27ac-b376-0f06905caa67@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 04:29:56PM -0400, Alex Bounine wrote:
> On 2018-07-31 08:54 AM, Alex Bounine wrote:
> > On 2018-07-31 04:41 AM, Will Deacon wrote:
> > > On Mon, Jul 30, 2018 at 06:50:34PM -0400, Alexei Colin wrote:
> > > > Platforms with a PCI bus will be offered the RapidIO menu since they may
> > > > be want support for a RapidIO PCI device. Platforms without a PCI bus
> > > > that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> > > > in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> > > > 
> > > > Tested that kernel builds for arm64 with RapidIO subsystem and
> > > > switch drivers enabled, also that the modules load successfully
> > > > on a custom Aarch64 Qemu model.
> > > > 
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Russell King <linux@armlinux.org.uk>
> > > > Cc: John Paul Walters <jwalters@isi.edu>
> > > > Cc: linux-arm-kernel@lists.infradead.org
> > > > Cc: linux-kernel@vger.kernel.org,
> > > > Signed-off-by: Alexei Colin <acolin@isi.edu>
> > > > ---
> > > >   arch/arm64/Kconfig | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > 
> > > Thanks, this looks much cleaner than before:
> > > 
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > > 
> > > The only thing I'm not sure about is why we don't just select HAS_RAPIDIO
> > > unconditionally in the arm64 Kconfig. Does selecting only that option
> > > actually pull in new code to the build?
> > > 
> > HAS_RAPIDIO option is intended for SOCs that have built in SRIO
> > controllers, like TI KeyStoneII or FPGAs. Because RapidIO subsystem core
> > is required during RapidIO port driver initialization, having separate
> > option allows us to control available build options for RapidIO core and
> > port driver (bool vs. tristate) and disable module option if port driver
> > is configured as built-in.
> 
> I am thinking about where HAS_RAPIDIO option can be set for arm64 branch.
> Having it set globally is too broad. For example we have Xilinx Zinq US
> board with SRIO IP on it. Having it globally in arm64 branch - bad. Probably
> having it set in drivers/soc/... is the best place.
> 
> Will, Alexei what do you think?

Since the HAS_RAPIODIO flag adds meta info about SoC, maybe the line
that 'select's it can go where the rest of the meta info is, which
differs across architectures:
* For ARM64, in arch/arm64/Kconfig.platforms under each config ARCH_*
for each SoC that includes RapidIO.
* For ARM, in arch/arm/mach-*/Kconfig

But, if we want the flag to be automatically selected for some larger
set of ARM64 SoCs without explicitly adding it to each one, then the
above is not going to do that.

> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index a8f0c74e6f7f..5e8cf90505ec 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -308,6 +308,8 @@ config PCI_SYSCALL
> > > >   source "drivers/pci/Kconfig"
> > > > +source "drivers/rapidio/Kconfig"
> > > > +
> > > >   endmenu
> > > >   menu "Kernel Features"
> > > > -- 
> > > > 2.18.0
> > > > 
