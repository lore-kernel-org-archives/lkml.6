Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeCIJqF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:46:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40372 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCIJqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:46:03 -0500
X-Google-Smtp-Source: AG47ELs+9OCDFpHYbFvLm420s8ZMG6byNc7dhC7y5ZyalQAmQum1KDxLawI0fhzAHnOc074QiO+k7Q==
Date: Fri, 9 Mar 2018 10:46:00 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario.Limonciello@dell.com
Cc: kai.heng.feng@canonical.com, mjg59@srcf.ucam.org, dvhart@infradead.org,
        andy@infradead.org, tiwai@suse.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180309094600.m24d3zbzdsmls7aw@pali>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180309090223.xb55ltac4pfesdrh@pali>
 <723DA929-C9FA-4F69-8D3A-03D8A75D09A6@canonical.com>
 <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <014795f5a3014cd3bf55de26f76a5af8@ausx13mpc124.AMER.DELL.COM>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 March 2018 09:34:01 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Kai Heng Feng [mailto:kai.heng.feng@canonical.com]
> > Sent: Friday, March 9, 2018 5:30 PM
> > To: Pali Rohár <pali.rohar@gmail.com>
> > Cc: mjg59@srcf.ucam.org; dvhart@infradead.org; andy@infradead.org;
> > Limonciello, Mario <Mario_Limonciello@Dell.com>; tiwai@suse.com; platform-
> > driver-x86@vger.kernel.org; Linux Kernel Mailing List <linux-
> > kernel@vger.kernel.org>; alsa-devel@alsa-project.org
> > Subject: Re: [PATCH v2 3/3] ALSA: hda: Disabled unused audio controller for Dell
> > platforms with Switchable Graphics
> > 
> > 
> > > On Mar 9, 2018, at 5:02 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> > >
> > > On Thursday 08 March 2018 17:10:23 Kai-Heng Feng wrote:
> > >> Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> > >> "Switchable Graphics" (SG).
> > >>
> > >> When SG is enabled, we have:
> > >> 00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> > >> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> > >> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >> [AMD/ATI] Ellesmere [Polaris10]
> > >> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> > >> [Radeon RX 580]
> > >>
> > >> The Intel Audio outputs all the sound, including HDMI audio. The audio
> > >> controller comes with AMD graphics doesn't get used.
> > >>
> > >> When SG is disabled, we have:
> > >> 00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> > >> 01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> > >> [AMD/ATI] Ellesmere [Polaris10]
> > >> 01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> > >> [Radeon RX 580]
> > >>
> > >> Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> > >> controller, others from Intel audio controller.
> > >>
> > >> When SG is enabled, the unused AMD audio controller still exposes its
> > >> sysfs, so userspace still opens the control file and stream. If
> > >> userspace tries to output sound through the stream, it hangs when
> > >> runtime suspend kicks in:
> > >> [ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> > >> [ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> > >>
> > >> Since the discrete audio controller isn't useful when SG enabled, we
> > >> should just disable the device.
> > >>
> > >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >> ---
> > >> v2: Mario suggested to squash the HDA part into the same series.
> > >>
> > >>  sound/pci/hda/hda_intel.c | 35 +++++++++++++++++++++++++++++++++++
> > >>  1 file changed, 35 insertions(+)
> > >>
> > >> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > >> index 96143df19b21..8e3e8b88624a 100644
> > >> --- a/sound/pci/hda/hda_intel.c
> > >> +++ b/sound/pci/hda/hda_intel.c
> > >> @@ -49,6 +49,7 @@
> > >>  #include <linux/clocksource.h>
> > >>  #include <linux/time.h>
> > >>  #include <linux/completion.h>
> > >> +#include <linux/dell-common.h>
> > >>
> > >>  #ifdef CONFIG_X86
> > >>  /* for snoop control */
> > >> @@ -1620,6 +1621,35 @@ static void check_msi(struct azx *chip)
> > >>  	}
> > >>  }
> > >>
> > >> +#if IS_ENABLED(CONFIG_DELL_LAPTOP)
> > >> +static bool check_dell_switchable_gfx(struct pci_dev *pdev)
> > >> +{
> > >> +	static int (*dell_switchable_gfx_enabled_func)(bool *);
> > >> +	bool enabled;
> > >> +	int err;
> > >> +
> > >> +	if (pdev->vendor != PCI_VENDOR_ID_ATI ||
> > >> +	    pdev->subsystem_vendor != PCI_VENDOR_ID_DELL)
> > >> +		return false;
> > >
> > > Are you sure that you want to do this check unconditionally on all
> > > machines which have enabled CONFIG_DELL_LAPTOP?
> > >
> > > Subvendor ID_DELL for dell specific code is not suspicious, but ID_ATI
> > > is. What would happen if ATI vendor changes to NVIDIA or other which is
> > > not related to Dell?
> > 
> > We only check it when it's both ATI and DELL, otherwise just return false?
> > 
> > The platform does have a NVIDIA variant, but the discrete NVIDIA have a
> > audio controller, hence it doesn't have the issue.
> > The issue only happens to AMD/ATI configs with "Switchable Graphics" option.
> > 
> 
> Pali is your concern that this code for matching vendor/subsystem is running
> on non-Dell too?  The only other recommendation I think that can be to restrict
> to matching Dell OEM strings in SMBIOS table, but I don't think that's any better
> than the matching for VID/SSVID.

My concern is about adding a new machine specific code into generic
driver, which check is done just by PCI vendor and subvendor.

In future there can be new models or other PCI devices which matches
above condition even they would not have any switchable graphics, nor
they would manufactured by Dell.

Also I can imagine that in future (or maybe already now?) it is possible
to find PCI device which pass above checks and connect this PCI device
into desktop /server / any non-laptop device.

If this switchable graphics solution is specific to dell laptops, then
rather checking for PCI vendor/subvevendor main check, there should be
main check via DMI strings.

Hardware is changing relatively quickly and there is absolutely no
guarantee that e.g. NVIDIA would not start providing audio controller in
similar like AMD and it would be put in those Dell machines.

> > >
> > > Interesting question would be, how handle this situation Windows?
> > 
> > I don't know how this platform handles this on Windows, I guess we need
> > Mario to shed some lights here.
> 
> Sorry I don't have this information to share.   I don't think it's too useful here
> anyway though because Windows driver architecture is much different in this
> area.
> 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
