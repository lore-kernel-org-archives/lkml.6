Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D71C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A33E2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 06:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s+l8KSY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfALGB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 01:01:28 -0500
Received: from ozlabs.org ([203.11.71.1]:58671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfALGB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 01:01:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43c8Hm3p4Vz9sCr;
        Sat, 12 Jan 2019 17:01:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547272884;
        bh=jRZhsgr44w2nxvj/el0IInVpBaRFklLMS55ewRbFJIA=;
        h=Date:From:To:Cc:Subject:From;
        b=s+l8KSY0rG7pOiNjZgBu+S6fzny3vbdaMJLMtNSR2BD8lO6rPVrGr13MJpzoMs/1f
         3Va3x2F/UwSb5U97P/55PLn8KPrbs97QeZprqpTLOeNZssz8DgGkIdbWh3oN1aHLAc
         URcCiWqLRzaQpglyxJKvQr2OHfExrnQ1UD9NIkEQtJCJ8FbHRFnV9Yb3xPyy0N5M4u
         SqkgWMJ6NC6ihZoOLEbGx65O7ScogWMFVBiMOJSfuXUAVY6RGKcRkRaDgKBbB7B0Al
         7T4XBB48yqnSbzS+DTDA/aQUmx3fu1OqF1d4A6evcs5Cnt21VkUK0Cpl/GSMBshB1o
         H+VOt8eUZoyRQ==
Date:   Sat, 12 Jan 2019 17:01:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: build failure after merge of the pwm tree
Message-ID: <20190112170117.0d4674fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZESKFcVIB9NPtY2Bj7f7hPG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZESKFcVIB9NPtY2Bj7f7hPG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Reported by "kernelci.org bot" <bot@kernelci.org>]

After merging the pwm tree, today's linux-next build (arm64-allmodconfig)
failed like this:

In file included from drivers/pwm/pwm-imx27.c:15:
drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared here (no=
t in a function); did you mean 'pwm_imx27_dt_ids'?
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
                         ^~~~~~~~~~~~~~
include/linux/module.h:213:15: note: in definition of macro 'MODULE_DEVICE_=
TABLE'
 extern typeof(name) __mod_##type##__##name##_device_table  \
               ^~~~
include/linux/module.h:213:21: error: '__mod_of__imx_pwm_dt_ids_device_tabl=
e' aliased to undefined symbol 'imx_pwm_dt_ids'
 extern typeof(name) __mod_##type##__##name##_device_table  \
                     ^~~~~~
drivers/pwm/pwm-imx27.c:292:1: note: in expansion of macro 'MODULE_DEVICE_T=
ABLE'
 MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);

Caused by commit

  5a309d380019 ("pwm: imx: Split into two drivers")

--=20
Cheers,
Stephen Rothwell

--Sig_/ZESKFcVIB9NPtY2Bj7f7hPG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw5gq0ACgkQAVBC80lX
0Gz+egf/WgHT/1rkRA3fJKK47K3izXK8iIuwLl1jaulPBkhFXVTt55oKXhgtxbOZ
wHpdFXQ15cTLgQgG85E7jtSK5E5jzhZtnvilos8sfU6sKvmwGcGhU7PB1TW2H3y9
lQZUuY/TJ/tt/6TCWtJA49MObpZeJqpinzuyb6Ig986sX5raOEBPq1WV8z/kAo4w
1GTdByZuzjiaJkb7FQySQI3osn9L1DFyoR/szAoST010HXchgui2BqM1Mo2YIbPf
SfpXGG0BLi84HAjVic8OgOXO3T2dE7WaglNOONio+ODI1HlDGCfLOj63Hbog1J3e
gyOfFwpM6aEAxvdLAQb301NcAAMunw==
=MDwn
-----END PGP SIGNATURE-----

--Sig_/ZESKFcVIB9NPtY2Bj7f7hPG--
