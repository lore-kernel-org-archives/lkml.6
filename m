Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933627AbeBMHoA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:44:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41326 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933463AbeBMHn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:43:59 -0500
Date: Tue, 13 Feb 2018 15:43:55 +0800
From: Baoquan He <bhe@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        x86@kernel.org, douly.fnst@cn.fujitsu.com, joro@8bytes.org,
        uobergfe@redhat.com, prarit@redhat.com
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180213074355.GD13253@localhost.localdomain>
References: <20180209121008.28980-1-bhe@redhat.com>
 <20180209121008.28980-3-bhe@redhat.com>
 <87r2pq9a60.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2pq9a60.fsf@xmission.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 02/11/18 at 09:08pm, Eric W. Biederman wrote:
> Baoquan He <bhe@redhat.com> writes:
> 
> > This is a regression fix.
> >
> > Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
> > I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
> > calling after disable_IO_APIC(). This introdued a regression. The
> > root cause is that disable_IO_APIC() not only clears IO_APIC, also
> > restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
> > after disable_IO_APIC() will disable LAPIC and ruin the possible
> > virtual wire mode setting which the code has been trying to do all
> > along.
> > To fix this, just break down disable_IO_APIC(), then call
> > clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
> > and call restore_boot_irq_mode() to restore boot irq mode before
> > reboot or kexec/kdump jump.
> 
> Two things here.
> a) This is missing a fixes tag and a CC stable.
> b) What makes your change to the KEXEC_JUMP code path safe?
>    Have the lapic and ioapic already been shut down?
> 
> The KEXEC_JUMP changes to machine_kexec_32.c and machine_kexec_64.c
> either need to be documented in the change long why they are safe
> so that this change becomes obviously safe and correct.

Re-read the code, I have to admit I didn't check the KEXEC_JUMP code
path carefully. 

kernel_kexec() {
	if (kexec_image->preserve_context) {
		...
		freeze_processes();
		...
		disable_nonboot_cpus();
		...
		
	else {
		...
		machine_shutdown();
		...
	}
	machine_kexec(kexec_image);
	...
}

  --machine_shutdown()
    --native_machine_shutdown()
      --disable_IO_APIC()
      --lapic_shutdown()

machine_kexec() {
	...
	if (image->preserve_context) {
		disable_IO_APIC();
	}
	...
}

KEXEC_JUMP code path is different than kexec/kdump, it doesn't call
lapic_shutdown() before jump. So commit 522e66464467
("x86/apic: Disable I/O APIC before shutdown of the local APIC") didn't
impact it. And here I break down disable_IO_APIC() and change to only
call restore_boot_irq_mode() to make a possible danger. I am not an
expert on KEXEC_JUMP, and don't know how to test it, so will keep the
code implementation consistent as before. For now, I plan to change it
as below if you don't object. As you pointed out, I will describe this
in patch log. 

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 1f790cf9d38f..cb0c2d0a4c99 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
                 * one form or other. kexec jump path also need
                 * one.
                 */
-               disable_IO_APIC();
+		clear_IO_APIC();
+               restore_boot_irq_mode();
 #endif
        }




> 
> Otherwise we risk and trivial and obvious looking change causing another
> regression like changing the order of lapic_shutdown and disable_IOAPIC
> did.
> 
> Eric
> 
> 
> >
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/include/asm/io_apic.h     | 1 +
> >  arch/x86/kernel/apic/io_apic.c     | 2 +-
> >  arch/x86/kernel/crash.c            | 3 ++-
> >  arch/x86/kernel/machine_kexec_32.c | 2 +-
> >  arch/x86/kernel/machine_kexec_64.c | 2 +-
> >  arch/x86/kernel/reboot.c           | 3 ++-
> >  6 files changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
> > index 558d1a6a13ad..0fa95bfacb39 100644
> > --- a/arch/x86/include/asm/io_apic.h
> > +++ b/arch/x86/include/asm/io_apic.h
> > @@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
> >  extern void setup_IO_APIC(void);
> >  extern void enable_IO_APIC(void);
> >  extern void disable_IO_APIC(void);
> > +extern void clear_IO_APIC(void);
> >  extern void restore_boot_irq_mode(void);
> >  extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
> >  extern void print_IO_APICs(void);
> > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> > index 7b73b6b9b4b6..2d7cd2db77f5 100644
> > --- a/arch/x86/kernel/apic/io_apic.c
> > +++ b/arch/x86/kernel/apic/io_apic.c
> > @@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
> >  		       mpc_ioapic_id(apic), pin);
> >  }
> >  
> > -static void clear_IO_APIC (void)
> > +void clear_IO_APIC (void)
> >  {
> >  	int apic, pin;
> >  
> > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > index 10e74d4778a1..1f6680427ff0 100644
> > --- a/arch/x86/kernel/crash.c
> > +++ b/arch/x86/kernel/crash.c
> > @@ -199,9 +199,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> >  #ifdef CONFIG_X86_IO_APIC
> >  	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
> >  	ioapic_zap_locks();
> > -	disable_IO_APIC();
> > +	clear_IO_APIC();
> >  #endif
> >  	lapic_shutdown();
> > +	restore_boot_irq_mode();
> >  #ifdef CONFIG_HPET_TIMER
> >  	hpet_disable();
> >  #endif
> > diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> > index edfede768688..f78bb4432bfb 100644
> > --- a/arch/x86/kernel/machine_kexec_32.c
> > +++ b/arch/x86/kernel/machine_kexec_32.c
> > @@ -199,7 +199,7 @@ void machine_kexec(struct kimage *image)
> >  		 * one form or other. kexec jump path also need
> >  		 * one.
> >  		 */
> > -		disable_IO_APIC();
> > +		restore_boot_irq_mode();
> >  #endif
> >  	}
> >  
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 1f790cf9d38f..cb0c2d0a4c99 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
> >  		 * one form or other. kexec jump path also need
> >  		 * one.
> >  		 */
> > -		disable_IO_APIC();
> > +		restore_boot_irq_mode();
> >  #endif
> >  	}
> >  
> > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > index 2126b9d27c34..725624b6c0c0 100644
> > --- a/arch/x86/kernel/reboot.c
> > +++ b/arch/x86/kernel/reboot.c
> > @@ -666,7 +666,7 @@ void native_machine_shutdown(void)
> >  	 * Even without the erratum, it still makes sense to quiet IO APIC
> >  	 * before disabling Local APIC.
> >  	 */
> > -	disable_IO_APIC();
> > +	clear_IO_APIC();
> >  #endif
> >  
> >  #ifdef CONFIG_SMP
> > @@ -680,6 +680,7 @@ void native_machine_shutdown(void)
> >  #endif
> >  
> >  	lapic_shutdown();
> > +	restore_boot_irq_mode();
> >  
> >  #ifdef CONFIG_HPET_TIMER
> >  	hpet_disable();
