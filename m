Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55599C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D6A2082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 23:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="aA9pjgwK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbeLPXA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:00:56 -0500
Received: from ozlabs.org ([203.11.71.1]:48063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730772AbeLPXA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 18:00:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43J0BY3Y1Dz9sD4;
        Mon, 17 Dec 2018 10:00:53 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1545001253;
        bh=Eg1LDCJuiycr+IJ1tTYlJ0JnuID5/I8C2ecxcy3sDgQ=;
        h=Date:From:To:Cc:Subject:From;
        b=aA9pjgwKPcggeH2HBbXOSu3ax12TQi2tYpN0VUoW5bQupX5S7JUnleVpSlZJdAX+K
         vNe6pQO+VdLGi7aciJ2N9T31GUGkXwjhU7oJ9lj840WMv7YDENMFzZxN57qkxgsSwr
         RygI/met5FVonoiXv16EfCXYcYIt5u2f8m0Swsj8g2NPvWQe2mevQNUEaTaBSFhZJE
         uu6X0pSu870YVfWPFB/JhXJsfL1ZCOVm3bu7SSd/fB8DRjrFKomx5cKwbor77A1ygN
         NDIXCZm7tg0yKsn86m1XprwMWfctYrdK+KA7EB2zesTJi+Xyhs+WGzgaJd9oCcCThb
         NfMRtMjYXWaTQ==
Date:   Mon, 17 Dec 2018 10:00:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: linux-next: build failure after merge of the hwmon-staging tree
Message-ID: <20181217100026.03438bcf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dzd9M8gZrQuqUT0Elw5Dp=U"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dzd9M8gZrQuqUT0Elw5Dp=U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

After merging the hwmon-staging tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/hwmon/Kconfig:1298:warning: ignoring unsupported character '/'
drivers/hwmon/Kconfig:1299: syntax error
drivers/hwmon/Kconfig:1298:warning: ignoring unsupported character '/'
drivers/hwmon/Kconfig:1298:warning: ignoring unsupported character '/'
drivers/hwmon/Kconfig:1298: invalid statement

Caused by commit

  de75c2156b2f ("hwmon: Add On-Chip Controller (OCC) hwmon driver")

interacting with updates to the kconfig system.

I have applied the following merge fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 17 Dec 2018 09:50:14 +1100
Subject: [PATCH] hwmon: quote the path in Kconfig source statements

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/hwmon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 62b68cd280dc..6f929bfa9fcd 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1295,7 +1295,7 @@ config SENSORS_NSA320
 	  This driver can also be built as a module. If so, the module
 	  will be called nsa320-hwmon.
=20
-source drivers/hwmon/occ/Kconfig
+source "drivers/hwmon/occ/Kconfig"
=20
 config SENSORS_PCF8591
 	tristate "Philips PCF8591 ADC/DAC"
--=20
2.19.1

--=20
Cheers,
Stephen Rothwell

--Sig_/dzd9M8gZrQuqUT0Elw5Dp=U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwW2QoACgkQAVBC80lX
0Gw/Qwf+N07HzHYu832boHvaSVadC7IutAx3CZa2PkZSNY8iGfEfHPHdqN/nVTk+
J7DvXuj7/p8/T4w8xty2hTVUzmYJhMwgh+DZkc0TQ0DccVTHRcc3Xdrx2zIY/hT4
oq5tYesPIj9bgvyxZ23i+ffmrikG6V+4Q+k45uRrpaWg71u7zMx0dVP1YGwFYkiy
/Nie8dU33rhNIncv3S2TUeyuDlM/C94BZyK+eZvwjWMXJajJL81/ayAsMSl7immL
x0ckeLRj83GWg4mN7EN4faLWt+pQLMDexeAHyROLUphQPb9MXjuVepk/R9rN0TRn
vHZCbgFdgqEhaHj0dPhL5N0u+kjvFQ==
=nlrm
-----END PGP SIGNATURE-----

--Sig_/dzd9M8gZrQuqUT0Elw5Dp=U--
