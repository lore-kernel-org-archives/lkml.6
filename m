Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CB7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A74620661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp0/w76s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A74620661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeH3Cc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeH3Cc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:32:26 -0400
Received: from mail.kernel.org (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B79B520644;
        Wed, 29 Aug 2018 22:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535582003;
        bh=VpOzEsjq7BnHpVB2u+LPjXwIXUQFtsPQKZaPW+iBu+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hp0/w76sKyRhrXvz2hkw/jqHoqjgDwHBQzB1tNKV98DqYQHEDC9BBOwyL2dKbHvSe
         j+Jvz0bmOXQKgP2ERZnUxxyCX3p6ol13W+Tt5MUBxKD1tseoK5A1m7ixuBeK3SbRdN
         CIuhJb5+wyAzWCuGBiCsJpUALTn85XLX9/zwhF14=
Date:   Thu, 30 Aug 2018 00:33:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: ab8500_fg: fix obsolete function
Message-ID: <20180829223320.rhfusyuywofjmpx7@earth.universe>
References: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37hn7rqsvit6mk4s"
Content-Disposition: inline
In-Reply-To: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--37hn7rqsvit6mk4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 27, 2018 at 06:49:15AM -0400, Ding Xiang wrote:
> simple_strtoul is obsolete, and use kstrtoint instead
>=20
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 02356f9..2bdadb5 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2582,11 +2582,12 @@ static ssize_t ab8505_powercut_flagtime_write(str=
uct device *dev,
>  				  const char *buf, size_t count)
>  {
>  	int ret;
> -	long unsigned reg_value;
> +	int reg_value;
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> =20
>  	if (reg_value > 0x7F) {
>  		dev_err(dev, "Incorrect parameter, echo 0 (1.98s) - 127 (15.625ms) for=
 flagtime\n");
> @@ -2636,7 +2637,9 @@ static ssize_t ab8505_powercut_maxtime_write(struct=
 device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x7F) {
>  		dev_err(dev, "Incorrect parameter, echo 0 (0.0s) - 127 (1.98s) for max=
time\n");
>  		goto fail;
> @@ -2684,7 +2687,9 @@ static ssize_t ab8505_powercut_restart_write(struct=
 device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0xF) {
>  		dev_err(dev, "Incorrect parameter, echo 0 - 15 for number of restart\n=
");
>  		goto fail;
> @@ -2777,7 +2782,9 @@ static ssize_t ab8505_powercut_write(struct device =
*dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x1) {
>  		dev_err(dev, "Incorrect parameter, echo 0/1 to disable/enable Pcut fea=
ture\n");
>  		goto fail;
> @@ -2849,7 +2856,9 @@ static ssize_t ab8505_powercut_debounce_write(struc=
t device *dev,
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
>  	struct ab8500_fg *di =3D power_supply_get_drvdata(psy);
> =20
> -	reg_value =3D simple_strtoul(buf, NULL, 10);
> +	if (kstrtoint(buf, 10, &reg_value))
> +		goto fail;
> +
>  	if (reg_value > 0x7) {
>  		dev_err(dev, "Incorrect parameter, echo 0 to 7 for debounce setting\n"=
);
>  		goto fail;
> --=20
> 1.8.3.1
>=20
>=20
>=20

--37hn7rqsvit6mk4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAluHHzAACgkQ2O7X88g7
+ppnEA//f6e2u3qwcvI1Eh6rrXjU/ST9096xpUNfHttE/gilKC5gQOU3V1qKV1lt
7L7OOMQGZZRAIdVz0mSPckryW3d/d+Tn3xqzzHO9VpV0SQmo+GcNTxOAIIJ7giPr
uXU6/YEVTBHm5kt7dkbTqhOJqq7dMGDYMd0dDTXl+aT/PyEAStL0ybGvHmQsFIap
2xVMzTkpkQWjPw9Ffm5yL4FZEFKc3tdPl0tCgOKRTW8zsO0u2VrDBveF+YFWJUM2
aiP54r56YbEPMTxsDO4gxY/QKOzwklIW+7BEH4RyGBkYhlJOYg9eGhZQ+Ca4JQ9H
9+i4yfrqbPgP8HFnPl0/EbuXGBfSjbf1xmu0efPhJZNhgE/mIG3w5qhVf0RgzGHz
7L5gmyaAGc32s2+jPMDQs8WJxI6TrwkJyRGRsK3r6DrUP/NTqzzW+DCaWFFSe/15
5P5qAUjxYku5626Em9vrQPRd5appDwCU470WYpHz73wzo9f7IqLXx1Ni8lVf4d3C
RDr5S90M10xP6M7SDxpNFqnPNZzKxkWV5L6Z3tDBMCxkTuUPsfsZl4tsR0AiTdVt
25i590tMGlUBEPlaOxd/I7/TuGKa4ERIha5D+PsiS+GDytAqblJ70ok99jUdVSyt
f3bZMofVrT+9JTRkkXGgBB1xaA1z2fmDqAAFxTJWxHQaudmBsgY=
=Mvg/
-----END PGP SIGNATURE-----

--37hn7rqsvit6mk4s--
