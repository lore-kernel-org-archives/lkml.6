Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57D0C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD2E20882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23PTGEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BD2E20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeGIQ6v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:58:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933207AbeGIQ6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:58:49 -0400
Received: by mail-wr1-f66.google.com with SMTP id s11-v6so11723915wra.13;
        Mon, 09 Jul 2018 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YjATzdLiK3ZBNCE24OPyjDJQUUgDxKryGHwOIDE7RRI=;
        b=E23PTGEdhqW+HG1qhNOToP5znBkOlRV9G1IuuT3/C4umizwpjyoVK+rpRyvbNf3kq1
         JWcNh9zyBepZLByh/TsoiBRRBogxb+GRqyEgpRfapgVWp5A0wGGERusgk7BTZEGRsZ8y
         JTOyiEn4kmmhxPrtA19Yxxv6eJZ26A8FsTYwpVh+ZWOsqDb1TrfJwz+fS8xfHOuMfYtC
         DLklYj12vss1j5K213sZG24jhrgftHOhjQekQrdf9Dxk0+89u0XmVJfYkZcaplnm8cvJ
         B6pdo+Tl9EZIzKVAUdAtuFm4/rzjLEWoChFfQ3jaZu/y+QqQ/RRKUQLtu10cMJfagwlO
         iybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YjATzdLiK3ZBNCE24OPyjDJQUUgDxKryGHwOIDE7RRI=;
        b=pCu74FdtBXh7YxS1sXCRFoDBObk4EChZOLYmhFlNcu6ZNO7WUUU/9WfBA4/nl8mN07
         5jwPQGTbNgqw8JUJUVZ6COhHJZovy4PlNQdFy3ApppJpqvIrk75VNoagxRkyT+w90Rfn
         psK2hxV8TpI7NzxM3IYS2Krcm6pHJY1cgdEA29HnmdEkK5ILPxUk7+4EQcHzISXzwM73
         RPrpOuyaI01gqemnktX4NjqBgPGLnoV1xTVsx8tRuM1/smUKPlnssjnmmEA6AOp+nkcl
         T3+bSyr3xUNR3J5j2zxVh7P7vcbEPbF3hVUCQG+4RT2HK4KjLsvjz5d5zwlHCIZrUAOZ
         G1dw==
X-Gm-Message-State: APt69E1H5Q+TUU0ipOwJC1nMCddIxF1jatF7mohGZdgqKWn601qCAa9i
        b0YZmwZbhQ1wwJ15Uq2vd750nQ==
X-Google-Smtp-Source: AAOMgpdirtbWpnBq48VAO21eTmied0mRYhwsHGzD1PUrWIgu+ZYRoo+ejFJdZHMVXLvr8D8YorAZHQ==
X-Received: by 2002:adf:a64d:: with SMTP id k71-v6mr14576958wrc.78.1531155528235;
        Mon, 09 Jul 2018 09:58:48 -0700 (PDT)
Received: from localhost (pD9E51B8F.dip0.t-ipconnect.de. [217.229.27.143])
        by smtp.gmail.com with ESMTPSA id s184-v6sm13283740wmf.5.2018.07.09.09.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 09:58:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:58:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vignesh R <vigneshr@ti.com>
Cc:     linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] pwm-tiehrpwm: fixes for disabling PWMs
Message-ID: <20180709165846.GC26651@ulmo>
References: <20180611060956.27999-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20180611060956.27999-1-vigneshr@ti.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 11, 2018 at 11:39:54AM +0530, Vignesh R wrote:
> EHRPWM has two PWM outputs. Currently with pwm-tiehrpwm driver, if PWMA
> is enabled and then disabled, and then PWMB is enabled, it is seen that
> PWMA turns on automatically. This series fixes the bug.
>=20
> Vignesh R (2):
>   pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
>   pwm: pwm-tiehrpwm: Fix disabling of output of PWMs
>=20
>  drivers/pwm/pwm-tiehrpwm.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Applied, thanks.

Thierry

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAltDlEYACgkQ3SOs138+
s6GPIxAAtvbBhGo4Kk614u3dQM6GF4zNASDL37o87buK0flh7zac0nvaVs0GV3De
P7BAj5Dir0zk03E4SwqWvM/Sg4ZVY/w/GP4oWWu7I9nWv6/KVmjg07fOhNuGZ3Cm
POnixN3GP80JBkD9HXK4uvtGAnaKGOZnWHyMfp+a9+oMDJdT7U3uocPAvFzpnrm3
QJjXOU8ETxLZzBU1Di/slXlcquzCyZmG0d2JFUco+sFy03FwQruSW4gy43CvscgI
1z7wSwBb3vEnPgzZi9ipFItDDhsntIPuWeaKdPuf5VEr+pOd/Yk6gIhJAqMaLyrD
W/jzSRortAb4qiZBT/SPYE73ST+z99Hy24LlSHe8B6u0gVzCM9nVKwGbWvlV2lHd
43eLelo3jlACFVVoIdrBUle5pWDoJKBqeYRFG339nKuTP3/WJkBsAx3qUmAM8vJ6
U9I+/UvACNXbo6g64udicy8oZNeHAAyqcRXRoNxjaWuwZKxbQtOh5j7Reom64ee0
+Ul4gEIGcKkXXlmVhHuiA6+Ced5ST76cGf5Bg6VpeZzZ8Wmc2spdTxuicSul5dn9
ctQM4fLbDDNdUCTkJh5zq7MDw/e+uVYfBXGApaQskzHI3Io+9QnAK7bTqkD8rEAz
hbkvsxroglzqbj5xa8XCS7w/QMxUYeIkvEZN5FVUOLUpIdXHbVM=
=ZWzG
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
