Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeCOEBi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 00:01:38 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50273 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751650AbeCOEBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 00:01:36 -0400
X-ME-Sender: <xms:H_CpWtrnY6vSvduFe0ak5VEysClDEvcYXFcjyRJww88CzwukZMg_8Q>
Date: Thu, 15 Mar 2018 01:01:32 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Emanuel Czirai <xftroxgpx@protonmail.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Fix CPU synchronization routine
Message-ID: <20180315040132.m3i3ozykkbjrxa66@khazad-dum.debian.net>
References: <20180314183615.17629-1-bp@alien8.de>
 <20180314183615.17629-2-bp@alien8.de>
 <20180315010014.xsedkarzrgqiunxf@khazad-dum.debian.net>
 <20180315010152.GE11061@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315010152.GE11061@pd.tnic>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018, Borislav Petkov wrote:
> On Wed, Mar 14, 2018 at 10:00:14PM -0300, Henrique de Moraes Holschuh wrote:
> > Intel takes anything from twenty thousand cycles to several *million*
> > cycles per core, proportional to microcode update size.
> 
> Got any hard data to back that claim up?

A reasonably well-known paper on intel microcode updates[1] profiled
that very well, years ago (2013).  The information about a linear
increase in update time versus update size comes from that paper (I did
not attempt to reproduce his findings, though).

When I measured my Xeon X5550 workstation doing an early update, the
Xeon took about 1M cycles for the BSP, and 800k cycles for the APs (see
below).

To measure that, as far as I recall I just did a rdtsc right before the
wrmsr, and another right after, and stashed the result somewhere to be
able to print it out later in the BSP's case.  I repeated the process
(by rebooting) a few times.  There was a *lot* of variation, but not
enough to get it wrong by an order of magnitude.

I am surprised that this would be news to you, though.  It is not like I
have been quiet about how expensive these updates are on Intel over the
past years every time I sent you a patch related to this...

Anyway, here's my measurement data from 2013:

Xeon X5550:
microcode_early: CPU0: entire core updated early to revision 0x19, in 1016168 cycles
microcode_early: CPU1: entire core updated early to revision 0x19, in 842264 cycles
microcode_early: CPU2: entire core updated early to revision 0x19, in 846784 cycles
microcode_early: CPU3: entire core updated early to revision 0x19, in 838196 cycles


[1] HAWKES, Ben. "Notes on Intel Microcode Updates", March 2013.

-- 
  Henrique Holschuh
