Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998F4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B75206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z489OqK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfAJH7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:59:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38784 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbfAJH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:59:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so10211702wrw.5;
        Wed, 09 Jan 2019 23:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wszGA2v3AoII9Q+xJf3Qvz06bsNcxHDgeUx0b4oBp8E=;
        b=Z489OqK81WADI1yIOpwMu7UwBtVBqDrhmrSHYzHD+gYXymEediyzz0yV8KdNTeK6F4
         aEjg1GIcslxhF+YO3lO6RtoFOcc51dI19+nqbEUQM06F0gVzkVD0vnOuYHF9yL1J5xnE
         g9xUVMfbh6HzabgtLYidTi1IWxh+qeHttx9uEZZMOFxrNsESnsP3L34sZYGDhRF8lkRF
         SM+pfr/EQrojcQdL0dRzUkB4MWqlEd6GNsNipHDqT/Rz7Jc5Qquu7MrwODehr611bu/x
         PkouYm+3E5PyyCXOBoOcC/8j7GUPZ5k92NjeZJBM6evzAzQIFmgHaBy1bd+tMhoH3DeZ
         yMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wszGA2v3AoII9Q+xJf3Qvz06bsNcxHDgeUx0b4oBp8E=;
        b=VNrVz3JdcY2a8vl//AnsvzekT9HTvGT1JOaDadwgQt+ASTkU0Tag/qUpR0FBBzdHOs
         vAo1SotPUahtBWmx+xCj+kIdHJ6KGVVL1mcDRCeB1RpC6PyO/+5CqfUtqOzy1RJSyEGI
         NwmC9Qgag9xipf4N0rMYF3sgo1SMdOHmFOirRIdvt1Gj40FV5tcw9WWNUMYxYVxMgtQe
         J1F3DCYb+0BHy2PEHa3peVEalKVYukwiTKwnyOfgNc0vX8gni8TW0nE+BQ/zE+HbJvRd
         bLrldlOk+bUwvG8ME+Icz27xV3wYbgn6ITCIkYBWrlGhDu6K7OGLjKNo13RRM1XwGIby
         BVuA==
X-Gm-Message-State: AJcUukcbSNg9Si7/KVDSyV88b/WrvV3+vure28+Z88Wtn8ONX6+znKfS
        yPJNfUbDnDhWfeXsearVTh5nAgL+
X-Google-Smtp-Source: ALg8bN7GpFBv4zgGjAV3yVWB0/dpEeNzj6NiYdrA9dZlpEwZ6RGQlyHnMNI+h4IBCg7G7H6ObbDuRg==
X-Received: by 2002:adf:d089:: with SMTP id y9mr8119667wrh.22.1547107168478;
        Wed, 09 Jan 2019 23:59:28 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id y34sm167415663wrd.68.2019.01.09.23.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 23:59:27 -0800 (PST)
Date:   Thu, 10 Jan 2019 08:59:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V5] i2c: tegra: Fix Maximum transfer size
Message-ID: <20190110075926.GA5213@ulmo>
References: <1546984750-26199-1-git-send-email-skomatineni@nvidia.com>
 <1546984750-26199-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <1546984750-26199-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 01:59:10PM -0800, Sowjanya Komatineni wrote:
> Tegra194 supports maximum 64K Bytes transfer per packet.
> Tegra186 and prior supports maximum 4K Bytes transfer per packet.
>=20
> This patch fixes this payload difference between Tegra194 and prior
> tegra chipsets using separate i2c_adapter_quirks.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/i2c/busses/i2c-tegra.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw2+1sACgkQ3SOs138+
s6HGZw/+OgrH0vkohH4q9BiATVC4SuZlLfhPt6G2C+/w2Ziuqh+F9ek1ByxxQRM3
rcP+YO76giKzcUSOnyglp0OVRAY0JLGetrk2ejlynC6g1thykq68rfflLZzEGNlG
auYJcAFLUuDpvpB8cynuSJUtX9S8dj/PUYuIGWEYrupYVSpNGqrWfd8AXhcUdO2N
O0gDtKLvVAtoieFks0xOFqoYxxYIaFndyAw+J/8GsJggKjkF7hPUS8gP9A0dSCVR
p3wumVhB+znWZEHH1Ya37vKIUbzbKQuFqxOY2JKW+7uNMmQ9MrCPRMidbUqhRB+y
DGfBl9J0SW4ng/9/Gce8f7GddXYQFH9E3cgUA1v9RjdcRstvqvnrci4HofATo8a3
TJftImGwgCgAsBzwruYVuotmDYmDX0gz3MWDzaI0ULDx+CR7WVnp+A45WhLefmxv
nvx6iQFhUwPLzVAbStqaLPF4L4aTgJWGZEaWkhwaHsPUs49SzqWHB+HEzZRh+naU
QWMsPS4bU3U1aHo87TIixUdoZysLiWLJxxg2mEIRWU+zM0Dw1K6rEPW0qMhYq4EV
xM+PXBg6zDLPdtGM2w55DfTSYtqBc54kfwY15xbZxkRBtbbs9yQyIsY7e/tvziyn
GSgi4B4A3CD1TTWvaXHtQM9TaMbbvHTvh6OFJPsJZ1xZr+SoE8Q=
=x4d3
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
