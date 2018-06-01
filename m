Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeFAGN6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:13:58 -0400
Received: from ozlabs.org ([203.11.71.1]:52843 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeFAGNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:13:55 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 16:13:52 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20180601161352.41bf6b29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/W+ytlMMLdh4opml_HzIlcML"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/W+ytlMMLdh4opml_HzIlcML
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/include/asm/cpufeature.h

between commits:

  a43ae4dfe56a ("arm64: Add 'ssbd' command-line option")
  c32e1736ca03 ("arm64: ssbd: Add global mitigation state accessor")
  647d0519b53f ("arm64: ssbd: Restore mitigation status on CPU resume")

from the arm64 tree and commit:

  31dc52b3c8fa ("arm64/sve: Move read_zcr_features() out of cpufeature.h")

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

diff --cc arch/arm64/include/asm/cpufeature.h
index 55bc1f073bfb,0a6b7133195e..000000000000
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@@ -510,55 -508,6 +508,28 @@@ static inline bool system_supports_sve(
  		cpus_have_const_cap(ARM64_SVE);
  }
 =20
- /*
-  * Read the pseudo-ZCR used by cpufeatures to identify the supported SVE
-  * vector length.
-  *
-  * Use only if SVE is present.
-  * This function clobbers the SVE vector length.
-  */
- static inline u64 read_zcr_features(void)
- {
- 	u64 zcr;
- 	unsigned int vq_max;
-=20
- 	/*
- 	 * Set the maximum possible VL, and write zeroes to all other
- 	 * bits to see if they stick.
- 	 */
- 	sve_kernel_enable(NULL);
- 	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
-=20
- 	zcr =3D read_sysreg_s(SYS_ZCR_EL1);
- 	zcr &=3D ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
- 	vq_max =3D sve_vq_from_vl(sve_get_vl());
- 	zcr |=3D vq_max - 1; /* set LEN field to maximum effective value */
-=20
- 	return zcr;
- }
-=20
 +#define ARM64_SSBD_UNKNOWN		-1
 +#define ARM64_SSBD_FORCE_DISABLE	0
 +#define ARM64_SSBD_KERNEL		1
 +#define ARM64_SSBD_FORCE_ENABLE		2
 +#define ARM64_SSBD_MITIGATED		3
 +
 +static inline int arm64_get_ssbd_state(void)
 +{
 +#ifdef CONFIG_ARM64_SSBD
 +	extern int ssbd_state;
 +	return ssbd_state;
 +#else
 +	return ARM64_SSBD_UNKNOWN;
 +#endif
 +}
 +
 +#ifdef CONFIG_ARM64_SSBD
 +void arm64_set_ssbd_mitigation(bool state);
 +#else
 +static inline void arm64_set_ssbd_mitigation(bool state) {}
 +#endif
 +
  #endif /* __ASSEMBLY__ */
 =20
  #endif

--Sig_/W+ytlMMLdh4opml_HzIlcML
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsQ5CAACgkQAVBC80lX
0GxfWAf9HnXSnCS5eXlPQAySvloaSqSxdCSPdxw9KZSUi9SauyvNTaiERIJPNbkh
R0IvQoraU/c/+SVqptxuN8Mtp5IZzezLqZRe1zmGK+6r31cUpI1T9DNa3fzALFis
UuZBrSM63acQh/5zRT9jWrKDT5QpOiMyMhoUnXJHrgAd9i4k/zAkCoK1shrDK3Gc
jnY15ep2EU7BLEa5AczOLivDX0MrWRQLslHmoXe129cEUYYbwC/MMl65IcLgS0C+
MCDZLwHqUUf+61REp30JSghytFgowMJqPSEJVaU1C361WNO3Px16BNMfU0xmqAbT
vsvjBmNNu/Pfc86njzIVbDBHgacl+Q==
=0O1t
-----END PGP SIGNATURE-----

--Sig_/W+ytlMMLdh4opml_HzIlcML--
