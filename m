Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeE3Mdi (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:33:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:12166 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbeE3Mdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:33:37 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,460,1520924400";
   d="asc'?scan'208";a="45384911"
From: Felipe Balbi <balbi@kernel.org>
To: Roger Quadros <rogerq@ti.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/2] usb: dwc3: of_simple: don't call pm_runtime_set_active()
In-Reply-To: <1527518174-27860-2-git-send-email-rogerq@ti.com>
References: <1527518174-27860-1-git-send-email-rogerq@ti.com> <1527518174-27860-2-git-send-email-rogerq@ti.com>
Date: Wed, 30 May 2018 15:31:41 +0300
Message-ID: <87k1rlcok2.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Roger Quadros <rogerq@ti.com> writes:

> Don't call pm_runtime_set_active() as it will prevent the device
> from being activated in the next pm_runtime_get_sync() call.
>
> Also call pm_runtime_get_sync() before of_platform_populate().
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>

This patch is wrong.

> ---
>  drivers/usb/dwc3/dwc3-of-simple.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of=
-simple.c
> index e98d221..2cbb5c0 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -121,6 +121,9 @@ static int dwc3_of_simple_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		goto err_resetc_assert;
>=20=20
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);

No, this is the wrong way to do things. My device should be enabled
already from probe, specially since I have already enabled clocks.

>  	ret =3D of_platform_populate(np, NULL, NULL, dev);
>  	if (ret) {
>  		for (i =3D 0; i < simple->num_clocks; i++) {
> @@ -131,10 +134,6 @@ static int dwc3_of_simple_probe(struct platform_devi=
ce *pdev)
>  		goto err_resetc_assert;
>  	}
>=20=20
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> -	pm_runtime_get_sync(dev);

this hunk is not wrong at all.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlsOma0ACgkQzL64meEa
mQbDmw/+KZnos/wV4aUu/5fQQ63waSp1DhEZF4DgD2C2vo0Q3BpvSQq3XCGy8xuH
SIElw1vL8gdYVyFCEOMaocvxBL1DL9Wi18I5BZKAk7SsABZUSojBVX1RzRoqco3j
lPrd64k5qbi8yWS/Bk3S9zsWR/V/BlUteOs2rO/0MJWxUPmi7fNZAczufOFL7m2D
AQAy7k1O8SjKIclN+cxftkqM8BNGuwP76CU+VxVav24AzplyCjjnJkUn9Wrj4baN
C5XRnGVaPKYZjqLfUdOkkA32efD9FXbrH0SxNeUCJfs1OguwaUpcCo+6Nqa5RLJr
FtqWc2aOWf12V28Z7v2VcbpSakukuvh/BHTMpTjR1/BU2E6aAXLUJYb83vMgaXJ+
bgssEeWWeGF/LffsFrxSQfhmQ2ED+17r3dLsBKgI4j8kQDfCCNdvU8BPM7qMKzWp
mUAfZrBh8tt/dro8gB7OTNoRRe4nwr/jv4ntIzcSZVy2Iq6grzg6cA/vizKb14O8
TA96x0lnNZdZb3/G83T7cQUXV/qkjZFj8j+zHWP1h39g7z91katqkD4ZOs/5PbIe
MzeUn6ViDcm+fUhQqHGRV9CGITJtMxWkT/U9f9ftyw8tNuTXyTUAT+Xhuq/G+L6E
IcNkSftZTuOZwQRPVl31T9k79VotswtBi8qeumv83k4rQx6GaHM=
=Eg8l
-----END PGP SIGNATURE-----
--=-=-=--
