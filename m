Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161783AbeBNSNr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:13:47 -0500
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:56990 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161695AbeBNSNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:13:45 -0500
Date: Wed, 14 Feb 2018 11:13:42 -0700
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave@sr71.net>,
        hpa@zytor.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk,
        linux-tip-commits@vger.kernel.org,
        Arjan van de Ven <arjan@infradead.org>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls
 from NMI context
Message-ID: <20180214181342.GA27600@anatevka.americas.hpqcorp.net>
Reply-To: Jerry.Hoemann@hpe.com
References: <1518362359-1005-1-git-send-email-dwmw@amazon.co.uk>
 <tip-670c3e8da87fa4046a55077b1409cf250865a203@git.kernel.org>
 <20180212102211.cdrrqqd4hdw7xu5y@gmail.com>
 <a85c28b8-1255-3264-bb4a-89e85e3c6009@sr71.net>
 <20180212165835.GO25181@hirez.programming.kicks-ass.net>
 <20180213075540.3lkikkpgjoe6ocjk@gmail.com>
 <5c3ba123-abbe-f153-7b75-a89d31d25c72@linux.intel.com>
 <20180214093159.mdzfupne547bi5qx@gmail.com>
 <20180214094404.GA18349@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214094404.GA18349@pd.tnic>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

I have a patch set under review that brings hpwdt into compliance
with the watchdog core.

One of the changes removes the callback into firmware in hpwdt_pretimeout
and its associated spinlock.

https://lkml.org/lkml/2018/2/12/30

I will add you to the CC list of the next version of the set.

Jerry


On Wed, Feb 14, 2018 at 10:44:05AM +0100, Borislav Petkov wrote:
> + Jerry
> 
> On Wed, Feb 14, 2018 at 10:31:59AM +0100, Ingo Molnar wrote:
> > 
> > * Tim Chen <tim.c.chen@linux.intel.com> wrote:
> > 
> > > Dave Hansen and I had some discussions on how to handle the nested NMI and 
> > > firmware calls.  We thought of using a per cpu counter to record the nesting 
> > > call depth and toggle IBRS appropriately for the depth 0->1 and 1->0 transition.  
> > > Will this change be sufficient?
> > 
> > Yeah, so I think the first question should be: does the firmware call from NMI 
> > context make sense to begin with?
> > 
> > Because in this particular case it does not appear to be so: the reason for the 
> > BIOS/firmware call appears to be to determine how we nmi_panic() after receiving 
> > an NMI that no other NMI handler handled: with a passive-aggressive "I don't know" 
> > panic message or with a slightly more informative panic message.
> > 
> > That's not a real value-add to users - so we can avoid all these complications by 
> > applying the patch below:
> > 
> >  drivers/watchdog/hpwdt.c | 30 ++++--------------------------
> >  1 file changed, 4 insertions(+), 26 deletions(-)
> > 
> > As a bonus the spinlock use can be removed as well.
> > 
> > Thanks,
> > 
> > 	Ingo
> > 
> > ====================>
> > From b038428a739a3fcf0b9678305c131f60af7422ca Mon Sep 17 00:00:00 2001
> > From: Ingo Molnar <mingo@kernel.org>
> > Date: Wed, 14 Feb 2018 10:24:41 +0100
> > Subject: [PATCH] watchdog: hpwdt: Remove spinlock acquire and BIOS calls from
> >  NMI context
> > 
> > Taking a spinlock and calling into the firmware are problematic things to
> > do from NMI callbacks.
> > 
> > It also seems completely pointless in this particular case:
> > 
> >  - cmn_regs is updated by the firmware call in the hpwdt_pretimeout() NMI
> >    callback, but there's almost no use for it: we use it only to determine
> >    whether to panic with an 'unknown NMI' or a slightly more descriptive
> >    message.
> > 
> >  - cmn_regs and rom_lock is not used anywhere else, other than early detection
> >    of the firmware capability.
> > 
> > So remove rom_lock, make the cmn_regs call from the detection routine only,
> > and thus make the NMI callback a lot more robust.
> > 
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/watchdog/hpwdt.c | 30 ++++--------------------------
> >  1 file changed, 4 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> > index f1f00dfc0e68..2544fe482fe3 100644
> > --- a/drivers/watchdog/hpwdt.c
> > +++ b/drivers/watchdog/hpwdt.c
> > @@ -150,9 +150,7 @@ static unsigned int hpwdt_nmi_decoding;
> >  static unsigned int allow_kdump = 1;
> >  static unsigned int is_icru;
> >  static unsigned int is_uefi;
> > -static DEFINE_SPINLOCK(rom_lock);
> >  static void *cru_rom_addr;
> > -static struct cmn_registers cmn_regs;
> >  
> >  extern asmlinkage void asminline_call(struct cmn_registers *pi86Regs,
> >  						unsigned long *pRomEntry);
> > @@ -225,6 +223,7 @@ static int cru_detect(unsigned long map_entry,
> >  	unsigned long physical_bios_base = 0;
> >  	unsigned long physical_bios_offset = 0;
> >  	int retval = -ENODEV;
> > +	struct cmn_registers cmn_regs = { };
> >  
> >  	bios32_map = ioremap(map_entry, (2 * PAGE_SIZE));
> >  
> > @@ -486,32 +485,18 @@ static int hpwdt_my_nmi(void)
> >   */
> >  static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
> >  {
> > -	unsigned long rom_pl;
> > -	static int die_nmi_called;
> > -
> >  	if (!hpwdt_nmi_decoding)
> >  		return NMI_DONE;
> >  
> >  	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
> >  		return NMI_DONE;
> >  
> > -	spin_lock_irqsave(&rom_lock, rom_pl);
> > -	if (!die_nmi_called && !is_icru && !is_uefi)
> > -		asminline_call(&cmn_regs, cru_rom_addr);
> > -	die_nmi_called = 1;
> > -	spin_unlock_irqrestore(&rom_lock, rom_pl);
> > -
> >  	if (allow_kdump)
> >  		hpwdt_stop();
> >  
> > -	if (!is_icru && !is_uefi) {
> > -		if (cmn_regs.u1.ral == 0) {
> > -			nmi_panic(regs, "An NMI occurred, but unable to determine source.\n");
> > -			return NMI_HANDLED;
> > -		}
> > -	}
> > -	nmi_panic(regs, "An NMI occurred. Depending on your system the reason "
> > -		"for the NMI is logged in any one of the following "
> > +	nmi_panic(regs,
> > +		"An NMI occurred. Depending on your system the reason "
> > +		"for the NMI might be logged in any one of the following "
> >  		"resources:\n"
> >  		"1. Integrated Management Log (IML)\n"
> >  		"2. OA Syslog\n"
> > @@ -744,13 +729,6 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
> >  				HPWDT_ARCH);
> >  			return retval;
> >  		}
> > -
> > -		/*
> > -		* We know this is the only CRU call we need to make so lets keep as
> > -		* few instructions as possible once the NMI comes in.
> > -		*/
> > -		cmn_regs.u1.rah = 0x0D;
> > -		cmn_regs.u1.ral = 0x02;
> >  	}
> >  
> >  	/*
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
-----------------------------------------------------------------------------
