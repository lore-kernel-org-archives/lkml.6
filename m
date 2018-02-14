Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966621AbeBNCog (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 21:44:36 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966382AbeBNCof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 21:44:35 -0500
Date: Wed, 14 Feb 2018 10:44:31 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        x86@kernel.org, douly.fnst@cn.fujitsu.com, joro@8bytes.org,
        uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180214024431.GB28659@localhost.localdomain>
References: <20180209121008.28980-1-bhe@redhat.com>
 <20180209121008.28980-3-bhe@redhat.com>
 <87r2pq9a60.fsf@xmission.com>
 <20180213074355.GD13253@localhost.localdomain>
 <87h8qk3htc.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8qk3htc.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/18 at 11:44am, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > Hi Eric,
> >
> > On 02/11/18 at 09:08pm, Eric W. Biederman wrote:
> >> Baoquan He <bhe@redhat.com> writes:
> >> 
> >> > This is a regression fix.
> >> >
> >> > Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
> >> > I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
> >> > calling after disable_IO_APIC(). This introdued a regression. The
> >> > root cause is that disable_IO_APIC() not only clears IO_APIC, also
> >> > restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
> >> > after disable_IO_APIC() will disable LAPIC and ruin the possible
> >> > virtual wire mode setting which the code has been trying to do all
> >> > along.
> >> > To fix this, just break down disable_IO_APIC(), then call
> >> > clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
> >> > and call restore_boot_irq_mode() to restore boot irq mode before
> >> > reboot or kexec/kdump jump.
> >> 
> >> Two things here.
> >> a) This is missing a fixes tag and a CC stable.
> >> b) What makes your change to the KEXEC_JUMP code path safe?
> >>    Have the lapic and ioapic already been shut down?
> >> 
> >> The KEXEC_JUMP changes to machine_kexec_32.c and machine_kexec_64.c
> >> either need to be documented in the change long why they are safe
> >> so that this change becomes obviously safe and correct.
> >
> > Re-read the code, I have to admit I didn't check the KEXEC_JUMP code
> > path carefully. 
> >
> > kernel_kexec() {
> > 	if (kexec_image->preserve_context) {
> > 		...
> > 		freeze_processes();
> > 		...
> > 		disable_nonboot_cpus();
> > 		...
> > 		
> > 	else {
> > 		...
> > 		machine_shutdown();
> > 		...
> > 	}
> > 	machine_kexec(kexec_image);
> > 	...
> > }
> >
> >   --machine_shutdown()
> >     --native_machine_shutdown()
> >       --disable_IO_APIC()
> >       --lapic_shutdown()
> >
> > machine_kexec() {
> > 	...
> > 	if (image->preserve_context) {
> > 		disable_IO_APIC();
> > 	}
> > 	...
> > }
> >
> > KEXEC_JUMP code path is different than kexec/kdump, it doesn't call
> > lapic_shutdown() before jump. So commit 522e66464467
> > ("x86/apic: Disable I/O APIC before shutdown of the local APIC") didn't
> > impact it. And here I break down disable_IO_APIC() and change to only
> > call restore_boot_irq_mode() to make a possible danger. I am not an
> > expert on KEXEC_JUMP, and don't know how to test it, so will keep the
> > code implementation consistent as before. For now, I plan to change it
> > as below if you don't object. As you pointed out, I will describe this
> > in patch log. 
> >
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 1f790cf9d38f..cb0c2d0a4c99 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
> >                  * one form or other. kexec jump path also need
> >                  * one.
> >                  */
> > -               disable_IO_APIC();
> > +		clear_IO_APIC();
> > +               restore_boot_irq_mode();
> >  #endif
> >         }
> >
> >
> 
> Let me give a very concrete suggestion:
> Patch 1) Replace "disable_IO_APIC();" with "clear_IO_APIC(); restore_boot_irq_mode();"
> Patch 2) Move restore_boot_irq_mode(); to fix the regression.
> 
> I think that will be a slightly shorter patch sequence than what you are
> dealing with and one that is slightly easier to read.

Sure, will do.

Thanks for reviewing and suggestion.

> 
> We need to sort out KEXEC_JUMP but that is something for another time.

Agree. We ever contacted the author, intel dev, seems they don't
maintain it any more. And very few people are interested and report
the relevant issues. While recently someone is testing KEXEC_JUMP
functionality and updating related doc, will continue tracking it.

Thanks
Baoquan
