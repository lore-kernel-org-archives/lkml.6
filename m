Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934581AbeBMQEm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 11:04:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39777 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933774AbeBMQEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 11:04:41 -0500
X-Google-Smtp-Source: AH8x227NvloiPipNbo/qssm2Ncb7gBIWJJ7xGt/9oXIKHIv282XyOn+bI2xCc2CBBsh2TBAmh0A2fQ==
Date: Tue, 13 Feb 2018 17:04:37 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: Thinkpad X1 Carbon 3rd - Reducing the compressed framebuffer size
Message-ID: <20180213160437.gy5luyygjvuktuqx@pali>
References: <20180206152143.vea6si7ncjj7sxyq@pali>
 <20180213085030.kiksdi2a7ksae5wz@pali>
 <20180213132726.GD5453@intel.com>
 <20180213133842.i5z5jj3sllorsy2w@pali>
 <20180213153654.GG5453@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180213153654.GG5453@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 February 2018 17:36:54 Ville Syrjälä wrote:
> On Tue, Feb 13, 2018 at 02:38:42PM +0100, Pali Rohár wrote:
> > On Tuesday 13 February 2018 15:27:26 Ville Syrjälä wrote:
> > > On Tue, Feb 13, 2018 at 09:50:30AM +0100, Pali Rohár wrote:
> > > > On Tuesday 06 February 2018 16:21:43 Pali Rohár wrote:
> > > > > Hi! I'm periodically getting following message in dmesg on Lenovo
> > > > > Thinkpad X1 Carbon 3rd generation:
> > > > > 
> > > > > [drm] Reducing the compressed framebuffer size. This may lead to less power savings than a non-reduced-size. Try to increase stolen memory size if available in BIOS.
> > > > > 
> > > > > In BIOS I already set GPU size to 512M, but this did not help. Also
> > > > > update to last BIOS version did not help.
> > > > > 
> > > > > So why this message is periodically print in dmesg? And what can I do
> > > > > with this problem?
> > > > > 
> > > > > And why cannot Linux kernel allocate itself more memory for GPU (if BIOS
> > > > > can/could do that)? Is not 512MB for GPU enough?
> > > > 
> > > > And here is output from lspci, which clearly says that 512MB is already
> > > > set for GPU:
> > > 
> > > The PCI BAR size has nothing to do with the size of the stolen memory.
> > > The BAR just provides a window into the global GTT address space of the
> > > GPU. Stolen memory is a contiguous chunk of physical memory carved out
> > > by the BIOS.
> > 
> > Ok, how could I detect how much memory was stolen?
> > 
> > In dmesg I see following lines:
> > 
> > [    0.000000] e820: BIOS-provided physical RAM map:
> > [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> > [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000008bfff] usable
> > [    0.000000] BIOS-e820: [mem 0x000000000008c000-0x000000000009ffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ab908fff] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000ab909000-0x00000000abb08fff] type 20
> > [    0.000000] BIOS-e820: [mem 0x00000000abb09000-0x00000000acbfefff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000acbff000-0x00000000acd7efff] ACPI NVS
> > [    0.000000] BIOS-e820: [mem 0x00000000acd7f000-0x00000000acdfefff] ACPI data
> > [    0.000000] BIOS-e820: [mem 0x00000000acdff000-0x00000000acdfffff] usable
> > [    0.000000] BIOS-e820: [mem 0x00000000f80f8000-0x00000000f80f8fff] reserved
> > [    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
> > [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000024dffffff] usable
> > 
> > [    0.000000] Reserving Intel graphics memory at 0x00000000ae000000-0x00000000afffffff
> 
> That's the one. Since you have a BDW the amount FBC can actually use
> will be 8MiB less than what's reported here. So looks like you should
> have 24MiB total, minus whatever else we end up allocating from stolen.
> 
> Check /sys/kernel/debug/dri/0/i915_gem_stolen to see what's there. Most

$ cat /sys/kernel/debug/dri/0/i915_gem_stolen
Stolen:
   ffff8b55bf17e080:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00083000, size: 00004000, type: 0) (stolen: 00001000)
   ffff8b55c2693040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 02b9f000, size: 00004000, type: 0) (stolen: 00005000)
   ffff8b55bf9a7300:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0f6b4000, size: 00004000, type: 0) (stolen: 00009000)
   ffff8b55a6161040:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0937f000, size: 00004000, type: 0) (stolen: 0000d000)
   ffff8b5563e0dac0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0f714000, size: 00004000, type: 0) (stolen: 00019000)
   ffff8b55bf17e800:    g         4KiB 41 00 [ 0 0 0 0 ] 0  LLC (pinned x 1) (ggtt offset: ffffe000, size: 00001000, type: 0) (stolen: 0012c000)
   ffff8b55bf02d540:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00141000, size: 00004000, type: 0) (stolen: 0012d000)
   ffff8b55c2989340:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00148000, size: 00004000, type: 0) (stolen: 00131000)
   ffff8b55c29890c0:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 0014f000, size: 00004000, type: 0) (stolen: 00135000)
   ffff8b55c2989840:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 1) (ggtt offset: 00156000, size: 00004000, type: 0) (stolen: 00139000)
   ffff8b55bf02da40:  p g     14400KiB 77 00 [ 0 0 0 0 ] 0  uncached dirty (name: 1) (pinned x 1) (display) (ggtt offset: 0015a000, size: 00e10000, type: 0) (stolen: 0013d000) (p mappable)
   ffff8b556dfba780:    g        16KiB 40 40 [ 0 0 0 0 ] 0  LLC dirty (pinned x 0) (ggtt offset: 0ad2a000, size: 00004000, type: 0) (stolen: 01655000)

