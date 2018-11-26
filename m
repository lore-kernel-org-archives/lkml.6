Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B46F20862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 15:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQmdsfac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B46F20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbeK0C2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:28:50 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36735 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0C2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 21:28:50 -0500
Received: by mail-ed1-f65.google.com with SMTP id f23so16223745edb.3;
        Mon, 26 Nov 2018 07:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jVvvSlcDW1rccwafybYx7K4mL+Q61eyXYRbJr4hiI0E=;
        b=iQmdsfacT9ox7RUgyDg3TtMjkgaENUWQREXsl+yOUP6kS50rpu1XiTx9bn3M/Lv4O4
         2dkeMCyQZzvBPGH32mtyWP0izZTz2S6U1qv5RZgrpeZf0ZYer2TrLvBHwxhOCXI1k9F3
         grkeXgW1DqPMMNAKmq8iH1u+FzHrI1gcnT1FEKC6YwfVO0RojlvfTJIXkReQ7yI/pQAl
         tYQPJDmLfGjp6nWTKljUO05A7pDGHjQEdrJWsj+50Wi8qd5v0iKeaYNizt8J98C9lSj1
         2aWSB0ap5fXf14G5L6OGSAGgX6B0xcGZXUa8vVDO5cE3bC/BZq+2UVpCrBxxdj/gbCyo
         wLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jVvvSlcDW1rccwafybYx7K4mL+Q61eyXYRbJr4hiI0E=;
        b=pACMowCpCz0hsNgaguf9Y+nOAFpIqYXLLfKioG0ykxTzfHaavm7aDt9/NlnvKQToYD
         BMwrD8z2qBzaIITHvYyyQZ22PqkTd9qjCnOUTBFUORpQXpxWIv2QTgO8BmaFEX7YYpR9
         f3yAxSIxzUvnBDZJOHX5Ygm2GTpAAdHCdcsy78GXDDnsz9ddZhcuKNUrZeHlaoHDK8wR
         Pg4O+M3JRRDBQ74VDWA4xwReBr29+2vIZ6utY6gTUHBg45T2IbuyHlefA6xJjNNotXGx
         WBGUObZoL2wQgT42cQUn7shrUOEVaSlJe4EEeEjYNC3AVcvEjZki+xZcU76E0lH8oHP+
         J4Kg==
X-Gm-Message-State: AA+aEWa5irZaZuOyrJgiYRjk9/y9I91sXnughfTRqqbnCaxU9TGmBKeh
        q4BJzJk0U896rzw3gizLik4eaQ/b
X-Google-Smtp-Source: AFSGD/VZ+ljIxOtr5OXzqt4aZMe8R+iuF1xCgMuofGsWIq9+yhE5zG4Ug/iABLSbCO5yBORcrlEBOg==
X-Received: by 2002:aa7:da48:: with SMTP id w8mr14026971eds.54.1543246461315;
        Mon, 26 Nov 2018 07:34:21 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c11-v6sm146882ejm.67.2018.11.26.07.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:34:20 -0800 (PST)
Date:   Mon, 26 Nov 2018 16:34:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jose Abreu <jose.abreu@synopsys.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: Move debugfs init/exit to
 ->probe()/->remove()
Message-ID: <20181126153419.GD19710@ulmo>
References: <20181123122122.18957-1-thierry.reding@gmail.com>
 <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
In-Reply-To: <9c8443aa-edaa-2398-bdd8-df49f2529cb6@synopsys.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 12:44:02PM +0000, Jose Abreu wrote:
> On 23-11-2018 12:21, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Setting up and tearing down debugfs is current unbalanced, as seen by
> > this error during resume from suspend:
> >
> >     [  752.134067] dwc-eth-dwmac 2490000.ethernet eth0: ERROR failed to=
 create debugfs directory
> >     [  752.134347] dwc-eth-dwmac 2490000.ethernet eth0: stmmac_hw_setup=
: failed debugFS registration
> >
> > The imbalance happens because the driver creates the debugfs hierarchy
> > when the device is opened and tears it down when the device is closed.
> > There's little gain in that, and it could be argued that it is even
> > surprising because it's not usually done for other devices. Fix the
> > imbalance by moving the debugfs creation and teardown to the driver's
> > ->probe() and ->remove() implementations instead.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >
>=20
> Did you test trying to dump "descriptors_status" file when
> interface is not open ? I think that's the main reason why this
> is not in probe ...

Indeed, that seems to cause a hang. Still, it doesn't sound like the
right things to repeatedly create and remove debugfs files just because
we can't provide the contents when the device is down.

How about we return an empty file or an error code instead when the
interface is down?

Thierry

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlv8EnsACgkQ3SOs138+
s6Fb6A//Z2w00B6tsi06+/dvF5NfOBe1/Qe584yHpemrWRQouopxgAxuzUsQ9DkT
ctl5xyuWtoGlpgKJiuOsfFC6/NtbvB104tZ/1P1TSrOqoYKOBZu9TO9dD/kkrEZP
f/Q8qHbqlkbaCz9stdxwzgLQGiUKYq2oOJ9BFmH3Nq73s6VxJtiDc46B5hgNNUwR
sInUnW6eXZSyXidQoNwOjAukXO5OGvE6ALPlBmd3dcQjRRo0OiqB/8NLYhbflcBc
/Pac0Lyr8xOm9ZdhFWB9k9TxYjDkHdaMREVkmGPkOjcr7I3GYqP8928fILd0Mell
pirV6jstA+MiUmELZMyyCnbHPiQ/pj2CY12mmfs6FfYSEF/5vyEpE1rUGKSqhC4r
GJ7E31zWMlP8aOdUfY042BRwAgBuPCSEZFt5GHzfDVt0GqR9AQZi01flfnRUMmrL
TdrJOc1MlNOrGasihTd4NSw8SbuwB+R5UYHEmX7rmlDlXQuWGmB0baCGePOpbYjZ
5uNc4WfA8k7v2gTlW6G+6RuPEAYZHdNtF0W2csZBPm5fJbKPZVOmDwqjwmFwiui6
O+VRu/NhQq5mqRAtCRXaxYrAKkTejABTKTHhIq1EAr+QzVRNZlofV8k8FSGHpWzg
uiTiy1+1GmYa1RiFIclPTruwaNEcEkrjUex3tuZVfy93bUrNP1s=
=T5F5
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--
