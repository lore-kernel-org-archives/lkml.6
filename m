Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0EEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A732186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VczqOWh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbeLTRfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:35:47 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:45008 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730195AbeLTRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:35:46 -0500
Received: by mail-ed1-f48.google.com with SMTP id y56so2413266edd.11;
        Thu, 20 Dec 2018 09:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aK2bTyKBxsYyfzCCKbtgvfu4UIYri9mPzx3HKzy3sh0=;
        b=VczqOWh1kKYBJrLH8gMmhTsP4H/UPkjlLO0n526qyDdjFw02foNw/HmiM/dSfDA0lb
         VuMPXJGV1KYOOEDVyKKo8/exA5PKdFkdvw5xN8eDsbRifeObdjE3SctIbhUUfTKiE+ya
         dZwD737faPztCz1uzHgI1QEb5THRoVW7nCfCDmRXR9hxCeegrDCzYt5A3Dh++mAjpBHW
         om1MsOuinUsc4uzCN7hwyy2zPM0zy63cPgAQepTDhux0qK6ZPYKJuapf67CCxklU2KmU
         4oREq1rXxiPX3D/5jxG/8WW7lXME+d+yq4aClnXW3YXIBsxLluXnni545xMqAN3ErKvG
         SQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aK2bTyKBxsYyfzCCKbtgvfu4UIYri9mPzx3HKzy3sh0=;
        b=FO5BEIZ9P5PDgKkLu4cbH62ILXx96UR+tpxQg+LFceW7+oDRbkSIUoO91PVbPrxp0+
         oRqyxhq8cl1AQ37uP0DatMLFbDdYumHRNZvHCieudnqMPmXOSw94aWQgjnXKbmIAaKr8
         SZ77RsqCTj7PijEn1L5qNcecQ7nj8X7R6U3MSrtkTwAwHVQutSz5TWaVuLV/39apT/pm
         FDS3FdU/Bnctd9pkTNHXxbdPcFPJ4MVRmndT8mvnu4S+5pQOMPUZfmtL7fhjUhAh/OaW
         gJwSSZ6Y6NQWzeZDnk4pmhiQwhB0nKXSJPTafNxjFOD0O9Hegfmob6FRmJM8zbbmWu+I
         RyDA==
X-Gm-Message-State: AA+aEWY8IreXgErHHRggc81gE2Z4P5fK+jxXDe/aLWhRDuLBU5YdeWQ3
        BFjLOn8i9gEGAGC4Dkkwye4=
X-Google-Smtp-Source: AFSGD/VCUSJrOVEInpMiVQwqGcva/cb6GwHYpg4N2G9jZL+4V3QxsYNoWol29MzTi/jUdFyyDRHgoA==
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17-v6mr20058711ejb.70.1545327343601;
        Thu, 20 Dec 2018 09:35:43 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id w10sm6270019eda.77.2018.12.20.09.35.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:35:42 -0800 (PST)
Date:   Thu, 20 Dec 2018 18:35:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: rcar: Add r8a774c0 support
Message-ID: <20181220173541.GD9408@ulmo>
References: <1544732415-6453-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <1544732415-6453-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 08:20:15PM +0000, Fabrizio Castro wrote:
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwb0u0ACgkQ3SOs138+
s6FQhRAAvoEK4Rspkrhlv3RNMJxy8x59HXTbQznabwS3vEN7KaH7XRSXlUtMwUHr
c/Fpv2ZZEGxne/HJ95iRtv0FJaO0HHfKZnI10ZDFhEHYmzE3+C6ZSPGSO7Xt4vbk
StUHJElLKbFU4eKHVNZ4knlGWkzT4BwF+kkpYlvGtQe2VI5RFtrfUiDDvIi/4fwk
8UOjX471jvhgv1Pfe26vaUCaCXZafLJ0IODmv4ANMRVBvZS9lJGw6BnJia4bUmri
du8bsAxNH7Uwp0CeBV5yQ121mYfmyw7DJiETmtQM4DEZm/XuuqHDSWhVuXs4YLAD
SA+/uWQNVcrFi8MOhRADb3qv/4Tl3Mtl39zo8MJzjyI2RWaYvYU1tzkMmGGDBOmE
9IOpshllwPxKZol0zSJgoD9XzA1juloZ0uYPs/DlA9R/RAt0inKzMA9cljaXQJWQ
mUAhCV7wSlZktxT1/aE7nxzgWCH8AxRCKwmeFbIxO6u9QeoDSIAGLl2W7EAio+2L
4xFNLK1kSi3/JSojlWLw53oihFwr1Ow2LFyQqxa0RhJC0xQk73PMKhMbonDiCz7t
4Iny50fcI/Byt5UbXKOgIDFM/L/P4o2ed3jork52YWhVVRCJrztM8KCSiz0Wf4vi
P+IeQ0ous7IS9hU9SXXAIyZUUiNzd7Lwbt+9CbpaHyqQdK2DVQc=
=oJgK
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
