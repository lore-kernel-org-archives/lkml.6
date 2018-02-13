Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934549AbeBMP7d (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:59:33 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:50898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933980AbeBMP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:59:32 -0500
Date: Tue, 13 Feb 2018 16:59:23 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Dave Hansen <dave.hansen@intel.com>
cc: bp@alien8.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        mroos@linux.ee, hpa@zytor.com, thomas.lendacky@amd.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/pti: Make sure the user/kernel PTEs match
In-Reply-To: <c1ab0e86-e7ed-6950-2b84-e6ebaa6d6db8@intel.com>
Message-ID: <alpine.DEB.2.21.1802131657260.1130@nanos.tec.linutronix.de>
References: <alpine.DEB.2.20.1801031407180.1957@nanos> <tip-52994c256df36fda9a715697431cba9daecb6b11@git.kernel.org> <c1ab0e86-e7ed-6950-2b84-e6ebaa6d6db8@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2018, Dave Hansen wrote:
> On 01/03/2018 08:22 AM, tip-bot for Thomas Gleixner wrote:
> > --- a/arch/x86/mm/pti.c
> > +++ b/arch/x86/mm/pti.c
> > @@ -367,7 +367,8 @@ static void __init pti_setup_espfix64(void)
> >  static void __init pti_clone_entry_text(void)
> >  {
> >  	pti_clone_pmds((unsigned long) __entry_text_start,
> > -			(unsigned long) __irqentry_text_end, _PAGE_RW);
> > +			(unsigned long) __irqentry_text_end,
> > +		       _PAGE_RW | _PAGE_GLOBAL);
> >  }
> 
> We appear to have lost all of our global bits between this and the
> cpu_entry_area itself.  To make K8 happy, shouldn't we just *set*
> _PAGE_GLOBAL universally instead of clearing it universally?
> 
> Also, don't we want _PAGE_GLOBAL in the cpu_entry_area.c pte setting?  I
> think I had this for all the shared user/kernel areas near the end of
> the KAISER era, but we appear to have totally nuked it for PTI.

Yes, we did due to the usage of supported_pte_flags vs. the hard coded
compile time thing. It was on my todo list to flag the shared areas global,
but I somehow nuked that item in a vein attempt to shrink that list :)
We surely should revisit that.

Thanks,

	tglx