> likely you'll have the fbdev framebuffer taking up a sizeable chunk.

Seems 14MB.

> You could get some back by reducing fbdev depth to 16bpp, or even 8bpp,
> but I'm not convinced the fbdev gamma LUT stuff really works currently
> so you might end up with bogus colors in your vts with that.

Ok, I could try it. Via fbset tool?

> > 
> > [    0.000000] Memory: 7972840K/8282704K available (6196K kernel code, 1159K rwdata, 2848K rodata, 1408K init, 688K bss, 309864K reserved, 0K cma-reserved)
> > 
> > > The BIOS may or may not provide a knob to change the size
> > > of the stolen memory.
> > 
> > In BIOS Setup screen I have option to choose GPU memory and I set it to
> > max 512MB. So this is not the right option...
> > 
> > And why cannot kernel use some continuous check of RAM itself?
> 
> Because the hardware won't allow it.

So it can be done only once after reboot? Or only prior to booting kernel?

> > 
> > > > 
> > > > $ lspci -v -s 00:02.0
> > > > 00:02.0 VGA compatible controller: Intel Corporation HD Graphics 5500 (rev 09) (prog-if 00 [VGA controller])
> > > >         Subsystem: Lenovo HD Graphics 5500
> > > >         Flags: bus master, fast devsel, latency 0, IRQ 46
> > > >         Memory at e0000000 (64-bit, non-prefetchable) [size=16M]
> > > >         Memory at c0000000 (64-bit, prefetchable) [size=512M]
> > > >         I/O ports at 3000 [size=64]
> > > >         [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
> > > >         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
> > > >         Capabilities: [d0] Power Management version 2
> > > >         Capabilities: [a4] PCI Advanced Features
> > > >         Kernel driver in use: i915
> > > >         Kernel modules: i915
> > > > 
> > > > -- 
> > > > Pali Rohár
> > > > pali.rohar@gmail.com
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > > 
> > 
> > -- 
> > Pali Rohár
> > pali.rohar@gmail.com
> 

-- 
Pali Rohár
pali.rohar@gmail.com
