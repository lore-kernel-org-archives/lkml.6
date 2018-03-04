Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeCDHeo (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 02:34:44 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57237 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCDHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 02:34:43 -0500
Date: Sun, 4 Mar 2018 08:34:39 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        ricardo.neri-calderon@linux.intel.com, rkrcmar@redhat.com,
        Janakarajan.Natarajan@amd.com, bp@suse.de, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
In-Reply-To: <20180303210653.GB22392@amd>
Message-ID: <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
References: <20180108201017.GA20588@amd> <alpine.DEB.2.20.1801082125530.2253@nanos> <20180108230355.GA25349@amd> <alpine.DEB.2.20.1801090043160.2253@nanos> <20180303210653.GB22392@amd>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2018, Pavel Machek wrote:
> On Tue 2018-01-09 00:44:30, Thomas Gleixner wrote:
> > On Tue, 9 Jan 2018, Pavel Machek wrote:
> > 
> > > On Mon 2018-01-08 21:27:25, Thomas Gleixner wrote:
> > > > On Mon, 8 Jan 2018, Pavel Machek wrote:
> > > > 
> > > > > 
> > > > > First, what is going on with X86_BUG_AMD_E400 and X86_BUG_AMD_APIC_C1E
> > > > > ? They seem to refer to the same bug, perhaps comment should mention
> > > > > that? (Do we need two flags for one bug?)
> > > > > 
> > > > > Next, maybe X86_BUG_CPU_INSECURE is a bit too generic? This seems to
> > > > > address "Meltdown" problem, but not "Spectre". Should it be limited to
> > > > > PPro and newer Intel CPUs?
> > > > > 
> > > > > Should another erratum be added for "Spectre"? This is present even on
> > > > > AMD CPUs, but should not be present in 486, maybe Pentium, and some
> > > > > Atom chips?
> > > > > 
> > > > > Plus... is this reasonable interface?
> > > > > 
> > > > > bugs		: cpu_insecure
> > > > 
> > > > We've renamed it to meltdown already and added spectre_v1/v2 bits for the
> > > > rest of the mess.
> > > 
> > > Could you explain (best with code comment) what is going on with
> > > X86_BUG_AMD_E400 and X86_BUG_AMD_APIC_C1E ? They seem to refer to the
> > > same bug.
> > 
> > Sorry, that;s really not the time for this.
> 
> Ok, is there better time now? The code is a bit confusing...

What's confusing? Here are the relevant code snippets in invocation order.

	/*
	 * Check whether the machine is affected by erratum 400. This is
	 * used to select the proper idle routine and to enable the check
	 * whether the machine is affected in arch_post_acpi_init(), which
	 * sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
	 */
	if (cpu_has_amd_erratum(c, amd_erratum_400))
		set_cpu_bug(c, X86_BUG_AMD_E400);

This sets the errate 400 bug bit to tell subsequent code that the CPU might
be affected by that erratum.

void select_idle_routine(const struct cpuinfo_x86 *c)
{

	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
		pr_info("using AMD E400 aware idle routine\n");
		x86_idle = amd_e400_idle;

Selects the idle routine depending on the bug flag

void __init arch_post_acpi_subsys_init(void)
{
	u32 lo, hi;

	if (!boot_cpu_has_bug(X86_BUG_AMD_E400))
		return;

	/*
	 * AMD E400 detection needs to happen after ACPI has been enabled. If
	 * the machine is affected K8_INTP_C1E_ACTIVE_MASK bits are set in
	 * MSR_K8_INT_PENDING_MSG.
	 */
	rdmsr(MSR_K8_INT_PENDING_MSG, lo, hi);
	if (!(lo & K8_INTP_C1E_ACTIVE_MASK))
		return;

Late detection whether C1E which halts TSC and APIC is enabled. This needs
to be done after ACPI is initialized.

/*
 * AMD Erratum 400 aware idle routine. We handle it the same way as C3 power
 * states (local apic timer and TSC stop).
 */
static void amd_e400_idle(void)
{
	/*
	 * We cannot use static_cpu_has_bug() here because X86_BUG_AMD_APIC_C1E
	 * gets set after static_cpu_has() places have been converted via
	 * alternatives.
	 */
	if (!boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
		default_idle();
		return;
	}

The actual idle routine. If the C1E bug flag is not set, CPU is not
affected, use default idle, otherwise handle it like other C-States which
stop TSC and APIC.


The comments are clear enough, but Feel free to send patches which enhance
them if you think thats necessary.

Thanks,

	tglx
