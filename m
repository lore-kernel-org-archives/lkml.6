Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeCZFox (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 01:44:53 -0400
Received: from ozlabs.org ([103.22.144.67]:38207 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750813AbeCZFov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 01:44:51 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 26 Mar 2018 16:43:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: manual merge of the kvm tree with the kvm-fixes tree
Message-ID: <20180326164351.72336a33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yTuUM.hG5VtWE2wj.EQs4K4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yTuUM.hG5VtWE2wj.EQs4K4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/vmx.c

between commit:

  9d1887ef3252 ("KVM: nVMX: sync vmcs02 segment regs prior to vmx_set_cr0")

from the kvm-fixes tree and commit:

  2bb8cafea80b ("KVM: vVMX: signal failure for nested VMEntry if emulation_=
required")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/vmx.c
index 92496b9b5f2b,b4d8da6c62c8..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -10952,6 -11010,19 +11021,14 @@@ static int prepare_vmcs02(struct kvm_vc
  	/* Note: modifies VM_ENTRY/EXIT_CONTROLS and GUEST/HOST_IA32_EFER */
  	vmx_set_efer(vcpu, vcpu->arch.efer);
 =20
 -	if (vmx->nested.dirty_vmcs12) {
 -		prepare_vmcs02_full(vcpu, vmcs12, from_vmentry);
 -		vmx->nested.dirty_vmcs12 =3D false;
 -	}
 -
+ 	/*
+ 	 * Guest state is invalid and unrestricted guest is disabled,
+ 	 * which means L1 attempted VMEntry to L2 with invalid state.
+ 	 * Fail the VMEntry.
+ 	 */
+ 	if (vmx->emulation_required)
+ 		return 1;
+=20
  	/* Shadow page tables on either EPT or shadow page tables. */
  	if (nested_vmx_load_cr3(vcpu, vmcs12->guest_cr3, nested_cpu_has_ept(vmcs=
12),
  				entry_failure_code))

--Sig_/yTuUM.hG5VtWE2wj.EQs4K4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq4iJcACgkQAVBC80lX
0Gz9EQf/W5RoGOVKkxcbJfe0BcnzZonlQzvILfuJ5cIhMBOYIAbW/SMrmxNrgvpT
yLVkDwwZqJuZKLTexDJ+eKEQHP9OhimxM9+/ZaJcqiExD49a21biJ+fL96koJcJI
x5bhAgKWYBtEbETluWKtDQjVG6K1TiHj9LpDcoW83lgSuo1IUQa3q5HIOemWPF1L
k6rXOvPdZjwWFOr/aumnEukwRtcpZq8PeTCTAEsudWnTtXgFBKPgbuojVrpPhLrF
rqBMOM3Xv65vZiOwmjDALK28Prr1/j2jNBvmpsLcbJn6jeMPmPTzAVSQ9MwWVXH9
rbSCpMvB8/bHJQdatyrHzaZ2lqOxMA==
=KDCQ
-----END PGP SIGNATURE-----

--Sig_/yTuUM.hG5VtWE2wj.EQs4K4--
