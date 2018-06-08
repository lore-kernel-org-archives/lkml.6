Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id QwmzOs/SGVt2TgAAmS7hNA
	; Fri, 08 Jun 2018 00:51:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1FE9F6089E; Fri,  8 Jun 2018 00:51:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Zht5tz7v"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A12D7605A5;
	Fri,  8 Jun 2018 00:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A12D7605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFHAvZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 20:51:25 -0400
Received: from ozlabs.org ([203.11.71.1]:48395 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeFHAvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 20:51:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4123kd3wPPz9ry1;
        Fri,  8 Jun 2018 10:51:21 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1528419082;
        bh=OAKoX5U3kzs9ANU+k7ZvBVMycbwKFM+K6Qic4ao3wm0=;
        h=Date:From:To:Cc:Subject:From;
        b=Zht5tz7vlPbOGxJME4rPuo7ShFX2F9mbVMXL4pCVUd60GPE6joZp/LDA67QmLPjLy
         Dsj2Q0+LEBFSUI3Z7UklBEdUOdPjYW5YwQWREDgG6hHH/O8gG8PMILwO4+PcdMF1aT
         DijEk+OJUfEyttQfoHlGPK56Rr9fhBovujHq8w4oJMXDAFZRg4y8eBTReI3+/MOqMD
         t0KSkHaPWiVhNTkm6l8erW3O4mn6+h0DE5haD6eTFhg/3FD7uG7xPZmLyRWhg1D1fq
         lbZgmc9WzNM3OdF1SF5HNLLBNMRw/BssXh+jfd6z4USucJEyjn5e8JcD4r/WmXw1M6
         uwtTO5TI+UhPw==
Date: Fri, 8 Jun 2018 10:51:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>
Subject: linux-next: build failure after merge of the thermal tree
Message-ID: <20180608105120.2e232f44@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OfKy.SFc+sZS2y_ArD9scpd"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OfKy.SFc+sZS2y_ArD9scpd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Zhang,

After merging the thermal tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/thermal/qcom/tsens.c: In function 'tsens_probe':
drivers/thermal/qcom/tsens.c:144:31: error: 's' undeclared (first use in th=
is function)
         num_sensors * sizeof(*s), GFP_KERNEL);
                               ^

Caused by commit

  6d7c70d1cd65 ("thermal: qcom: tsens: Allow number of sensors to come from=
 DT")

interacting with commit

  0ed2dd03b94b ("treewide: Use struct_size() for devm_kmalloc() and friends=
")

from Linus' tree.  It looks like git somehow screwed up the automatic
conflict resolution.

I have added the following patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 Jun 2018 10:46:46 +1000
Subject: [PATCH] thermal: gcom: fix up bad git conflict resolution

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/thermal/qcom/tsens.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index fb8c87f55240..6164fd36dda3 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -140,8 +140,8 @@ static int tsens_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
=20
-	tmdev =3D devm_kzalloc(dev, sizeof(*tmdev) +
-			     num_sensors * sizeof(*s), GFP_KERNEL);
+	tmdev =3D devm_kzalloc(dev, struct_size(tmdev, sensor, num_sensors),
+			     GFP_KERNEL);
 	if (!tmdev)
 		return -ENOMEM;
=20
--=20
2.17.1

--=20
Cheers,
Stephen Rothwell

--Sig_/OfKy.SFc+sZS2y_ArD9scpd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZ0wgACgkQAVBC80lX
0Gyvtgf/XFkDsz5595Bs/FzL4PZATY+ULoGjE68Fn/WpGqbNzDMY49vut2SNCPdF
gFxjRwUrb7Z0s14HuAh7uq0RUAzzEvW+xVZgnq/gF8UHziol/wYjSCQiwQE+QPw7
dyn9PlUrcgytU0W6GZakeLjoWRMigDfTFkiFSDiPbqHirXBXtZXE5rBWk+QQH8ye
nmADXINOpco+MxNdtn4fWMgc1IdbQD7jaip0tuehQHbB88UI5IihPXISWnSUpl1K
t5xLUEK+/+Q+e4H6HB1ExTj5xJSVUzXJrfKIH63qzHHgFC6oKFpAdQGQcTNglz5o
fEsLnp0T98bgzOjJ23LYgqk5Yr37Tg==
=KzrQ
-----END PGP SIGNATURE-----

--Sig_/OfKy.SFc+sZS2y_ArD9scpd--
