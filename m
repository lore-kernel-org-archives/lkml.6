Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48423C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE873208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 13:03:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE873208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbeGaOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:43:27 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53954 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732141AbeGaOn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:43:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF76580D;
        Tue, 31 Jul 2018 06:03:12 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 076333F5D0;
        Tue, 31 Jul 2018 06:03:09 -0700 (PDT)
Date:   Tue, 31 Jul 2018 14:03:07 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        patches@groups.riscv.org, robh+dt@kernel.org, albert@sifive.com,
        yamada.masahiro@socionext.com, mmarek@suse.com,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, oleg@redhat.com, mingo@redhat.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 04/12] RISC-V: Init and Halt Code
Message-ID: <20180731130307.3geak2mx37is7uec@lakrids.cambridge.arm.com>
References: <20171005110111.GB4929@leverpostej>
 <mhng-266f17e0-1151-4136-9627-9e0e8d242e4c@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-266f17e0-1151-4136-9627-9e0e8d242e4c@palmer-si-x1c4>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 04:42:49PM -0700, Palmer Dabbelt wrote:
> Sorry it took me an absurd amount of time to get back around to this...  I'm 
> adding our mailing list, as we didn't even have one a year ago.

No worries; we all get swamped with things.

> I've included a few patches in line here, but they're just drafts.  I'll test
> them and submit them properly.

> >> +static void ci_leaf_init(struct cacheinfo *this_leaf,
> >> +			 struct device_node *node,
> >> +			 enum cache_type type, unsigned int level)
> >> +{
> >> +	this_leaf->of_node = node;
> >> +	this_leaf->level = level;
> >> +	this_leaf->type = type;
> >> +	/* not a sector cache */
> >> +	this_leaf->physical_line_partition = 1;
> >> +	/* TODO: Add to DTS */
> >> +	this_leaf->attributes =
> >> +		CACHE_WRITE_BACK
> >> +		| CACHE_READ_ALLOCATE
> >> +		| CACHE_WRITE_ALLOCATE;
> >> +}
> >
> > In practice, it's very hard to remove implicit assumptions later down
> > the line, so I'd recommend you add this to your DT from the outset.
> 
> Are these actually used by anything?  I poked around the kernel and it appears 
> that pretty much all they do is get printed in drivers/base/cacheinfo.c.  It 
> looks like we're only filling out half the info in there anyway so it feels 
> like we'd be better off just deleting these and waiting until we have a proper 
> scheme before setting anything.

I think that would make sense. That way you should be able to assume
that the data is correct if present, and if anyone screams that they ned
it, you'll be able to find out why.

[...]

