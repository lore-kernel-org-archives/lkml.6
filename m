Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933103AbeBVPqM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:46:12 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40455 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933023AbeBVPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:46:10 -0500
X-ME-Sender: <xms:wuWOWsDM17NuYYxe74TV8f_cX6GkvvuF7eOy3n20u_k9NeD6kl9oqw>
Date: Thu, 22 Feb 2018 12:46:05 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>
Subject: Re: [v2 1/3] x86/microcode/intel: Check microcode revision before
 updating sibling threads
Message-ID: <20180222154605.er6llhcaxmie3rhr@khazad-dum.debian.net>
References: <1519281205-58951-1-git-send-email-ashok.raj@intel.com>
 <1519281205-58951-2-git-send-email-ashok.raj@intel.com>
 <20180222110056.GA27489@pd.tnic>
 <20180222115554.GA3797@araj-mobl1.jf.intel.com>
 <20180222121506.GC27489@pd.tnic>
 <20180222131918.GB3797@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222131918.GB3797@araj-mobl1.jf.intel.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018, Raj, Ashok wrote:
> On Thu, Feb 22, 2018 at 01:15:06PM +0100, Borislav Petkov wrote:
> > On Thu, Feb 22, 2018 at 03:55:54AM -0800, Raj, Ashok wrote:
> > > The current code wasn't trying to enforce checking the loaded microcode revision on a thread
> > > before attempting to load the microcode. While you comeback from resume, if C0T0 already
> > > is up, and we loaded the early microcode, then when handling C0T1 there is no need to 
> > > do a wrmsrl to reapply microcode since its already loaded as part of C0T0. 
> > 
> > And I'm asking exactly this: is it simply "we don't need to do WRMSR" or
> > "we should not"?
> > 
> > Because avoiding the WRMSR costs more than simply doing it and letting
> > the HT thread ignore the supplied microcode.
> 
> This isn't a simple WRMSR like others. Microcode engine needs to do 
> a bunch of validation.
> 
> > 
> > If it is "we don't need to but there's nothing wrong when we do it" then
> > we don't need this patch. And I'm pretty sure "nothing wrong when we do
> > it" would be the answer. Otherwise we have bigger problems.
> 
> In the past the only guidance was to not load microcode at the same time to the 
> thread siblings of a core. We now have new guidance that the sibling must be 
> spinning and not doing other things that can introduce instability around loading 
> microcode.

Document that properly in the Intel SDM, *please*.

While at it, please verify with the microcode teams that the requirement
for 16-byte alignment of the microcode update as present in the Intel
SDM still stands.  Linux does not enforce it on the early microcode
update loader when using an initramfs (but userspace can work around
that, and iucode_tool --early-fw does so).  If that 16-byte alignment is
important, I could dust off some patches that fix it.

-- 
  Henrique Holschuh
