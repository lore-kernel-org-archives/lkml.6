Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeC1FB2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 01:01:28 -0400
Received: from ozlabs.org ([103.22.144.67]:50499 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbeC1FB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 01:01:26 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 28 Mar 2018 16:00:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shanker Donthineni <shankerd@codeaurora.org>,
        Dave Martin <dave.martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180328160034.61e0e588@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Z9mbEhA0yKtgkviCBIOc1G5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z9mbEhA0yKtgkviCBIOc1G5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/kernel/cpu_errata.c

between commit:

  c0cda3b8ee6b ("arm64: capabilities: Update prototype for enable call back=
")
  followed by a series of patches cleaning up capabilities

from the arm64 tree and commits:

  4b472ffd1513 ("arm64: Enable ARM64_HARDEN_EL2_VECTORS on Cortex-A57 and A=
72")
  f9f5dc19509b ("arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 for Falkor BP hard=
ening")

from the kvm-arm tree.

I fixed it up (maybe, please check the result and see below) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/cpu_errata.c
index 2df792771053,caa73af7d26e..000000000000
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@@ -76,8 -57,11 +76,10 @@@ cpu_enable_trap_ctr_access(const struc
  {
  	/* Clear SCTLR_EL1.UCT */
  	config_sctlr_el1(SCTLR_EL1_UCT, 0);
 -	return 0;
  }
 =20
+ atomic_t arm64_el2_vector_last_slot =3D ATOMIC_INIT(-1);
+=20
  #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
  #include <asm/mmu_context.h>
  #include <asm/cacheflush.h>
@@@ -179,18 -156,31 +174,31 @@@ static void call_hvc_arch_workaround_1(
  	arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_1, NULL);
  }
 =20
+ static void qcom_link_stack_sanitization(void)
+ {
+ 	u64 tmp;
+=20
+ 	asm volatile("mov	%0, x30		\n"
+ 		     ".rept	16		\n"
+ 		     "bl	. + 4		\n"
+ 		     ".endr			\n"
+ 		     "mov	x30, %0		\n"
+ 		     : "=3D&r" (tmp));
+ }
+=20
 -static int enable_smccc_arch_workaround_1(void *data)
 +static void
 +enable_smccc_arch_workaround_1(const struct arm64_cpu_capabilities *entry)
  {
 -	const struct arm64_cpu_capabilities *entry =3D data;
  	bp_hardening_cb_t cb;
  	void *smccc_start, *smccc_end;
  	struct arm_smccc_res res;
+ 	u32 midr =3D read_cpuid_id();
 =20
  	if (!entry->matches(entry, SCOPE_LOCAL_CPU))
 -		return 0;
 +		return;
 =20
  	if (psci_ops.smccc_version =3D=3D SMCCC_VERSION_1_0)
 -		return 0;
 +		return;
 =20
  	switch (psci_ops.conduit) {
  	case PSCI_CONDUIT_HVC:
@@@ -214,139 -204,33 +222,124 @@@
  		break;
 =20
  	default:
 -		return 0;
 +		return;
  	}
 =20
+ 	if (((midr & MIDR_CPU_MODEL_MASK) =3D=3D MIDR_QCOM_FALKOR) ||
+ 	    ((midr & MIDR_CPU_MODEL_MASK) =3D=3D MIDR_QCOM_FALKOR_V1))
+ 		cb =3D qcom_link_stack_sanitization;
+=20
  	install_bp_hardening_cb(entry, cb, smccc_start, smccc_end);
 =20
 -	return 0;
 +	return;
  }
 =20
- static void qcom_link_stack_sanitization(void)
- {
- 	u64 tmp;
-=20
- 	asm volatile("mov	%0, x30		\n"
- 		     ".rept	16		\n"
- 		     "bl	. + 4		\n"
- 		     ".endr			\n"
- 		     "mov	x30, %0		\n"
- 		     : "=3D&r" (tmp));
- }
-=20
- static void
- qcom_enable_link_stack_sanitization(const struct arm64_cpu_capabilities *=
entry)
- {
- 	install_bp_hardening_cb(entry, qcom_link_stack_sanitization,
- 				__qcom_hyp_sanitize_link_stack_start,
- 				__qcom_hyp_sanitize_link_stack_end);
- }
  #endif	/* CONFIG_HARDEN_BRANCH_PREDICTOR */
 =20
 -#define MIDR_RANGE(model, min, max) \
 -	.def_scope =3D SCOPE_LOCAL_CPU, \
 -	.matches =3D is_affected_midr_range, \
 -	.midr_model =3D model, \
 -	.midr_range_min =3D min, \
 -	.midr_range_max =3D max
 +#define CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)	\
 +	.matches =3D is_affected_midr_range,			\
 +	.midr_range =3D MIDR_RANGE(model, v_min, r_min, v_max, r_max)
 +
 +#define CAP_MIDR_ALL_VERSIONS(model)					\
 +	.matches =3D is_affected_midr_range,				\
 +	.midr_range =3D MIDR_ALL_VERSIONS(model)
 +
 +#define MIDR_FIXED(rev, revidr_mask) \
 +	.fixed_revs =3D (struct arm64_midr_revidr[]){{ (rev), (revidr_mask) }, {=
}}
 +
 +#define ERRATA_MIDR_RANGE(model, v_min, r_min, v_max, r_max)		\
 +	.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,				\
 +	CAP_MIDR_RANGE(model, v_min, r_min, v_max, r_max)
 +
 +#define CAP_MIDR_RANGE_LIST(list)				\
 +	.matches =3D is_affected_midr_range_list,			\
 +	.midr_range_list =3D list
 +
 +/* Errata affecting a range of revisions of  given model variant */
 +#define ERRATA_MIDR_REV_RANGE(m, var, r_min, r_max)	 \
 +	ERRATA_MIDR_RANGE(m, var, r_min, var, r_max)
 +
 +/* Errata affecting a single variant/revision of a model */
 +#define ERRATA_MIDR_REV(model, var, rev)	\
 +	ERRATA_MIDR_RANGE(model, var, rev, var, rev)
 +
 +/* Errata affecting all variants/revisions of a given a model */
 +#define ERRATA_MIDR_ALL_VERSIONS(model)				\
 +	.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 +	CAP_MIDR_ALL_VERSIONS(model)
 +
 +/* Errata affecting a list of midr ranges, with same work around */
 +#define ERRATA_MIDR_RANGE_LIST(midr_list)			\
 +	.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,			\
 +	CAP_MIDR_RANGE_LIST(midr_list)
 +
 +/*
 + * Generic helper for handling capabilties with multiple (match,enable) p=
airs
 + * of call backs, sharing the same capability bit.
 + * Iterate over each entry to see if at least one matches.
 + */
 +static bool __maybe_unused
 +multi_entry_cap_matches(const struct arm64_cpu_capabilities *entry, int s=
cope)
 +{
 +	const struct arm64_cpu_capabilities *caps;
 +
 +	for (caps =3D entry->match_list; caps->matches; caps++)
 +		if (caps->matches(caps, scope))
 +			return true;
 +
 +	return false;
 +}
 +
 +/*
 + * Take appropriate action for all matching entries in the shared capabil=
ity
 + * entry.
 + */
 +static void __maybe_unused
 +multi_entry_cap_cpu_enable(const struct arm64_cpu_capabilities *entry)
 +{
 +	const struct arm64_cpu_capabilities *caps;
 +
 +	for (caps =3D entry->match_list; caps->matches; caps++)
 +		if (caps->matches(caps, SCOPE_LOCAL_CPU) &&
 +		    caps->cpu_enable)
 +			caps->cpu_enable(caps);
 +}
 +
 +#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
 +
 +/*
 + * List of CPUs where we need to issue a psci call to
 + * harden the branch predictor.
 + */
 +static const struct midr_range arm64_bp_harden_smccc_cpus[] =3D {
 +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 +	MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 +	MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 +	{},
 +};
 +
 +static const struct midr_range qcom_bp_harden_cpus[] =3D {
 +	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 +	MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
 +	{},
 +};
 +
 +static const struct arm64_cpu_capabilities arm64_bp_harden_list[] =3D {
 +	{
 +		CAP_MIDR_RANGE_LIST(arm64_bp_harden_smccc_cpus),
 +		.cpu_enable =3D enable_smccc_arch_workaround_1,
 +	},
 +	{
 +		CAP_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
 +		.cpu_enable =3D qcom_enable_link_stack_sanitization,
 +	},
 +	{},
 +};
 =20
 -#define MIDR_ALL_VERSIONS(model) \
 -	.def_scope =3D SCOPE_LOCAL_CPU, \
 -	.matches =3D is_affected_midr_range, \
 -	.midr_model =3D model, \
 -	.midr_range_min =3D 0, \
 -	.midr_range_max =3D (MIDR_VARIANT_MASK | MIDR_REVISION_MASK)
 +#endif
 =20
  const struct arm64_cpu_capabilities arm64_errata[] =3D {
  #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
@@@ -491,15 -369,56 +484,27 @@@
  #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
  	{
  		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR_V1),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
 -		.enable =3D enable_smccc_arch_workaround_1,
 +		.type =3D ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
 +		.matches =3D multi_entry_cap_matches,
 +		.cpu_enable =3D multi_entry_cap_cpu_enable,
 +		.match_list =3D arm64_bp_harden_list,
  	},
  	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 -		.enable =3D enable_smccc_arch_workaround_1,
 -	},
 -	{
 -		.capability =3D ARM64_HARDEN_BRANCH_PREDICTOR,
 -		MIDR_ALL_VERSIONS(MIDR_CAVIUM_THUNDERX2),
 -		.enable =3D enable_smccc_arch_workaround_1,
 +		.capability =3D ARM64_HARDEN_BP_POST_GUEST_EXIT,
 +		ERRATA_MIDR_RANGE_LIST(qcom_bp_harden_cpus),
  	},
+ #endif
+ #ifdef CONFIG_HARDEN_EL2_VECTORS
+ 	{
+ 		.desc =3D "Cortex-A57 EL2 vector hardening",
+ 		.capability =3D ARM64_HARDEN_EL2_VECTORS,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
++		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
+ 	},
+ 	{
+ 		.desc =3D "Cortex-A72 EL2 vector hardening",
+ 		.capability =3D ARM64_HARDEN_EL2_VECTORS,
 -		MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
++		ERRATA_MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
+ 	},
  #endif
  	{
  	}

--Sig_/Z9mbEhA0yKtgkviCBIOc1G5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq7IXIACgkQAVBC80lX
0GwdAQf+KO+sVEVd6hxhVtGmUitipcta8KfPTlSCSrgT0JaLm1fNFx3dboaCKhZ2
bSQSoJjFtlpJspBx8da7IjD0VJCka6Iv3T3g2Vj+aOReleX9YdmuzWKDUPKcYwpW
KHZWC1DhEQrjGIuTrospPyQ/riismKisWULFJAesuDtzY4nf7KTLHQPgBnbMBlMb
pBzfZ4e0mxfV8EPIOVXmdO7c5s4g7TCEyMJhe59oj2X9ooFBQtn9YbFHM+KaFa9i
k+ZDDaTEGKGsQIpHERqCFbaFomZ0XFXV7CP9cpNd9GtOcxVJ24+5GfPrA1Gcaz/0
GglrRKE8DSZ54lLBjN1NGD8/AUnZIA==
=vf9V
-----END PGP SIGNATURE-----

--Sig_/Z9mbEhA0yKtgkviCBIOc1G5--
