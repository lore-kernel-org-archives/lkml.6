Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeDQHxE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:53:04 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:44705 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeDQHxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:53:02 -0400
X-Google-Smtp-Source: AIpwx49VyodnjznVSRQ2bYZuJUioNJH8uoDqQeBeQYB7oCyR0xtCbNRRkaD0pZsHVoKlnv40zdhOnw==
Date: Tue, 17 Apr 2018 09:52:57 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, mario.limonciello@dell.com,
        andy@infradead.org, dvhart@infradead.org, mjg59@srcf.ucam.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: hda: Disabled unused audio controller for
 Dell platforms with Switchable Graphics
Message-ID: <20180417075257.zjnju4jyyc3k5fez@pali>
References: <s5hr2nk8zs5.wl-tiwai@suse.de>
 <20180412105909.tbyfcjm55sb47hiq@pali>
 <93DC0F40-81A5-49C6-A470-0D1B6AA85725@canonical.com>
 <20180414104512.GA27158@wunner.de>
 <20180414104950.ngomyjy5l5cwhb5i@pali>
 <20180414111711.GA4245@wunner.de>
 <20180415171746.futkvgbaoj6quy5z@pali>
 <20180415190523.GA16129@wunner.de>
 <20180416142512.bwsemgwrncyl5xan@pali>
 <20180417023829.GA1533@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180417023829.GA1533@wunner.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 April 2018 04:38:29 Lukas Wunner wrote:
> On Mon, Apr 16, 2018 at 04:25:12PM +0200, Pali Rohár wrote:
> > On Sunday 15 April 2018 21:05:23 Lukas Wunner wrote:
> > > On Sun, Apr 15, 2018 at 07:17:46PM +0200, Pali Rohár wrote:
> > > > On Saturday 14 April 2018 13:17:11 Lukas Wunner wrote:
> > > > > On Sat, Apr 14, 2018 at 12:49:50PM +0200, Pali Rohár wrote:
> > > > > > On Saturday 14 April 2018 12:45:12 Lukas Wunner wrote:
> > > > > > > On Thu, Apr 12, 2018 at 10:15:41PM +0800, Kai-Heng Feng wrote:
> > > > > > > > Do you have any suggestion to check if it connects to the system via
> > > > > > > > Thunderbolt?
> > > > > > > 
> > > > > > > Just use pci_is_thunderbolt_attached(), introduced by 8531e283bee6,
> > > > > > > like this:
> > > > > > > 
> > > > > > > if (check_dell_switchable_gfx(pci) && !pci_is_thunderbolt_attached(pci))
> > > > > > 
> > > > > > And what about PCI-e device attached to ExpressCard slot?
> > > > > 
> > > > > I don't know of a bullet-proof way to recognize those.
> > > > 
> > > > Hm... maybe another idea: Is it possible to detect which audio pci
> > > > device belongs to graphics card via vga_switcheroo? Currently, looking
> > > > at output it is same PCI device as graphic card, just different PCI
> > > > function.
> > > 
> > > No, the DRM drivers don't filter ExpressCard-attached GPUs when
> > > registering with vga_switcheroo.
> > 
> > > They do filter Thunderbolt-attached GPUs.
> > 
> > So check via vga_switcheroo should at least work for Thunderbolt GPUs.
> > 
> > I do not know if it is possible, but for me it looks like that check via
> > vga_switcheroo should be better then adding another heuristic to other
> > drivers.
> 
> It is way simpler and more straightforward if hda_intel.c calls
> pci_is_thunderbolt_attached() directly, as I've suggested above.
> 
> The DRM drivers call that as well and register with vga_switcheroo
> only if it returns false.  So if hda_intel.c asked vga_switcheroo
> and got back a negative answer, it would never know whether it's
> because the DRM driver hasn't finished probing yet, or it's module
> is blacklisted, or whatever.

Ok, module blacklisting can be a problem.

> 
> > And once we would have good/reliable check for EC devices we can add it
> > into vga_switcheroo and all users of it could benefit. Anyway, I think
> > that vga_switcheroo should filter also EC GPU cards if it already
> > filters Thunderbolt.
> 
> vga_switcheroo doesn't do the filtering, the DRM drivers themselves
> decice whether to register with vga_switcheroo or not.  The motivation
> is to avoid middle layers and instead provide the DRM drivers with
> a library of helpers that they may call at their own discretion.

Understood. Driver itself can also do more work, e.g. ask ACPI or do
some other check to decide whatever to register to vga_switcheroo or
not.

But probably, hda_intel should have same logic for disabling device like
gpu drivers for detection if they are going to register into
vga_switcheroo or not.

Right now this seems to be really complicated and suggested solution
with pci_is_thunderbolt_attached() looks to be really simple and better
for now.

> See this blog post and the links therein for background info:
> http://blog.ffwll.ch/2016/12/midlayers-once-more-with-feeling.html
> 
> Thanks,
> 
> Lukas

-- 
Pali Rohár
pali.rohar@gmail.com
