Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933659AbeBVRvf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:51:35 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59373 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933495AbeBVRvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:51:33 -0500
X-ME-Sender: <xms:JAOPWga7rpasystRDRruWIBMpjEbFnoJi7PDuUDIXlkQyFVhG4iPNg>
Date: Thu, 22 Feb 2018 14:51:29 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222175129.4nluqvqdowrm6jv3@khazad-dum.debian.net>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
 <20180222121506.GC27489@pd.tnic>
 <20180222131918.GB3797@araj-mobl1.jf.intel.com>
 <20180222154605.er6llhcaxmie3rhr@khazad-dum.debian.net>
 <0575AF4FD06DD142AD198903C74E1CC87A61B8E8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0575AF4FD06DD142AD198903C74E1CC87A61B8E8@ORSMSX103.amr.corp.intel.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018, Van De Ven, Arjan wrote:
> > > In the past the only guidance was to not load microcode at the same time to
> > the
> > > thread siblings of a core. We now have new guidance that the sibling must be
> > > spinning and not doing other things that can introduce instability around
> > loading
> > > microcode.
> > 
> > Document that properly in the Intel SDM, *please*.
> 
> yes we will update the SDM, just that is a much longer process than sending code out.
> 
> > 
> > While at it, please verify with the microcode teams that the requirement
> > for 16-byte alignment of the microcode update as present in the Intel
> > SDM still stands.  
> 
> I'd be surprised if it did not. 

The question would be better phrased as: important to which processors?
Just very old ones?

The late microcode update loader has it 16-byte aligned as a side-effect
of malloc() from what I recall when I tested it with SLUB, SLAB (I am
not sure about what the result was for SLOB), so it is an issue that was
introduced with the early initramfs microcode loader support.

However, the early loader doesn't have that benefit for the BSP.  If the
16-byte alignment were important for most stuff since the Core2, we
should be crashing like crazy when attempting early microcode updates...

Thus, apparently, 4-byte alignment (which we do always get out of the
early initramfs) is good enough on most non-ancient processors when
updating the BSP the way Linux does it, since it does work for most
people.

I don't recall what the situation is for the APs for the early loader,
though.

> >Linux does not enforce it on the early microcode update loader when
> > using an initramfs (but userspace can work around that, and
> > iucode_tool --early-fw does so).  If that 16-byte alignment is
> > important, I could dust off some patches that fix it.
> 
> hmm wonder what those tools do nowadays; Intel publishes the microcode
> in the linux native format since some time (and the .dat format is
> about to go away entirely)

I think most of them don't force the alignment in userspace.  The
exceptions are Debian, Ubuntu, and their derivatives when using
initramfs-tools (not dracut).

I do belive there are a few that generate /boot/ucode.initrd to load as
the first initrd via the bootloader using iucode_tool --write-earlyfw
(instead of using cpio).  That would also have the workaround in place.

-- 
  Henrique Holschuh
