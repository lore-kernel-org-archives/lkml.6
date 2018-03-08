Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935652AbeCHLaY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 06:30:24 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:58407 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeCHLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 06:30:22 -0500
Date: Thu, 8 Mar 2018 12:30:20 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: mjg59@srcf.ucam.org, pali.rohar@gmail.com, dvhart@infradead.org,
        andy@infradead.org, Mario Limonciello <mario.limonciello@dell.com>,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 3/3] ALSA: hda: Disabled unused audio
 controller for Dell platforms with Switchable Graphics
Message-ID: <20180308113020.GA23073@wunner.de>
References: <20180308091023.9061-1-kai.heng.feng@canonical.com>
 <20180308091023.9061-3-kai.heng.feng@canonical.com>
 <20180308093848.GA24068@wunner.de>
 <1A1B9259-DC5B-4C1A-96BD-7FCACDBFFBB3@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1A1B9259-DC5B-4C1A-96BD-7FCACDBFFBB3@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 06:38:45PM +0800, Kai Heng Feng wrote:
> >On Mar 8, 2018, at 5:38 PM, Lukas Wunner <lukas@wunner.de> wrote:
> >On Thu, Mar 08, 2018 at 05:10:23PM +0800, Kai-Heng Feng wrote:
> >>Some Dell platforms (Preicsion 7510/7710/7520/7720) have a BIOS option
> >>"Switchable Graphics" (SG).
> >>
> >>When SG is enabled, we have:
> >>00:02.0 VGA compatible controller: Intel Corporation Device 591b (rev 04)
> >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>[AMD/ATI] Ellesmere [Polaris10]
> >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >>[Radeon RX 580]
> >>
> >>The Intel Audio outputs all the sound, including HDMI audio. The audio
> >>controller comes with AMD graphics doesn't get used.
> >>
> >>When SG is disabled, we have:
> >>00:1f.3 Audio device: Intel Corporation CM238 HD Audio Controller (rev 31)
> >>01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
> >>[AMD/ATI] Ellesmere [Polaris10]
> >>01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Ellesmere
> >>[Radeon RX 580]
> >>
> >>Now it's a typical discrete-only system. HDMI audio comes from AMD audio
> >>controller, others from Intel audio controller.
> >>
> >>When SG is enabled, the unused AMD audio controller still exposes its
> >>sysfs, so userspace still opens the control file and stream. If
> >>userspace tries to output sound through the stream, it hangs when
> >>runtime suspend kicks in:
> >>[ 12.796265] snd_hda_intel 0000:01:00.1: Disabling via vga_switcheroo
> >>[ 12.796367] snd_hda_intel 0000:01:00.1: Cannot lock devices!
> >
> >This should be fixed by the following series:
> >https://lists.freedesktop.org/archives/dri-devel/2018-March/168012.html
> >
> >Please verify that by testing the series on the machine in question.
> >I'm hoping to get those patches in for 4.17.  I suspect that your
> >patch may not be necessary then.
> 
> I no longer see the warning message with your patch. Thanks!

Awesome, thanks for testing!


> >>Since the discrete audio controller isn't useful when SG enabled, we
> >>should just disable the device.
> >
> >I don't quite follow, when SG is enabled but hda_intel doesn't bind
> >to the AMD audio device, how are you going to stream audio to
> >external displays?  Are external DP/HDMI ports muxed to the integrated
> >GPU when SG is enabled?
> 
> Yes. It's a muxed port.
> The can directly output via integrated Intel GPU when SG is enabled.
> The discrete audio controller never gets used when SG is enabled.

Okay, that's a crucial piece of information which I think should be
made more explicit in the commit message and probably also in a code
comment so that someone reading through hda_intel.c doesn't have to
look in the git history to understand what's going on.

I'd remove the portion of the commit message pertaining to runtime
suspend and instead write something like:

    If Switchable Graphics is enabled, external DP/HDMI ports are
    muxed to the Intel GPU and HDA controller and therefore those
    on the AMD HDA controller shouldn't be exposed to user space.

Thanks,

Lukas
