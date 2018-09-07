Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AB0C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6DA20861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oywnkJRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6DA20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbeIGFfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:35:25 -0400
Received: from ozlabs.org ([203.11.71.1]:51281 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729830AbeIGFfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:35:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 425zYM3C6fz9s3x;
        Fri,  7 Sep 2018 10:57:11 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536281831;
        bh=2qmV/bqGbJuRaI6gcYqjaO6CaXbVDQRm8EiHCgvXf/s=;
        h=Date:From:To:Cc:Subject:From;
        b=oywnkJRSaxOteVMSAHof6hBqJ9ur6HntIm8kvj4M36NNMjB+mSjqGxOy1PGZbaT1b
         5jk20lRY1EcYGDWfEt+CLkrci8ZGiZ5W0kZLc0Hbbz2eNfVeL5beLi9weXmNk5JaqA
         oUEm/E6sXZN4ffi2GriOVooly/+13YapDJD90FYMSADe2bSNWaaqwbUmUBIM8BUI/t
         IPA1GPj9QEs1v+InQdFe/9gU9g5r3O/9NUAQ1pra9vnG0UCc/nQaRVE8GTzjl+znY7
         WFicDY8dUyeWknS2PUIPXzK3v0e1WlLE6mnALs172ij7DhNffkQB/mfob19iavKSNe
         fj8rdLc0Am7Sw==
Date:   Fri, 7 Sep 2018 10:57:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20180907105710.7ac48267@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/XTd5dFCzM44jrC1EFWZzrq8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XTd5dFCzM44jrC1EFWZzrq8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

sound/soc/soc-dapm.c: In function 'snd_soc_dai_link_event':
sound/soc/soc-dapm.c:3771:9: warning: 'ret' may be used uninitialized in th=
is function [-Wmaybe-uninitialized]
  return ret;
         ^~~

This looks like a (subtle) false positive. You have to assume that all
the loops will be executed at least once.

Probably introduced by commit

  4a75aae17b2a ("ASoC: dapm: Add support for multi-CODEC CODEC to CODEC lin=
ks")

--=20
Cheers,
Stephen Rothwell

--Sig_/XTd5dFCzM44jrC1EFWZzrq8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluRzOYACgkQAVBC80lX
0GwMUQgAg39mQjGval79/rsMqYOB/RXO6ah/nwZDsBzOb83J0Lu8gOlUEI91Dt/v
9jsd1+Qw11QKa2+aF0hD6gsVuhoG6D8GNha19bh79+QG8xsir8zZamTExPtzhi7i
saQD5WHZBjtjQwagF42XewbGXmsd9lblHhw6LlF5CKKZJf57/VaAnvhjUq3fHTyk
vWQ6znLFSzD7SGtjOiSANGG9QDwQcpdg9NPU0bzxtRyyg9Hm2aFK3j+oVXEY6tuI
OMZh5Ox2Awq1e8qqSlxnh5GM34f/u7IsSbnDDy6ReRlNljpyKh+Dx/b6o7WADbvb
2l9C/ulImsQkmaBkEJVSS9l1ArosWg==
=kq7a
-----END PGP SIGNATURE-----

--Sig_/XTd5dFCzM44jrC1EFWZzrq8--
