Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbeEBHpA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:45:00 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:36325 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeEBHo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:44:57 -0400
Date: Wed, 2 May 2018 09:44:55 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Takashi Iwai <tiwai@suse.de>, mjg59@srcf.ucam.org,
        dvhart@infradead.org, andy@infradead.org,
        Mario Limonciello <mario.limonciello@dell.com>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v4 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Message-ID: <20180502074455.GA17650@wunner.de>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
 <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
 <20180424211347.GA18258@wunner.de>
 <A9269F25-2239-4E3C-A3B3-FFDD69A90DD0@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A9269F25-2239-4E3C-A3B3-FFDD69A90DD0@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 03:52:08PM +0800, Kai Heng Feng wrote:
> > On Apr 25, 2018, at 5:13 AM, Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Apr 23, 2018 at 04:18:35PM +0800, Kai Heng Feng wrote:
> > > That's because the audio device got runtime suspended by the graphics.
> > >
> > > In this case, if we really want to use the the discrete audio,
> > > then we also need to wake up the graphics.
> > > The discrete audio is totally useless when SG is enabled,
> > > so my approach is just to disable it.
> >
> > I don't quite follow, that should be fixed by commit 07f4f97d7b4b
> > ("vga_switcheroo: Use device link for HDA controller") which landed
> > in v4.17-rc1.
> 
> Looks like I hit a new bug: the discrete GFX and its audio controller
> never enters to D3.
> The GFX can enter to D3 with my prosed patch.

Can you find out why?  Does the HDA controller have a codec as child
device that doesn't runtime suspend, perhaps because it failed to
initialize correctly?  If a codec device fails to runtime suspend,
the HDA controller (as parent) and by extension the GPU (via the
device link) are also kept runtime active.

Do you see anything in dmesg when the AMD HDA controller probes?
If you look in /sys/bus/pci/devices/0000:01:00.1/power/, does the
HDA controller have active kids and what is its usage count?


> > My understanding was that with SG enabled, the external DP/HDMI ports
> > are muxed to the Intel GPU, so audio can only be streamed to external
> > displays by the Intel HDA, not by the HDA integrated into the discrete
> > AMD/Nvidia GPU.  Audio streamed to the latter would essentially end up
> > in a blackhole.  And preventing the user from seeing such useless audio
> > devices was the sole purpose of this commit.  Am I missing something?
> 
> Yes this is the intention.

Could you add this information to the commit message then?

Thanks,

Lukas
