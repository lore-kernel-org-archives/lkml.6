Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeELTPz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 15:15:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35096 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeELTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 15:15:54 -0400
Date: Sat, 12 May 2018 12:15:51 -0700
From: Darren Hart <dvhart@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: kbuild test robot <lkp@intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/platform/x86/dell-smbios-smm.c:99: undefined reference
 to `dcdbas_smi_request'
Message-ID: <20180512191551.GA45271@fedora>
References: <201805121703.jgrY5zId%fengguang.wu@intel.com>
 <20180512183207.GA5102@fedora>
 <97a38f51-31ab-f346-051b-b8bed4eca641@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a38f51-31ab-f346-051b-b8bed4eca641@infradead.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 12, 2018 at 11:51:02AM -0700, Randy Dunlap wrote:
> On 05/12/2018 11:32 AM, Darren Hart wrote:
> > On Sat, May 12, 2018 at 05:28:05PM +0800, kbuild test robot wrote:
> >> Hi Mario,
> >>
> >> FYI, the error/warning still remains.
> >>
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   f0ab773f5c96c29a5227234c4b5a820f5591b74d
> >> commit: 25d47027e1003546bfd8964b4423cb39bc2d53e9 platform/x86: dell-smbios: Link all dell-smbios-* modules together
> >> date:   9 weeks ago
> >> config: x86_64-randconfig-s5-05121617 (attached as .config)
> >> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> >> reproduce:
> >>         git checkout 25d47027e1003546bfd8964b4423cb39bc2d53e9
> > 
> > This failure:
> > 
> > $ zcat config.gz | grep DCDBAS
> > CONFIG_DCDBAS=m            <----------
> > 
> > $ zcat config.gz | grep SMBIOS
> > CONFIG_DELL_SMBIOS=y       <----------
> > ddCONFIG_DELL_SMBIOS_WMI=y
> > CONFIG_DELL_SMBIOS_SMM=y   <----------
> > 
> > Is no longer possible as of:
> > 
> > cc69c88 platform/x86: dell-smbios: Resolve dependency error on DCDBAS
> > 
> > +#
> > +# If the DELL_SMBIOS_SMM feature is enabled, the DELL_SMBIOS driver
> > +# becomes dependent on the DCDBAS driver. The "depends" line prevents a
> > +# configuration where DELL_SMBIOS=y while DCDBAS=m.
> > +#
> >  config DELL_SMBIOS
> >         tristate "Dell SMBIOS driver"
> > +       depends on DCDBAS || DCDBAS=n
> > 
> 
> and but yet, in linux-4.17-rc4, with this posted config file (after
> using:  yes '' |make oldconfig), we can see:
> 
> WARNING: unmet direct dependencies detected for DELL_SMBIOS
>   Depends on [m]: X86 [=y] && X86_PLATFORM_DEVICES [=y] && (DCDBAS [=m] || DCDBAS [=m]=n) && (ACPI_WMI [=y] || ACPI_WMI [=y]=n)
>   Selected by [y]:
>   - DELL_WMI [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && ACPI_WMI [=y] && DMI [=y] && INPUT [=y] && (ACPI_VIDEO [=y] || ACPI_VIDEO [=y]=n)
> 
> CONFIG_DELL_SMBIOS=y
> CONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_SMBIOS_SMM=y
> # CONFIG_DELL_LAPTOP is not set
> CONFIG_DELL_WMI=y

Ugh. It must be this straggler then:

config DELL_WMI
	...
	select DELL_SMBIOS

which will set DELL_SMBIOS to y and ignore the dependencies.

The only other DELL related select in the Kconfig is DELL_WMI_DESCRIPTOR which
doesn't have a prompt, but does depend on ACPI_WMI. It is only selected from
configs which already depend on ACPI_WMI.

So the immediate fix appears to be:


>From bf88bc78d5bb1f03a1b99b110b71af8443692df0 Mon Sep 17 00:00:00 2001
Message-Id: <bf88bc78d5bb1f03a1b99b110b71af8443692df0.1526152324.git.dvhart@infradead.org>
From: Darren Hart <dvhart@infradead.org>
Date: Sat, 12 May 2018 12:10:07 -0700
Subject: [PATCH] platform/x86: DELL_WMI use depends on instead of select for
 DELL_SMBIOS

If DELL_WMI "select"s DELL_SMBIOS, the DELL_SMBIOS dependencies are
ignored and it is still possible to end up with unmet direct
dependencies.

Change the select to a depends on.

Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
---
 drivers/platform/x86/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bc309c5..566644b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -168,8 +168,8 @@ config DELL_WMI
 	depends on DMI
 	depends on INPUT
 	depends on ACPI_VIDEO || ACPI_VIDEO = n
+	depends on DELL_SMBIOS
 	select DELL_WMI_DESCRIPTOR
-	select DELL_SMBIOS
 	select INPUT_SPARSEKMAP
 	---help---
 	  Say Y here if you want to support WMI-based hotkeys on Dell laptops.
-- 
2.9.3


-- 
Darren Hart
VMware Open Source Technology Center
