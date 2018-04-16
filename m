Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755427AbeDPOZT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:25:19 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35310 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755291AbeDPOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:25:15 -0400
X-Google-Smtp-Source: AIpwx48FHqXB1r1cBeHkDV267tuL4DWcmniqnLKMeTwZF3wGoTec3K4RpZIr3ujGpK+2KH4MdfXh4w==
Date: Mon, 16 Apr 2018 16:25:12 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180416142512.bwsemgwrncyl5xan@pali>
References: <20180412104239.25584-1-kai.heng.feng@canonical.com>
 <20180412104239.25584-3-kai.heng.feng@canonical.com>
 <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
 <20180414111711.GA4245@wunner.de>
 <20180415171746.futkvgbaoj6quy5z@pali>
 <20180415190523.GA16129@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180415190523.GA16129@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 April 2018 21:05:23 Lukas Wunner wrote:
> On Sun, Apr 15, 2018 at 07:17:46PM +0200, Pali Rohár wrote:
> > On Saturday 14 April 2018 13:17:11 Lukas Wunner wrote:
> > > On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Rohár wrote:
> > > > On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > > > > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > > > > Do you have any suggestion to check if it connects to the system via
> > > > > > Thunderbolt?
> > > > > 
> > > > > Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> > > > > like this:
> > > > > 
> > > > > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))
> > > > 
> > > > And what about PCI-e device attached to ExpressCard slot?
> > > 
> > > I don't know of a bullet-proof way to recognize those.  In theory
> > > one could check if the PCIe port above the GPU is a non-hotplug
> > > root port, but I think there are machines with hotplug capable
> > > root ports with GPUs below them that aren't actually removable.
> > > 
> > > However I think ExpressCard-attached GPUs were rare, much less ones
> > > with integrated HDA controller, so in reality that's probably a
> > > non-issue.
> > 
> > Hm... maybe another idea: Is it possible to detect which audio pci
> > device belongs to graphics card via vga_switcheroo? Currently, looking
> > at output it is same PCI device as graphic card, just different PCI
> > function.
> 
> No, the DRM drivers don't filter ExpressCard-attached GPUs when
> registering with vga_switcheroo.

> They do filter Thunderbolt-attached GPUs.

So check via vga_switcheroo should at least work for Thunderbolt GPUs.

> The ExpressCard 2.0 spec defines some ACPI stuff that *might* be
> used to recognize root ports that are ExpressCard slots, but I'm
> not sure how reliable that is.

So for EC we do not know or have reliable detection.

I do not know if it is possible, but for me it looks like that check via
vga_switcheroo should be better then adding another heuristic to other
drivers.

Lukas, what do you think? And it is possible to use this check for
detecting audio device?

And once we would have good/reliable check for EC devices we can add it
into vga_switcheroo and all users of it could benefit. Anyway, I think
that vga_switcheroo should filter also EC GPU cards if it already
filters Thunderbolt.

> I don't have such a machine and have no experience with it.
> 
> This is from the MacBookPro8,3 DSDT:
> 
>             Device (RP04)
>             {
>                 Name (_ADR, 0x001C0003)
>                 OperationRegion (A1E0, PCI_Config, 0x19, 0x01)
>                 Field (A1E0, ByteAcc, NoLock, Preserve)
>                 {
>                     SECB,   8
>                 }
> 
>                 Device (EXCD)
>                 {
>                     Name (_ADR, 0x00)
>                     Name (_SUN, 0x01)
>                     Method (_RMV, 0, NotSerialized)
>                     {
>                         Return (0x01)
>                     }
> 
>                     Name (_EJD, "\\_SB.PCI0.EHC2.HUBN.PRTN.PRT4")
>                 }
>                 ...
>             }
> 
> Thanks,
> 
> Lukas

-- 
Pali Rohár
pali.rohar@gmail.com
