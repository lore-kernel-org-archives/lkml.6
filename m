Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeFAGXZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:23:25 -0400
Received: from ozlabs.org ([203.11.71.1]:53313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750812AbeFAGXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:23:23 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 16:23:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180601162320.1ef18d8e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Bnf1ja+zn6L3VbNCA3o2aAj"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Bnf1ja+zn6L3VbNCA3o2aAj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got conflicts in:

  arch/arm64/include/asm/kvm_host.h
  arch/arm64/kvm/hyp/switch.c

between commit:

  55e3748e8902 ("arm64: KVM: Add ARCH_WORKAROUND_2 support for guests")

from the arm64 tree and commits:

  fa89d31c5306 ("KVM: arm64: Repurpose vcpu_arch.debug_flags for general-pu=
rpose flags")
  e6b673b741ea ("KVM: arm64: Optimise FPSIMD handling to reduce guest/host =
thrashing")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/kvm_host.h
index 95d8a0e15b5f,a4ca202ff3f2..000000000000
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@@ -216,11 -217,8 +217,11 @@@ struct kvm_vcpu_arch=20
  	/* Exception Information */
  	struct kvm_vcpu_fault_info fault;
 =20
 +	/* State of various workarounds, see kvm_asm.h for bit assignment */
 +	u64 workaround_flags;
 +
- 	/* Guest debug state */
- 	u64 debug_flags;
+ 	/* Miscellaneous vcpu state flags */
+ 	u64 flags;
 =20
  	/*
  	 * We maintain more than a single set of debug registers to support
diff --cc arch/arm64/kvm/hyp/switch.c
index c50cedc447f1,2d45bd719a5d..000000000000
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@@ -452,10 -475,6 +511,8 @@@ int kvm_vcpu_run_vhe(struct kvm_vcpu *v
  		/* And we're baaack! */
  	} while (fixup_guest_exit(vcpu, &exit_code));
 =20
 +	__set_host_arch_workaround_state(vcpu);
 +
- 	fp_enabled =3D fpsimd_enabled_vhe();
-=20
  	sysreg_save_guest_state_vhe(guest_ctxt);
 =20
  	__deactivate_traps(vcpu);
@@@ -512,10 -525,6 +565,8 @@@ int __hyp_text __kvm_vcpu_run_nvhe(stru
  		/* And we're baaack! */
  	} while (fixup_guest_exit(vcpu, &exit_code));
 =20
 +	__set_host_arch_workaround_state(vcpu);
 +
- 	fp_enabled =3D __fpsimd_enabled_nvhe();
-=20
  	__sysreg_save_state_nvhe(guest_ctxt);
  	__sysreg32_save_state(vcpu);
  	__timer_disable_traps(vcpu);

--Sig_/Bnf1ja+zn6L3VbNCA3o2aAj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQ5lgACgkQAVBC80lX
0Gy1+wgAhXE0xIMgljuJbQ70gw3VeNzUUl3AeUdufN8deeMmXq63PpcQBs5nL6P5
1+XXvNiKRF4BeEUkMjfziCqYJjDcgL8cAOkEXXXlCyiJnywNm29+wTD1TVSY79aE
QSQ0d7DsHLwLFBoBZmQpPJdVCQcnLTfBPxVBQexmfCDqHuOX5I+aLa395qe3t50U
n94JIZph3z+tG4YTECwKzw2nZwRViohQbe75MMuJpmKJwZlJqo5SqCVo/3GbNhSX
cDA86wKb8Q27KYHGwP+j/y3aEkOFGLa8MIfzFcvQL2JysD0l0pdbumXwINIo95y3
Ak6n3FTo/vrUSlkPy1n/sK2N0zYjGw==
=RtD2
-----END PGP SIGNATURE-----

--Sig_/Bnf1ja+zn6L3VbNCA3o2aAj--
