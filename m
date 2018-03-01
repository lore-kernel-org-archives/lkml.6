Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162310AbeCAVjD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:39:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55078 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161622AbeCAVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:39:01 -0500
Date: Thu, 1 Mar 2018 13:38:57 -0800
From: Darren Hart <dvhart@infradead.org>
To: Mario.Limonciello@dell.com
Cc: andy.shevchenko@gmail.com, pali.rohar@gmail.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
 modules together
Message-ID: <20180301213857.GC25613@fury>
References: <1519755784-2155-1-git-send-email-mario.limonciello@dell.com>
 <1519755784-2155-3-git-send-email-mario.limonciello@dell.com>
 <20180301174845.GA25613@fury>
 <44477ede216542d89090494590ad7a2c@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44477ede216542d89090494590ad7a2c@ausx13mpc124.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 08:54:31PM +0000, Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Darren Hart [mailto:dvhart@infradead.org]
> > Sent: Thursday, March 1, 2018 11:49 AM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; pali.rohar@gmail.com;
> > LKML <linux-kernel@vger.kernel.org>; platform-driver-x86@vger.kernel.org
> > Subject: Re: [PATCH v3 3/3] platform/x86: dell-smbios: Link all dell-smbios-*
> > modules together
> > 
> > On Tue, Feb 27, 2018 at 12:23:04PM -0600, Mario Limonciello wrote:
> > > Some race conditions were raised due to dell-smbios and its backends
> > > not being ready by the time that a consumer would call one of the
> > > exported methods.
> > >
> > > To avoid this problem, guarantee that all initialization has been
> > > done by linking them all together and running init for them all.
> > >
> > > As part of this change the Kconfig needs to be adjusted so that
> > > CONFIG_DELL_SMBIOS_SMM and CONFIG_DELL_SMBIOS_WMI are boolean
> > > rather than modules.
> > >
> > > CONFIG_DELL_SMBIOS is a visually selectable option again and both
> > > CONFIG_DELL_SMBIOS_WMI and CONFIG_DELL_SMBIOS_SMM are optional.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > > Changes from v2:
> > >  * Move rest of #ifdef out of source files
> > >  * Only compile units as necessary
> > >
> > >  drivers/platform/x86/Kconfig            | 11 ++++++++---
> > >  drivers/platform/x86/Makefile           |  4 ++--
> > >  drivers/platform/x86/dell-smbios-base.c | 21 ++++++++++++++++++++-
> > >  drivers/platform/x86/dell-smbios-smm.c  | 18 ++++--------------
> > >  drivers/platform/x86/dell-smbios-wmi.c  | 14 ++++----------
> > >  drivers/platform/x86/dell-smbios.h      | 27 ++++++++++++++++++++++++++-
> > >  6 files changed, 64 insertions(+), 31 deletions(-)
> > >
> > > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> > > index 9a8f964..0c0897e 100644
> > > --- a/drivers/platform/x86/Kconfig
> > > +++ b/drivers/platform/x86/Kconfig
> > > @@ -106,10 +106,15 @@ config ASUS_LAPTOP
> > >  	  If you have an ACPI-compatible ASUS laptop, say Y or M here.
> > >
> > >  config DELL_SMBIOS
> > > -	tristate
> > > +	tristate "Dell SMBIOS driver"
> > > +	---help---
> > > +	This provides support for the Dell SMBIOS calling interface.
> > > +	If you have a Dell computer you should enable this option.
> > > +
> > > +	Be sure to select at least one backend for it to work properly.
> > 
> > In order to make the default sane, I would suggest making the above a menu
> > (default n), nesting the two options below, and making WMI a default=y. This
> > satisfies Linus' requirement by defaulting everything to n, but enables a sane
> > default IFF the DELL_SMBIOS menu is enabled.
> > 
> > Alternatively, all of the above can be put under the "Dell Extras" menu I
> > proposed, and DELL_SMBIOS can default to m and DELL_SMBIOS_WMI can default
> > to y.
> 
> I'm on board with moving everything to a Dell extras menu.  There are so many
> drivers now, it really seems like the best way to make sure that people get them.
> 
> You'll have to actively go out of your way to turn off one of the sub-drivers then
> to get into the situation that was described.
> 
> Since you did the original patch for dell extras nested in a mail would you mind 
> sending that as a follow up second patch on top of my patch?
> 
> I think it's probably too much to do it all in this same patch itself.

Yup, easier for me to wrangle that all on my end. I'll look at your 3 again with
that in mind and let you know if I think any changes are needed, or just update
mine to apply on top.

-- 
Darren Hart
VMware Open Source Technology Center
