Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C958C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6FF218D3
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 00:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pDmW+M8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfBGArb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 19:47:31 -0500
Received: from ozlabs.org ([203.11.71.1]:43851 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfBGAra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 19:47:30 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43w05X1G7zz9s3q;
        Thu,  7 Feb 2019 11:47:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549500448;
        bh=Zp+p0jHWtgs5UWtPK1b2zEWNffhb8e5+dEXNeJCnCmc=;
        h=Date:From:To:Cc:Subject:From;
        b=pDmW+M8YOnuvyEfFF4H/RXxxG0jRCHBT0qf75igj5HbpK9Rz/gx53o2/yfTvA9kP2
         1dsmZ/pr8q+D1kLTW3XWMdN77ygxkhzkHel0+AK045VhKkd7JbzSC9vmehiVE4bwWk
         6McgFWx7S2LglXgNiTZgvKJfC1S3L87pdFUinvOFuTLl8qbpt5muYMLSxQaIj5n60N
         Q5HYSputAb8EqpX2kbfqmhEAmIF2YkrdRxzvflXxm2HEmf2544xc6/7v9tiET1KKi6
         Axahd/nr1VRnE9H1rhsTlY4sXTnn0s1qxgeYdQIneNWmRrfvChRY0ROIZGWkuSfF0S
         3aLDdEkdIJWWw==
Date:   Thu, 7 Feb 2019 11:47:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Subject: linux-next: manual merge of the opp tree with the cpufreq-arm tree
Message-ID: <20190207114726.741da653@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nV2JY/799zyzBbiIdh3+g1k"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nV2JY/799zyzBbiIdh3+g1k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

Today's linux-next merge of the opp tree got a conflict in:

  drivers/cpufreq/qcom-cpufreq-hw.c

between commit:

  5471b2c9bd08 ("cpufreq: qcom: Read voltage LUT and populate OPP")

from the cpufreq-arm tree and commit:

  597457d7e054 ("cpufreq: qcom-hw: Register an Energy Model")

from the opp tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/cpufreq/qcom-cpufreq-hw.c
index 15f31e8c09c2,a16b9dca7ea3..000000000000
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@@ -224,13 -205,8 +224,15 @@@ static int qcom_cpufreq_hw_cpu_init(str
  		goto error;
  	}
 =20
 +	ret =3D dev_pm_opp_get_opp_count(cpu_dev);
 +	if (ret <=3D 0) {
 +		dev_err(cpu_dev, "Failed to add OPPs\n");
 +		ret =3D -ENODEV;
 +		goto error;
 +	}
 +
+ 	dev_pm_opp_of_register_em(policy->cpus);
+=20
  	policy->fast_switch_possible =3D true;
 =20
  	return 0;

--Sig_/nV2JY/799zyzBbiIdh3+g1k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxbgB4ACgkQAVBC80lX
0GzyXQf/TTJt2einDltTe1wTkY7UAEDMMKYZblGBnjigwEerH+Efyj6vfNzuhZRM
rqmKONIVCyxhMeJj5r2WXhjB7bmuwk6HpMDaK4v+S1ZKBDbwkzLT67ZbAaaIPKiB
jw++xPFL0cHIMH1H2qDbX99I04Q5uv4VFKoaVkC8JTM16ZF9Qsim9No0/uvNBCOp
SHDnV/XC15Ne7Q+SjcJQeFkOLrrBq3SgWzMOqrZSYoklVm6ETBRNdfTjI2/wqxSB
ZdThB2bhECDElj7s6Zc4DxJSQqUlQdERW2WooyHTUZ9Lko+hqUKv1zCqiboZt2W8
LrtT+Ehwn0K2BKryKfhWxc5dGMPeUw==
=lCoA
-----END PGP SIGNATURE-----

--Sig_/nV2JY/799zyzBbiIdh3+g1k--
