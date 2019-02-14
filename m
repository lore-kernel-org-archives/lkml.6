Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674C7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3184D20818
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="azT1Sf9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405455AbfBNDab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:30:31 -0500
Received: from ozlabs.org ([203.11.71.1]:42523 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405416AbfBNDab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:30:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 440MNM2KzZz9sMp;
        Thu, 14 Feb 2019 14:30:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550115027;
        bh=AlHfP0oDaWQgQR7MsEY6pTiV+D4GVE+B+pM0ZNt3SeM=;
        h=Date:From:To:Cc:Subject:From;
        b=azT1Sf9PZx1Xn6YcwNjpgm87cJtzQ6tBOcuwoObQrI7v0ZQ9LJ5c+EHpM0kuVUoOP
         2dTBMOiraSPW8ycdzyebVme66GEi+3PwgxnlrnuYGM8cuS4vMxrkvZb1+mHPf1a4N4
         N/cwf0RKa9Ur1u6uPxj68HFKx9FHpVpgTdmZNXm0uO7QWqFdTOq9mOaNAGBR6AtkCi
         XDpVTR9jiTih+j9g7NHh9QM2knTK5JyVMyM86XwtfOgNhOSktxA1ja7mWL5fqP7Q2k
         13HGD3nee7FXFr75EIiyAF1PeFSlBzPIrKniNLoZ1/wenVgfofHuSDxngoKI49Msov
         dFs0bhmJynEjg==
Date:   Thu, 14 Feb 2019 14:30:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-arm tree with the kvm-fixes
 tree
Message-ID: <20190214143022.1652616e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qC1DzH0xqhtUyHdE/8q9I3i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qC1DzH0xqhtUyHdE/8q9I3i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm/include/asm/kvm_host.h

between commit:

  358b28f09f0a ("arm/arm64: KVM: Allow a VCPU to fully reset itself")

from the kvm-fixes tree and commit:

  42a2502ef5f8 ("arm/arm64: KVM: Statically configure the host's view of MP=
IDR")

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

diff --cc arch/arm/include/asm/kvm_host.h
index 50e89869178a,8073267dc4a0..000000000000
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@@ -148,13 -151,13 +152,20 @@@ struct kvm_cpu_context=20
 =20
  typedef struct kvm_cpu_context kvm_cpu_context_t;
 =20
+ static inline void kvm_init_host_cpu_context(kvm_cpu_context_t *cpu_ctxt,
+ 					     int cpu)
+ {
+ 	/* The host's MPIDR is immutable, so let's set it up at boot time */
+ 	cpu_ctxt->cp15[c0_MPIDR] =3D cpu_logical_map(cpu);
+ }
+=20
 +struct vcpu_reset_state {
 +	unsigned long	pc;
 +	unsigned long	r0;
 +	bool		be;
 +	bool		reset;
 +};
 +
  struct kvm_vcpu_arch {
  	struct kvm_cpu_context ctxt;
 =20

--Sig_/qC1DzH0xqhtUyHdE/8q9I3i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxk4M8ACgkQAVBC80lX
0GzeSAgAiMAKFE8uj5Pp8Y5aItPZH4Dn7b7E1+AxvKkaikY/L/3cQY/Dgvxhpbiv
j9YWc3NLmt83M1r/jZduGApGdfwIRgfHZeAdJv0fFcpp1dmbAuvd94P8IUV1L0c0
hHmq6EUepBAWQjHVZfvn6wkfSddW1aN1USOZH0d0uyHuvhG/Rz45M+/jqCaoUQPt
8sQpWCqTnqDKSbUJlvjOd6Qyc30D4BCUPUktnBioY28TySKFFKALAS9my6Pb1mvZ
AoQXJKYUe6TNjaHS3Gz+ModvD6O8+OPL4NrX7xqEZZrsQQndGGNfCxoGqsWU2OcA
6sLUGJQgycUjWzNeXvCrh8wAam+ABA==
=bfjp
-----END PGP SIGNATURE-----

--Sig_/qC1DzH0xqhtUyHdE/8q9I3i--
