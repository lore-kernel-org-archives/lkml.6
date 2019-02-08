Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA6C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388D72192B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JFuDp4Ko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfBHCS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:18:28 -0500
Received: from ozlabs.org ([203.11.71.1]:38981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfBHCS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:18:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43wf40327xz9sML;
        Fri,  8 Feb 2019 13:18:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549592304;
        bh=8e2ZpH8MtZaRty+saml17dUq8FWtrO9kS/L1dZxj7cY=;
        h=Date:From:To:Cc:Subject:From;
        b=JFuDp4KoU8OjxMVOGMezG1MyUTuGU9opqgSuYpB+c4TETtc4rYTPrBl1/rgoK3oqw
         la9KuoaPjJqrUX3OlAvptmiD9hqqmuHqkQQalDMFWz1Iz853sa576DiJoAlAnZy9kx
         1hCkvgmYU1vHArW8zdkhqni6cUq2IQDjzIkvMkakaa3aXihISpChJm7751fDVR8RdT
         3QTtezZoQrS0ESf8Mk9nWEzdRWNLHls/MuKTDkdACqnZjwFwga4A6Mnmtoaz72hkWQ
         CHNCSaAT+/WRXqoLmezkxRXrkUHEdIfHHOJ7tQsLd+1+xTY4b63ZsdZ8YPbIi0D5Vf
         Ps7I+edh77NZw==
Date:   Fri, 8 Feb 2019 13:18:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20190208131823.0fd205b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dC5s+7syQoLthq/0T6_91Yv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dC5s+7syQoLthq/0T6_91Yv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

sound/soc/xilinx/xlnx_formatter_pcm.c: In function 'xlnx_formatter_pcm_new':
sound/soc/xilinx/xlnx_formatter_pcm.c:539:9: error: void value not ignored =
as it ought to be
  return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    SNDRV_DMA_TYPE_DEV, component->dev,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    xlnx_pcm_hardware.buffer_bytes_max,
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    xlnx_pcm_hardware.buffer_bytes_max);
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/xilinx/xlnx_formatter_pcm.c:543:1: warning: control reaches end o=
f non-void function [-Wreturn-type]
 }
 ^

Caused by commit

  6f6c3c36f091 ("ASoC: xlnx: add pcm formatter platform driver")

interacting with commit

  9adb5165f1de ("ALSA: pcm: Define snd_pcm_lib_preallocate_*() as returning=
 void")

from the sound tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 8 Feb 2019 13:14:24 +1100
Subject: [PATCH] Asoc: xlnx: fix up for snd_pcm_lib_preallocate_pages_for_a=
ll() API change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 sound/soc/xilinx/xlnx_formatter_pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_=
formatter_pcm.c
index 97177d35652e..dc8721f4f56b 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -536,10 +536,11 @@ static int xlnx_formatter_pcm_new(struct snd_soc_pcm_=
runtime *rtd)
 {
 	struct snd_soc_component *component =3D snd_soc_rtdcom_lookup(rtd,
 								    DRV_NAME);
-	return snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
+	snd_pcm_lib_preallocate_pages_for_all(rtd->pcm,
 			SNDRV_DMA_TYPE_DEV, component->dev,
 			xlnx_pcm_hardware.buffer_bytes_max,
 			xlnx_pcm_hardware.buffer_bytes_max);
+	return 0;
 }
=20
 static const struct snd_pcm_ops xlnx_formatter_pcm_ops =3D {
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/dC5s+7syQoLthq/0T6_91Yv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxc5u8ACgkQAVBC80lX
0GyUqgf9FAFNpFyJcXdLgAa2q8jefELz/jD6C/KUnQa9QvDGfHjitpEYgXVF7/65
4IOyrlP4Nx7s+u/6WzXhSRHQyuOwL46pQr7SjaYyZwEXD775Rf+y9iVNblSKKj+9
ZtI+k+Id5ql7XqUOIZMbaCyKAmhKqhVPdUrcXSTPzmtN/0Iq/6Gu7B4Pe1K+uvc8
2ohN1VhEmlo+JR8qJ4lVMEJZLGbTubTaCwbiw2EkvI1cBe0mNZN1mlu6B1371Snm
elJH5ULszcEzoZ9A1+RWagfA5ps1Hk3vIoQ6R+78IWPoLjXzSZZpaRGuMoAmgeVi
OqKzNbxSqjpEs0mbl/cf/+sG7hMP3A==
=4bUa
-----END PGP SIGNATURE-----

--Sig_/dC5s+7syQoLthq/0T6_91Yv--
