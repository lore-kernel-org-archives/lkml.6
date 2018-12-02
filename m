Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6617AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C9F20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b7tjqRIE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C9F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725810AbeLBW0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 17:26:31 -0500
Received: from ozlabs.org ([203.11.71.1]:46225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbeLBW0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 17:26:31 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 437N5H1Djzz9s47;
        Mon,  3 Dec 2018 09:26:27 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543789587;
        bh=7ZuWb/iry3L60djYiiSGpAf7zGKhe7yQxwKzjQNk/y8=;
        h=Date:From:To:Cc:Subject:From;
        b=b7tjqRIETwIID+PvFXyhSwea1CprhD6zPs0GuRHigcguv+AKy1uiL+BqooeQZwfq9
         36kwDyeSeQeX3+IqTAmOL0oI0vLfAW7m43JsEwUvu5fIniqYxW2REoE+vqm/iS1Qhl
         exXzHlFl5xB27pjv7uKPOUTx62u1VT6vvU+xRu566oeBh8QTn7mhNm5x113sAU0bVL
         bG33kxlkTcX0O5in+sEfJ9mPDiclUuq3lwqC01mlcl4SD38JZUeR52HXuPya8KoQJ/
         /kiTyKjB9UhGLbHOUbtHPrG3RdsIfapQlr2UbcVq0710PN8I9kV/uRoPGppkYHSYc/
         izWGEpc5/2Yzw==
Date:   Mon, 3 Dec 2018 09:26:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOp?= =?UTF-8?B?cm9u?= 
        <peron.clem@gmail.com>, Dinh Nguyen <dinguyen@kernel.org>
Subject: linux-next: manual merge of the reset tree with the arm-soc tree
Message-ID: <20181203092626.7f1ab2f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/6+JRWsYlHtqSZBx10FeT+8L"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6+JRWsYlHtqSZBx10FeT+8L
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Philipp,

Today's linux-next merge of the reset tree got a conflict in:

  arch/arm/mach-socfpga/socfpga.c

between commit:

  8f6f8c77fc4d ("reset: socfpga: add an early reset driver for SoCFPGA")

from the arm-soc tree and commit:

  48e2bab90d8e ("ARM: socfpga: Clean unused functions")

from the reset tree.

Note that it is generally a bad idea to declare extern functions in c
files ... the declaration should be in some header file that is included
by the files containing the definition and usage.  That would
have also removed the need for the forward declaration in
drivers/reset/reset-socfpga.c.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-socfpga/socfpga.c
index 5fb6f79059a8,cc64576c102b..000000000000
--- a/arch/arm/mach-socfpga/socfpga.c
+++ b/arch/arm/mach-socfpga/socfpga.c
@@@ -32,7 -32,9 +32,9 @@@ void __iomem *rst_manager_base_addr
  void __iomem *sdr_ctl_base_addr;
  unsigned long socfpga_cpu1start_addr;
 =20
+ extern void __init socfpga_reset_init(void);
+=20
 -void __init socfpga_sysmgr_init(void)
 +static void __init socfpga_sysmgr_init(void)
  {
  	struct device_node *np;
 =20

--Sig_/6+JRWsYlHtqSZBx10FeT+8L
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwEXBIACgkQAVBC80lX
0GwlFwf/ZvuY4YXQnBH4c26EhsKjK5qLAR1or+i2kALicm5U3PfoIbwJHkq6wmL+
BzutVSJYd+a1LMVdbOV3ayY4bu4In5GuSmsKC35vBqGF9TY8ORZde1hZalIcsG5A
AMQEr7bbhnTWC+L0RFx6lE3NLShh4VzGLAXlT7sxTzlR7sEUYMexIhFFpPQSgMII
neYawUX2PROpF/+9BbVMKhxIDS0Lgsm8Y6ujiTbeCqoHGrobTnY5R0lTBUV8NL18
hOYUGrSPO38E3t8aC1K6jwHFGb1fWJ1cc4HK1Vn/H92HEuP12boqZjbClNfMOMek
bbcxbNO75piJCDp+O5ndgyzKKKD3og==
=F0UW
-----END PGP SIGNATURE-----

--Sig_/6+JRWsYlHtqSZBx10FeT+8L--
