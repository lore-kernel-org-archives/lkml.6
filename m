Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751460AbeDXVNw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:13:52 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:40339 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeDXVNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:13:50 -0400
Date: Tue, 24 Apr 2018 23:13:47 +0200
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
Message-ID: <20180424211347.GA18258@wunner.de>
References: <20180420094432.13133-1-kai.heng.feng@canonical.com>
 <20180420094432.13133-3-kai.heng.feng@canonical.com>
 <s5hbmeew01d.wl-tiwai@suse.de>
 <E5D0F76C-0A83-4D2C-81F7-BD5768C0A7DC@canonical.com>
 <20180423080844.yh6ndicpu6mwy336@pali>
 <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF30493D-012C-41E8-B379-85138E1EDE05@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 04:18:35PM +0800, Kai Heng Feng wrote:
> >On Apr 23, 2018, at 4:08 PM, Pali Rohár <pali.rohar@gmail.com> wrote:
> >On Monday 23 April 2018 16:04:55 Kai Heng Feng wrote:
> >>>On Apr 20, 2018, at 8:10 PM, Takashi Iwai <tiwai@suse.de> wrote:
> >>>On Fri, 20 Apr 2018 11:44:32 +0200, Kai-Heng Feng wrote:
> >>>>Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> >>>>controller, others from Intel audio controller.
> >>>>
> >>>>When SG is enabled, the unused AMD audio contoller still exposes its
> >>>>sysfs, so userspace still opens the control file and stream. If
> >>>>userspace tries to output sound through the stream, it hangs the system.
> >>>
> >>>Hm, could you give more information about how it hangs?
> >>
> >>Well, I should say "it hangs the userspace process" instead.
> >>
> >>$ speaker-test -t wav -c 2 -D hw:CARD=HDMI,DEV=3
> >>...and it just stopped. Can't Ctrl+C to break it.
> >
> >So userspace process cannot be killed at all? Then it is different bug
> >in kernel and disabling pci device is just a workaround. Not a real fix.
> >
> >I would propose to find out what happen and why it cannot be killed
> >(probably it stuck somewhere in kernel) and fix it properly.
> 
> That's because the audio device got runtime suspended by the graphics.
> 
> In this case, if we really want to use the the discrete audio, then we also
> need to wake up the graphics.
> The discrete audio is totally useless when SG is enabled, so my approach is
> just to disable it.

I don't quite follow, that should be fixed by commit 07f4f97d7b4b
("vga_switcheroo: Use device link for HDA controller") which landed
in v4.17-rc1.

My understanding was that with SG enabled, the external DP/HDMI ports
are muxed to the Intel GPU, so audio can only be streamed to external
displays by the Intel HDA, not by the HDA integrated into the discrete
AMD/Nvidia GPU.  Audio streamed to the latter would essentially end up
in a blackhole.  And preventing the user from seeing such useless audio
devices was the sole purpose of this commit.  Am I missing something?

Thanks,

Lukas
