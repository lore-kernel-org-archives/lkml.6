Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8A9C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A0D21708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 03:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="H3Hl7Y6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A0D21708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeI1KLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 06:11:12 -0400
Received: from ozlabs.org ([203.11.71.1]:58243 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeI1KLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 06:11:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42LyNV6LfSz9s3Z;
        Fri, 28 Sep 2018 13:49:30 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538106571;
        bh=dqq6wco2e//1pFJK4QuRzdB5buuWUhCmiqUjAjGkweE=;
        h=Date:From:To:Cc:Subject:From;
        b=H3Hl7Y6lZQM4RRIgi6guAJhV0PAUjKw9r8zq+ogwcIWDdi13XJsMhQ9LT1UbHvc38
         Yjdl7Ha5h9rfOWMujxNNCrMcmjTwSfcipHQs1wmCE7Ozj6b4AFOQgobc9Q4ZxHMEyy
         bo2Kq0NhCCABRRirTEP+9pExxX/laMHbBdL6l1hUIhKU2KdL0aaj5pPPLDzxijrZGs
         kvZ6v9tot4qO66T36/93sEt6A1UVdcH9d7RoXsnhZr/oQa7S29aDOO1LwyZdXYlbdF
         +d4x4NBUlGmt3mQIs0IgBv4reZugrhHHqhwTUBv1RigB79ARlSH51KvMKrDTYNaOXq
         PlEqkfG49TMUw==
Date:   Fri, 28 Sep 2018 13:49:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the arm64 tree
Message-ID: <20180928134929.73598ec6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AbN9IIKd.4DXS_x49UCAG6i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AbN9IIKd.4DXS_x49UCAG6i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Eric,

Today's linux-next merge of the userns tree got a conflict in:

  arch/arm64/kernel/traps.c

between commit:

  8a60419d3676 ("arm64: force_signal_inject: WARN if called from kernel con=
text")

from the arm64 tree and commit:

  6fa998e83ef9 ("signal/arm64: Push siginfo generation into arm64_notify_di=
e")

from the userns tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/kernel/traps.c
index 21689c6a985f,856b32aa03d8..000000000000
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@@ -353,12 -366,6 +368,9 @@@ void force_signal_inject(int signal, in
  	const char *desc;
  	struct pt_regs *regs =3D current_pt_regs();
 =20
 +	if (WARN_ON(!user_mode(regs)))
 +		return;
 +
- 	clear_siginfo(&info);
-=20
  	switch (signal) {
  	case SIGILL:
  		desc =3D "undefined instruction";

--Sig_/AbN9IIKd.4DXS_x49UCAG6i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlutpMkACgkQAVBC80lX
0GwSLAf/UNR1AOtAmLKtxFCoadq57qvQjMMqsNVV1yNb23v+f7mJejm+u34AMoHE
scjKQqm8ndKVs7dgqNoqDCnNahTEEGnRmqzr/d0ONqzhLdm+Chbn7DAuv8cNNgpZ
MMozwZYaKt/KEBCjMsdUV4zq1XIkCYk6LxfqQIi4hkPwQExOoJf4Ppi/XmN3bkRD
TfxTTudkwQdc/CD/GOYWpxW1MXIKevVpkmLpINFek+cXRWEdY+O2imy9QptyxI2p
mOs9jaMevYsOZKXh6wr7qPL6Z+cyZWIwTje5G3FYi73EdeVXmTP1gyf1NcPaZfve
i8xRLMHpa7x0NKtgQTaukn7TFnXwsg==
=tN97
-----END PGP SIGNATURE-----

--Sig_/AbN9IIKd.4DXS_x49UCAG6i--
