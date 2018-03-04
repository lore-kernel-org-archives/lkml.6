Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752561AbeCDIwC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 03:52:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38406 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeCDIwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 03:52:01 -0500
Date: Sun, 4 Mar 2018 09:51:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, r.marek@assembler.cz,
        ricardo.neri-calderon@linux.intel.com, rkrcmar@redhat.com,
        Janakarajan.Natarajan@amd.com, bp@suse.de, x86@kernel.org,
        hpa@zytor.com, mingo@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] clarify how insecure CPU is
Message-ID: <20180304085159.GB7931@amd>
References: <20180108201017.GA20588@amd>
 <alpine.DEB.2.20.1801082125530.2253@nanos>
 <20180108230355.GA25349@amd>
 <alpine.DEB.2.20.1801090043160.2253@nanos>
 <20180303210653.GB22392@amd>
 <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803040825130.1654@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > > > >=20
> > > > > > First, what is going on with X86_BUG_AMD_E400 and X86_BUG_AMD_A=
PIC_C1E
> > > > > > ? They seem to refer to the same bug, perhaps comment should me=
ntion
> > > > > > that? (Do we need two flags for one bug?)
> > > > > >=20
> > > > > > Next, maybe X86_BUG_CPU_INSECURE is a bit too generic? This see=
ms to
> > > > > > address "Meltdown" problem, but not "Spectre". Should it be lim=
ited to
> > > > > > PPro and newer Intel CPUs?
> > > > > >=20
> > > > > > Should another erratum be added for "Spectre"? This is present =
even on
> > > > > > AMD CPUs, but should not be present in 486, maybe Pentium, and =
some
> > > > > > Atom chips?
> > > > > >=20
> > > > > > Plus... is this reasonable interface?
> > > > > >=20
> > > > > > bugs		: cpu_insecure
> > > > >=20
> > > > > We've renamed it to meltdown already and added spectre_v1/v2 bits=
 for the
> > > > > rest of the mess.
> > > >=20
> > > > Could you explain (best with code comment) what is going on with
> > > > X86_BUG_AMD_E400 and X86_BUG_AMD_APIC_C1E ? They seem to refer to t=
he
> > > > same bug.
> > >=20
> > > Sorry, that;s really not the time for this.
> >=20
> > Ok, is there better time now? The code is a bit confusing...
>=20
> What's confusing? Here are the relevant code snippets in invocation order.
>=20
> 	/*
> 	 * Check whether the machine is affected by erratum 400. This is
> 	 * used to select the proper idle routine and to enable the check
> 	 * whether the machine is affected in arch_post_acpi_init(), which
> 	 * sets the X86_BUG_AMD_APIC_C1E bug depending on the MSR check.
> 	 */
> 	if (cpu_has_amd_erratum(c, amd_erratum_400))
> 		set_cpu_bug(c, X86_BUG_AMD_E400);
>=20
> This sets the errate 400 bug bit to tell subsequent code that the CPU mig=
ht
> be affected by that erratum.
>=20
> void select_idle_routine(const struct cpuinfo_x86 *c)
> {
>=20
> 	if (boot_cpu_has_bug(X86_BUG_AMD_E400)) {
> 		pr_info("using AMD E400 aware idle routine\n");
> 		x86_idle =3D amd_e400_idle;
>=20
> Selects the idle routine depending on the bug flag
>=20
> void __init arch_post_acpi_subsys_init(void)
> {
> 	u32 lo, hi;
>=20
> 	if (!boot_cpu_has_bug(X86_BUG_AMD_E400))
> 		return;
>=20
> 	/*
> 	 * AMD E400 detection needs to happen after ACPI has been enabled. If
> 	 * the machine is affected K8_INTP_C1E_ACTIVE_MASK bits are set in
> 	 * MSR_K8_INT_PENDING_MSG.
> 	 */
> 	rdmsr(MSR_K8_INT_PENDING_MSG, lo, hi);
> 	if (!(lo & K8_INTP_C1E_ACTIVE_MASK))
> 		return;
>=20
> Late detection whether C1E which halts TSC and APIC is enabled. This needs
> to be done after ACPI is initialized.
>=20
> /*
>  * AMD Erratum 400 aware idle routine. We handle it the same way as C3 po=
wer
>  * states (local apic timer and TSC stop).
>  */
> static void amd_e400_idle(void)
> {
> 	/*
> 	 * We cannot use static_cpu_has_bug() here because X86_BUG_AMD_APIC_C1E
> 	 * gets set after static_cpu_has() places have been converted via
> 	 * alternatives.
> 	 */
> 	if (!boot_cpu_has_bug(X86_BUG_AMD_APIC_C1E)) {
> 		default_idle();
> 		return;
> 	}
>=20
> The actual idle routine. If the C1E bug flag is not set, CPU is not
> affected, use default idle, otherwise handle it like other C-States which
> stop TSC and APIC.
>=20
>=20
> The comments are clear enough, but Feel free to send patches which enhance
> them if you think thats necessary.

Thanks for explanation. Might this be good idea?

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h
index f41079d..4901742 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -341,7 +341,7 @@
 #define X86_BUG_FDIV			X86_BUG(1) /* FPU FDIV */
 #define X86_BUG_COMA			X86_BUG(2) /* Cyrix 6x86 coma */
 #define X86_BUG_AMD_TLB_MMATCH		X86_BUG(3) /* "tlb_mmatch" AMD Erratum 383=
 */
-#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* "apic_c1e" AMD Erratum 400 */
+#define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* System is affected AMD Erratum=
 400, special idle routine is needed */
 #define X86_BUG_11AP			X86_BUG(5) /* Bad local APIC aka 11AP */
 #define X86_BUG_FXSAVE_LEAK		X86_BUG(6) /* FXSAVE leaks FOP/FIP/FOP */
 #define X86_BUG_CLFLUSH_MONITOR		X86_BUG(7) /* AAI65, CLFLUSH required bef=
ore MONITOR */
@@ -356,7 +356,7 @@
 #define X86_BUG_NULL_SEG		X86_BUG(10) /* Nulling a selector preserves the =
base */
 #define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* SWAPGS without input dep on G=
S */
 #define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CP=
U */
-#define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erra=
tum 400 */
+#define X86_BUG_AMD_E400		X86_BUG(13) /* System may be affected by Erratum=
 400, X86_BUG_AMD_APIC_C1E might be needed  */
 #define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown a=
ttack and needs kernel page table isolation */
 #define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre vari=
ant 1 attack with conditional branches */
 #define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre vari=
ant 2 attack with indirect branches */

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqbs68ACgkQMOfwapXb+vKpbACguaX5bIcGWob7beFFoXzcCzkb
FiMAoMQVwnp5ItCYeZlcFupyFm8b0lbL
=FOrj
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
