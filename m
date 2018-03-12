Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932267AbeCLWI0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:08:26 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:54242 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeCLWIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:08:24 -0400
Date: Mon, 12 Mar 2018 23:07:51 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Darren Hart <dvhart@infradead.org>
Cc: mario.limonciello@dell.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Message-ID: <20180312220751.GA1757@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4716007c23abeb0e42015786794539454aff487b.1520886814.git.dvhart@infradead.org>
 <20180312202319.GA88572@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 01:23:19PM -0700, Darren Hart wrote:
> On Mon, Mar 12, 2018 at 07:53:57PM +0100, Dominik Brodowski wrote:
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
> 
> We're working on a dependency fix, but I think the problem you have here is
> likely to be ACPI_WMI=m instead of =y while you have DELL_SMBIOS=y
> 
> The fix won't allow that configuration. I'll include you in Cc of v2 of that
> fix which I'll send shortly.

On Mon, Mar 12, 2018 at 01:36:06PM -0700, Darren Hart wrote:
> Similarly to DCDBAS for DELL_SMBIOS_SMM, if DELL_SMBIOS_WMI is enabled,
> DELL_SMBIOS becomes dependent on ACPI_WMI. Update the depends lines to
> prevent a configuration where DELL_SMBIOS=y and either backend
> dependency =m. Update the comment accordingly.

I'm awfully sorry, but this patch doesn't solve the issue.
CONFIG_ACPI_WMI=y was/is set, but still enabling CONFIG_DELL_SMBIOS_WMI=y
causes a very-early crash of v4.16-rc5. In fact, so early that the normal
boot messages never show up on the screen...

Thanks,
	Dominik
