Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbeC2FMx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 01:12:53 -0400
Received: from ozlabs.org ([103.22.144.67]:48145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbeC2FMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 01:12:51 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Thu, 29 Mar 2018 16:11:57 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: linux-next: manual merge of the kvm tree with the kvm-fixes tree
Message-ID: <20180329161157.692371b9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xtKjDh0m5V9HKV0B7=+SJxM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xtKjDh0m5V9HKV0B7=+SJxM
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
index 92496b9b5f2b,9bc05f5349c8..000000000000
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@@ -10952,6 -11081,21 +11092,16 @@@ static int prepare_vmcs02(struct kvm_vc
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
+ 	if (vmx->emulation_required) {
+ 		*entry_failure_code =3D ENTRY_FAIL_DEFAULT;
+ 		return 1;
+ 	}
+=20
  	/* Shadow page tables on either EPT or shadow page tables. */
  	if (nested_vmx_load_cr3(vcpu, vmcs12->guest_cr3, nested_cpu_has_ept(vmcs=
12),
  				entry_failure_code))

--Sig_/xtKjDh0m5V9HKV0B7=+SJxM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq8dZ0ACgkQAVBC80lX
0GyxOgf/UoGIEdsWueZrvrHbwHdu+zS1PjUUc21a2oblc+w2reNO6LLXdJGGjNRz
/g09EyXKUqSZipKxwSE0yTcaiv6zutHxoQ3jNgJIfB4f6I1O0QFUdznLwfrSqtu+
2HPXKkBZe9V5V3KHmS31HBQ2Gn0qHGlZL9v8aYGE17ec5hj7VyRmgTSMR+Iv36lX
OKfpfcJ2RTXbSzrrDrLnwW8/c4+JZwkGsnlJuPGclDc00sYuSXnX6N212H5Od0xZ
L3gDhIG6vbT5KQiY72Qr1EY5iHyYBVavccG7Ds87hM7xo1Q0Ab31aNBkgx06OJqm
/fLALB+BEu0raCNgK03f79qN6V34ew==
=xwCR
-----END PGP SIGNATURE-----

--Sig_/xtKjDh0m5V9HKV0B7=+SJxM--
