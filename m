Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933123AbeB1THa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 14:07:30 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57257 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932423AbeB1TH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 14:07:29 -0500
X-ME-Sender: <xms:8P2WWh0HNsZMVz94kpFlV_AuNgrXk3jHfrXpWlPpxRabBrmaq5D5fg>
Date: Wed, 28 Feb 2018 16:07:25 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] x86/microcode: Do not upload microcode if CPUs are
 offline
Message-ID: <20180228190725.c2yuivmmfiezsict@khazad-dum.debian.net>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-5-bp@alien8.de>
 <20180228131156.i4y6la7besdflffd@khazad-dum.debian.net>
 <20180228132639.GA23235@araj-mobl1.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228132639.GA23235@araj-mobl1.jf.intel.com>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2018, Raj, Ashok wrote:
> On Wed, Feb 28, 2018 at 10:11:56AM -0300, Henrique de Moraes Holschuh wrote:
> > > Avoid loading microcode if any of the CPUs are offline, and issue a
> > > warning. Having different microcode revisions on the system at any time
> > > is outright dangerous.
> > 
> > Even if we update that microcode during CPU early bring-up, before we
> > mark it on-line and start using it?
> > 
> > AFAIK, late-loading or not, this is what should happen in the current
> > code: APs that are brought up after a microcode update is loaded (either
> > by the early or late driver, it doesn't matter) will be always
> > *early-updated* to the new microcode.
> > 
> > Is it dangerous to have an offline core at an older microcode revision
> > than the online cores?
> 
> We don't want to leave a system and allow the user to update microcode
> when some cpus are offline. Remember cpu_offline in linux is only 
> logical offlining.. so the cpu is still in the system.. it can even 
> participate in MCE for e.g. It is very much alive. Its not a question
> that "Would it not work" but its not worth to leave an open door and 
> being paranoid is best!

I see.  Thanks for the explanation!

> > I am not against the patch, mind you, but I am curious about why it is
> > supposed to be dangerous if we're updating the CPUs before we start
> > using them *anyway*.
> > 
> > Also, if this is really dangerous, does it means safe CPU hotplug isn't
> > possible?  AFAICT, the firmware would have to do it for us, but it
> > *doesn't* have the up-to-date microcode (*we* had to update it)...
> 
> The difference is hot-adding you know you are going to update the current
> microcode. But leaving a cpu in offline state is leaving it stale for a long
> time without realizing that you have some stale cores.

That begs the question: do we have any reasons to not update the
microcode even the offline cores?

-- 
  Henrique Holschuh