> >> +{
> >> +	const char *isa, *status;
> >> +	u32 hart;
> >> +
> >> +	if (!of_device_is_compatible(node, "riscv")) {
> >> +		pr_warn("Found incompatible CPU\n");
> >> +		return -(ENODEV);
> >> +	}
> >> +
> >> +	if (of_property_read_u32(node, "reg", &hart)) {
> >> +		pr_warn("Found CPU without hart ID\n");
> >> +		return -(ENODEV);
> >> +	}
> >> +	if (hart >= NR_CPUS) {
> >> +		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
> >> +		return -(ENODEV);
> >> +	}
> >
> > Here you assume that the hard ID is equalt to the Linux logical ID.
> >
> > I'd recommend that (as other architectures do), you decouple the two.
> >
> > That's going to be necessary for things like kdump to work, as the kdump
> > kernel will run on (Linux logical) CPU0, but may have been executed from
> > any secondary CPU.
> 
> This is a good point.  We currently have another headache with CPU numbering on
> some systems where the machine CPU ID of 0 actually isn't a Linux CPU (ie, it
> doesn't have virtual memory) and we're handling the remapping in the
> bootloader.  That's a bit convoluted, so it might be easier to handle the
> remapping in Linux.
> 
> >> +
> >> +	if (of_property_read_string(node, "status", &status)) {
> >> +		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
> >> +		return -(ENODEV);
> >> +	}
> >> +	if (strcmp(status, "okay")) {
> >> +		pr_info("CPU with hartid=%d has a non-okay status of \"%s\"\n", hart, status);
> >> +		return -(ENODEV);
> >> +	}
> >
> > Please use of_device_is_available().
> >
> >> +
> >> +	if (of_property_read_string(node, "riscv,isa", &isa)) {
> >> +		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
> >> +		return -(ENODEV);
> >> +	}
> >> +	if (isa[0] != 'r' || isa[1] != 'v') {
> >> +		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
> >> +		return -(ENODEV);
> >> +	}
> >
> > As mentioned on the binding patch, I'd recommend that you use a set of
> > discrete flags.
> 
> RISC-V defines what the ISA string means, and it's got all sorts of mechanism
> for extensibility already defined.  I'm trying to avoid inventing any other
> encodings of this as they're just going to be incompatible in some subtle way.

Ok.

> 
> > [...]
> >
> >> +static int c_show(struct seq_file *m, void *v)
> >> +{
> >> +	unsigned long hart_id = (unsigned long)v - 1;
> >> +	struct device_node *node = of_get_cpu_node(hart_id, NULL);
> >> +	const char *compat, *isa, *mmu;
> >> +
> >> +	seq_printf(m, "hart\t: %lu\n", hart_id);
> >> +	if (!of_property_read_string(node, "riscv,isa", &isa)
> >> +	    && isa[0] == 'r'
> >> +	    && isa[1] == 'v')
> >> +		seq_printf(m, "isa\t: %s\n", isa);
> >> +	if (!of_property_read_string(node, "mmu-type", &mmu)
> >> +	    && !strncmp(mmu, "riscv,", 6))
> >> +		seq_printf(m, "mmu\t: %s\n", mmu+6);
> >> +	if (!of_property_read_string(node, "compatible", &compat)
> >> +	    && strcmp(compat, "riscv"))
> >> +		seq_printf(m, "uarch\t: %s\n", compat);
> >> +	seq_puts(m, "\n");
> >
> > I'd *very strongly* recommend that you don't pass the DT values straight
> > through to userspace.
> >
> > Otherwise, things like riscv,isa = "rvtypo'd\nsomething" get exposed,
> > and inevitably, some subset of userspace ends up relying upon it, while
> > others break based upon it.
> >
> > Further, specifically for the ISA parts, this is a very bad idea. If
> > some ISA extensions require kernel support (e.g. to context switch
> > state, or disable some configurable traps), they cannot work without
> > kernel support. Generally, the wayt to handle this is for the kernel to
> > detect the features at boot time, and save these in hwcaps.
> >
> > Later, the hwcaps can be used to generate /proc/cpunifo output, and are
> > also exposed via auxv, which avoids applications and libraries having to
> > parse /proc/cpuinfo just to determine whether they have a particular
> > feature, which doesn't work in many situations (e.g. early boot where
> > /proc may not be mounted).
> >
> > Take a look at arm64's hwcaps for an example of how to use hwcaps.
> 
> Yes, that's a very good point.  We actually have an implementation of hwcaps
> (that's exposed via the aux vector) that's cropped up in the mean time, and
> while the right thing to do is probably to generate cpuinfo from that I do at
> least have a simple patch that allows us to avoid passing garbage to userspace:
> 
>     commit 6dbfebe5b2ddd873283abf625556b99f98cc85f2
>     gpg: Signature made Fri 27 Jul 2018 10:40:02 AM PDT
>     gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
>     gpg:                issuer "palmer@dabbelt.com"
>     gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
>     gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
>     Author: Palmer Dabbelt <palmer@sifive.com>
>     Date:   Fri Jul 27 09:57:29 2018 -0700
> 
>         RISC-V: Filter ISA and MMU values in cpuinfo
> 
>         We shouldn't be directly passing device tree values to userspace, both
>         because there could be mistakes in device trees and because the kernel
>         doesn't support arbitrary ISAs.
> 
>         Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> 
>     diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
>     index 19e98c1710dd..a18b4e3962a1 100644
>     --- a/arch/riscv/kernel/cpu.c
>     +++ b/arch/riscv/kernel/cpu.c
>     @@ -58,6 +58,57 @@ int riscv_of_processor_hartid(struct device_node *node)
> 
>      #ifdef CONFIG_PROC_FS
> 
>     +static void print_isa(struct seq_file *f, const char *orig_isa)
>     +{
>     +    static const char *ext = "mafdc";
>     +    const char *isa = orig_isa;
>     +    const char *e;
>     +
>     +    /* Linux doesn't support rv32e or rv128i, and we only support booting
>     +     * kernels on harts with the same ISA that the kernel is compiled for. */
>     +#if defined(CONFIG_32BIT)
>     +    if (strncmp(isa, "rv32i", 5) != 0)
>     +        return;
>     +#elif defined(CONFIG_64BIT)
>     +    if (strncmp(isa, "rv64i", 5) != 0)
>     +        return;
>     +#endif
>     +
>     +    /* Print the base ISA, as we already know it's legal. */
>     +    seq_printf(f, "isa\t: ");
>     +    seq_write(f, isa, 5);
>     +    isa += 5;
>     +
>     +    /* Check the rest of the ISA string for valid extensions, printing those we
>     +     * find.  RISC-V ISA strings define an order, so we only print the
>     +     * extension bits when they're in order. */
>     +    for (e = ext; *e != '\0'; ++e) {
>     +        if (isa[0] == e[0]) {
>     +            seq_write(f, isa, 1);
>     +            isa++;
>     +        }
>     +    }
>     +
>     +    /* If we were given an unsupported ISA in the device tree then print a bit
>     +     * of info describing what went wrong. */
>     +    if (isa[0] != '\0')
>     +        pr_info("unsupported ISA \"%s\" in device tree", orig_isa);

It's probably best to do this once at boot time, rather than each time
someone (e.g. libc) reads /proc/cpuinfo. That way you get a message in a
deterministic location, and don't end up with an accidental DoS.

[...]

> >> +ENTRY(_start)
> >> +	/* Mask all interrupts */
> >> +	csrw sie, zero
> >> +
> >> +	/* Load the global pointer */
> >> +.option push
> >> +.option norelax
> >> +	la gp, __global_pointer$
> >> +.option pop
> >> +
> >> +	/*
> >> +	 * Disable FPU to detect illegal usage of
> >> +	 * floating point in kernel space
> >> +	 */
> >> +	li t0, SR_FS
> >> +	csrc sstatus, t0
> >> +
> >> +	/* Pick one hart to run the main boot sequence */
> >> +	la a3, hart_lottery
> >> +	li a2, 1
> >> +	amoadd.w a3, a2, (a3)
> >> +	bnez a3, .Lsecondary_start
> >
> > I would *very strongly* recommend that you do not throw all CPUs into
> > the kernel at the start of time, and instead have a mechanism where you
> > can bring CPUs into the kernel individually.
> >
> > While it's simple, it comes with a number of long term problems (e.g.
> > for kexec/kdump), some of which are unsolvable (e.g. as you cannot know
> > how many CPUs are stuck in the kernel text, which haven't been brought
> > online).
> >
> > If you want a simple SMP bringup mechanism, ePAPR's spin-table (and
> > arm64's different-but-identically-named spin-table) are good starting
> > points. Just make sure you require each CPU is brought online
> > individually. We didn't do that for arm64 from day one, and it still
> > prevents us from making improvements that we'd like to, years later.
> >
> > Doing that will also simplify decoupling the HART IDs from linux logical
> > IDs, necessary for kdump/kexec, etc.
> 
> Defining a proper platform specification is something we've been punting on for
> too long.  It's nominally on my plate, but I'm a bit behind right now.  We've
> been able to get away without one because we don't have real bootloaders yet,
> but it's really time to get started working on this so we don't end up in a bad
> situation where we have production hardware out there that is capable of
> running Linux but is stuck with pre-specification firmware.

Indeed; best of luck! :)

[...]

> >> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
> >> +{
> >> +	tidle->thread_info.cpu = cpu;
> >> +
> >> +	/*
> >> +	 * On RISC-V systems, all harts boot on their own accord.  Our _start
> >> +	 * selects the first hart to boot the kernel and causes the remainder
> >> +	 * of the harts to spin in a loop waiting for their stack pointer to be
> >> +	 * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
> >> +	 * the spinning harts that they can continue the boot process.
> >> +	 */
> >> +	smp_mb();
> >> +	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
> >> +	__cpu_up_task_pointer[cpu] = tidle;
> >
> > Shouldn't these be WRITE_ONCE() (or some atomic) to avoid tearing?
> >
> > How are the secondaries reading these? Is there any requirement on the
> > order these become visible?
> 
> They just need to be WRITE_ONCE, the secondary harts spin until both of these
> are non-zero so it's not necessary to have any ordering here.  Thanks for
> pointing this out, though, as this would have been an afwul bug to track down :)

Ok. I assume the other end is doing something equivalent to READ_ONCE()
for each!

[...]

> >
> >> +/*
> >> + * C entry point for a secondary processor.
> >> + */
> >> +asmlinkage void __init smp_callin(void)
> >> +{
> >> +	struct mm_struct *mm = &init_mm;
> >> +
> >> +	/* All kernel threads share the same mm context.  */
> >> +	atomic_inc(&mm->mm_count);
> >
> > I beleive this should be:
> >
> > 	mmgrab(mm);
> >
> > See commit f1f1007644ffc805 ("mm: add new mmgrab() helper")
> 
> Thanks!
> 
>     commit 120b58060bbd67d893552d89b18ebbc7fea66ea9
>     gpg: Signature made Fri 27 Jul 2018 03:19:16 PM PDT
>     gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
>     gpg:                issuer "palmer@dabbelt.com"
>     gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
>     gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
>     Author: Palmer Dabbelt <palmer@sifive.com>
>     Date:   Fri Jul 27 15:16:35 2018 -0700
> 
>         RISC-V: Use mmgrab()
> 
>         f1f1007644ff ("mm: add new mmgrab() helper") added a helper that we
>         missed out on.
> 
>         Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> 
>     diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>     index 4f18ca5050bc..57552fa3892b 100644
>     --- a/arch/riscv/kernel/smpboot.c
>     +++ b/arch/riscv/kernel/smpboot.c
>     @@ -79,8 +79,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>      	 * the spinning harts that they can continue the boot process.
>      	 */
>      	smp_mb();
>     -	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
>     -	__cpu_up_task_pointer[cpu] = tidle;
>     +	WRITE_ONCE(__cpu_up_stack_pointer[cpu], task_stack_page(tidle) + THREAD_SIZE);
>     +	WRITE_ONCE(__cpu_up_task_pointer[cpu], tidle);
> 
>      	while (!cpu_online(cpu))
>      		cpu_relax();
>     @@ -100,7 +100,7 @@ asmlinkage void __init smp_callin(void)
>      	struct mm_struct *mm = &init_mm;
> 
>      	/* All kernel threads share the same mm context.  */
>     -	atomic_inc(&mm->mm_count);
>     +   mm_grab(mm);
>      	current->active_mm = mm;
> 
>      	trap_init();
> 
> >> +	current->active_mm = mm;
> >> +
> >> +	trap_init();
> >> +	init_clockevent();
> >> +	notify_cpu_starting(smp_processor_id());
> >> +	set_cpu_online(smp_processor_id(), 1);
> >> +	local_flush_tlb_all();
> >
> > Why do you need a TLB flush here?
> 
> On RISC-V systems there is a mask that specifies which CPUs to target with
> remote TLB flushes.  If the CPU is offline then it will not be included as part
> of the mask bits set for global TLB flushes, so they're essentially ignored.
> Thus we do a local flush here in case any other flushes were ignored.

Is that just for transient kernel mappings (e.g. vmalloc), or other
things (e.g. junk values in the TLB out-of-reset)?

For the former that may be ok, depending on your TLB architecture, but
for the latter I'd suspect that you need to do TLB maintenance before
enabling the MMU.

Thanks,
Mark.
