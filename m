Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeDNKpR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 06:45:17 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:55401 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750880AbeDNKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 06:45:15 -0400
Date: Sat, 14 Apr 2018 12:45:12 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180414104512.GA27158@wunner.de>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > >>@@ -1711,6 +1745,11 @@ static int azx_create(struct snd_card *card,
> > >>struct pci_dev *pci,
> > >> 	if (err < 0)
> > >> 		return err;
> > >>
> > >>+	if (check_dell_switchable_gfx(pci)) {
> > >>+		pci_disable_device(pci);
> > 
> > Now looking at it again... This code disables all ATI and NVIDIA sound
> > cards available in any Dell System (laptop or AIO) if system says that
> > SG is enabled, right?
> > 
> > It means that also any external ATI or NVIDIA PCI card with audio device
> > connected to Thunderbolt (e.g. via PCI <--> TB bridge) is always
> > unconditionally disabled too?
> 
> I never thought of this case, thanks for bringing this up.
> Do you have any suggestion to check if it connects to the system via
> Thunderbolt?

Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
like this:

if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))


> >>>+	/* Only need to check for Dell laptops and AIOs */
> >>>+	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) ||
> >>>+	    !(dmi_match(DMI_CHASSIS_TYPE, "10") ||
> >>>+	      dmi_match(DMI_CHASSIS_TYPE, "13")) ||
> >>>+	    !(pdev->vendor == PCI_VENDOR_ID_ATI ||
> >>>+	      pdev->vendor == PCI_VENDOR_ID_NVIDIA))
> >>>+		return false;

It sure would be nice if someone could add macros for the chassis type
to include/linux/dmi.h so that we don't have to use these magic numbers
everywhere:

$ git grep -l DMI_CHASSIS_TYPE
drivers/firmware/dmi-id.c
drivers/firmware/dmi_scan.c
drivers/input/keyboard/atkbd.c
drivers/input/serio/i8042-x86ia64io.h
drivers/platform/x86/asus-wmi.c
drivers/platform/x86/dell-laptop.c
drivers/platform/x86/samsung-laptop.c
include/linux/mod_devicetable.h
scripts/mod/file2alias.c

Thanks,

Lukas
