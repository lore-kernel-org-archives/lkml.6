Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190A6C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D431720818
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8T2AaZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfBFMd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:33:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36422 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfBFMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:33:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so7376803wrv.3;
        Wed, 06 Feb 2019 04:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+s1EmaK3oC+9seiiS52xOwx8uIjGJX026I3/pIjzUJ4=;
        b=p8T2AaZ1HDv3hQTkOtlVKQsuZYdHihiJ7I08BVe/yosecuJ/+1jLP59EsdqMdzGjkH
         OPf5g/zNwj4VVVWTi9fqmUL4RWYbY0CG3tNkD0HtkBXprbpUvFXUvHXxxmfXrbud055H
         RJqrhSwYRikoHlKh1tfVieumbLDFfAbC0uCTfRkz8EakIp5JoUK8lPxqw3t4cVbn378z
         mpuGeJif+2gtIGmqTy/D5wyxGEOt8L1l0huixvHHEesjZoLOGNTNAVj0HI8IDrag9nDj
         T+5v+lIgKUjg0Zkc+obm0jK9RhMYiKQWUgJdY7d9LWRg/fk+SXxUZ7wu2dBI/Ihb5H00
         RlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+s1EmaK3oC+9seiiS52xOwx8uIjGJX026I3/pIjzUJ4=;
        b=bfu9PP/YjKqKI54jhWWV0Q66XCwlhHI0isz8HhPa/tujet44WzU4lwAUYsmmEfNeGx
         ojIazAZNu3Go1B0zW+wir42urdtDAvSQD/vkJjQsr6e8pxIQHFJ2M7i5enRBPliSjNfW
         xovhjvR6k6XNryi+gll4XtOAjI5AQH1rSco4DfHwqNPb7WxLhCZnfESkdVYOogYupeXc
         4dqyxBt275yUrXscn1yfB0MVpQbL7T1yoEAldbbI3y+vSxuAL2KQl+dlZmknqpP/fN63
         Il35GTyNjDVEA07+eWL2wnl2Zllos7BQiYRYcVk/nHYUsZleFbKR2NQAdFfufSR1qbHX
         mH5g==
X-Gm-Message-State: AHQUAuYFnXk9q1AScTRjaQVBC5+B8RSnyWwDpRnHi/zTfKItRFuwXIG2
        asdSwqeJaEYEThvrfhpPxrNpU2OCHg0=
X-Google-Smtp-Source: AHgI3IbLFkwe8dup9RL0rdmSXaWOl335tkx/V+/4lB0wgJDMjzBsjnt6a9GZhsRC3X3aoLyVb98vEg==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr7569477wrs.290.1549456436744;
        Wed, 06 Feb 2019 04:33:56 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a187sm21428356wmf.33.2019.02.06.04.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 04:33:56 -0800 (PST)
Date:   Wed, 6 Feb 2019 13:33:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Joe Perches <joe@perches.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Zimmerman <pauldzim@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] r8169: Load MAC address from device tree if
 present
Message-ID: <20190206123355.GD21676@ulmo>
References: <20190206123018.24802-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20190206123018.24802-1-thierry.reding@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 01:30:17PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>=20
> If the system was booted using a device tree and if the device tree
> contains a MAC address, use it instead of reading one from the EEPROM.
> This is useful in situations where the EEPROM isn't properly programmed
> or where the firmware wants to override the existing MAC address.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Applies on net-next.
>=20
> Changes in v2:
> - rewrite error check for readability
> - initialize mac_addr array
>=20
>  drivers/net/ethernet/realtek/r8169.c | 36 ++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 13 deletions(-)

Sorry, I forgot to include Heiner's Reviewed-by tag here, but with any
luck patchwork will pick it up if I do this:

This patch previously:

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa1C8ACgkQ3SOs138+
s6GxWg//TDiJpd5gaQZNAade35NOyBX29QlimbE+xfLJmouURIPWzuqiDXllwYmV
W9BqFppWTIYgzC86aJsKCwEoG80Bbp1pRRlQH2EHY4JtB5OVWywRdEaoNTZ51t1A
8pIQdf13Fs3afcakEM6TQEqHnh9S1k3aR9GuWPIfj40kUw1ezvbeSJJUtMvYP+lg
ii9nETSpYjbMFd+A5DZYcyVU+0ngushVdidq8BW3O96l4mOfEVPluIDfJW5cADqh
PlCddHGH4cAbtX0X1U65SemzyYRM22dqsA/u/l6QB9zHVjujID6FPJVVFpHIJxoB
ffvEcQHR3K+7B6nlyrYn1/1swFxdIURhlYDIJsTUzQ8p2yVgh9UugALa6GeyXifT
Te0vzosuLU6tzrqSrlnnxyhbB5cBzU3KXDdYyrjGwHU0vExZk/9NqLjOCPRPzJR9
+6iCgj8QukckmOb65VLeRMC/6OF5qpJx0BuIdZSxdTkoJMNHmAhoBfGeg4Ce3ppf
ub6BjegIdwHhwu5gPaGinV8RK7wTH0cv2UHU6BEQQ8pQKYnTnhgEdtHGeST0/iMl
xNrqriRDIGweb8mk4eVb+Qr/rS87m6Wpvsi5qMhlQCx9i6CukwgsagQ55TQBmAMT
wwUr1JWgkbSIlnXJDIyd5/f0NFi9VdV19yrQMzm1HKT1wn8rVdc=
=61U5
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
