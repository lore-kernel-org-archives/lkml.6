Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701EC20855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 02:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Sy7rzP+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfBAClt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 21:41:49 -0500
Received: from ozlabs.org ([203.11.71.1]:44819 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfBAClt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 21:41:49 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43rLwB6tXpz9s9G;
        Fri,  1 Feb 2019 13:41:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548988907;
        bh=H9z0j9CFWkso4P66eHJ815nyGci0xrfG3LXjZ28lK1g=;
        h=Date:From:To:Cc:Subject:From;
        b=Sy7rzP+38SLyVVaaGq5k/h0hYBFQXne4dQHxfkqmVrb0484/QqemHFfyD+X3i3xwx
         78MDW+ZRzonPLM0PQAOSAWz9TuRbX7T29UUkuT7Cmm2zjOxGcSIbkktgWs1x+FVicx
         vkKF94iPLhE8SYJX2pMbYAgAsHG8/LRTWTXvsXh6QIuiae/Fcvv253ZBy7yhELv4P3
         meaByTedMOBVS6a9dQyG7v6TR5R2kFxkurTIdJMUymYwwT6RaUyejRTVivMSNdWdLj
         qwlxle/GjjfXsPnrxK8BA2stlvApZLi08kypw1bJ7cqOVSMzIEh0Rj/AM2vkRmxRys
         FyGGSHPpod8+g==
Date:   Fri, 1 Feb 2019 13:41:46 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Gong <richard.gong@intel.com>
Subject: linux-next: build failure after merge of the driver-core tree
Message-ID: <20190201134146.0bfd5ba0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lmUdlu=jNXJPqEDeJ+DeG3j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lmUdlu=jNXJPqEDeJ+DeG3j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Greg,

After merging the driver-core tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "__arm_smccc_hvc" [drivers/firmware/stratix10-svc.ko] undefined!
ERROR: "__arm_smccc_smc" [drivers/firmware/stratix10-svc.ko] undefined!

Exposed by commit

  095ff29d2b88 ("firmware: intel_stratix10_service: add hardware dependency=
")

I have added the following partial revert for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 1 Feb 2019 13:37:59 +1100
Subject: [PATCH] firmware: intel_stratix10_service: remove COMPILE_TEST

This does not build yet ...

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/firmware/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 7e5491aed5c8..cac16c4b0df3 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
=20
 config INTEL_STRATIX10_SERVICE
 	tristate "Intel Stratix10 Service Layer"
-	depends on (ARCH_STRATIX10 && HAVE_ARM_SMCCC) || COMPILE_TEST
+	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
 	default n
 	help
 	  Intel Stratix10 service layer runs at privileged exception level,
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lmUdlu=jNXJPqEDeJ+DeG3j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxTseoACgkQAVBC80lX
0GyNlggAjvyfwfqu/vDXDZ4bD8SrzOP0wIDWi+xujMJPplSrmMXk8VijnxS0fmOF
rXxcBikI0GVgUi+g6yVTkwmxtkXk3AwloLf68HUM7tW96bLFJf8XmX8jkAULdQ5j
CJ6rYo09oyK3kQIM40I/2zYd+jX9RdDmhn7UEq+RPiEkBB/GDnGIYLX4Nf26YtxA
HW1qbnxPiVbz9z9YgcPYua4bhtpeDApkvQgc5q9kkQ28qHDg2i7TCgUD4JJ5DqHN
RuSNWe//4iAbVogQMEQ4hxfQc9upDqaBkQM0yaKW6Aof7o7LVtNhwtAFFXmXWo5p
vDb+07OnWWZa8kCVbchj1+8QhBlk5Q==
=VwrN
-----END PGP SIGNATURE-----

--Sig_/lmUdlu=jNXJPqEDeJ+DeG3j--
