Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F067EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD9B20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDD9B20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeLEVIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:08:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:59802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727575AbeLEVIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:08:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AB0CEAFEF;
        Wed,  5 Dec 2018 21:08:32 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Date:   Thu, 06 Dec 2018 08:08:24 +1100
Cc:     devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: mt7621-mmc: Remove missed lines of the #if 0 block in sd.c
In-Reply-To: <20181205161001.GA12511@nishad>
References: <20181205161001.GA12511@nishad>
Message-ID: <87tvjrel6f.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05 2018, Nishad Kamdar wrote:

> The below patch
> https://lore.kernel.org/patchwork/patch/995533/
> does not completely remove an #if 0 block in sd.c.

Standard practice is to identify patches by their commit id.
In this case you could
  git log --oneline  drivers/staging/mt7621-mmc/sd.c

choose the right patch, and copy/paste with a bit of editing, so:

  Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in
  sd.c") does not completely ....

I have

  [alias]
  	cm =3D !git --no-pager show -s --format=3Dcm
	fx =3D !git --no-pager show -s --format=3Dfixes
  [pretty]
	fixes =3D Fixes: %h (\"%s\")
	cm =3D Commit %h (\"%s\")

in my $HOME/.gitconfig so I can get the text with, e.g.,

  $ git cm 2a54e3259e2a
  Commit 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")

Then as that commit introduced a problem, it is best-practice to also do

  $ git fx 2a54e3259e2a
  Fixes: 2a54e3259e2a ("staging: mt7621-mmc: Remove #if 0 blocks in sd.c")

and add the "Fixes" near the Signed-off-by line.

Thanks,
NeilBrown


> This causes the function msdc_select_clksrc()
> which was earler not compiled, to be compiled.
> That causes an error - MSDC_CLKSRC_REG is not
> defined.
>
> This patch completely removes the #if 0 block
>
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---
>  drivers/staging/mt7621-mmc/sd.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc=
/sd.c
> index 7b66f9b0a094..3d918e481bd8 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -216,26 +216,6 @@ static void msdc_tasklet_card(struct work_struct *wo=
rk)
>  	spin_unlock(&host->lock);
>  }
>=20=20
> -static void msdc_select_clksrc(struct msdc_host *host, unsigned char clk=
src)
> -{
> -	u32 val;
> -
> -	BUG_ON(clksrc > 3);
> -
> -	val =3D readl(host->base + MSDC_CLKSRC_REG);
> -	if (readl(host->base + MSDC_ECO_VER) >=3D 4) {
> -		val &=3D ~(0x3  << clk_src_bit[host->id]);
> -		val |=3D clksrc << clk_src_bit[host->id];
> -	} else {
> -		val &=3D ~0x3; val |=3D clksrc;
> -	}
> -	writel(val, host->base + MSDC_CLKSRC_REG);
> -
> -	host->hclk =3D hclks[clksrc];
> -	host->hw->clk_src =3D clksrc;
> -}
> -#endif /* end of --- */
> -
>  static void msdc_set_mclk(struct msdc_host *host, int ddr, unsigned int =
hz)
>  {
>  	//struct msdc_hw *hw =3D host->hw;
> --=20
> 2.17.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlwIPkkACgkQOeye3VZi
gbmyAg/+Le52NLIJ2gVH21PYCVy+ZveawkEnefKByKeQllJCh+xam98j62cth2Lc
2Loa1+DW7VYAzXBCpF8anG6HWAWS/36LDTQ6lTCRS8wdvGSyKUi+oIYP+mbh8ydU
Xm8pyou58VKy8UFS2U5Q3cRHPa3QmzTTcyPoYYhZ76zA+cMUfL9wvoCHcAJUiXkK
53j1GUS61H7Zr7Oaum4E0Sqtk/gbJfIRJo+Gnp315ha/0UhNFo120l+q9IkNWPBQ
bgaBVmK64ZqQkbQI1lqLRNscxl/1MZzlJRVauUHpsNYl2kCWr2fYcmqInREQ4BJW
iZhY0xxqMjne3sgk5ZMuzk4Cd4TJrH+xjHruyxfeviW9poh1emXIaHStn95Xi/jy
9ojsEhRzdtK8P8mcapQoKnUI8Qp/IFrKUwuW254DQTNV64mxLdelw50qCTv+7nBd
p5CeCzcC67MgU/SPwV2XDVQRkWnb/xUAL5b/zA3x8WgWh2ZH5wuRUNGXAZV/qGxV
MO/9EXRDQeGaDn7qDTn8RF/FokGxVq6Z3LG/e6lSvpnNtnlTL/Dtasy722XBGndS
DnVmGlFtHtgcIuaWTiVURbR1CunPOVAh89qmt+XGkkNgxDZZT+vsCjOfvSSUCudk
OEtX2IjYn11BbjmP3mFiD8YuoUwfE29Nuk4lRQX0hrdW66CuYOw=
=0ciX
-----END PGP SIGNATURE-----
--=-=-=--
