Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751784AbeBTKg6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:36:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:32895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbeBTKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:36:57 -0500
Date: Tue, 20 Feb 2018 11:37:03 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: karahmed@amazon.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        jmattson@google.com, rkrcmar@redhat.com, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com, mingo@kernel.org
Subject: Re: [PATCH v3 2/4] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
In-Reply-To: <1519116825.7876.112.camel@infradead.org>
Message-ID: <alpine.DEB.2.21.1802201115190.24268@nanos.tec.linutronix.de>
References: <1519037457-7643-1-git-send-email-dwmw@amazon.co.uk>  <1519037457-7643-3-git-send-email-dwmw@amazon.co.uk>  <alpine.DEB.2.21.1802200854010.24268@nanos.tec.linutronix.de> <1519116825.7876.112.camel@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2266313-1519123025=:24268"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2266313-1519123025=:24268
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 20 Feb 2018, David Woodhouse wrote:
> On Tue, 2018-02-20 at 09:31 +0100, Thomas Gleixner wrote:
> > > @@ -3387,13 +3387,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >  
> > >  		vmx->spec_ctrl = data;
> > >  
> > > -		if (!data)
> > > +		if (!data && !spectre_v2_ibrs_all())
> > >  			break;
> > >  
> > >  		/*
> > >  		 * For non-nested:
> > >  		 * When it's written (to non-zero) for the first time, pass
> > > -		 * it through.
> > > +		 * it through unless we have IBRS_ALL and it should just be
> > > +		 * set for ever.
> >
> > A non zero write is going to disable the intercept only when IBRS_ALL
> > is on. The comment says is should be set forever, i.e. not changeable by
> > the guest. So the condition should be:
> > 
> > 		if (!data || spectre_v2_ibrs_all())
> > 			break;
> > Hmm?
> 
> Yes, good catch. Thanks.
> 
> However, Paolo is very insistent that taking the trap every time is
> actually a lot *slower* than really frobbing IBRS on certain
> microarchitectures, so my hand-waving "pfft, what did they expect?" is
> not acceptable.
> 
> Which I think puts us back to the "throwing the toys out of the pram"
> solution; demanding that Intel give us a new feature bit for "IBRS_ALL,
> and the bit in the MSR is a no-op". Which was going to be true for
> *most* new CPUs anyway. (Note: a blacklist for those few CPUs on which
> it *isn't* true might also suffice instead of a new feature bit.)
>
> Unless someone really wants to implement the atomic MSR save and
> restore on vmexit, and make it work with nesting, and make the whole
> thing sufficiently simple that we don't throw our toys out of the pram
> anyway when we see it?

That whole stuff was duct taped into microcode in a rush and the result is
that we have only the choice between fire and frying pan. Whatever we
decide to implement is not going to be a half baken hack.

I fully agree that Intel needs to get their act together and implement
IBRS_ALL sanely.

The right thing to do is to allow the host to lock down the MSR once it
enabled IBRS_ALL so that any write to it will just turn into NOOPs. That
removes all worries about guests and in future generations of CPUs this bit
might just be hardwired to one and the MSR just a dummy for compability
reasons.

Thanks,

	tglx

--8323329-2266313-1519123025=:24268--
