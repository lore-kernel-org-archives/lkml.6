Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBZQb0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:31:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37934 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeBZQbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:31:25 -0500
Date: Mon, 26 Feb 2018 17:31:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
Message-ID: <20180226163102.GM4377@pd.tnic>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:14:10AM -0600, Tom Lendacky wrote:
> On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
> > On Sat, 24 Feb 2018, Paul Menzel wrote:
> >> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
> >>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
> >>>> Borislav is seeing similar issues on larger AMD machines. The interrupt
> >>>> seems to come from BIOS/microcode during bringup of secondary CPUs and we
> >>>> have no idea why.
> >>>
> >>> Paul, can you boot 4.14 and grep your dmesg for something like:
> >>>
> >>> [    0.000000] spurious 8259A interrupt: IRQ7. >
> >>> ?
> >>
> >> No, I do not see that. Please find the logs attached.
> > 
> > From your 4.14 log:
> > 
> > Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
> > Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
> 
> I think I remember seeing something like this previously and it turned out
> to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
> interrupt controller.  In an SMP system, only one processor in the system
> should be configured to handle legacy 8259 interrupts (ExtINT delivery
> mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
> the BIOS was fixed, the spurious interrupt message went away.
> 
> I believe at some point during UEFI, the APs were exposed to an ExtINT
> interrupt.  Since they were configured to handle ExtINT delivery mode and
> interrupts were not yet enabled, the interrupt was left pending.  When the
> APs were started by the OS and interrupts were enabled, the interrupt
> triggered. Since the original pending interrupt was handled by the BSP,
> there was no longer an interrupt actually pending, so the 8259 responds
> with IRQ 7 when queried by the OS.  This occurred for each AP.

Interesting - is this something that can happen on Zen too?

Because I have such reports too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
