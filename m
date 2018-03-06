Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753636AbeCFMAg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 07:00:36 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59863 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753520AbeCFMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 07:00:35 -0500
Date: Tue, 6 Mar 2018 13:00:23 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v4 5/6] MIPS: generic: Add support for Microsemi Ocelot
Message-ID: <20180306120023.GS3035@piout.net>
References: <20180302224811.26840-1-alexandre.belloni@bootlin.com>
 <20180302224811.26840-6-alexandre.belloni@bootlin.com>
 <20180303002528.GE4197@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303002528.GE4197@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2018 at 00:25:29 +0000, James Hogan wrote:
> Similarly if the platform is little endian only, you could also add:
> # require CONFIG_CPU_LITTLE_ENDIAN=y
> 

It supports big endian.

> > +
> > +CONFIG_LEGACY_BOARD_OCELOT=y
> > +
> > +CONFIG_MIPS_CMDLINE_FROM_BOOTLOADER=y
> 
> Hmm, can this break any other generic platforms that already make the
> DTB command line override the arcs_cmdline? Paul?
> 
> I.e. In arch_mem_init() the condition of copying arcs_cmdline to
> boot_command_line would switch from !boot_command_line[0] to
> arcs_cmdline[0]. I suppose arcs_cmdline[] may not have been written in
> those cases. If its safe then it should probably be a standard thing
> selected by MIPS_GENERIC instead of a board specific thing.
> 

Actually, this is not needed so I'm removing it.

> > +CONFIG_MAGIC_SYSRQ=y
> 
> Perhaps its worth adding this to the base generic_defconfig if its
> useful to have.
> 

Our test automation tool is using it to reboot the platform but I don't
know if this is useful for anybody else.

> > +static __init bool ocelot_detect(void)
> > +{
> > +	u32 rev;
> > +
> > +	rev = __raw_readl((void *)DEVCPU_GCB_CHIP_REGS_CHIP_ID);
> 
> Isn't that an address in the user segment, i.e. TLB mapped virtual
> memory? Does the bootloader set up a wired mapping for it or something?
> 
> The address looks similar to UART_UART which is given to ioremap so must
> be a physical address. Perhaps the mapping you're using is 1:1
> virtual:physical address?
> 
> If its using a TLB mapping, then:
> 1) That isn't safe this early to run on other platforms, as it'll give a
>    TLB refill exception. It should be quite possible to detect such a
>    mapping to make it safer though.
> 2) If yamon initialises the TLB to a known state, then that may well be
>    a hacky but workable way to distinguish yamon (sead3) from redboot
>    (mscc) in future.
> 

Yes, this is an identity mapping that is installed by redboot because
all the peripherals are in the user segment.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
