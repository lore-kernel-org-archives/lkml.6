Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeBMDYm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 22:24:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933293AbeBMDYl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 22:24:41 -0500
Date: Tue, 13 Feb 2018 11:24:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de,
        x86@kernel.org, joro@8bytes.org, uobergfe@redhat.com,
        prarit@redhat.com
Subject: Re: [PATCH v3 2/5] x86/apic: Fix restoring boot irq mode in reboot
 and kexec/kdump
Message-ID: <20180213032436.GC13253@localhost.localdomain>
References: <20180209121008.28980-1-bhe@redhat.com>
 <20180209121008.28980-3-bhe@redhat.com>
 <87r2pq9a60.fsf@xmission.com>
 <bb1a2eb2-335a-b789-4274-6b62dd5ef2ef@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb1a2eb2-335a-b789-4274-6b62dd5ef2ef@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/13/18 at 10:43am, Dou Liyang wrote:
> Hi Baoquan,
> 
> At 02/12/2018 11:08 AM, Eric W. Biederman wrote:
> > Baoquan He <bhe@redhat.com> writes:
> > 
> > > This is a regression fix.
> > > 
> > > Before, to fix erratum AVR31, commit 522e66464467 ("x86/apic: Disable
> > > I/O APIC before shutdown of the local APIC") moved lapic_shutdown()
> > > calling after disable_IO_APIC(). This introdued a regression. The
> > > root cause is that disable_IO_APIC() not only clears IO_APIC, also
> > > restore boot irq mode by setting LAPIC/APIC/IMCR, lapic_shutdown()
> > > after disable_IO_APIC() will disable LAPIC and ruin the possible
> > > virtual wire mode setting which the code has been trying to do all
> > > along.
> > > 
> > > The consequence is, in KVM guest kernel always prints warning as below
> > > during kexec/kdump kernel boots up. That happened in setup_local_APIC()
> > > since 'do { xxx } while (queued && max_loops > 0)' loop does not function
> 
> I am not sure another thing here
> 
> AFAIK, according to the order of SMP machine shutdown, other CPUs will
> be stopped firstly, then the last CPU disable its local apic.
> 
>  --machine_shutdown
>    |----......
>    |----stop_other_cpus()
>    |----local_shutdown()
> 
> So, the pending interrupts exist only in BSP and only be ACKed by
> BSP. is it right?(I validated this by print the value of APIC_IRR/ISR of
> all CPUs, found only BSP had the non-zero value).
> 
> If it is right, We will do not need check the pending interrupt for each
> cpus.
> 
> BTW, the pending interrupt check code is mixed with the local
> APIC setup code, that looks messy. How about extracting the code which
> related to the crash interrupt check, put it into a new function and
> only invoked it when the CPU is BSP?

Yes, looks a good code cleaning up. Virtual wire irq mode only go
through the boot cpu's lapic.

In fact, or put in apic_bsp_setup() since it's only related to boot
cpu to make it look cleaner if can do.

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 3fc259b4dd2d..cec2d0692ace 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2380,6 +2380,7 @@ void __init apic_bsp_setup(bool upmode)
        connect_bsp_APIC();
        if (upmode)
                apic_bsp_up_setup();
+       clear_crash_pending_intr();
        setup_local_APIC();
 
        enable_IO_APIC();

> 
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 3fc259b4dd2d..0350528b320d 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -1408,6 +1408,57 @@ static void lapic_setup_esr(void)
>                         oldvalue, value);
>  }
> 
> +
> +static void clear_crash_pending_intr(void)
> +{
> +       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> +       unsigned long long tsc = 0, ntsc;
> +       unsigned int value, queued;
> +       int i, j, acked = 0;
Better do a check here.

	  if (disable_apic)
		return;
> +
> +       if (boot_cpu_has(X86_FEATURE_TSC))
> +               tsc = rdtsc();
> +       /*
> +        * After a crash, we no longer service the interrupts and a pending
> +        * interrupt from previous kernel might still have ISR bit set.
> +        *
> +        * Most probably by now CPU has serviced that pending interrupt and
> +        * it might not have done the ack_APIC_irq() because it thought,
> +        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> +        * does not clear the ISR bit and cpu thinks it has already serivced
> +        * the interrupt. Hence a vector might get locked. It was noticed
> +        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> +        */
> +       do {
> +               queued = 0;
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> +                       queued |= apic_read(APIC_IRR + i*0x10);
> +
> +               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> +                       value = apic_read(APIC_ISR + i*0x10);
> +                       for (j = 31; j >= 0; j--) {
> +                               if (value & (1<<j)) {
> +                                       ack_APIC_irq();
> +                                       acked++;
> +                               }
> +                       }
> +               }
> +               if (acked > 256) {
> +                       printk(KERN_ERR "LAPIC pending interrupts after %d
> EOI\n",
> +                              acked);
> +                       break;
> +               }
> +               if (queued) {
> +                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> +                               ntsc = rdtsc();
> +                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> +                       } else
> +                               max_loops--;
> +               }
> +       } while (queued && max_loops > 0);
> +       WARN_ON(max_loops <= 0);
> +}
> +
>  /**
>   * setup_local_APIC - setup the local APIC
>   *
> @@ -1417,13 +1468,7 @@ static void lapic_setup_esr(void)
>  void setup_local_APIC(void)
>  {
>         int cpu = smp_processor_id();
> -       unsigned int value, queued;
> -       int i, j, acked = 0;
> -       unsigned long long tsc = 0, ntsc;
> -       long long max_loops = cpu_khz ? cpu_khz : 1000000;
> -
> -       if (boot_cpu_has(X86_FEATURE_TSC))
> -               tsc = rdtsc();
> -               tsc = rdtsc();
> +       unsigned int value;
> 
>         if (disable_apic) {
>                 disable_ioapic_support();
> @@ -1475,45 +1520,8 @@ void setup_local_APIC(void)
>         value &= ~APIC_TPRI_MASK;
>         apic_write(APIC_TASKPRI, value);
> 
> -       /*
> -        * After a crash, we no longer service the interrupts and a pending
> -        * interrupt from previous kernel might still have ISR bit set.
> -        *
> -        * Most probably by now CPU has serviced that pending interrupt and
> -        * it might not have done the ack_APIC_irq() because it thought,
> -        * interrupt came from i8259 as ExtInt. LAPIC did not get EOI so it
> -        * does not clear the ISR bit and cpu thinks it has already serivced
> -        * the interrupt. Hence a vector might get locked. It was noticed
> -        * for timer irq (vector 0x31). Issue an extra EOI to clear ISR.
> -        */
> -       do {
> -               queued = 0;
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--)
> -                       queued |= apic_read(APIC_IRR + i*0x10);
> -
> -               for (i = APIC_ISR_NR - 1; i >= 0; i--) {
> -                       value = apic_read(APIC_ISR + i*0x10);
> -                       for (j = 31; j >= 0; j--) {
> -                               if (value & (1<<j)) {
> -                                       ack_APIC_irq();
> -                                       acked++;
> -                               }
> -                       }
> -               }
> -               if (acked > 256) {
> -                       printk(KERN_ERR "LAPIC pending interrupts after %d
> EOI\n",
> -                              acked);
> -                       break;
> -               }
> -               if (queued) {
> -                       if (boot_cpu_has(X86_FEATURE_TSC) && cpu_khz) {
> -                               ntsc = rdtsc();
> -                               max_loops = (cpu_khz << 10) - (ntsc - tsc);
> -                       } else
> -                               max_loops--;
> -               }
> -       } while (queued && max_loops > 0);
> -       WARN_ON(max_loops <= 0);
> +       if (!cpu)
> +               clear_crash_pending_intr();
> 
>         /*
>          * Now that we are all set up, enable the APIC
> 
> 
> Thanks,
> 	dou.
> 
> > > well any more if pending irq exists in APIC IRR after LAPIC is disabled.
> > > And people even saw casual kdump kernel hang once in ~30 attempts during
> > > stress testing of kdump on KVM machine.
> > > 
> > > [    0.001000] WARNING: CPU: 0 PID: 0 at arch/x86/kernel/apic/apic.c:1467 setup_local_APIC+0x228/0x330
> > > [    0.001000] Modules linked in:
> > > [    0.001000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc5+ #3
> > > [    0.001000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1.fc26 04/01/2014
> > > [    0.001000] RIP: 0010:setup_local_APIC+0x228/0x330
> > > [    0.001000] RSP: 0000:ffffffffb6e03eb8 EFLAGS: 00010286
> > > [    0.001000] RAX: 0000009edb4c4d84 RBX: 0000000000000000 RCX: 00000000b099d800
> > > [    0.001000] RDX: 0000009e00000000 RSI: 0000000000000000 RDI: 0000000000000810
> > > [    0.001000] RBP: 0000000000000000 R08: ffffffffffffffff R09: 0000000000000001
> > > [    0.001000] R10: ffff98ce6a801c00 R11: 0761076d072f0776 R12: 0000000000000001
> > > [    0.001000] R13: 00000000000000f0 R14: 0000000000004000 R15: ffffffffffffc6ff
> > > [    0.001000] FS:  0000000000000000(0000) GS:ffff98ce6bc00000(0000) knlGS:0000000000000000
> > > [    0.001000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [    0.001000] CR2: 00000000ffffffff CR3: 0000000022209000 CR4: 00000000000406b0
> > > [    0.001000] Call Trace:
> > > [    0.001000]  apic_bsp_setup+0x56/0x74
> > > [    0.001000]  x86_late_time_init+0x11/0x16
> > > [    0.001000]  start_kernel+0x3c9/0x486
> > > [    0.001000]  secondary_startup_64+0xa5/0xb0
> > > [    0.001000] Code: 00 85 c9 74 2d 0f 31 c1 e1 0a 48 c1 e2 20 41 89 cf 4c 03 7c 24 08 48 09 d0 49 29 c7 4c 89 3c 24 48 83 3c 24 00 0f 8f 8f fe ff
> > > ff <0f> ff e9 10 ff ff ff 48 83 2c 24 01 eb e7 48 83 c4 18 5b 5d 41
> > > [    0.001000] ---[ end trace b88e71b9a6ebebdd ]---
> > > [    0.001000] masked ExtINT on CPU#0
> > > 
> > > To fix this, just break down disable_IO_APIC(), then call
> > > clear_IO_APIC() to stop IO_APIC where disable_IO_APIC() was called,
> > > and call restore_boot_irq_mode() to restore boot irq mode before
> > > reboot or kexec/kdump jump.
> > 
> > Two things here.
> > a) This is missing a fixes tag and a CC stable.
> > b) What makes your change to the KEXEC_JUMP code path safe?
> >     Have the lapic and ioapic already been shut down?
> > 
> > The KEXEC_JUMP changes to machine_kexec_32.c and machine_kexec_64.c
> > either need to be documented in the change long why they are safe
> > so that this change becomes obviously safe and correct.
> > 
> > Otherwise we risk and trivial and obvious looking change causing another
> > regression like changing the order of lapic_shutdown and disable_IOAPIC
> > did.
> > 
> > Eric
> > 
> > 
> > > 
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > ---
> > >   arch/x86/include/asm/io_apic.h     | 1 +
> > >   arch/x86/kernel/apic/io_apic.c     | 2 +-
> > >   arch/x86/kernel/crash.c            | 3 ++-
> > >   arch/x86/kernel/machine_kexec_32.c | 2 +-
> > >   arch/x86/kernel/machine_kexec_64.c | 2 +-
> > >   arch/x86/kernel/reboot.c           | 3 ++-
> > >   6 files changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/io_apic.h b/arch/x86/include/asm/io_apic.h
> > > index 558d1a6a13ad..0fa95bfacb39 100644
> > > --- a/arch/x86/include/asm/io_apic.h
> > > +++ b/arch/x86/include/asm/io_apic.h
> > > @@ -193,6 +193,7 @@ static inline unsigned int io_apic_read(unsigned int apic, unsigned int reg)
> > >   extern void setup_IO_APIC(void);
> > >   extern void enable_IO_APIC(void);
> > >   extern void disable_IO_APIC(void);
> > > +extern void clear_IO_APIC(void);
> > >   extern void restore_boot_irq_mode(void);
> > >   extern int IO_APIC_get_PCI_irq_vector(int bus, int devfn, int pin);
> > >   extern void print_IO_APICs(void);
> > > diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
> > > index 7b73b6b9b4b6..2d7cd2db77f5 100644
> > > --- a/arch/x86/kernel/apic/io_apic.c
> > > +++ b/arch/x86/kernel/apic/io_apic.c
> > > @@ -587,7 +587,7 @@ static void clear_IO_APIC_pin(unsigned int apic, unsigned int pin)
> > >   		       mpc_ioapic_id(apic), pin);
> > >   }
> > > -static void clear_IO_APIC (void)
> > > +void clear_IO_APIC (void)
> > >   {
> > >   	int apic, pin;
> > > diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> > > index 10e74d4778a1..1f6680427ff0 100644
> > > --- a/arch/x86/kernel/crash.c
> > > +++ b/arch/x86/kernel/crash.c
> > > @@ -199,9 +199,10 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
> > >   #ifdef CONFIG_X86_IO_APIC
> > >   	/* Prevent crash_kexec() from deadlocking on ioapic_lock. */
> > >   	ioapic_zap_locks();
> > > -	disable_IO_APIC();
> > > +	clear_IO_APIC();
> > >   #endif
> > >   	lapic_shutdown();
> > > +	restore_boot_irq_mode();
> > >   #ifdef CONFIG_HPET_TIMER
> > >   	hpet_disable();
> > >   #endif
> > > diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> > > index edfede768688..f78bb4432bfb 100644
> > > --- a/arch/x86/kernel/machine_kexec_32.c
> > > +++ b/arch/x86/kernel/machine_kexec_32.c
> > > @@ -199,7 +199,7 @@ void machine_kexec(struct kimage *image)
> > >   		 * one form or other. kexec jump path also need
> > >   		 * one.
> > >   		 */
> > > -		disable_IO_APIC();
> > > +		restore_boot_irq_mode();
> > >   #endif
> > >   	}
> > > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > > index 1f790cf9d38f..cb0c2d0a4c99 100644
> > > --- a/arch/x86/kernel/machine_kexec_64.c
> > > +++ b/arch/x86/kernel/machine_kexec_64.c
> > > @@ -297,7 +297,7 @@ void machine_kexec(struct kimage *image)
> > >   		 * one form or other. kexec jump path also need
> > >   		 * one.
> > >   		 */
> > > -		disable_IO_APIC();
> > > +		restore_boot_irq_mode();
> > >   #endif
> > >   	}
> > > diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> > > index 2126b9d27c34..725624b6c0c0 100644
> > > --- a/arch/x86/kernel/reboot.c
> > > +++ b/arch/x86/kernel/reboot.c
> > > @@ -666,7 +666,7 @@ void native_machine_shutdown(void)
> > >   	 * Even without the erratum, it still makes sense to quiet IO APIC
> > >   	 * before disabling Local APIC.
> > >   	 */
> > > -	disable_IO_APIC();
> > > +	clear_IO_APIC();
> > >   #endif
> > >   #ifdef CONFIG_SMP
> > > @@ -680,6 +680,7 @@ void native_machine_shutdown(void)
> > >   #endif
> > >   	lapic_shutdown();
> > > +	restore_boot_irq_mode();
> > >   #ifdef CONFIG_HPET_TIMER
> > >   	hpet_disable();
> > 
> > 
> > 
> 
> 
