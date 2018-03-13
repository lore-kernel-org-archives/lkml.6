Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbeCMFyy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 01:54:54 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:39780 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751329AbeCMFyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 01:54:52 -0400
Date: Tue, 13 Mar 2018 06:51:09 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Mario.Limonciello@dell.com
Cc: dvhart@infradead.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180313055109.GA14542@light.dominikbrodowski.net>
References: <20180312185357.GA1672@light.dominikbrodowski.net>
 <4cce64d16cab4d499dca9347c1a1f30c@ausx13mpc120.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cce64d16cab4d499dca9347c1a1f30c@ausx13mpc120.AMER.DELL.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 10:42:01PM +0000, Mario.Limonciello@dell.com wrote:
> 
> 
> > -----Original Message-----
> > From: Dominik Brodowski [mailto:linux@dominikbrodowski.net]
> > Sent: Tuesday, March 13, 2018 2:54 AM
> > To: dvhart@infradead.org; Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
> > 
> > Mario,
> > 
> > unfortunately, my Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016 fails to
> > boot v4.16-rc5. More exactly, I could bisect it down to commit 25d47027e10
> > ("platform/x86: dell-smbios: Link all dell-smbios-* modules together").
> > Usually, I have enabled
> > 
> > CONFIG_SENSORS_DELL_SMM=y
> > CONFIG_DELL_SMBIOS=y
> > CONFIG_DELL_SMBIOS_WMI=y
> > CONFIG_DELL_SMBIOS_SMM=y
> > CONFIG_DELL_LAPTOP=y
> > CONFIG_DELL_WMI=y
> > CONFIG_DELL_WMI_DESCRIPTOR=y
> > # CONFIG_DELL_WMI_AIO is not set
> > # CONFIG_DELL_WMI_LED is not set
> > # CONFIG_DELL_SMO8800 is not set
> > # CONFIG_DELL_RBTN is not set
> > # CONFIG_DELL_RBU is not set
> > 
> > For v4.16-rc5 to work, I need to manually disable DELL_SMBIOS_WMI:
> > 
> > -CONFIG_DELL_SMBIOS_WMI=y
> > +# CONFIG_DELL_SMBIOS_WMI is not set
> > 
> > Any ideas?
> > 
> Dominick,
> 
> Interesting.  Can you please change CONFIG_DELL_SMBIOS to a module
> and see if that behavior persists?  If it does, can you please blacklist it on
> the kernel command line and try to load it manually and share any
> backtrace?

Mario,

building and running it as a *module* works flawlessly. But that was
actually expected after a 'grep "initcall"' in drivers/platform/x86:

As Darren pointed out, DELL_SMBIOS_WMI depends on ACPI_WMI, so probably
ACPI_WMI needs to be initialized first. However, the all-in-one
dell-smbios.o is run as subsys_initcall(), same as wmi.o
(subsys_initcall_sync() there).

If both are built-ins, that means that dell-smbios.o is run first, and wmi.o
second. Changing dell-smbios.o to run at the later fs_initcall() level
instead lets me boot the kernel. HOWEVER:

1) Is there a reason why both the core and the dell-smbios-smm driver have
   to run already at subsys_initcall() time? They did so previous to your
   patch. Is it OK to defer these parts opf the all-in-one dell-smbios.o
   to fs_initcall(), or even to the default device_initcall()?

2) dell-smbios-wmi depends on (well, selects) DELL_WMI_DESCRIPTOR. The
   dell-smbios-wmi is running at the default device_initcall() time, but
   (AFAICS) probably later than the initialization of dell-smbios-wmi.o.
   May I presume that this poses no additional problem?

Thanks,
	Dominik
