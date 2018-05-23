Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754300AbeEWIFw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:05:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44744 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbeEWIFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:05:46 -0400
X-Google-Smtp-Source: AB8JxZr8R0pMOVU2tUq78a/9Lfy9F9CoqSzeVGWGkBI2JayzOcTddQX7EJMSu6bwJuBr2v8DzjxMmQ==
Date: Wed, 23 May 2018 18:05:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8] powerpc/mm: Only read faulting instruction when
 necessary in do_page_fault()
Message-ID: <20180523180537.37d54cb7@roar.ozlabs.ibm.com>
In-Reply-To: <cda4bbef-f4a9-142d-3fa4-86c2693ed35f@c-s.fr>
References: <61ef5847cedae91eb5415f40fb4276585950cb43.1527058032.git.christophe.leroy@c-s.fr>
        <20180523171710.00792240@roar.ozlabs.ibm.com>
        <cda4bbef-f4a9-142d-3fa4-86c2693ed35f@c-s.fr>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4N85xlh010675

On Wed, 23 May 2018 09:31:33 +0200
Christophe LEROY <christophe.leroy@c-s.fr> wrote:

> Le 23/05/2018 à 09:17, Nicholas Piggin a écrit :
> > On Wed, 23 May 2018 09:01:19 +0200 (CEST)
> > Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> >   

> >> @@ -264,8 +266,30 @@ static bool bad_stack_expansion(struct pt_regs *regs, unsigned long address,
> >>   		 * between the last mapped region and the stack will
> >>   		 * expand the stack rather than segfaulting.
> >>   		 */
> >> -		if (address + 2048 < uregs->gpr[1] && !store_update_sp)
> >> -			return true;
> >> +		if (address + 2048 >= uregs->gpr[1])
> >> +			return false;
> >> +		if (is_retry)
> >> +			return false;
> >> +
> >> +		if ((flags & FAULT_FLAG_WRITE) && (flags & FAULT_FLAG_USER) &&
> >> +		    access_ok(VERIFY_READ, nip, sizeof(inst))) {
> >> +			int res;
> >> +
> >> +			pagefault_disable();
> >> +			res = __get_user_inatomic(inst, nip);
> >> +			pagefault_enable();
> >> +			if (res) {
> >> +				up_read(&mm->mmap_sem);
> >> +				res = __get_user(inst, nip);
> >> +				if (!res && store_updates_sp(inst))
> >> +					return -1;
> >> +				return true;
> >> +			}
> >> +			if (store_updates_sp(inst))
> >> +				return false;
> >> +		}
> >> +		up_read(&mm->mmap_sem);  
> > 
> > Starting to look pretty good... I think probably I prefer the mmap_sem
> > drop going into the caller so we don't don't drop in the child function.  
> 
> Yes I can do that. I though it was ok as the drop is already done in 
> children functions like bad_area(), bad_access(), ...

That's true, all exit functions though. I think it may end up being a
bit nicer with the up_read in the caller, but see what you think.

> > I thought the retry logic was a little bit complex too, what do you
> > think of using fault_in_pages_readable and just doing a full retry to
> > avoid some of this complexity?  
> 
> Yes lets try that way, allthough fault_in_pages_readable() is nothing 
> else than a get_user().
> Should we take any precaution to avoid retrying forever or is it just 
> not worth it ?

generic_perform_write() the core of the data copying for write(2)
syscall does this retry, so I think it's okay... Although I think I
wrote that so maybe that's a circular justification.

I think if we end up thrashing on this type of loop for a long time,
the system will already be basically dead.


> >>   	/* The stack is being expanded, check if it's valid */
> >> -	if (unlikely(bad_stack_expansion(regs, address, vma, store_update_sp)))
> >> -		return bad_area(regs, address);
> >> +	is_bad = bad_stack_expansion(regs, address, vma, flags, is_retry);
> >> +	if (unlikely(is_bad == -1)) {
> >> +		is_retry = true;
> >> +		goto retry;
> >> +	}
> >> +	if (unlikely(is_bad))
> >> +		return bad_area_nosemaphore(regs, address);  
> > 
> > Suggest making the return so that you can do a single unlikely test for
> > the retry or bad case, and then distinguish the retry in there. Code
> > generation should be better.  
> 
> Ok. I'll try and come with v9 during this morning.

Thanks,
Nick
